/**
 * @file board_esp32s3_supermini_st7565.h
 * Board definition: ESP32-S3 Super Mini + ST7565 128x64 LCD (LCD12864-06D)
 *
 * MCU:      ESP32-S3FH4R2 "Super Mini" dev board (4MB Flash, 2MB Quad PSRAM)
 * Display:  ST7565 128x64 mono LCD (e.g. GMG12864-06D COG module) via 4-wire
 *           SPI — deliberately reuses the SSD1306 variant's existing pin
 *           budget instead of claiming new GPIOs: SCLK/MOSI are CS-muxed
 *           onto the same SPI2 bus already wired for CC1101/SD (see
 *           furi_hal_spi.c's furi_hal_spi_bus_handle_lcd_st7565), and CS/DC
 *           reuse the pins the SSD1306 variant used for its I2C bus (SDA/SCL
 *           are free once the display is no longer I2C). There's no
 *           dedicated RST pin in this pinout — tie the panel's RST to 3.3V
 *           through a resistor and let the software-reset command in
 *           furi_hal_display.c bring it up. Native Flipper framebuffer
 *           resolution, written straight to GDDRAM — same page-addressed
 *           1bpp layout as the SSD1306 variant, no scaling/color conversion.
 * Input:    6x tactile buttons to GND, internal pull-ups. Up/Down/OK/Back
 *           drive the menus; Left/Right are polled+debounced but unused for
 *           now (reserved for game controls, e.g. Doom/Flappy Bird)
 * SubGHz:   CC1101 via SPI (shared bus with SD card *and* the LCD now,
 *           CS-muxed) — still SPI2_HOST
 * SD Card:  SPI (shared bus with CC1101 and the LCD)
 * NFC:      PN532 via I2C — optional, user-wired; no IRQ/RST pins used
 *           (see furi_hal_nfc.c). Moved to GPIO14/15 on this variant since
 *           the display now occupies the SSD1306 variant's old I2C pins
 *           (8/9) for its CS/DC lines.
 * IR:       TX-only breakout on GPIO44 — optional, user-wired; no receiver
 * NRF24/Speaker/Mic/RGB: not wired on this board
 *
 * NOTE: 4MB flash is tight for this firmware's full app set. If the build
 * overflows the partition, trim more apps in fam_config.py (WiFi/BLE are
 * the biggest) rather than switching partition tables.
 */

#pragma once

/* ---- Board metadata ---- */
#define BOARD_NAME        "ESP32-S3 Super Mini ST7565"
#define BOARD_TARGET      "esp32s3"

/* ---- Hardware Button Pins (internal pull-up, active low, wired to GND) ---- */
#define BOARD_PIN_BTN_UP        10
#define BOARD_PIN_BTN_DOWN      11
#define BOARD_PIN_BTN_OK        12
#define BOARD_PIN_BTN_BACK      13
#define BOARD_PIN_BTN_LEFT      1   /* reserved for game controls */
#define BOARD_PIN_BTN_RIGHT     2   /* reserved for game controls */
#define BOARD_PIN_BUTTON_BOOT   12  /* alias OK — deep-sleep wake / power-off hold */
#define BOARD_PIN_BATTERY_ADC   UINT16_MAX  /* No battery ADC on this board */

/* ---- Display: ST7565 128x64 mono LCD via 4-wire SPI, CS-muxed onto the
 * CC1101/SD SPI2 bus ----
 * BOARD_DISPLAY_ST7565_SPI switches furi_hal_display.c from the default
 * ST7789/esp_lcd SPI driver to a raw ST7565 command/page driver that talks
 * over furi_hal_spi_bus_handle_lcd_st7565 (see furi_hal_spi.c) instead of
 * owning its own SPI peripheral. SCLK/MOSI below are therefore the *same*
 * physical pins as BOARD_PIN_CC1101_SCK/MOSI further down — that's
 * intentional, not a typo. Only CS and DC are LCD-exclusive, and both reuse
 * pins the SSD1306 variant spent on its I2C bus (SDA=8/SCL=9), so this
 * pinout adds zero new GPIOs versus board_esp32s3_supermini_ssd1306.h. */
#define BOARD_DISPLAY_ST7565_SPI 1
#define BOARD_PIN_LCD_MOSI      6   /* SI  — shared with BOARD_PIN_CC1101_MOSI */
#define BOARD_PIN_LCD_SCLK      4   /* SCL — shared with BOARD_PIN_CC1101_SCK */
#define BOARD_PIN_LCD_CS        8   /* CS  — ex-OLED SDA pin */
#define BOARD_PIN_LCD_DC        9   /* A0/RS — ex-OLED SCL pin */
#define BOARD_PIN_LCD_RST       UINT16_MAX  /* No dedicated pin — tie RST to 3.3V via a resistor;
                                              * furi_hal_display.c falls back to a software reset (0xE2). */
#define BOARD_PIN_LCD_BL        UINT16_MAX  /* Reflective glass — no backlight on this module */
#define BOARD_HAS_LCD_BACKLIGHT 0            /* skips LEDC PWM setup on the dummy BL pin */
#define BOARD_LCD_H_RES         128
#define BOARD_LCD_V_RES         64
#define BOARD_LCD_BL_ACTIVE_LOW false
/* Some ST7565 12864 modules address a 132-column-wide GDDRAM but only wire
 * up 128 of them, shifted by 4 — if the image is offset/shifted sideways,
 * try 4 here. */
#define BOARD_LCD_COL_OFFSET    0

/* ---- SD Card (shared SPI bus with CC1101 below) ----
 * CLK/MOSI/MISO are the CC1101 pins; CS is the Super Mini's "TX" pin. */
#define BOARD_PIN_SD_CS         43
#define BOARD_PIN_SD_MISO       5

/* ---- Touch Controller — NOT PRESENT (button input) ---- */
#define BOARD_PIN_TOUCH_SCL     UINT16_MAX
#define BOARD_PIN_TOUCH_SDA     UINT16_MAX
#define BOARD_PIN_TOUCH_RST     UINT16_MAX
#define BOARD_PIN_TOUCH_INT     UINT16_MAX
#define BOARD_TOUCH_I2C_ADDR    0x00
#define BOARD_TOUCH_I2C_PORT    I2C_NUM_0
#define BOARD_TOUCH_I2C_FREQ_HZ 0
#define BOARD_TOUCH_I2C_TIMEOUT 0

/* ---- SubGHz / CC1101 (shared SPI bus with SD card AND the LCD, CS-muxed) ---- */
#define BOARD_PIN_CC1101_SCK    4
#define BOARD_PIN_CC1101_CSN    7
#define BOARD_PIN_CC1101_MISO   5
#define BOARD_PIN_CC1101_MOSI   6
#define BOARD_PIN_CC1101_GDO0   3
#define BOARD_PIN_CC1101_GDO2   UINT16_MAX  /* not wired */
#define BOARD_CC1101_SPI_SHARED 1           /* CC1101 shares SPI2_HOST with SD and the LCD */

/* ---- NFC: PN532 (I2C) — moved to GPIO14/15 on this variant, since 8/9
 * (the SSD1306 variant's I2C pins) are now the LCD's CS/DC lines. IRQ/RST
 * are intentionally left undefined: furi_hal_nfc.c guards both with #ifdef
 * and falls back to I2C status-byte polling / skips the RST toggle. */
#define BOARD_PIN_NFC_SCL       14
#define BOARD_PIN_NFC_SDA       15
#define BOARD_NFC_I2C_PORT      I2C_NUM_0

/* ---- IR: TX-only breakout module (GND/VCC/OUT) on GPIO44 ("RX", silkscreened
 * next to GPIO43 "TX" — both broken out as the UART0 pair). No receiver
 * wired: BOARD_PIN_IR_RX stays UINT16_MAX, and furi_hal_infrared.c's RX
 * start now checks for that and fails gracefully instead of aborting. */
#define BOARD_PIN_IR_TX         44
#define BOARD_PIN_IR_RX         UINT16_MAX

/* ---- Features ---- */
#define BOARD_HAS_TOUCH         0
#define BOARD_HAS_ENCODER       0
#define BOARD_HAS_SD_CARD       1
#define BOARD_HAS_BLE           1
#define BOARD_HAS_RGB_LED       0
#define BOARD_HAS_VIBRO         0
#define BOARD_HAS_SPEAKER       0
#define BOARD_HAS_IR            1  /* TX-only, see BOARD_PIN_IR_TX above */
#define BOARD_HAS_IBUTTON       0
#define BOARD_HAS_RFID          0

/* Single USB-C port doubles as the flashing/console USB-Serial-JTAG bridge.
 * Claiming it for USB-OTG (HID, MSC, ...) drops that bridge, so apps should
 * default to BLE instead of grabbing USB unconditionally. */
#define BOARD_USB_SHARED_WITH_CONSOLE 1
#define BOARD_HAS_NFC           1  /* PN532 on its own I2C bus (GPIO14/15) */
#define BOARD_HAS_SUBGHZ        1  /* Built-in CC1101 */
#define BOARD_HAS_MIC           0

/* ---- Power Management (no fuel gauge / charger present on this board) ---- */
#define BQ27220_ADDR                    0x55
#define BQ25896_CHARGE_LIMIT            1280
#define FURI_HAL_POWER_VIRTUAL_CAPACITY_MAH (1300U)
