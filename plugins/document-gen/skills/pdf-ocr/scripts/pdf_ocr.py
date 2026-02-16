#!/usr/bin/env python3
"""OCR a PDF using GLM-OCR via Ollama, outputting markdown."""

import subprocess
import json
import base64
import urllib.request
import sys
import os
import time

USAGE = """\
Usage: python3 pdf_ocr.py <input.pdf> <output.md>

  input.pdf   Path to the PDF file to process (must exist, must be .pdf)
  output.md   Path for the markdown output file

Example:
  python3 pdf_ocr.py ~/Documents/report.pdf ~/Documents/report.md

Requirements:
  - Ollama running locally (http://127.0.0.1:11434) with glm-ocr model
  - pdftoppm and pdfinfo (brew install poppler)
  - sips (built-in on macOS)
"""

if len(sys.argv) < 3:
    print(f"Error: expected 2 arguments, got {len(sys.argv) - 1}", file=sys.stderr)
    print(USAGE, file=sys.stderr)
    sys.exit(1)

PDF_PATH = sys.argv[1]
OUTPUT_PATH = sys.argv[2]

if not os.path.isfile(PDF_PATH):
    print(f"Error: file not found: {PDF_PATH}", file=sys.stderr)
    print(USAGE, file=sys.stderr)
    sys.exit(1)

if not PDF_PATH.lower().endswith(".pdf"):
    print(f"Error: input must be a .pdf file, got: {PDF_PATH}", file=sys.stderr)
    sys.exit(1)
OLLAMA_URL = "http://127.0.0.1:11434/api/generate"
MAX_DIM = 1024  # max pixel dimension for images sent to model
DPI = 72  # low DPI since we'll resize anyway


def get_page_count(pdf_path):
    result = subprocess.run(["pdfinfo", pdf_path], capture_output=True, text=True)
    for line in result.stdout.split("\n"):
        if line.startswith("Pages:"):
            return int(line.split(":")[1].strip())
    raise ValueError("Could not determine page count")


def pdf_page_to_png(pdf_path, page_num, output_prefix):
    """Convert a single PDF page to PNG."""
    subprocess.run(
        [
            "pdftoppm",
            "-png",
            "-f",
            str(page_num),
            "-l",
            str(page_num),
            "-r",
            str(DPI),
            pdf_path,
            output_prefix,
        ],
        capture_output=True,
        check=True,
    )
    # pdftoppm adds page number suffix
    suffix = f"-{page_num:02d}.png" if page_num < 100 else f"-{page_num:03d}.png"
    return output_prefix + suffix


def resize_image(img_path, max_dim):
    """Resize image using sips (macOS) to fit within max_dim."""
    result = subprocess.run(
        ["sips", "-g", "pixelWidth", "-g", "pixelHeight", img_path],
        capture_output=True,
        text=True,
    )
    width = height = 0
    for line in result.stdout.split("\n"):
        if "pixelWidth" in line:
            width = int(line.split(":")[1].strip())
        if "pixelHeight" in line:
            height = int(line.split(":")[1].strip())

    if max(width, height) > max_dim:
        resized_path = img_path.replace(".png", "_resized.png")
        subprocess.run(
            ["sips", "-Z", str(max_dim), img_path, "--out", resized_path],
            capture_output=True,
            check=True,
        )
        return resized_path
    return img_path


def ocr_image(img_path, task="Text Recognition:"):
    """Send image to GLM-OCR via Ollama and return recognized text."""
    with open(img_path, "rb") as f:
        img_b64 = base64.b64encode(f.read()).decode()

    payload = {
        "model": "glm-ocr",
        "prompt": task,
        "images": [img_b64],
        "stream": False,
    }

    data = json.dumps(payload).encode()
    req = urllib.request.Request(
        OLLAMA_URL, data=data, headers={"Content-Type": "application/json"}
    )

    with urllib.request.urlopen(req, timeout=120) as resp:
        result = json.loads(resp.read())
        return result.get("response", "")


def repair_bullets(text):
    """Normalize bullet characters to standard markdown list syntax."""
    lines = text.split("\n")
    repaired = []
    for line in lines:
        stripped = line.lstrip()
        indent = line[: len(line) - len(stripped)]
        # Replace common OCR bullet characters with markdown dash
        if stripped and stripped[0] in "\u2022\u25e6\u25aa\u25b8\u25ba\u2023\u2043\u25c6\u25cb\u25cf\u25a0\u25a1\u25b6\u2192":
            stripped = "-" + stripped[1:]
        repaired.append(indent + stripped)
    return "\n".join(repaired)


def main():
    pdf_path = PDF_PATH
    output_path = OUTPUT_PATH

    num_pages = get_page_count(pdf_path)
    print(f"Processing {num_pages} pages from: {pdf_path}")

    tmp_dir = "/tmp/claude/ocr_pages"
    os.makedirs(tmp_dir, exist_ok=True)

    all_text = []

    for page in range(1, num_pages + 1):
        print(f"\n--- Page {page}/{num_pages} ---")
        start = time.time()

        # Convert PDF page to image
        prefix = os.path.join(tmp_dir, "page")
        img_path = pdf_page_to_png(pdf_path, page, prefix)

        # Resize if needed
        img_path = resize_image(img_path, MAX_DIM)

        # OCR
        text = ocr_image(img_path)

        elapsed = time.time() - start
        print(f"  Got {len(text)} chars in {elapsed:.1f}s")

        if text.strip():
            text = repair_bullets(text.strip())
            all_text.append(f"<!-- Page {page} -->\n\n{text}")
        else:
            all_text.append(f"<!-- Page {page} -->\n\n[No text recognized]")

        # Clean up temp images
        for f in os.listdir(tmp_dir):
            if f.startswith("page"):
                os.remove(os.path.join(tmp_dir, f))

    # Write output
    final_md = "\n\n---\n\n".join(all_text)
    with open(output_path, "w") as f:
        f.write(final_md)

    print(f"\n\nDone! Output written to: {output_path}")
    print(f"Total length: {len(final_md)} characters")


if __name__ == "__main__":
    main()
