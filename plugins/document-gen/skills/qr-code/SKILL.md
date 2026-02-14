---
name: qr-code
description: "Generate QR codes from URLs, text, or other data and save them as SVG, PNG, EPS, or PDF files. This skill should be used when the user asks to create, generate, or make a QR code for any content such as website URLs, text strings, WiFi credentials, contact info, or other data. Triggers include mentions of 'QR code', 'QR', 'barcode for a link', or requests to make a scannable code. Supports customization of colors, size, error correction level, and output format."
---

# QR Code Generator

Generate QR codes from any text or URL data, with support for multiple output formats and visual customization.

## Workflow

1. **Ask** where to save the output file:
   - Desktop: `~/Desktop/my_qr.svg`
   - Downloads: `~/Downloads/my_qr.svg`
   - Current project directory
   - A specific path they provide
2. Run `scripts/generate_qr.py` via `uv run` with the user's data and desired options.
3. Present the result to the user.

## Script Usage

The script uses PEP 723 inline metadata to declare its dependency (`segno`). Run it with `uv run` and dependencies are resolved and cached automatically — no manual installation required.

```bash
uv run ${CLAUDE_PLUGIN_ROOT}/skills/qr-code/scripts/generate_qr.py DATA OUTPUT_PATH [options]
```

### Required Arguments

| Argument | Description |
|----------|-------------|
| `DATA`   | The content to encode (URL, text, etc.) |
| `OUTPUT_PATH` | Output file path. Extension determines format: `.svg`, `.png`, `.eps`, `.pdf`, `.txt` |

### Options

| Option | Default | Description |
|--------|---------|-------------|
| `--scale` | `10` | Module scale factor (pixels per module) |
| `--border` | `4` | Quiet zone border width in modules |
| `--dark` | `#000000` | Dark module color (hex) |
| `--light` | `#ffffff` | Light module color (hex) |
| `--error` | `M` | Error correction: `L`=7%, `M`=15%, `Q`=25%, `H`=30% |
| `--version` | auto | Force a specific QR version (1-40) |
| `--micro` | off | Create a Micro QR Code (for very short data) |
| `--transparent` | off | Transparent background (SVG/PNG only) |

## Format Guidance

- **SVG** (`.svg`): Recommended default. Scalable vector, ideal for print and web. Smallest file size.
- **PNG** (`.png`): Raster image. Requires `pillow` as an additional dependency. Good for embedding in documents.
- **EPS** (`.eps`): Vector format for professional print workflows.
- **PDF** (`.pdf`): Vector PDF, good for print-ready documents.

Default to **SVG** unless the user requests otherwise.

## Error Correction Guidance

| Level | Recovery | When to use |
|-------|----------|-------------|
| L | 7% | Maximum data density, clean environments |
| **M** | **15%** | **Default. Good balance for most uses** |
| Q | 25% | QR codes that may be partially obscured |
| H | 30% | QR codes with logos overlaid, harsh environments |

If the user wants to overlay a logo on the QR code, suggest `--error H` for maximum resilience.

## Examples

Generate a basic SVG QR code:
```bash
uv run ${CLAUDE_PLUGIN_ROOT}/skills/qr-code/scripts/generate_qr.py "https://example.com/" ~/Desktop/example_qr.svg
```

Generate a styled PNG with custom colors:
```bash
uv run ${CLAUDE_PLUGIN_ROOT}/skills/qr-code/scripts/generate_qr.py "https://example.com/" ~/Downloads/example_qr.png \
  --scale 20 --dark "#1a1a2e" --light "#f0f0f0" --error H
```

Generate a compact Micro QR for short text:
```bash
uv run ${CLAUDE_PLUGIN_ROOT}/skills/qr-code/scripts/generate_qr.py "HELLO" ~/Desktop/hello_qr.svg --micro --scale 15
```

Transparent background SVG:
```bash
uv run ${CLAUDE_PLUGIN_ROOT}/skills/qr-code/scripts/generate_qr.py "https://example.com/" ~/Desktop/example_qr.svg --transparent
```
