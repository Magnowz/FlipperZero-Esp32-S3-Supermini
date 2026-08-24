/**
 * Background qFlipper bridge — see qflipper_bridge.h.
 *
 * This is the former standalone "qFlipper" app (applications/main/qflipper)
 * turned into a background service owned by the desktop: the composite + RPC
 * pipe run in a dedicated FuriThread instead of a foreground view, so the lock
 * menu can toggle it on/off while the user keeps using the desktop.
 *
 * Installing the TinyUSB composite switches the ESP32-S3 internal USB PHY from
 * USB-Serial-JTAG to USB-OTG, which kills the serial/JTAG bridge esptool uses
 * for flashing. So we only do it on demand. stop() leaves the composite
 * installed (like USB-Storage) and only detaches the RPC bridge — this
 * esp_tinyusb build can't cleanly reinstall after an uninstall, so the
 * composite stays up until reboot.
 */

#include "qflipper_bridge.h"

#include <furi.h>
#include <furi_hal.h>
#include <furi_hal_usb.h>
#include <furi_hal_usb_cdc.h>
#include <rpc/rpc.h>
#include <storage/storage.h>
#include <stdarg.h>
#include <stdio.h>

#include <stdint.h>
#include <stddef.h>
#include <string.h>

#include "sdkconfig.h"

#if CONFIG_IDF_TARGET_ESP32S3 || CONFIG_IDF_TARGET_ESP32S2
#include "furi_hal_usb_tinyusb_composite.h"
#define QFLIPPER_HAVE_COMPOSITE 1
#else
#define QFLIPPER_HAVE_COMPOSITE 0
#endif

#define TAG "qFlipperBridge"

#define USB_RPC_CDC_ITF       0
/* Larger drain chunks shorten the race window between the avail-check and
 * the FIFO read in usb_rpc_drain_rx — fewer iterations, fewer chances for
 * the host to slip a byte into the FIFO that we'd then drop. */
#define USB_RPC_RX_CHUNK_SIZE 2048

/* The console (and any live `winbuild.py monitor` session) goes dark the
 * moment the USB-OTG composite takes over the shared port, so FURI_LOG
 * output during a qFlipper connection attempt is invisible over USB. Storage
 * (SD card) is unaffected, so mirror the key handshake events to a plain
 * text file instead — read it back afterward via the Archive app or SD
 * reader. */
#define QFLIPPER_DEBUG_LOG_PATH EXT_PATH("qflipper_debug.log")

#if QFLIPPER_HAVE_COMPOSITE
static void qflipper_debug_log(const char* fmt, ...) {
    Storage* storage = furi_record_open(RECORD_STORAGE);
    File* file = storage_file_alloc(storage);

    if(storage_file_open(file, QFLIPPER_DEBUG_LOG_PATH, FSAM_WRITE, FSOM_OPEN_APPEND)) {
        char line[160];
        va_list args;
        va_start(args, fmt);
        int len = vsnprintf(line, sizeof(line) - 2, fmt, args);
        va_end(args);
        if(len > 0) {
            size_t n = (size_t)len < sizeof(line) - 2 ? (size_t)len : sizeof(line) - 2;
            line[n] = '\n';
            storage_file_write(file, line, n + 1);
        }
    }

    storage_file_close(file);
    storage_file_free(file);
    furi_record_close(RECORD_STORAGE);
}
#endif /* QFLIPPER_HAVE_COMPOSITE */

/* Internal events */
typedef enum {
    UsbRpcEventConnected,    /* DTR went high */
    UsbRpcEventDisconnected, /* DTR went low or USB disconnect */
    UsbRpcEventRxAvailable,  /* CDC RX bytes ready */
    UsbRpcEventTxComplete,   /* CDC TX done */
    UsbRpcEventExit,         /* stop() requested — leave the loop */
} UsbRpcEvent;

typedef struct {
    FuriThread* thread;
    FuriMessageQueue* event_q;

    Rpc* rpc;
    RpcSession* session;

    bool connected;       /* DTR state */
    bool session_open;    /* RPC session active */
    bool rpc_mode;        /* false = CLI handshake, true = piping protobuf */
    volatile bool exiting; /* stop() requested — bail out of any blocking loop */

    /* CLI handshake line buffer (qFlipper sends "start_rpc_session\r") */
    char cli_buf[64];
    size_t cli_len;

    /* RX scratch buffer */
    uint8_t rx_buf[USB_RPC_RX_CHUNK_SIZE];
} UsbRpcSrv;

/* Single-instance background bridge. */
static UsbRpcSrv* s_bridge = NULL;

#if QFLIPPER_HAVE_COMPOSITE

/* ─────────────────────────────────────────────────────────────────────
 * CDC callbacks (from furi_hal_usb_cdc).
 *
 * These run on the TinyUSB task. We hand events to the bridge thread
 * via the message queue and return quickly.
 * ───────────────────────────────────────────────────────────────────── */

static void usb_rpc_post_event(UsbRpcSrv* srv, UsbRpcEvent ev) {
    furi_message_queue_put(srv->event_q, &ev, 0);
}

static void usb_rpc_cdc_tx_done(void* ctx) {
    usb_rpc_post_event(ctx, UsbRpcEventTxComplete);
}

static void usb_rpc_cdc_rx(void* ctx) {
    usb_rpc_post_event(ctx, UsbRpcEventRxAvailable);
}

static void usb_rpc_cdc_state(void* ctx, CdcState state) {
    UsbRpcSrv* srv = ctx;
    if(state == CdcStateDisconnected) {
        usb_rpc_post_event(srv, UsbRpcEventDisconnected);
    }
    /* Connected via DTR edge in ctrl_line callback below */
}

static void usb_rpc_cdc_ctrl_line(void* ctx, CdcCtrlLine ctrl) {
    UsbRpcSrv* srv = ctx;
    qflipper_debug_log(
        "ctrl_line: raw=0x%02x dtr=%d rts=%d",
        (unsigned)ctrl,
        (ctrl & CdcCtrlLineDTR) ? 1 : 0,
        (ctrl & CdcCtrlLineRTS) ? 1 : 0);
    /* Host serial libraries commonly wiggle DTR/RTS independently while
     * opening a port (e.g. DTR=1,RTS=0 immediately followed by DTR=0,RTS=1) —
     * that's control-line housekeeping, not a hangup. Treating any DTR-clear
     * as a full disconnect tore down the CLI/RPC session right as qFlipper
     * was about to send "start_rpc_session". Only disconnect when the host
     * has released BOTH lines (truly closed the port); either line still
     * asserted means it's still there. */
    if(ctrl != 0) {
        usb_rpc_post_event(srv, UsbRpcEventConnected);
    } else {
        usb_rpc_post_event(srv, UsbRpcEventDisconnected);
    }
}

static CdcCallbacks usb_rpc_cdc_callbacks = {
    .tx_ep_callback = usb_rpc_cdc_tx_done,
    .rx_ep_callback = usb_rpc_cdc_rx,
    .state_callback = usb_rpc_cdc_state,
    .ctrl_line_callback = usb_rpc_cdc_ctrl_line,
    .config_callback = NULL,
};

/* ─────────────────────────────────────────────────────────────────────
 * RPC -> CDC (outbound)
 * ───────────────────────────────────────────────────────────────────── */

static void usb_rpc_send_bytes(void* ctx, uint8_t* bytes, size_t len) {
    (void)ctx;
    while(len > 0) {
        uint16_t chunk = (len > 0xFFFF) ? 0xFFFF : (uint16_t)len;
        furi_hal_cdc_send(USB_RPC_CDC_ITF, bytes, chunk);
        bytes += chunk;
        len -= chunk;
    }
}

/* ─────────────────────────────────────────────────────────────────────
 * Session lifecycle
 * ───────────────────────────────────────────────────────────────────── */

static void usb_rpc_session_open(UsbRpcSrv* srv) {
    if(srv->session_open) return;

    srv->session = rpc_session_open(srv->rpc, RpcOwnerUsb);
    if(!srv->session) {
        FURI_LOG_E(TAG, "rpc_session_open failed");
        qflipper_debug_log("rpc_session_open FAILED");
        return;
    }
    rpc_session_set_context(srv->session, srv);
    rpc_session_set_send_bytes_callback(srv->session, usb_rpc_send_bytes);
    srv->session_open = true;
    FURI_LOG_I(TAG, "RPC session opened");
    qflipper_debug_log("rpc_session_open OK");
}

static void usb_rpc_session_close(UsbRpcSrv* srv) {
    if(!srv->session_open) return;

    rpc_session_close(srv->session);
    srv->session = NULL;
    srv->session_open = false;
    FURI_LOG_I(TAG, "RPC session closed");
}

static void usb_rpc_drain_rx(UsbRpcSrv* srv) {
    if(!srv->session_open) {
        uint8_t scratch[64];
        while(furi_hal_cdc_receive(USB_RPC_CDC_ITF, scratch, sizeof(scratch)) > 0) {
        }
        return;
    }

    /* Never read from the CDC FIFO unless we have downstream room for the whole
     * chunk we're about to consume. If the RPC stream is saturated we sit-and-
     * wait here so the TinyUSB RX FIFO fills up and USB-NAKs the host — the only
     * flow-control mechanism over USB-CDC. */
    while(true) {
        if(srv->exiting) return;
        size_t avail = rpc_session_get_available_size(srv->session);
        if(avail == 0) {
            furi_delay_ms(1);
            if(!srv->session_open || srv->exiting) return;
            continue;
        }

        size_t to_read = avail < sizeof(srv->rx_buf) ? avail : sizeof(srv->rx_buf);
        int32_t got = furi_hal_cdc_receive(USB_RPC_CDC_ITF, srv->rx_buf, to_read);
        if(got <= 0) {
            break;
        }

        size_t fed = rpc_session_feed(srv->session, srv->rx_buf, (size_t)got, FuriWaitForever);
        if(fed != (size_t)got) {
            FURI_LOG_E(TAG, "rpc_session_feed underran: %zu/%ld", fed, got);
            break;
        }
    }
}

/* ─────────────────────────────────────────────────────────────────────
 * CLI handshake — qFlipper drives the text CLI before piping protobuf.
 * We emulate just enough to satisfy the handshake, then flip into RPC mode.
 * ───────────────────────────────────────────────────────────────────── */

#define QFLIPPER_CLI_PROMPT  "\r\n\r\n>: "
#define QFLIPPER_RPC_COMMAND "start_rpc_session"

static void qflipper_cli_send_prompt(void) {
    uint32_t start = furi_get_tick();
    qflipper_debug_log("send_prompt: calling furi_hal_cdc_send len=%u", (unsigned)strlen(QFLIPPER_CLI_PROMPT));
    furi_hal_cdc_send(
        USB_RPC_CDC_ITF, (uint8_t*)QFLIPPER_CLI_PROMPT, strlen(QFLIPPER_CLI_PROMPT));
    qflipper_debug_log("send_prompt: returned after %ums", (unsigned)(furi_get_tick() - start));
}

static void qflipper_cli_rx(UsbRpcSrv* srv) {
    uint8_t buf[64];
    int32_t got;
    while((got = furi_hal_cdc_receive(USB_RPC_CDC_ITF, buf, sizeof(buf))) > 0) {
        char printable[65];
        int32_t p = 0;
        for(; p < got && p < 64; p++) {
            uint8_t b = buf[p];
            printable[p] = (b >= 0x20 && b < 0x7f) ? (char)b : '.';
        }
        printable[p] = '\0';
        qflipper_debug_log("cli_rx: got=%ld bytes='%s'", (long)got, printable);

        for(int32_t i = 0; i < got; i++) {
            char c = (char)buf[i];

            if(c == '\r' || c == '\n') {
                srv->cli_buf[srv->cli_len] = '\0';
                qflipper_debug_log("cli_rx: line='%s'", srv->cli_buf);

                if(strstr(srv->cli_buf, QFLIPPER_RPC_COMMAND) != NULL) {
                    qflipper_debug_log("cli_rx: matched start_rpc_session, switching to RPC");
                    furi_hal_cdc_send(
                        USB_RPC_CDC_ITF,
                        (uint8_t*)(QFLIPPER_RPC_COMMAND "\r\n"),
                        strlen(QFLIPPER_RPC_COMMAND "\r\n"));

                    srv->cli_len = 0;
                    srv->rpc_mode = true;
                    usb_rpc_session_open(srv);

                    if(srv->session_open && (i + 1) < got) {
                        rpc_session_feed(
                            srv->session, &buf[i + 1], (size_t)(got - i - 1), FuriWaitForever);
                    }
                    return;
                }

                srv->cli_len = 0;
                qflipper_cli_send_prompt();
            } else if(srv->cli_len < sizeof(srv->cli_buf) - 1) {
                srv->cli_buf[srv->cli_len++] = c;
            }
        }
    }
}

/* ─────────────────────────────────────────────────────────────────────
 * Bridge thread
 * ───────────────────────────────────────────────────────────────────── */

/* How often to re-send the CLI prompt while connected but not yet in RPC
 * mode. The very first prompt (sent immediately on DTR-up) can land before
 * the host's read side is actually ready to receive — a known race with some
 * CDC-ACM host stacks — silently dropping that one packet. Re-announcing
 * periodically means the host picks it up on whichever attempt it's ready
 * for, instead of the session dying silently after one lost packet. */
#define QFLIPPER_PROMPT_RESEND_MS 1000

static void qflipper_bridge_run(UsbRpcSrv* srv) {
    UsbRpcEvent ev;
    while(true) {
        FuriStatus status =
            furi_message_queue_get(srv->event_q, &ev, QFLIPPER_PROMPT_RESEND_MS);
        if(status == FuriStatusErrorTimeout) {
            if(srv->connected && !srv->rpc_mode) {
                qflipper_debug_log("resend: periodic CLI prompt re-announce");
                qflipper_cli_send_prompt();
            }
            continue;
        }
        if(status != FuriStatusOk) {
            continue;
        }

        switch(ev) {
        case UsbRpcEventExit:
            return;

        case UsbRpcEventConnected:
            if(srv->connected) {
                qflipper_debug_log("event=Connected (already connected, ignored)");
                break;
            }
            srv->connected = true;
            srv->rpc_mode = false;
            srv->cli_len = 0;
            FURI_LOG_I(TAG, "DTR up — entering CLI, sending prompt");
            qflipper_debug_log("event=Connected: sending CLI prompt");
            qflipper_cli_send_prompt();
            break;

        case UsbRpcEventDisconnected:
            if(!srv->connected) {
                qflipper_debug_log("event=Disconnected (not connected, ignored)");
                break;
            }
            srv->connected = false;
            srv->rpc_mode = false;
            srv->cli_len = 0;
            FURI_LOG_I(TAG, "DTR down — closing RPC session");
            qflipper_debug_log("event=Disconnected: closing RPC session");
            usb_rpc_session_close(srv);
            break;

        case UsbRpcEventRxAvailable:
            if(srv->rpc_mode) {
                usb_rpc_drain_rx(srv);
            } else {
                qflipper_cli_rx(srv);
            }
            break;

        case UsbRpcEventTxComplete:
            break;
        }
    }
}

/* The thread only runs the event loop. The composite is installed before the
 * thread starts (start()) and torn down after it joins (stop()), both on the
 * caller's (desktop) thread. The exiting flag lets the loop bail out of a
 * blocking RX drain so join() always completes promptly. */
static int32_t qflipper_bridge_thread(void* ctx) {
    UsbRpcSrv* srv = ctx;
    qflipper_bridge_run(srv);
    return 0;
}

#endif /* QFLIPPER_HAVE_COMPOSITE */

/* ─────────────────────────────────────────────────────────────────────
 * Public API
 * ───────────────────────────────────────────────────────────────────── */

bool qflipper_bridge_start(void) {
#if !QFLIPPER_HAVE_COMPOSITE
    return false;
#else
    if(s_bridge) return true; /* already active */

    qflipper_debug_log("=== qflipper_bridge_start() ===");

    UsbRpcSrv* srv = malloc(sizeof(UsbRpcSrv));
    srv->event_q = furi_message_queue_alloc(16, sizeof(UsbRpcEvent));
    srv->session = NULL;
    srv->connected = false;
    srv->session_open = false;
    srv->rpc_mode = false;
    srv->exiting = false;
    srv->cli_len = 0;

    srv->rpc = furi_record_open(RECORD_RPC);

    /* Install the composite as a real Flipper Zero (0483:5740). Idempotent if
     * another consumer (USB-Storage) already installed it. */
    if(!furi_hal_usb_composite_install(0, 0, NULL, NULL)) {
        FURI_LOG_E(TAG, "composite_install failed");
        qflipper_debug_log("composite_install FAILED");
        furi_record_close(RECORD_RPC);
        furi_message_queue_free(srv->event_q);
        free(srv);
        return false;
    }
    qflipper_debug_log("composite_install OK");

    /* set_callbacks fires state/ctrl_line immediately with the current line
     * state, so if DTR is already high this seeds a Connected event into the
     * queue (drained once the thread starts). */
    furi_hal_cdc_set_callbacks(USB_RPC_CDC_ITF, &usb_rpc_cdc_callbacks, srv);
    qflipper_debug_log("cdc_set_callbacks done, ctrl_line_state=0x%02x", (unsigned)furi_hal_cdc_get_ctrl_line_state(USB_RPC_CDC_ITF));

    srv->thread = furi_thread_alloc_ex("QflipperBridge", 8192, qflipper_bridge_thread, srv);
    s_bridge = srv;
    furi_thread_start(srv->thread);
    qflipper_debug_log("bridge thread started");

    return true;
#endif
}

void qflipper_bridge_stop(void) {
#if QFLIPPER_HAVE_COMPOSITE
    UsbRpcSrv* srv = s_bridge;
    if(!srv) return;
    s_bridge = NULL;

    /* Wake the loop out of any blocking RX drain, then ask it to exit. */
    srv->exiting = true;
    UsbRpcEvent ev = UsbRpcEventExit;
    furi_message_queue_put(srv->event_q, &ev, FuriWaitForever);

    furi_thread_join(srv->thread);
    furi_thread_free(srv->thread);

    /* Detach the RPC bridge but LEAVE the composite installed — exactly like
     * USB-Storage, which only toggles its MSC function. The esp_tinyusb build
     * here can't cleanly reinstall after furi_hal_usb_composite_uninstall()
     * (tusb_teardown is a no-op), so uninstalling here would break the next
     * Enable. The composite stays up until reboot; re-enabling just reattaches
     * the CDC callbacks. */
    furi_hal_cdc_set_callbacks(USB_RPC_CDC_ITF, NULL, NULL);
    usb_rpc_session_close(srv);
    furi_record_close(RECORD_RPC);

    furi_message_queue_free(srv->event_q);
    free(srv);
#endif
}

bool qflipper_bridge_is_active(void) {
    return s_bridge != NULL;
}
