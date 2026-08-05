@echo off
setlocal enabledelayedexpansion

rem Wrapper around winbuild.py for the esp32s3_supermini_ssd1306 board.
rem Fixes the ESP_IDF_DIR env var so it always points at the same ESP-IDF
rem tree that IDF_TOOLS_PATH uses (avoids the v5.4/v5.5 mismatch).
rem
rem Usage:
rem   s3_supermini.bat setup
rem   s3_supermini.bat build
rem   s3_supermini.bat flash [COMx]
rem   s3_supermini.bat all   [COMx]
rem   s3_supermini.bat monitor [COMx]
rem   s3_supermini.bat build-debug   (adds ESP_IDF_EXPORT_DEBUG=1 for troubleshooting)

set "ESP_IDF_DIR=C:\Espressif\frameworks\esp-idf-v5.4.1"

set "CMD=%~1"
if "%CMD%"=="" set "CMD=build"
set "PORT=%~2"
if "%PORT%"=="" set "PORT=COM14"

if "%CMD%"=="setup" (
    python winbuild.py setup
) else if "%CMD%"=="build" (
    python winbuild.py build --board s3_supermini
) else if "%CMD%"=="build-debug" (
    set "ESP_IDF_EXPORT_DEBUG=1"
    python winbuild.py build --board s3_supermini
) else if "%CMD%"=="flash" (
    python winbuild.py flash --board s3_supermini --port !PORT!
) else if "%CMD%"=="all" (
    python winbuild.py all --board s3_supermini --port !PORT!
) else if "%CMD%"=="monitor" (
    python winbuild.py monitor --port !PORT!
) else (
    echo Unknown command: %CMD%
    echo Usage: %~nx0 [setup^|build^|build-debug^|flash^|all^|monitor] [COMx]
    exit /b 1
)

endlocal
