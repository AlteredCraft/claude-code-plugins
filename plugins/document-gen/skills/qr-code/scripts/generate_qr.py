#!/usr/bin/env python3
# /// script
# requires-python = ">=3.10"
# dependencies = ["segno"]
# ///
"""Generate QR codes in SVG, PNG, EPS, or PDF format.

Run with: uv run generate_qr.py <data> <output_path> [options]

Examples:
    uv run generate_qr.py "https://example.com" output.svg
    uv run generate_qr.py "https://example.com" output.png --scale 20 --dark "#1a1a2e"
    uv run generate_qr.py "Hello World" output.svg --error H --border 2 --scale 15
    uv run generate_qr.py "https://example.com" output.svg --micro
"""

import argparse
import sys

import segno


def main():
    parser = argparse.ArgumentParser(description="Generate QR codes in various formats.")
    parser.add_argument("data", help="The data to encode (URL, text, etc.)")
    parser.add_argument("output", help="Output file path (extension determines format: .svg, .png, .eps, .pdf, .txt)")
    parser.add_argument("--scale", type=int, default=10, help="Module scale factor (default: 10)")
    parser.add_argument("--border", type=int, default=4, help="Quiet zone border in modules (default: 4)")
    parser.add_argument("--dark", default="#000000", help="Dark module color as hex (default: #000000)")
    parser.add_argument("--light", default="#ffffff", help="Light module color as hex (default: #ffffff)")
    parser.add_argument("--error", choices=["L", "M", "Q", "H"], default="M",
                        help="Error correction level: L=7%%, M=15%%, Q=25%%, H=30%% (default: M)")
    parser.add_argument("--micro", action="store_true", help="Create a Micro QR Code (smaller, less data)")
    parser.add_argument("--version", type=int, default=None, help="Force a specific QR version (1-40, default: auto)")
    parser.add_argument("--transparent", action="store_true", help="Transparent background (SVG/PNG only)")

    args = parser.parse_args()

    # Create the QR code
    try:
        if args.micro:
            qr = segno.make_micro(args.data, error=args.error)
        else:
            qr = segno.make(args.data, error=args.error, version=args.version, micro=False)
    except segno.DataOverflowError:
        print("Error: Data too long for the specified version/error level.", file=sys.stderr)
        sys.exit(1)

    # Build save kwargs
    save_kwargs = {
        "scale": args.scale,
        "border": args.border,
        "dark": args.dark,
        "light": None if args.transparent else args.light,
    }

    # Save the QR code
    qr.save(args.output, **save_kwargs)

    # Report
    size = qr.symbol_size(scale=args.scale, border=args.border)
    recovery = {"L": "7%", "M": "15%", "Q": "25%", "H": "30%"}[args.error]
    print(f"QR code generated successfully!")
    print(f"  File:    {args.output}")
    print(f"  Data:    {args.data}")
    print(f"  Version: {qr.version} ({'Micro' if args.micro else 'Standard'})")
    print(f"  Error:   {args.error} ({recovery} recovery)")
    print(f"  Size:    {size[0]}x{size[1]} (scale={args.scale}, border={args.border})")


if __name__ == "__main__":
    main()
