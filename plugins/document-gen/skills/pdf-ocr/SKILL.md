---
name: pdf-ocr
description: "Parse PDF files to markdown using GLM-OCR via Ollama locally. Converts each page to an image, runs OCR, and outputs clean markdown. Use when the user wants to extract text from a PDF."
allowed-tools: Bash, Read, Write, AskUserQuestion
argument-hint: <path-to-pdf>
---

# PDF OCR via GLM-OCR + Ollama

Convert PDF files to markdown using local OCR. Each page is rendered to an image, processed through GLM-OCR running on Ollama, and the recognized text is assembled into a single markdown file.

## Workflow

### Phase 1: Dependency Check

Run these checks and report a status table. If any required dependency is missing, use AskUserQuestion to offer installation.

| Dependency | Check | Install |
|-----------|-------|---------|
| Ollama running | `curl -sf http://127.0.0.1:11434/api/tags > /dev/null` | **Cannot auto-start.** Tell user to start Ollama and stop. |
| `glm-ocr` model | Check that Ollama tags response contains `glm-ocr` | `ollama pull glm-ocr` |
| `pdftoppm` | `which pdftoppm` | `brew install poppler` |
| `pdfinfo` | `which pdfinfo` | Comes with poppler |
| `sips` | `which sips` | Built-in on macOS. Warn if missing. |

Check all five in a single Bash call:

```bash
echo "=== Ollama ===" && curl -sf http://127.0.0.1:11434/api/tags && echo "" && echo "=== pdftoppm ===" && which pdftoppm && echo "=== pdfinfo ===" && which pdfinfo && echo "=== sips ===" && which sips
```

Parse the output:
- If curl fails: Ollama is not running. **Stop and tell user to start Ollama.**
- If `glm-ocr` is not in the tags list: ask user if they want to pull it (`ollama pull glm-ocr`).
- If `pdftoppm` or `pdfinfo` missing: ask user if they want to install poppler (`brew install poppler`).
- If `sips` missing: warn user (built-in on macOS, no auto-install).

If all checks pass, proceed to Phase 2.

### Phase 2: Execute OCR

1. Validate the argument is a path to an existing `.pdf` file. If no argument was provided, print usage and stop:
   > Usage: `/pdf-ocr <path-to-pdf>`
   > Converts a PDF to markdown using local GLM-OCR via Ollama.

2. Determine the output path: same directory as the PDF, same base name with `.md` extension.

3. Get the page count to decide foreground vs background execution:

```bash
pdfinfo "<pdf_path>" | grep "^Pages:"
```

4. Run the OCR script:

```bash
python3 ${CLAUDE_PLUGIN_ROOT}/skills/pdf-ocr/scripts/pdf_ocr.py "<input.pdf>" "<output.md>"
```

- **10 pages or fewer**: Run in foreground (timeout 600000ms / 10 min).
- **More than 10 pages**: Run in background so the user can continue working. Use `timeout: 600000`.

### Phase 3: Report Results

After the script completes:

1. Read the first 50 lines of the output `.md` file to show a preview.
2. Report:
   - Page count processed
   - Output file path
   - Total character count (from the script's stdout)
   - Approximate time taken (from the script's stdout)

## Key Technical Details

- Images are rendered at 72 DPI then resized to max 1024px (the sweet spot for GLM-OCR accuracy)
- The prompt must be exactly `"Text Recognition:"` — other prompts degrade quality
- Each page gets a `<!-- Page N -->` marker with `---` separators between pages
- The script uses only Python 3 stdlib (no pip dependencies)
- Temp files are created in `/tmp/claude/ocr_pages` and cleaned up per-page
