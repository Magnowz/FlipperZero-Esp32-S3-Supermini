/**
 * @file board_esp32s3_supermini_ssd1306.h
 * Board definition: ESP32-S3 Super Mini + SSD1306 128x64 OLED
 *
 * MCU:      ESP32-S3FH4R2 "Super Mini" dev board (4MB Flash, 2MB Quad PSRAM)
 * Display:  SSD1306 128x64 mono OLED via I2C — native Flipper framebuffer
 *           resolution, written straight to GDDRAM (see furi_hal_display.c)
 * Input:    6x tactile buttons to GND, internal pull-ups. Up/Down/OK/Back
 *           drive the menus; Left/Right are polled+debounced but unused for
 *           now (reserved for game controls, e.g. Doom/Flappy Bird)
 * SubGHz:   CC1101 via SPI (shared bus with SD card, CS-muxed)
 * SD Card:  SPI (shared bus with CC1101)
 * NFC/IR/NRF24/Speaker/Mic/RGB: not wired on this board
 *
 * NOTE: 4MB flash is tight for this firmware's full app set. If the build
 * overflows the partition, trim more apps in fam_config.py (WiFi/BLE are
 * the biggest) rather than switching partition tables.
 */

#pragma once

/* ---- Board metadata ---- */
#define BOARD_NAME        "ESP32-S3 Super Mini SSD1306"
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

/* ---- Display: SSD1306 128x64 mono OLED via I2C ----
 * BOARD_DISPLAY_SSD1306_I2C switches furi_hal_display.c from the default
 * ST7789/esp_lcd SPI driver to the I2C SSD1306 driver. */
#define BOARD_DISPLAY_SSD1306_I2C 1
#define BOARD_PIN_OLED_SDA      8
#define BOARD_PIN_OLED_SCL      9
#define BOARD_OLED_I2C_PORT     I2C_NUM_0
#define BOARD_OLED_I2C_FREQ_HZ  400000
#define BOARD_OLED_I2C_ADDR     0x3C  /* Some modules use 0x3D — change here if the screen stays blank */

/* ---- LCD pins/geometry — no SPI LCD on this board. Dummy pin values are
 * still required: board.h sanity-checks BOARD_PIN_LCD_MOSI, and
 * furi_hal_resources.c unconditionally builds a GpioPin struct from each
 * (harmless — never touched in the SSD1306 I2C driver path). ---- */
#define BOARD_PIN_LCD_MOSI      UINT16_MAX
#define BOARD_PIN_LCD_SCLK      UINT16_MAX
#define BOARD_PIN_LCD_DC        UINT16_MAX
#define BOARD_PIN_LCD_CS        UINT16_MAX
#define BOARD_PIN_LCD_RST       UINT16_MAX
#define BOARD_PIN_LCD_BL        UINT16_MAX  /* OLED is self-lit — no backlight pin */
#define BOARD_HAS_LCD_BACKLIGHT 0           /* skips LEDC PWM setup on the dummy BL pin */
#define BOARD_LCD_H_RES         128
#define BOARD_LCD_V_RES         64
#define BOARD_LCD_BL_ACTIVE_LOW false

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

/* ---- SubGHz / CC1101 (shared SPI bus with SD card, CS-muxed) ---- */
#define BOARD_PIN_CC1101_SCK    4
#define BOARD_PIN_CC1101_CSN    7
#define BOARD_PIN_CC1101_MISO   5
#define BOARD_PIN_CC1101_MOSI   6
#define BOARD_PIN_CC1101_GDO0   3
#define BOARD_PIN_CC1101_GDO2   UINT16_MAX  /* not wired */
#define BOARD_CC1101_SPI_SHARED 1           /* CC1101 shares SPI2_HOST with SD */

/* ---- NFC / IR — not wired on this board ---- */
#define BOARD_PIN_NFC_SCL       UINT16_MAX
#define BOARD_PIN_NFC_SDA       UINT16_MAX
#define BOARD_PIN_NFC_IRQ       UINT16_MAX
#define BOARD_PIN_NFC_RST       UINT16_MAX
#define BOARD_NFC_I2C_PORT      I2C_NUM_0
#define BOARD_PIN_IR_TX         UINT16_MAX
#define BOARD_PIN_IR_RX         UINT16_MAX

/* ---- Features ---- */
#define BOARD_HAS_TOUCH         0
#define BOARD_HAS_ENCODER       0
#define BOARD_HAS_SD_CARD       1
#define BOARD_HAS_BLE           1
#define BOARD_HAS_RGB_LED       0
#define BOARD_HAS_VIBRO         0
#define BOARD_HAS_SPEAKER       0
#define BOARD_HAS_IR            0
#define BOARD_HAS_IBUTTON       0
#define BOARD_HAS_RFID          0

/* Single USB-C port doubles as the flashing/console USB-Serial-JTAG bridge.
 * Claiming it for USB-OTG (HID, MSC, ...) drops that bridge, so apps should
 * default to BLE instead of grabbing USB unconditionally. */
#define BOARD_USB_SHARED_WITH_CONSOLE 1
#define BOARD_HAS_NFC           0
#define BOARD_HAS_SUBGHZ        1  /* Built-in CC1101 */
#define BOARD_HAS_MIC           0

/* ---- Power Management (no fuel gauge / charger present on this board) ---- */
#define BQ27220_ADDR                    0x55
#define BQ25896_CHARGE_LIMIT            1280
#define FURI_HAL_POWER_VIRTUAL_CAPACITY_MAH (1300U)
