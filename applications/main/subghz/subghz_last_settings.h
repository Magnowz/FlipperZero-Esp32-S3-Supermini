#pragma once

#include <furi_hal.h>
#include <stdint.h>
#include <stdbool.h>
#include <storage/storage.h>
#include <lib/subghz/types.h>

/* -93 dBm (stock default) sits close to the noise floor of cheap CC1101
 * modules and triggers false hits from board self-noise (e.g. the SD card
 * sharing the CC1101 SPI bus on boards where BOARD_CC1101_SPI_SHARED=1).
 * -80 dBm still catches real remotes (which arrive much stronger) while
 * ignoring weak/borderline noise. */
#define SUBGHZ_LAST_SETTING_FREQUENCY_ANALYZER_TRIGGER        (-80.0f)
// 1 = "AM650"
// "AM270", "AM650", "FM238", "FM12K", "FM476",
#define SUBGHZ_LAST_SETTING_DEFAULT_PRESET                    1
#define SUBGHZ_LAST_SETTING_DEFAULT_FREQUENCY                 433920000
#define SUBGHZ_LAST_SETTING_FREQUENCY_ANALYZER_FEEDBACK_LEVEL 2

typedef struct {
    uint32_t frequency;
    uint32_t preset_index; // AKA Modulation
    uint32_t frequency_analyzer_feedback_level;
    float frequency_analyzer_trigger;
    bool protocol_file_names;
    bool enable_hopping;
    uint32_t ignore_filter;
    uint32_t filter;
    float rssi;
    bool delete_old_signals;
    float hopping_threshold;
    bool leds_and_amp;
    uint8_t tx_power;
    int32_t frequency_offset; // Hz, crystal calibration offset
} SubGhzLastSettings;

SubGhzLastSettings* subghz_last_settings_alloc(void);

void subghz_last_settings_free(SubGhzLastSettings* instance);

void subghz_last_settings_load(SubGhzLastSettings* instance, size_t preset_count);

bool subghz_last_settings_save(SubGhzLastSettings* instance);
