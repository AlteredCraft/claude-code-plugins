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

1. **Ask** where to save the final `.pptx`
2. **Gather** content requirements (title, sections, bullets)
3. **Set up** a temp Python project with python-pptx
4. **Generate** the presentation
5. **Deliver** to specified location
6. **Cleanup** temp files

All work happens in `/tmp/claude/pptx-project/` to avoid filesystem clutter.

## Design Philosophy

The skill produces **bold, professional** presentations:
- Strong, saturated colors (not pastels)
- Sharp rectangles and clean lines
- High contrast text
- Generous whitespace

## License

MIT
