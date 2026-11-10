#Requires -Version 5.1
<#
.SYNOPSIS
    Merge bootloader + partition table + app into single firmware and flash to ESP32-S3 Supermini

.PARAMETER Board
    Target board (default: s3_supermini)

.PARAMETER Port
    Serial port (default: COM14)

.PARAMETER Output
    Output firmware filename (default: full_firmware.bin)

.EXAMPLE
    .\merge_and_flash.ps1 -Port COM14 -Board s3_supermini
    .\merge_and_flash.ps1 -Port COM14  # uses defaults
#>

param(
    [string]$Board = "s3_supermini",
    [string]$Port = "COM14",
    [string]$Output = "full_firmware.bin"
)

$ErrorActionPreference = "Stop"

Write-Host "`n====================================`n  Merging Firmware Components`n====================================" -ForegroundColor Cyan
Write-Host "Board: $Board" -ForegroundColor Green
Write-Host "Output: $Output`n" -ForegroundColor Green

# Merge firmware
try {
    & python merge_firmware.py --board $Board --output $Output
    if ($LASTEXITCODE -ne 0) {
        throw "Merge script failed"
    }
} catch {
    Write-Host "ERROR: Failed to merge firmware: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`n====================================`n  Flashing to ESP32 ($Port)`n====================================" -ForegroundColor Cyan

# Flash firmware
try {
    & esptool.py -p $Port write_flash 0x0 $Output
    if ($LASTEXITCODE -ne 0) {
        throw "Flash failed"
    }
} catch {
    Write-Host "ERROR: Flash failed: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`n====================================`n  ✅ SUCCESS! Board flashed`n====================================" -ForegroundColor Green
