#!/usr/bin/env python3
"""
Merge bootloader + partition table + app into a single firmware binary.

Usage:
    python merge_firmware.py [--board s3_supermini] [--output full_firmware.bin]

Output: full_firmware.bin (gravável diretamente com: esptool.py write_flash 0x0 full_firmware.bin)
"""

import argparse
import os
import sys
from pathlib import Path

def merge_binaries(board="s3_supermini", output_file="full_firmware.bin"):
    """Merge bootloader, partition table, and app into single binary."""

    # Build directory mapping
    build_dirs = {
        "t_embed": "build_t_embed",
        "esp32s3": "build_s3",
        "waveshare_c6": "build_waveshare_c6",
        "s3_supermini": "build_s3_supermini",
    }

    build_dir = build_dirs.get(board)
    if not build_dir:
        print(f"❌ Unknown board: {board}")
        print(f"Available: {', '.join(build_dirs.keys())}")
        return False

    repo_root = Path(__file__).resolve().parent
    build_path = repo_root / build_dir

    # File paths
    bootloader_bin = build_path / "bootloader" / "bootloader.bin"
    partition_table_bin = build_path / "partition_table" / "partition-table.bin"
    app_bin = build_path / "furi_esp32.bin"

    # Verify all files exist
    for f, name in [(bootloader_bin, "bootloader"), (partition_table_bin, "partition table"), (app_bin, "app")]:
        if not f.exists():
            print(f"❌ {name} not found: {f}")
            return False

    print(f"✅ Found all components for board '{board}':")
    print(f"   Bootloader:      {bootloader_bin.name} ({bootloader_bin.stat().st_size} bytes)")
    print(f"   Partition table: {partition_table_bin.name} ({partition_table_bin.stat().st_size} bytes)")
    print(f"   App firmware:    {app_bin.name} ({app_bin.stat().st_size} bytes)")

    # Read binaries
    with open(bootloader_bin, "rb") as f:
        bootloader_data = f.read()
    with open(partition_table_bin, "rb") as f:
        partition_data = f.read()
    with open(app_bin, "rb") as f:
        app_data = f.read()

    # Create merged binary with proper offsets
    # Offset 0x0: bootloader (0x8000 bytes reserved)
    # Offset 0x8000: partition table (0x1000 bytes reserved)
    # Offset 0x10000: app

    max_size = 0x10000 + len(app_data)  # Total size needed
    merged = bytearray(max_size)

    # Fill with 0xFF (erased flash value)
    merged[:] = [0xFF] * max_size

    # Place components at their offsets
    offset_bootloader = 0x0
    offset_partition = 0x8000
    offset_app = 0x10000

    merged[offset_bootloader:offset_bootloader+len(bootloader_data)] = bootloader_data
    merged[offset_partition:offset_partition+len(partition_data)] = partition_data
    merged[offset_app:offset_app+len(app_data)] = app_data

    # Write merged binary
    output_path = repo_root / output_file
    with open(output_path, "wb") as f:
        f.write(merged)

    print(f"\n✅ Merged firmware created: {output_path}")
    print(f"   Size: {len(merged)} bytes ({len(merged)/1024/1024:.2f} MB)")
    print(f"\n📝 Flash with one command:")
    print(f"   esptool.py -p COM14 write_flash 0x0 {output_file}")
    print(f"\n   Or with idf.py:")
    print(f"   idf.py -B {build_dir} burn_key secure_boot")

    return True

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Merge bootloader, partition table, and app into single firmware binary"
    )
    parser.add_argument(
        "--board",
        default="s3_supermini",
        choices=["t_embed", "esp32s3", "waveshare_c6", "s3_supermini"],
        help="Target board (default: s3_supermini)"
    )
    parser.add_argument(
        "--output",
        default="full_firmware.bin",
        help="Output filename (default: full_firmware.bin)"
    )

    args = parser.parse_args()

    if not merge_binaries(args.board, args.output):
        sys.exit(1)
