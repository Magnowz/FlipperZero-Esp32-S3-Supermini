/**
 * @file furi_hal_display.c
 * Display HAL — board-driven configuration via boards/board.h
 *
 * Flipper GUI: 128x64 mono → aspect-fit scaled and centered on display
 */

#include "furi_hal_display.h"
#include "furi_hal_light.h"
#include "furi_hal_resources.h"
#include "furi_hal_spi_bus.h"
#include "furi_hal_spi.h"
#include "boards/board.h"

#include <string.h>
#include <esp_log.h>
#include <esp_heap_caps.h>
#include <esp_system.h>
#include <driver/gpio.h>
#include <driver/spi_master.h>
#include <esp_lcd_panel_io.h>
#include <esp_lcd_panel_vendor.h>
#include <esp_lcd_panel_ops.h>
#include <freertos/semphr.h>

static const char* TAG = "FuriHalDisplay";

#if defined(BOARD_DISPLAY_SSD1306_I2C) && BOARD_DISPLAY_SSD1306_I2C
/* ---------------------------------------------------------------------------
 * SSD1306 128x64 mono OLED via I2C
 *
 * The Flipper GUI framebuffer handed to furi_hal_display_commit() is already
 * a 128x64 1bpp u8g2 tile buffer: 8 pages of 128 bytes, byte[page*128+x] bit n
 * = pixel (x, page*8+n), bit 0 = top pixel of the tile. That is *exactly* the
 * SSD1306's own GDDRAM layout in page-addressing mode (with the standard
 * segment-remap (0xA1) + COM-scan-remap (0xC8) orientation every common
 * SSD1306 breakout uses) — so unlike the color LCD boards there is no
 * upscale/color conversion to do: each page is written to GDDRAM verbatim.
 * --------------------------------------------------------------------------- */

#include <driver/i2c.h>

#define OLED_WIDTH  BOARD_LCD_H_RES  /* 128 */
#define OLED_HEIGHT BOARD_LCD_V_RES  /* 64 */
#define OLED_PAGES  (OLED_HEIGHT / 8)

static bool oled_ready = false;
static uint16_t oled_fg_color = 0;
static uint16_t oled_bg_color = 1;

static esp_err_t oled_i2c_write(const uint8_t* payload, size_t len) {
    return i2c_master_write_to_device(
        BOARD_OLED_I2C_PORT, BOARD_OLED_I2C_ADDR, payload, len, pdMS_TO_TICKS(100));
}

/* Every command byte gets its own control-byte-prefixed transaction (Co=0,
 * D/C=0). The SSD1306's command parser is stateful across transactions, so
 * multi-byte commands (e.g. 0xD5 0x80) work fine sent one byte at a time —
 * this is the same approach most minimal SSD1306 drivers use. */
static void oled_cmd(uint8_t cmd) {
    uint8_t buf[2] = {0x00, cmd};
    oled_i2c_write(buf, sizeof(buf));
}

void furi_hal_display_init(void) {
    ESP_LOGI(TAG, "Initializing SSD1306 OLED (I2C) for %s", BOARD_NAME);

    i2c_config_t conf = {
        .mode = I2C_MODE_MASTER,
        .sda_io_num = BOARD_PIN_OLED_SDA,
        .scl_io_num = BOARD_PIN_OLED_SCL,
        .sda_pullup_en = GPIO_PULLUP_ENABLE,
        .scl_pullup_en = GPIO_PULLUP_ENABLE,
        .master.clk_speed = BOARD_OLED_I2C_FREQ_HZ,
    };
    esp_err_t err = i2c_param_config(BOARD_OLED_I2C_PORT, &conf);
    if(err == ESP_OK) {
        err = i2c_driver_install(BOARD_OLED_I2C_PORT, conf.mode, 0, 0, 0);
    }
    /* ESP_ERR_INVALID_STATE is OK — port may already be installed (e.g. after
     * a soft restart that didn't clear the driver). */
    if(err != ESP_OK && err != ESP_ERR_INVALID_STATE) {
        ESP_LOGE(TAG, "OLED I2C init failed: %s", esp_err_to_name(err));
        return;
    }

    static const uint8_t init_seq[] = {
        0xAE,       /* Display off */
        0xD5, 0x80, /* Clock divide ratio / oscillator frequency */
        0xA8, (uint8_t)(OLED_HEIGHT - 1), /* Multiplex ratio */
        0xD3, 0x00, /* Display offset = 0 */
        0x40,       /* Display start line = 0 */
        0x8D, 0x14, /* Charge pump enable (required for most 3.3V modules) */
        0x20, 0x02, /* Memory addressing mode = page addressing */
        0xA1,       /* Segment remap (col 127 -> SEG0) */
        0xC8,       /* COM output scan direction, remapped */
        0xDA, 0x12, /* COM pins hardware config */
        0x81, 0x8F, /* Contrast control */
        0xD9, 0xF1, /* Pre-charge period */
        0xDB, 0x40, /* VCOMH deselect level */
        0xA4,       /* Resume to RAM content display (not "all pixels on") */
        0xA6,       /* Normal display (not inverted) */
        0xAF,       /* Display on */
    };
    for(size_t i = 0; i < sizeof(init_seq); i++) {
        oled_cmd(init_seq[i]);
    }

    oled_ready = true;

    /* Clear GDDRAM so the panel doesn't flash stale/random contents before
     * the first real frame is committed. */
    uint8_t zero_page[1 + OLED_WIDTH] = {0x40};
    for(uint8_t page = 0; page < OLED_PAGES; page++) {
        oled_cmd(0xB0 + page); /* Page start address */
        oled_cmd(0x00);        /* Lower column address = 0 */
        oled_cmd(0x10);        /* Higher column address = 0 */
        oled_i2c_write(zero_page, sizeof(zero_page));
    }

    ESP_LOGI(
        TAG, "SSD1306 initialized (%dx%d, I2C addr 0x%02X, SDA=%d SCL=%d)",
        OLED_WIDTH, OLED_HEIGHT, BOARD_OLED_I2C_ADDR, BOARD_PIN_OLED_SDA, BOARD_PIN_OLED_SCL);
}

void furi_hal_display_commit(const uint8_t* data, uint32_t size) {
    UNUSED(size);
    if(!oled_ready || !data) return;

    uint8_t page_buf[1 + OLED_WIDTH];
    page_buf[0] = 0x40;

    for(uint8_t page = 0; page < OLED_PAGES; page++) {
        oled_cmd(0xB0 + page);
        oled_cmd(0x00);
        oled_cmd(0x10);
        memcpy(&page_buf[1], &data[page * OLED_WIDTH], OLED_WIDTH);
        oled_i2c_write(page_buf, sizeof(page_buf));
    }
}

void furi_hal_display_set_backlight(uint8_t brightness) {
    /* OLED is self-lit — there is no backlight to dim. Map "brightness" to
     * the SSD1306's own contrast register instead, so the settings slider
     * still does something visible. */
    if(!oled_ready) return;
    oled_cmd(0x81);
    oled_cmd(brightness);
}

void furi_hal_display_sleep(void) {
    if(!oled_ready) return;
    oled_cmd(0xAE); /* Display off — cuts panel current, GDDRAM retained */
}

uint16_t furi_hal_display_get_h_res(void) {
    return OLED_WIDTH;
}

uint16_t furi_hal_display_get_v_res(void) {
    return OLED_HEIGHT;
}

esp_lcd_panel_handle_t furi_hal_display_get_panel_handle(void) {
    /* No esp_lcd panel on a plain I2C mono OLED — full-screen takeover apps
     * (Doom/Wolf3D) already null-check this and bail out cleanly. */
    return NULL;
}

/* Mono display: fg/bg "color" is meaningless, but keep the setters/getters
 * as harmless stubs so the UI-color settings screen doesn't need a
 * board-specific stub of its own. */
void furi_hal_display_set_fg_color(uint16_t color) {
    oled_fg_color = color;
}

uint16_t furi_hal_display_get_fg_color(void) {
    return oled_fg_color;
}

void furi_hal_display_set_bg_color(uint16_t color) {
    oled_bg_color = color;
}

uint16_t furi_hal_display_get_bg_color(void) {
    return oled_bg_color;
}

#elif defined(BOARD_DISPLAY_ST7565_SPI) && BOARD_DISPLAY_ST7565_SPI
/* ---------------------------------------------------------------------------
 * ST7565 128x64 mono LCD (e.g. GMG12864-06D COG module) via 4-wire SPI
 *
 * Same page-addressed GDDRAM layout as the SSD1306 branch above (8 pages of
 * 128 bytes, byte[page*128+x] bit n = pixel (x, page*8+n), bit 0 = top pixel
 * of the tile) — the u8g2 framebuffer maps onto it 1:1, no scaling/color
 * conversion needed. The wire protocol differs: instead of an I2C control
 * byte, a dedicated A0 (a.k.a. RS/DC) GPIO line tells the controller whether
 * the byte going out over MOSI is a command (A0 low) or display data (A0
 * high) — that line is toggled by hand around each transaction below.
 *
 * Unlike a from-scratch SPI bus, this variant is deliberately CS-muxed onto
 * the *same* SPI2 bus already wired for CC1101/SD (see
 * board_esp32s3_supermini_st7565.h and furi_hal_spi.c's
 * furi_hal_spi_bus_handle_lcd_st7565) so the board doesn't need any GPIOs
 * beyond what the SSD1306 variant of this board already used — SCLK/MOSI are
 * shared with CC1101, only CS (freed-up ex-OLED SDA pin) and DC (freed-up
 * ex-OLED SCL pin) are LCD-only. All transfers go through
 * furi_hal_spi_acquire()/furi_hal_spi_bus_tx()/furi_hal_spi_release(), which
 * take the same bus mutex CC1101/SD use, so display writes can't interleave
 * with SubGHz or SD card transactions. There's no dedicated RST pin in this
 * pinout either — hold the panel's RST line to 3.3V through a pull-up
 * resistor and let power-on-reset plus the CMD_RESET (0xE2) below bring it
 * up clean.
 * --------------------------------------------------------------------------- */

#define LCD_WIDTH  BOARD_LCD_H_RES  /* 128 */
#define LCD_HEIGHT BOARD_LCD_V_RES  /* 64 */
#define LCD_PAGES  (LCD_HEIGHT / 8)

#ifndef BOARD_LCD_COL_OFFSET
#define BOARD_LCD_COL_OFFSET 0
#endif

static bool st7565_ready = false;
static uint16_t st7565_fg_color = 0;
static uint16_t st7565_bg_color = 1;

/* A0/DC low = command byte, A0/DC high = display data. Acquires the shared
 * SPI2 bus mutex for the duration of the transfer so CC1101/SD transactions
 * can't land mid-frame. */
static void st7565_write(bool is_data, const uint8_t* buf, size_t len) {
    if(gpio_lcd_dc.pin == UINT16_MAX || len == 0) return;
    gpio_set_level((gpio_num_t)gpio_lcd_dc.pin, is_data ? 1 : 0);
    furi_hal_spi_acquire(&furi_hal_spi_bus_handle_lcd_st7565);
    furi_hal_spi_bus_tx(&furi_hal_spi_bus_handle_lcd_st7565, buf, len, 100);
    furi_hal_spi_release(&furi_hal_spi_bus_handle_lcd_st7565);
}

/* ST7565 commands are always single bytes (unlike ST7789's command+param
 * framing), so every command gets its own tiny transaction — mirrors the
 * SSD1306 branch's per-byte oled_cmd() above, just over SPI instead of I2C. */
static void st7565_cmd(uint8_t cmd) {
    st7565_write(false, &cmd, 1);
}

/* Set page/column cursor and write one page's worth of pixel data as a
 * single bus acquisition (3 command bytes + 1 data burst), instead of the
 * 4 separate acquire/release round-trips a per-byte st7565_cmd()/data-write
 * pair would cost per page. */
static void st7565_write_page(uint8_t page, const uint8_t* row, size_t len) {
    if(gpio_lcd_dc.pin == UINT16_MAX) return;

    uint8_t cursor_cmds[3] = {
        (uint8_t)(0xB0 + page),
        (uint8_t)(0x10 | ((BOARD_LCD_COL_OFFSET >> 4) & 0x0F)),
        (uint8_t)(0x00 | (BOARD_LCD_COL_OFFSET & 0x0F)),
    };

    furi_hal_spi_acquire(&furi_hal_spi_bus_handle_lcd_st7565);
    gpio_set_level((gpio_num_t)gpio_lcd_dc.pin, 0);
    furi_hal_spi_bus_tx(&furi_hal_spi_bus_handle_lcd_st7565, cursor_cmds, sizeof(cursor_cmds), 100);
    gpio_set_level((gpio_num_t)gpio_lcd_dc.pin, 1);
    furi_hal_spi_bus_tx(&furi_hal_spi_bus_handle_lcd_st7565, row, len, 100);
    furi_hal_spi_release(&furi_hal_spi_bus_handle_lcd_st7565);
}

void furi_hal_display_init(void) {
    ESP_LOGI(TAG, "Initializing ST7565 LCD (shared SPI2 bus) for %s", BOARD_NAME);

    if(gpio_lcd_dc.pin != UINT16_MAX) {
        gpio_config_t dc_cfg = {
            .mode = GPIO_MODE_OUTPUT,
            .pin_bit_mask = 1ULL << gpio_lcd_dc.pin,
        };
        gpio_config(&dc_cfg);
    }

    /* No dedicated RST pin on this pinout (tied to 3.3V through a resistor
     * on the board) — give the panel a generous power-on settle delay, then
     * lean on the CMD_RESET (0xE2) software reset below instead of a GPIO
     * pulse. If a board variant *does* wire RST to a GPIO, pulse it here. */
    vTaskDelay(pdMS_TO_TICKS(50));
    if(gpio_lcd_rst.pin != UINT16_MAX) {
        gpio_config_t rst_cfg = {
            .mode = GPIO_MODE_OUTPUT,
            .pin_bit_mask = 1ULL << gpio_lcd_rst.pin,
        };
        gpio_config(&rst_cfg);
        gpio_set_level((gpio_num_t)gpio_lcd_rst.pin, 1);
        vTaskDelay(pdMS_TO_TICKS(10));
        gpio_set_level((gpio_num_t)gpio_lcd_rst.pin, 0);
        vTaskDelay(pdMS_TO_TICKS(20));
        gpio_set_level((gpio_num_t)gpio_lcd_rst.pin, 1);
        vTaskDelay(pdMS_TO_TICKS(50));
    }

    st7565_cmd(0xE2); /* Software reset (internal reset cycle) */
    vTaskDelay(pdMS_TO_TICKS(10));

    /* Standard ST7565-family init sequence — matches most 128x64 "12864" COG
     * modules (DOGM128/ERC12864/GMG12864-06D and clones). If the screen
     * stays blank, shows a checkerboard, or is mirrored, try flipping
     * CMD_SET_BIAS (0xA2<->0xA3) or ADC/COM direction (0xA0<->0xA1,
     * 0xC0<->0xC8) below — these vary by panel vendor/batch even on
     * otherwise-identical glass. */
    st7565_cmd(0xA2);       /* Bias 1/9 */
    st7565_cmd(0xA0);       /* ADC select: normal (SEG0 = column 0) */
    st7565_cmd(0xC8);       /* COM output scan direction: reversed */
    st7565_cmd(0x40);       /* Display start line = 0 */

    st7565_cmd(0x28 | 0x4); /* Power control: booster circuit on */
    vTaskDelay(pdMS_TO_TICKS(50));
    st7565_cmd(0x28 | 0x6); /* + voltage regulator circuit on */
    vTaskDelay(pdMS_TO_TICKS(50));
    st7565_cmd(0x28 | 0x7); /* + voltage follower circuit on (full power) */
    vTaskDelay(pdMS_TO_TICKS(10));

    st7565_cmd(0x20 | 0x6);  /* Regulator resistor ratio */
    st7565_cmd(0x81);        /* Electronic volume (contrast) mode set */
    st7565_cmd(0x18);        /* Contrast value (0-63) — tweak if too light/dark */

    st7565_cmd(0xA4);       /* Display all points normal (not all-on) */
    st7565_cmd(0xA6);       /* Normal display (not inverted) */
    st7565_cmd(0xAF);       /* Display on */

    st7565_ready = true;

    /* Clear GDDRAM so the panel doesn't show stale/random contents before
     * the first real frame is committed. */
    uint8_t zero_row[LCD_WIDTH] = {0};
    for(uint8_t page = 0; page < LCD_PAGES; page++) {
        st7565_write_page(page, zero_row, sizeof(zero_row));
    }

    ESP_LOGI(
        TAG, "ST7565 initialized (%dx%d, shared SCLK/MOSI, CS=%d DC=%d)",
        LCD_WIDTH, LCD_HEIGHT, gpio_lcd_cs.pin, gpio_lcd_dc.pin);
}

void furi_hal_display_commit(const uint8_t* data, uint32_t size) {
    UNUSED(size);
    if(!st7565_ready || !data) return;

    for(uint8_t page = 0; page < LCD_PAGES; page++) {
        st7565_write_page(page, &data[page * LCD_WIDTH], LCD_WIDTH);
    }
}

void furi_hal_display_set_backlight(uint8_t brightness) {
    /* Reflective glass, no backlight wired on this module — map
     * "brightness" onto the ST7565's own contrast register instead, so the
     * settings slider still does something visible. */
    if(!st7565_ready) return;
    st7565_cmd(0x81);
    st7565_cmd(brightness >> 2); /* 0-255 -> 0-63 */
}

void furi_hal_display_sleep(void) {
    if(!st7565_ready) return;
    st7565_cmd(0xAE); /* Display off — cuts panel current, GDDRAM retained */
}

uint16_t furi_hal_display_get_h_res(void) {
    return LCD_WIDTH;
}

uint16_t furi_hal_display_get_v_res(void) {
    return LCD_HEIGHT;
}

esp_lcd_panel_handle_t furi_hal_display_get_panel_handle(void) {
    /* No esp_lcd panel on a raw-driven ST7565 — full-screen takeover apps
     * (Doom/Wolf3D) already null-check this and bail out cleanly. */
    return NULL;
}

/* Mono display: fg/bg "color" is meaningless, but keep the setters/getters
 * as harmless stubs so the UI-color settings screen doesn't need a
 * board-specific stub of its own. */
void furi_hal_display_set_fg_color(uint16_t color) {
    st7565_fg_color = color;
}

uint16_t furi_hal_display_get_fg_color(void) {
    return st7565_fg_color;
}

void furi_hal_display_set_bg_color(uint16_t color) {
    st7565_bg_color = color;
}

uint16_t furi_hal_display_get_bg_color(void) {
    return st7565_bg_color;
}

#else /* !BOARD_DISPLAY_SSD1306_I2C, !BOARD_DISPLAY_ST7565_SPI — ST7789/JD9853 color LCD via esp_lcd SPI */

/* Display dimensions from board config */
#define LCD_H_RES BOARD_LCD_H_RES
#define LCD_V_RES BOARD_LCD_V_RES

/* Flipper framebuffer dimensions */
#define FB_WIDTH  128
#define FB_HEIGHT 64

/* Always-on left/right inset (in physical LCD pixels) kept as plain background
 * color so the UI never sits flush against the screen's left/right edges. A
 * board may override this in its board.h; otherwise this default applies
 * everywhere. Set to 0 to disable. */
#ifndef BOARD_LCD_SIDE_MARGIN
#define BOARD_LCD_SIDE_MARGIN 4
#endif
#define DISPLAY_SIDE_MARGIN BOARD_LCD_SIDE_MARGIN

/* Horizontal resolution actually available to the UI after reserving the
 * left/right margins. The aspect-fit below scales into this, then the result
 * is centered across the full LCD resolution — so the leftover on each side
 * is always >= the margin and is painted with the background color. */
#define USABLE_H_RES (LCD_H_RES - 2 * DISPLAY_SIDE_MARGIN)

/* Scale the 128x64 framebuffer to the largest centered size that keeps aspect ratio. */
#if (USABLE_H_RES * FB_HEIGHT) <= (LCD_V_RES * FB_WIDTH)
#define SCALED_WIDTH  USABLE_H_RES
#define SCALED_HEIGHT ((USABLE_H_RES * FB_HEIGHT) / FB_WIDTH)
#else
#define SCALED_HEIGHT LCD_V_RES
#define SCALED_WIDTH  ((LCD_V_RES * FB_WIDTH) / FB_HEIGHT)
#endif

/* Centering margins */
#define MARGIN_X ((LCD_H_RES - SCALED_WIDTH) / 2)
#define MARGIN_Y ((LCD_V_RES - SCALED_HEIGHT) / 2)

/* Colors from board config — both are set at runtime so the user can pick
 * UI Background (fg_color, the field that fills "unset" mono pixels) and
 * UI Foreground (bg_color, what fills "set" pixels = drawn UI elements). */
static uint16_t fg_color;
static uint16_t bg_color;

/* SPI configuration from board config */
#define LCD_SPI_HOST   BOARD_LCD_SPI_HOST
#define LCD_SPI_FREQ   BOARD_LCD_SPI_FREQ_HZ
#define LCD_CMD_BITS   BOARD_LCD_CMD_BITS
#define LCD_PARAM_BITS BOARD_LCD_PARAM_BITS

/* Stripe-based rendering: render & DMA-send N lines at a time.
 * Reduces DMA buffer from full-frame (~100KB) to a small stripe (~5KB). */
#define STRIPE_HEIGHT 8

static esp_lcd_panel_handle_t panel_handle = NULL;
static uint16_t* rgb565_buf = NULL; // STRIPE_HEIGHT lines only
static SemaphoreHandle_t lcd_flush_done = NULL;
static uint8_t x_scale_lut[SCALED_WIDTH];
static uint8_t y_scale_lut[SCALED_HEIGHT];

static bool furi_hal_display_flush_done_callback(
    esp_lcd_panel_io_handle_t panel_io,
    esp_lcd_panel_io_event_data_t* edata,
    void* user_ctx) {
    UNUSED(panel_io);
    UNUSED(edata);
    UNUSED(user_ctx);

    BaseType_t yield = pdFALSE;
    if(lcd_flush_done) {
        xSemaphoreGiveFromISR(lcd_flush_done, &yield);
    }

    return yield == pdTRUE;
}

static void furi_hal_display_prepare_flush(void) {
    if(!lcd_flush_done) return;

    xSemaphoreTake(lcd_flush_done, 0);
}

static void furi_hal_display_wait_flush(void) {
    if(!lcd_flush_done) return;

    if(xSemaphoreTake(lcd_flush_done, pdMS_TO_TICKS(250)) != pdTRUE) {
        ESP_LOGW(TAG, "Timed out waiting for LCD flush");
    }
}

static void furi_hal_display_init_scale_lut(void) {
    for(size_t x = 0; x < SCALED_WIDTH; x++) {
        x_scale_lut[x] = (x * FB_WIDTH) / SCALED_WIDTH;
    }

    for(size_t y = 0; y < SCALED_HEIGHT; y++) {
        y_scale_lut[y] = (y * FB_HEIGHT) / SCALED_HEIGHT;
    }
}

static void display_fill_color(uint16_t color) {
    uint16_t* line = heap_caps_malloc(LCD_H_RES * sizeof(uint16_t), MALLOC_CAP_DMA);
    if(!line) return;
    for(int i = 0; i < LCD_H_RES; i++) line[i] = color;
    furi_hal_spi_bus_lock();
    for(int y = 0; y < LCD_V_RES; y++) {
        furi_hal_display_prepare_flush();
        esp_lcd_panel_draw_bitmap(panel_handle, 0, y, LCD_H_RES, y + 1, line);
        furi_hal_display_wait_flush();
    }
    furi_hal_spi_bus_unlock();
    free(line);
}

/* Paint a solid-color rectangle using rgb565_buf as scratch. Caller must hold
 * the SPI bus lock. Chunks vertically at STRIPE_HEIGHT to stay within the
 * buffer's capacity (STRIPE_HEIGHT rows × SCALED_WIDTH cols). Used by the
 * commit path to keep the LCD margins in sync with fg_color changes. */
static void display_paint_rect(
    size_t x, size_t y, size_t w, size_t h, uint16_t color) {
    if(w == 0 || h == 0 || w > LCD_H_RES) return;

    for(size_t y_off = 0; y_off < h; y_off += STRIPE_HEIGHT) {
        size_t chunk_h = h - y_off;
        if(chunk_h > STRIPE_HEIGHT) chunk_h = STRIPE_HEIGHT;

        const size_t px_count = w * chunk_h;
        for(size_t i = 0; i < px_count; i++) rgb565_buf[i] = color;

        furi_hal_display_prepare_flush();
        esp_lcd_panel_draw_bitmap(
            panel_handle, x, y + y_off, x + w, y + y_off + chunk_h, rgb565_buf);
        furi_hal_display_wait_flush();
    }
}

void furi_hal_display_init(void) {
    ESP_LOGI(TAG, "Initializing display for %s", BOARD_NAME);
    furi_hal_spi_bus_init();
    if(!lcd_flush_done) {
        lcd_flush_done = xSemaphoreCreateBinary();
        ESP_ERROR_CHECK(lcd_flush_done ? ESP_OK : ESP_ERR_NO_MEM);
    }

    /* Initialize SPI bus */
    spi_bus_config_t bus_cfg = {
        .mosi_io_num = gpio_lcd_din.pin,
        .miso_io_num = gpio_sdcard_miso.pin,
        .sclk_io_num = gpio_lcd_clk.pin,
        .quadwp_io_num = -1,
        .quadhd_io_num = -1,
        .max_transfer_sz = LCD_H_RES * STRIPE_HEIGHT * sizeof(uint16_t),
    };
    esp_err_t spi_err = spi_bus_initialize(LCD_SPI_HOST, &bus_cfg, SPI_DMA_CH_AUTO);
    /* ESP_ERR_INVALID_STATE is OK — bus may already be initialized by SubGHz on shared-bus boards */
    if(spi_err != ESP_OK && spi_err != ESP_ERR_INVALID_STATE) {
        ESP_ERROR_CHECK(spi_err);
    }

    /* Create panel IO (SPI) */
    esp_lcd_panel_io_handle_t io_handle = NULL;
    esp_lcd_panel_io_spi_config_t io_config = {
        .dc_gpio_num = gpio_lcd_dc.pin,
        .cs_gpio_num = gpio_lcd_cs.pin,
        .pclk_hz = LCD_SPI_FREQ,
        .lcd_cmd_bits = LCD_CMD_BITS,
        .lcd_param_bits = LCD_PARAM_BITS,
        .spi_mode = 0,
        .trans_queue_depth = 1,
        .on_color_trans_done = furi_hal_display_flush_done_callback,
        .user_ctx = NULL,
    };
    ESP_ERROR_CHECK(esp_lcd_new_panel_io_spi(LCD_SPI_HOST, &io_config, &io_handle));

    /* Create ST7789 panel */
    esp_lcd_panel_dev_config_t panel_config = {
        .reset_gpio_num = gpio_lcd_rst.pin,
#if defined(BOARD_LCD_COLOR_ORDER_BGR) && BOARD_LCD_COLOR_ORDER_BGR
        .rgb_ele_order = LCD_RGB_ELEMENT_ORDER_BGR,
#else
        .rgb_ele_order = LCD_RGB_ELEMENT_ORDER_RGB,
#endif
        .bits_per_pixel = 16,
    };
    /* --- Bring the ST7789 to a known-clean state, every boot --------------
     * A software reset (esp_restart) does NOT power-cycle the display: the
     * ST7789 keeps every register — MADCTL/colour-order, COLMOD, inversion,
     * rotation. That happens after an `esptool` flash *and* after any other
     * firmware that configured the panel differently ran before us. If any of
     * that lingers the R/B channels end up swapped — Flipper orange shows up as
     * blue — until the user pulls the battery (a real cold boot). So we do what
     * a thorough driver (TFT_eSPI) does on every init: hardware-reset pulse →
     * SWRESET command → full panel init → re-assert COLMOD. After that the panel
     * is in *our* configuration regardless of what ran before. */

    /* 1) Hardware reset pulse on RESX (HIGH → LOW → HIGH, generous timing). */
    gpio_config_t rst_cfg = {
        .mode = GPIO_MODE_OUTPUT,
        .pin_bit_mask = 1ULL << gpio_lcd_rst.pin,
    };
    gpio_config(&rst_cfg);
    gpio_set_level((gpio_num_t)gpio_lcd_rst.pin, 1);   /* ensure a clean falling edge */
    vTaskDelay(pdMS_TO_TICKS(10));
    gpio_set_level((gpio_num_t)gpio_lcd_rst.pin, 0);   /* assert reset (active low) */
    vTaskDelay(pdMS_TO_TICKS(20));                      /* RESX min low is 10us; be generous */
    gpio_set_level((gpio_num_t)gpio_lcd_rst.pin, 1);   /* release reset */
    vTaskDelay(pdMS_TO_TICKS(150));                     /* ST7789: wait ≥120ms after reset */

    /* 2) Software reset (0x01) — re-loads all registers to factory defaults
     *    even if the RESX pulse above didn't fully take (e.g. a glitch on the
     *    line right after the ESP32 digital reset). The display still draws
     *    pixels in that case, so this command reaches it just fine. */
    ESP_ERROR_CHECK(esp_lcd_panel_io_tx_param(io_handle, 0x01 /* SWRESET */, NULL, 0));
    vTaskDelay(pdMS_TO_TICKS(150));

    ESP_ERROR_CHECK(esp_lcd_new_panel_st7789(io_handle, &panel_config, &panel_handle));

    /* 3) esp_lcd does another RESX pulse, then SLPOUT + COLMOD + MADCTL. */
    ESP_ERROR_CHECK(esp_lcd_panel_reset(panel_handle));
    ESP_ERROR_CHECK(esp_lcd_panel_init(panel_handle));

    /* Display orientation and corrections from board config (these (re)write
     * MADCTL with our colour order + mirror/swap bits, and INVON/INVOFF). */
    ESP_ERROR_CHECK(esp_lcd_panel_invert_color(panel_handle, BOARD_LCD_INVERT_COLOR));
    ESP_ERROR_CHECK(esp_lcd_panel_swap_xy(panel_handle, BOARD_LCD_SWAP_XY));
    ESP_ERROR_CHECK(esp_lcd_panel_mirror(panel_handle, BOARD_LCD_MIRROR_X, BOARD_LCD_MIRROR_Y));
    ESP_ERROR_CHECK(esp_lcd_panel_set_gap(panel_handle, BOARD_LCD_GAP_X, BOARD_LCD_GAP_Y));

    /* 4) Belt-and-suspenders: pin down pixel format + normal display mode.
     *    COLMOD 0x55 = 16 bits/pixel (RGB565) — matches bits_per_pixel=16 above;
     *    NORON (0x13) = normal display mode (not partial/idle). Both are no-ops
     *    when the state is already right and cost nothing. */
    {
        const uint8_t colmod = 0x55;
        ESP_ERROR_CHECK(esp_lcd_panel_io_tx_param(io_handle, 0x3A /* COLMOD */, &colmod, 1));
    }
    ESP_ERROR_CHECK(esp_lcd_panel_io_tx_param(io_handle, 0x13 /* NORON */, NULL, 0));

    /* Turn on display */
    ESP_ERROR_CHECK(esp_lcd_panel_disp_on_off(panel_handle, true));

    fg_color = BOARD_LCD_FG_COLOR;
    bg_color = BOARD_LCD_BG_COLOR;

    furi_hal_display_init_scale_lut();

    /* Allocate DMA-capable RGB565 stripe buffer (STRIPE_HEIGHT lines only).
     * Sized to the full LCD width so the same scratch buffer can paint the
     * full-width top/bottom margin strips as well as the scaled UI stripes. */
    size_t stripe_bytes = LCD_H_RES * STRIPE_HEIGHT * sizeof(uint16_t);
    rgb565_buf = heap_caps_malloc(stripe_bytes, MALLOC_CAP_DMA);
    if(!rgb565_buf) {
        ESP_LOGE(TAG, "Failed to allocate RGB565 stripe buffer (%d bytes)",
                 (int)stripe_bytes);
        return;
    }

    /* Clear entire screen to background (unset pixels = FG) */
    display_fill_color(fg_color);

    ESP_LOGI(TAG, "Display initialized (%dx%d, scaled %dx%d, stripe=%d lines, buf=%d bytes)",
             FB_WIDTH, FB_HEIGHT, SCALED_WIDTH, SCALED_HEIGHT, STRIPE_HEIGHT, (int)stripe_bytes);
}

void furi_hal_display_commit(const uint8_t* data, uint32_t size) {
    UNUSED(size);
    if(!panel_handle || !rgb565_buf || !data) return;

    /*
     * Stripe-based rendering: render STRIPE_HEIGHT lines into the small DMA
     * buffer, send via SPI, then render the next stripe.
     * Saves ~95KB of internal DMA-capable SRAM.
     *
     * u8g2 tile buffer layout:
     * 8 pages of 128 bytes each (128 columns × 8 pages = 1024 bytes)
     * Byte at [page * 128 + x]: bit n = pixel at (x, page*8 + n)
     * Bit 0 = top pixel in tile, bit 7 = bottom pixel in tile
     */
    furi_hal_spi_bus_lock();

    /* Repaint the margin strips with the current fg_color every frame so the
     * entire screen tracks UI Color changes. Without this the init-time fill
     * persists and the margins keep showing the boot-time orange while the
     * central framebuffer area updates.
     *
     * Top/bottom strips span the full width; left/right strips (the always-on
     * DISPLAY_SIDE_MARGIN inset, plus any extra from aspect-fit centering) span
     * only the height of the scaled image so they don't overdraw the corners. */
    if(MARGIN_Y > 0) {
        display_paint_rect(0, 0, LCD_H_RES, MARGIN_Y, fg_color);
        display_paint_rect(
            0, MARGIN_Y + SCALED_HEIGHT,
            LCD_H_RES, LCD_V_RES - MARGIN_Y - SCALED_HEIGHT, fg_color);
    }
    if(MARGIN_X > 0) {
        display_paint_rect(0, MARGIN_Y, MARGIN_X, SCALED_HEIGHT, fg_color);
        display_paint_rect(
            MARGIN_X + SCALED_WIDTH, MARGIN_Y,
            LCD_H_RES - MARGIN_X - SCALED_WIDTH, SCALED_HEIGHT, fg_color);
    }

    for(size_t stripe_y = 0; stripe_y < SCALED_HEIGHT; stripe_y += STRIPE_HEIGHT) {
        size_t stripe_h = STRIPE_HEIGHT;
        if(stripe_y + stripe_h > SCALED_HEIGHT) {
            stripe_h = SCALED_HEIGHT - stripe_y;
        }

        /* Render stripe into buffer */
        for(size_t row = 0; row < stripe_h; row++) {
            const size_t sy = stripe_y + row;
            const uint8_t mono_y = y_scale_lut[sy];
            const size_t page = mono_y >> 3;
            const uint8_t bit_mask = 1U << (mono_y & 0x07);
            uint16_t* dst = &rgb565_buf[row * SCALED_WIDTH];

            for(size_t sx = 0; sx < SCALED_WIDTH; sx++) {
                const uint8_t mono_x = x_scale_lut[sx];
                const bool pixel_set = (data[page * FB_WIDTH + mono_x] & bit_mask) != 0;
                dst[sx] = pixel_set ? bg_color : fg_color;
            }
        }

        /* DMA send this stripe */
        furi_hal_display_prepare_flush();
        esp_lcd_panel_draw_bitmap(
            panel_handle,
            MARGIN_X, MARGIN_Y + stripe_y,
            MARGIN_X + SCALED_WIDTH, MARGIN_Y + stripe_y + stripe_h,
            rgb565_buf);
        furi_hal_display_wait_flush();
    }

    furi_hal_spi_bus_unlock();
}

void furi_hal_display_set_backlight(uint8_t brightness) {
    furi_hal_light_set(LightBacklight, brightness);
}

void furi_hal_display_sleep(void) {
    if(!panel_handle) return;
    furi_hal_spi_bus_lock();
    /* SLPIN: stop the panel's internal oscillator/booster to cut idle current */
    esp_lcd_panel_disp_on_off(panel_handle, false);
    furi_hal_spi_bus_unlock();
}

uint16_t furi_hal_display_get_h_res(void) {
    return LCD_H_RES;
}

uint16_t furi_hal_display_get_v_res(void) {
    return LCD_V_RES;
}

esp_lcd_panel_handle_t furi_hal_display_get_panel_handle(void) {
    return panel_handle;
}

void furi_hal_display_set_fg_color(uint16_t color) {
    fg_color = color;
}

uint16_t furi_hal_display_get_fg_color(void) {
    return fg_color;
}

void furi_hal_display_set_bg_color(uint16_t color) {
    bg_color = color;
}

uint16_t furi_hal_display_get_bg_color(void) {
    return bg_color;
}

#endif /* BOARD_DISPLAY_SSD1306_I2C / BOARD_DISPLAY_ST7565_SPI */
