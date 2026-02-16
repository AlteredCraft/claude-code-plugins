# ac-document-gen

Document generation tools for creating professional presentations, reports, and formatted documents.

## Skills

### powerpoint

Create professional PowerPoint presentations using python-pptx.

**Features:**
- Title, section, content, and closing slide types
- Custom color schemes and typography
- Visual accents (bars, lines, backgrounds)
- Square bullet markers
- Images and tables support

**Invocation:**
```
ac-document-gen:powerpoint
```

**Example:**
> "Create a presentation about our Q4 results with 5 slides"

### qr-code

Generate QR codes from URLs, text, or other data in multiple formats.

**Features:**
- SVG, PNG, EPS, and PDF output formats
- Custom colors, scale, and border
- Error correction levels (L/M/Q/H)
- Micro QR Code support
- Transparent backgrounds

**Invocation:**
```
ac-document-gen:qr-code
```

**Example:**
> "Generate a QR code for https://example.com as an SVG"

### pdf-ocr

Parse PDF files to markdown using GLM-OCR via Ollama locally.

**Features:**
- Local OCR via GLM-OCR model on Ollama (no cloud APIs)
- Page-by-page conversion with `<!-- Page N -->` markers
- Automatic dependency checking and guided installation
- Background processing for large PDFs (>10 pages)
- Bullet character normalization to standard markdown

**Invocation:**
```
ac-document-gen:pdf-ocr <path-to-pdf>
```

**Example:**
> "Convert my report PDF to markdown"

**Requirements:** Ollama with `glm-ocr` model, `poppler` (`pdftoppm`/`pdfinfo`), `sips` (macOS built-in)

## Installation

### From GitHub (Recommended)

```bash
claude plugins install alteredcraft-plugins/ac-document-gen
```

### Manual Installation

Clone and add to your Claude Code plugins:

```bash
git clone https://github.com/AlteredCraft/claude-code-plugins.git
claude plugins install --local ./claude-code-plugins/plugins/document-gen
```

## How It Works

Each skill follows a consistent workflow:

1. **Ask** where to save the output file
2. **Gather** requirements from the user
3. **Generate** the output using Python scripts via `uv run`
4. **Deliver** to the specified location

- **powerpoint**: Sets up a temp project in `/tmp/claude/pptx-project/`, generates the `.pptx`, delivers it, and cleans up.
- **qr-code**: Runs a single script with PEP 723 inline metadata — no temp project needed. Dependencies (`segno`) are resolved automatically by `uv run`.
- **pdf-ocr**: Checks local dependencies (Ollama, glm-ocr, poppler), converts each PDF page to an image, runs OCR via Ollama, and assembles the results into a single `.md` file.

## License

MIT
