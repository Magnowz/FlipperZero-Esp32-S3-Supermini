@echo off
REM Merge firmware and flash to ESP32-S3 Supermini

setlocal enabledelayedexpansion

set BOARD=s3_supermini
set BUILD_DIR=build_s3_supermini
set PORT=COM14
set FIRMWARE=full_firmware.bin

REM Parse arguments
if not "%1"=="" set PORT=%1
if not "%2"=="" set BOARD=%2

echo.
echo ====================================
echo  Merging Firmware Components
echo ====================================
echo Board: %BOARD%
echo Output: %FIRMWARE%
echo.

REM Run merge script
python merge_firmware.py --board %BOARD% --output %FIRMWARE%
if errorlevel 1 (
    echo ERROR: Failed to merge firmware
    exit /b 1
)

echo.
echo ====================================
echo  Flashing to ESP32 (%PORT%)
echo ====================================
echo.

REM Flash merged firmware
esptool.py -p %PORT% write_flash 0x0 %FIRMWARE%

if errorlevel 1 (
    echo ERROR: Flash failed
    exit /b 1
)

echo.
echo ====================================
echo  ✅ SUCCESS! Board flashed
echo ====================================
echo.

endlocal
