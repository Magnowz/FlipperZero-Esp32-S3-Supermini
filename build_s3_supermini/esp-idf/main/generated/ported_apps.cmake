set(ESP32_FAM_PORTED_OBJECT_TARGETS)

set(ESP32_FAM_ASSETS_SCRIPT "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/tools/fam/compile_icons.py")
set(ESP32_FAM_RUNTIME_ROOT "${ESP32_FAM_GENERATED_DIR}/fam_runtime_root")
set(ESP32_FAM_RUNTIME_EXT_ROOT "${ESP32_FAM_RUNTIME_ROOT}/ext")
set(ESP32_FAM_STAGE_ASSETS_STAMP "${ESP32_FAM_RUNTIME_ROOT}/.assets.stamp")

add_library(esp32_fam_app_cli OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/cli/cli_main_commands.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/cli/cli_main_shell.c"
)
target_include_directories(esp32_fam_app_cli PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/cli"
)
target_compile_definitions(esp32_fam_app_cli PRIVATE SRV_CLI)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_cli)

add_library(esp32_fam_app_cli_subghz OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_chat.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_cli.c"
)
target_include_directories(esp32_fam_app_cli_subghz PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_cli_subghz)

add_library(esp32_fam_app_example_apps_assets OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets/example_apps_assets.c"
)
target_include_directories(esp32_fam_app_example_apps_assets PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_example_apps_assets)

add_library(esp32_fam_app_example_apps_data OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_data/example_apps_data.c"
)
target_include_directories(esp32_fam_app_example_apps_data PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_data"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_example_apps_data)

add_library(esp32_fam_app_example_number_input OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_number_input/example_number_input.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_number_input/scenes/example_number_input_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_number_input/scenes/example_number_input_scene_input_max.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_number_input/scenes/example_number_input_scene_input_min.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_number_input/scenes/example_number_input_scene_input_number.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_number_input/scenes/example_number_input_scene_show_number.c"
)
target_include_directories(esp32_fam_app_example_number_input PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_number_input"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_example_number_input)

add_library(esp32_fam_app_js_blebeacon OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_blebeacon.c"
)
target_include_directories(esp32_fam_app_js_blebeacon PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_blebeacon PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_blebeacon)

add_library(esp32_fam_app_js_event_loop OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_event_loop/js_event_loop.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_event_loop/js_event_loop_api_table.cpp"
)
target_include_directories(esp32_fam_app_js_event_loop PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_event_loop PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_event_loop)

add_library(esp32_fam_app_js_gui OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/js_gui.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/js_gui_api_table.cpp"
)
target_include_directories(esp32_fam_app_js_gui PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui)

add_library(esp32_fam_app_js_gui__button_menu OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/button_menu.c"
)
target_include_directories(esp32_fam_app_js_gui__button_menu PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__button_menu PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__button_menu)

add_library(esp32_fam_app_js_gui__button_panel OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/button_panel.c"
)
target_include_directories(esp32_fam_app_js_gui__button_panel PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__button_panel PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__button_panel)

add_library(esp32_fam_app_js_gui__byte_input OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/byte_input.c"
)
target_include_directories(esp32_fam_app_js_gui__byte_input PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__byte_input PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__byte_input)

add_library(esp32_fam_app_js_gui__dialog OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/dialog.c"
)
target_include_directories(esp32_fam_app_js_gui__dialog PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__dialog PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__dialog)

add_library(esp32_fam_app_js_gui__empty_screen OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/empty_screen.c"
)
target_include_directories(esp32_fam_app_js_gui__empty_screen PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__empty_screen PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__empty_screen)

add_library(esp32_fam_app_js_gui__file_picker OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/file_picker.c"
)
target_include_directories(esp32_fam_app_js_gui__file_picker PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__file_picker PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__file_picker)

add_library(esp32_fam_app_js_gui__icon OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/icon.c"
)
target_include_directories(esp32_fam_app_js_gui__icon PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__icon PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__icon)

add_library(esp32_fam_app_js_gui__loading OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/loading.c"
)
target_include_directories(esp32_fam_app_js_gui__loading PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__loading PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__loading)

add_library(esp32_fam_app_js_gui__menu OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/menu.c"
)
target_include_directories(esp32_fam_app_js_gui__menu PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__menu PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__menu)

add_library(esp32_fam_app_js_gui__number_input OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/number_input.c"
)
target_include_directories(esp32_fam_app_js_gui__number_input PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__number_input PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__number_input)

add_library(esp32_fam_app_js_gui__popup OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/popup.c"
)
target_include_directories(esp32_fam_app_js_gui__popup PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__popup PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__popup)

add_library(esp32_fam_app_js_gui__submenu OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/submenu.c"
)
target_include_directories(esp32_fam_app_js_gui__submenu PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__submenu PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__submenu)

add_library(esp32_fam_app_js_gui__text_box OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/text_box.c"
)
target_include_directories(esp32_fam_app_js_gui__text_box PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__text_box PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__text_box)

add_library(esp32_fam_app_js_gui__text_input OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/text_input.c"
)
target_include_directories(esp32_fam_app_js_gui__text_input PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__text_input PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__text_input)

add_library(esp32_fam_app_js_gui__vi_list OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/vi_list.c"
)
target_include_directories(esp32_fam_app_js_gui__vi_list PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__vi_list PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__vi_list)

add_library(esp32_fam_app_js_gui__widget OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_gui/widget.c"
)
target_include_directories(esp32_fam_app_js_gui__widget PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__widget PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__widget)

add_library(esp32_fam_app_js_math OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_math.c"
)
target_include_directories(esp32_fam_app_js_math PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_math PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_math)

add_library(esp32_fam_app_js_notification OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_notification.c"
)
target_include_directories(esp32_fam_app_js_notification PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_notification PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_notification)

add_library(esp32_fam_app_js_storage OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_storage.c"
)
target_include_directories(esp32_fam_app_js_storage PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_storage PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_storage)

add_library(esp32_fam_app_js_subghz OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_subghz/js_subghz.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_subghz/radio_device_loader.c"
)
target_include_directories(esp32_fam_app_js_subghz PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_subghz PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_subghz)

add_library(esp32_fam_app_keypad_test OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/debug/keypad_test/keypad_test.c"
)
target_include_directories(esp32_fam_app_keypad_test PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/debug/keypad_test"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_keypad_test)

add_library(esp32_fam_app_subghz OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/radio_device_loader.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_device.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_protocols.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_radio_device_loader.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_worker.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_chat.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_frequency_analyzer_worker.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_gen_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_threshold_rssi.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_txrx.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_txrx_create_protocol_key.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_usb_export.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_load_file.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_load_select.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_run_attack.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_save_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_save_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_setup_attack.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_setup_extra.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_decode_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_delete.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_delete_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_delete_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_frequency_analyzer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_jammer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_more_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_need_saving.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_playlist.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_radio_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_read_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_receiver.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_receiver_config.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_receiver_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_rpc.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_save_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_save_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_saved.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_saved_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_button.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_counter.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_key.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_seed.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_serial.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_type.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_show_error.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_show_error_sub.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_signal_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_tpms_edit.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_transmitter.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_cli.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_dangerous_freq.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_history.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_i.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_last_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/receiver.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subbrute_attack_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subbrute_main_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_frequency_analyzer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_jammer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_playlist.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_read_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_view_tpms_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/transmitter.c"
)
target_include_directories(esp32_fam_app_subghz PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz"
)
target_compile_definitions(esp32_fam_app_subghz PRIVATE APP_SUBGHZ)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_subghz)

add_library(esp32_fam_app_cli_vcp OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/cli/cli_vcp.c"
)
target_include_directories(esp32_fam_app_cli_vcp PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/cli"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_cli_vcp)

add_library(esp32_fam_app_js_app OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/js_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/js_modules.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/js_thread.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/js_value.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_flipper.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/modules/js_tests.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/plugin_api/app_api_table.cpp"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/views/console_view.c"
)
target_include_directories(esp32_fam_app_js_app PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_app PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_app)

add_library(esp32_fam_app_power_settings OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/power_settings_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/scenes/power_settings_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/scenes/power_settings_scene_battery_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/scenes/power_settings_scene_power_off.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/scenes/power_settings_scene_reboot.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/scenes/power_settings_scene_reboot_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/scenes/power_settings_scene_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app/views/battery_info.c"
)
target_include_directories(esp32_fam_app_power_settings PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/power_settings_app"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_power_settings)

add_library(esp32_fam_app_lfrfid OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/lfrfid.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/lfrfid_cli.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_clear_t5577.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_clear_t5577_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_delete_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_delete_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_emulate.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_enter_password.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_exit_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_extra_actions.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_raw_emulate.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_raw_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_raw_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_raw_read.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_raw_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_read.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_read_key_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_read_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_retry_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_rpc.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_save_data.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_save_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_save_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_save_type.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_saved_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_saved_key_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_select_key.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_select_raw_key.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_write.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_write_and_set_pass.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/scenes/lfrfid_scene_write_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/views/lfrfid_view_read.c"
)
target_include_directories(esp32_fam_app_lfrfid PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_lfrfid)

add_library(esp32_fam_app_storage_settings OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_benchmark.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_benchmark_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_factory_reset.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_format_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_formatting.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_internal_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_sd_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_unmount_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/scenes/storage_settings_scene_unmounted.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings/storage_settings.c"
)
target_include_directories(esp32_fam_app_storage_settings PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/storage_settings"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_storage_settings)

add_library(esp32_fam_app_nfc OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/chameleon/chameleon.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/chameleon/chameleon_nfc.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/felica_auth.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/mf_classic_key_cache.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/mf_ultralight_auth.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/mf_user_dict.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/mfkey32_logger.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/nfc_detected_protocols.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/nfc_emv_parser.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/nfc_supported_cards.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/emv/emv.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/emv/emv_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/felica/felica.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/felica/felica_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_3a/iso14443_3a.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_3a/iso14443_3a_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_3b/iso14443_3b.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_3b/iso14443_3b_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_4a/iso14443_4a.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_4a/iso14443_4a_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_4b/iso14443_4b.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso14443_4b/iso14443_4b_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso15693_3/iso15693_3.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/iso15693_3/iso15693_3_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_classic/mf_classic.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_classic/mf_classic_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_desfire/mf_desfire.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_desfire/mf_desfire_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_plus/mf_plus.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_plus/mf_plus_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_ultralight/mf_ultralight.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/mf_ultralight/mf_ultralight_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/nfc_protocol_support.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/nfc_protocol_support_gui_common.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/nfc_protocol_support_unlock_helper.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/ntag4xx/ntag4xx.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/ntag4xx/ntag4xx_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/slix/slix.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/slix/slix_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/st25tb/st25tb.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/st25tb/st25tb_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/type_4_tag/type_4_tag.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/protocol_support/type_4_tag/type_4_tag_render.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/helpers/slix_unlock.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/nfc_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_chameleon_wipe.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_clone_place_blank.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_debug.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_delete.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_delete_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_des_auth_key_input.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_des_auth_unlock_warn.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_detect.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_emulate.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_emv_transactions.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_exit_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_extra_actions.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_felica_more_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_felica_system.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_field.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_file_select.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_generate_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_detect_reader.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_dict_attack.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_keys.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_add.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_delete.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_list.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_warn_duplicate.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_mfkey_complete.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_mfkey_nonces_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_show_keys.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_update_initial.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_update_initial_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_classic_update_initial_wrong_card.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_desfire_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_desfire_more_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_dict_attack.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_add.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_delete.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_list.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_warn_duplicate.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_capture_pass.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_key_input.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_unlock_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_mf_ultralight_unlock_warn.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_more_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_read.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_read_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_read_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_restore_original.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_restore_original_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_retry_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_rpc.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_save_confirm.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_save_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_save_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_saved_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_select_protocol.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_set_atqa.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_set_sak.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_set_type.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_set_uid.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_slix_key_input.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_slix_unlock.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_slix_unlock_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_slix_unlock_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_supported_card.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/scenes/nfc_scene_write.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/views/detect_reader.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/views/dict_attack.c"
)
target_include_directories(esp32_fam_app_nfc PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_nfc)

add_library(esp32_fam_app_desktop_settings OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/desktop_settings_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/helpers/pin_code.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_change_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_favorite.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_happy_mode.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_name_popup.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_auth.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_disable.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_error.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_setup.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_setup_done.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_setup_howto.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_pin_setup_howto2.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/scenes/desktop_settings_scene_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/views/desktop_settings_view_pin_setup_howto.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/views/desktop_settings_view_pin_setup_howto2.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings/views/desktop_view_pin_input.c"
)
target_include_directories(esp32_fam_app_desktop_settings PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/desktop_settings"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_desktop_settings)

add_library(esp32_fam_app_dolphin OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/dolphin/dolphin.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/dolphin/helpers/dolphin_deed.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/dolphin/helpers/dolphin_state.c"
)
target_include_directories(esp32_fam_app_dolphin PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/dolphin"
)
target_compile_definitions(esp32_fam_app_dolphin PRIVATE SRV_DOLPHIN)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_dolphin)

add_library(esp32_fam_app_power_start OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_cli.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/power.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/power_api.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/power_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/views/power_off.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/views/power_unplug_usb.c"
)
target_include_directories(esp32_fam_app_power_start PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_power_start)

add_library(esp32_fam_app_ble_spam OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/ble_auto_walk_log.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/ble_spam_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/ble_spam_hal.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/ble_tracker_hal.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/ble_uuid_db.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/ble_walk_hal.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_auto_walk.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_main.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_pair_spam_custom.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_race_detector.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_running.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_spam_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_tracker_geiger.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_tracker_scan.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_walk_char_detail.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_walk_chars.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_walk_scan.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scene_walk_services.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/scenes/scenes.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/views/ble_auto_walk_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/views/ble_spam_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/views/ble_walk_detail_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/views/ble_walk_scan_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/views/race_detector_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/views/tracker_geiger_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam/views/tracker_list_view.c"
)
target_include_directories(esp32_fam_app_ble_spam PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/ble_spam"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_ble_spam)

add_library(esp32_fam_app_wlan OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_attack_targets.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_client_picker.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_connect.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_evil_portal.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_evil_portal_bridge_pwd.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_evil_portal_bridge_ssid.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_evil_portal_captured.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_evil_portal_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_evil_portal_ssid.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_handshake.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_handshake_save_path.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_handshake_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_lan.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_live_creds.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_main.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_mitm_inject_code.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_mitm_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_network_actions.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_network_deauth.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_network_scanning.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_package_sniffer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_port_scanner.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_ssid_connect.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_ssid_screen.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_ssid_spam.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_ssid_spam_custom.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_ssid_spam_run.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scene_update_sd.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/scenes/scenes.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_connect_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_deauther_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_evil_portal_captured_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_evil_portal_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_handshake_channel_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_handshake_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_lan_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_live_creds_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_portscan_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_sd_update_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_sniffer_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/views/wlan_view_common.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_client_scanner.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_cred_sniff.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_evil_portal.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_evil_portal_bridge.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_evil_portal_html.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_evil_portal_templates.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_hal.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_handshake_parser.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_handshake_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_html_inject.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_lan_cache.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_mitm_payloads.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_mitm_server.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_netcut.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_netscan.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_oui.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_passwords.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_pcap.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app/wlan_sd_update.c"
)
target_include_directories(esp32_fam_app_wlan PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/wlan_app"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_wlan)

add_library(esp32_fam_app_bad_usb OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/bad_usb_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/helpers/bad_usb_hid.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/helpers/ble_hid_ext_profile.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/helpers/ducky_script.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/helpers/ducky_script_commands.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/helpers/ducky_script_keycodes.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_config.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_config_ble_mac.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_config_ble_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_config_layout.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_config_usb_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_config_usb_vidpid.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_confirm_unpair.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_done.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_error.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_file_select.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/scenes/bad_usb_scene_work.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/views/bad_usb_view.c"
)
target_include_directories(esp32_fam_app_bad_usb PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_bad_usb)

add_library(esp32_fam_app_notification_settings OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/notification_settings/notification_settings_app.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/notification_settings/notification_settings_color_picker.c"
)
target_include_directories(esp32_fam_app_notification_settings PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/notification_settings"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_notification_settings)

add_library(esp32_fam_app_passport OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/dolphin_passport/passport.c"
)
target_include_directories(esp32_fam_app_passport PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/settings/dolphin_passport"
)
target_compile_definitions(esp32_fam_app_passport PRIVATE APP_PASSPORT)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_passport)

add_library(esp32_fam_app_clock OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/clock_app.c"
)
target_include_directories(esp32_fam_app_clock PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_clock)

add_library(esp32_fam_app_js_app_start OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/js_app.c"
)
target_include_directories(esp32_fam_app_js_app_start PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_app_start PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_app_start)

add_library(esp32_fam_app_power OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_cli.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/power.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/power_api.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/power_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/views/power_off.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power/power_service/views/power_unplug_usb.c"
)
target_include_directories(esp32_fam_app_power PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/power"
)
target_compile_definitions(esp32_fam_app_power PRIVATE SRV_POWER)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_power)

add_library(esp32_fam_app_storage OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/filesystem_api.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storage.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storage_cli.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storage_external_api.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storage_glue.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storage_internal_api.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storage_processing.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storage_sd_api.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storages/sd_notify.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage/storages/storage_ext.c"
)
target_include_directories(esp32_fam_app_storage PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/storage"
)
target_compile_definitions(esp32_fam_app_storage PRIVATE SRV_STORAGE)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_storage)

add_library(esp32_fam_app_desktop OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/animations/animation_manager.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/animations/animation_storage.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/animations/views/bubble_animation_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/animations/views/one_shot_animation_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/desktop.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/desktop_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/helpers/mesh_capture.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/helpers/mesh_config.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/helpers/mesh_service.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/helpers/pin_code.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/helpers/qflipper_bridge.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/helpers/slideshow.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_debug.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_fault.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_hw_mismatch.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_lock_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_locked.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_main.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_mesh_action.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_mesh_clients.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_mesh_device.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_mesh_handshake.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_mesh_pair.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_mesh_wifi.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_pin_input.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_pin_timeout.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_secure_enclave.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_slideshow.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/scenes/desktop_scene_usb_storage.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_debug.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_lock_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_locked.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_main.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_mesh_action.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_mesh_clients.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_mesh_device.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_mesh_handshake.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_mesh_wifi.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_pin_input.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_pin_timeout.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_slideshow.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/desktop_view_usb_storage.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop/views/mesh_view_common.c"
)
target_include_directories(esp32_fam_app_desktop PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/desktop"
)
target_compile_definitions(esp32_fam_app_desktop PRIVATE SRV_DESKTOP)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_desktop)

add_library(esp32_fam_app_subghz_load_dangerous_settings OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/radio_device_loader.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_device.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_protocols.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_radio_device_loader.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subbrute_worker.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_chat.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_frequency_analyzer_worker.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_gen_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_threshold_rssi.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_txrx.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_txrx_create_protocol_key.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/helpers/subghz_usb_export.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_load_file.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_load_select.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_run_attack.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_save_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_save_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_setup_attack.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_setup_extra.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_bf_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_decode_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_delete.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_delete_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_delete_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_frequency_analyzer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_jammer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_more_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_need_saving.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_playlist.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_radio_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_read_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_receiver.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_receiver_config.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_receiver_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_rpc.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_save_name.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_save_success.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_saved.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_saved_menu.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_button.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_counter.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_key.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_seed.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_serial.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_set_type.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_show_error.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_show_error_sub.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_signal_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_start.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_tpms_edit.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/scenes/subghz_scene_transmitter.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_cli.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_dangerous_freq.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_history.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_i.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/subghz_last_settings.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/receiver.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subbrute_attack_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subbrute_main_view.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_frequency_analyzer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_jammer.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_playlist.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_read_raw.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/subghz_view_tpms_info.c"
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/views/transmitter.c"
)
target_include_directories(esp32_fam_app_subghz_load_dangerous_settings PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_subghz_load_dangerous_settings)

add_library(esp32_fam_app_namechanger_srv OBJECT
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/namechanger/namechanger.c"
)
target_include_directories(esp32_fam_app_namechanger_srv PRIVATE
    "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/services/namechanger"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_namechanger_srv)

add_custom_command(
    OUTPUT "${ESP32_FAM_STAGE_ASSETS_STAMP}"
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${ESP32_FAM_RUNTIME_ROOT}"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/example_apps_assets"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets/files" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/example_apps_assets"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/subghz"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/subghz"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/js_app"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/js_app"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/lfrfid"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/lfrfid"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/nfc"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/nfc"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/bad_usb"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/bad_usb"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/clock"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/clock"
    COMMAND ${CMAKE_COMMAND} -E touch "${ESP32_FAM_STAGE_ASSETS_STAMP}"
    DEPENDS
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets/files/poems/a jelly-fish.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets/files/poems/my shadow.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets/files/poems/theme in yellow.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets/files/test_asset.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/ba-BA.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/colemak.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/cz_CS.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/da-DA.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/de-CH.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/de-DE-mac.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/de-DE.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/dvorak.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/en-UK.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/en-US.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/es-ES.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/es-LA.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/fi-FI.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/fr-BE.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/fr-CA.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/fr-CH.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/fr-FR-mac.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/fr-FR.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/hr-HR.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/hu-HU.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/it-IT-mac.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/it-IT.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/nb-NO.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/nl-NL.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/pt-BR.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/pt-PT.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/si-SI.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/sk-SK.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/sv-SE.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/assets/layouts/tr-TR.kl"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/demo_chromeos.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/demo_gnome.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/demo_macos.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/demo_windows.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/Install_qFlipper_gnome.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/Install_qFlipper_macOS.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/Install_qFlipper_windows.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources/badusb/test_mouse.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/ibtnfuzzer/example_uids_cyfral.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/ibtnfuzzer/example_uids_ds1990.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/ibtnfuzzer/example_uids_metakom.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/music_player/Marble_Machine.fmf"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/rfidfuzzer/example_uids_em4100.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/rfidfuzzer/example_uids_h10301.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/rfidfuzzer/example_uids_hidprox.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/rfidfuzzer/example_uids_pac.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/subplaylist/example_playlist.txt"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/100us.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/call_test_1.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/call_test_2.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/dump_0x00000000_1k.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/dump_0x00000000_4b.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/dump_STM32.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/goto_test.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/halt.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/reset.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources/swd_scripts/test_write.swd"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/resources/lfrfid/assets/iso3166.lfrfid"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources/nfc/assets/aid.nfc"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources/nfc/assets/country_code.nfc"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources/nfc/assets/currency_code.nfc"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources/nfc/assets/mf_classic_dict.nfc"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources/nfc/assets/mf_ultralight_c_dict.nfc"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources/nfc/assets/skylanders.nfc"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources/nfc/assets/vendors.nfc"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources/subghz/assets/alutech_at_4n"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources/subghz/assets/dangerous_settings"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources/subghz/assets/keeloq_mfcodes"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources/subghz/assets/keeloq_mfcodes_user"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources/subghz/assets/keeloq_mfcodes_user.example"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources/subghz/assets/nice_flor_s"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources/subghz/assets/setting_user.example"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/array_buf_test.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/bad_uart.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/badusb_demo.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/blebeacon.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/console.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/delay.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/event_loop.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/gpio.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/gui.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/i2c.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/infrared-send.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/interactive.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/load.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/load_api.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/math.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/notify.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/path.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/spi.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/storage.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/stringutils.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/subghz.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/uart_echo.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/uart_echo_8e1.js"
        "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples/apps/Scripts/js_examples/usbdisk.js"
    VERBATIM
)
add_custom_target(esp32_fam_stage_assets DEPENDS "${ESP32_FAM_STAGE_ASSETS_STAMP}")
