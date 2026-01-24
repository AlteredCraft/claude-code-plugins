---
name: powerpoint
description: Create professional PowerPoint presentations. Use when asked to "create a PowerPoint", "make a presentation", "build slides", or generate pptx files.
argument-hint: [topic or content outline]
---

# PowerPoint Creator Skill

Create professional PowerPoint presentations programmatically using python-pptx.

## Overview

This skill enables creation of `.pptx` files with:
- Title, section, content, and closing slides
- Bullet points with custom markers
- Visual accents (bars, lines, backgrounds)
- Images, tables, and logos
- Custom color schemes and fonts

## File Management

**All temporary files go in `/tmp/claude/pptx-project/`** to avoid filesystem clutter.

Before starting, ask where to save the final `.pptx`:
- Desktop: `~/Desktop/presentation.pptx`
- Downloads: `~/Downloads/presentation.pptx`
- Current project directory
- A specific path they provide

## Quick Start Workflow

### 1. Set Up Environment

```bash
mkdir -p /tmp/claude/pptx-project && cd /tmp/claude/pptx-project
uv init && uv add python-pptx Pillow
```

### 2. Create Script

Write or adapt a script based on user requirements. Use `scripts/create_presentation.py` as reference.

### 3. Generate and Deliver

```bash
cd /tmp/claude/pptx-project
uv run python create_presentation.py ~/Desktop/presentation.pptx
```

### 4. Cleanup

```bash
rm -rf /tmp/claude/pptx-project
```

## Design Principles

### Avoid Common Pitfalls

**DO NOT create "pastel and bubbly" designs.** Common mistakes:
- Soft, desaturated colors (cream, light teal, soft pink)
- Decorative circles and rounded shapes
- Too much visual clutter

**DO create bold, professional designs:**
- Strong, saturated primary colors
- Sharp rectangles and clean lines
- High contrast between text and background
- Generous whitespace

### Recommended Design Elements

1. **Vertical accent bar** on title slides (left edge)
2. **Solid color backgrounds** for section dividers (use primary color)
3. **Top border line** on content slides
4. **Square bullet markers** instead of text bullets
5. **Dark background** for closing slides (contrast with content)

## Core Imports

```python
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN
from pptx.enum.shapes import MSO_SHAPE  # Required for rectangles/shapes
```

## Essential Patterns

### Setting Background Color

```python
def add_background(slide, color: RGBColor):
    """Set slide background to solid color."""
    fill = slide.background.fill
    fill.solid()
    fill.fore_color.rgb = color
```

### Adding Accent Shapes

```python
# Vertical accent bar (title slides)
bar = slide.shapes.add_shape(
    MSO_SHAPE.RECTANGLE,
    left=Inches(0), top=Inches(0),
    width=Inches(0.35), height=Style.SLIDE_HEIGHT
)
bar.fill.solid()
bar.fill.fore_color.rgb = Style.PRIMARY
bar.line.fill.background()  # Remove border

# Horizontal accent line
line = slide.shapes.add_shape(
    MSO_SHAPE.RECTANGLE,
    left=Inches(1), top=Inches(4.5),
    width=Inches(2), height=Inches(0.04)
)
line.fill.solid()
line.fill.fore_color.rgb = Style.ACCENT
line.line.fill.background()
```

### Square Bullet Markers

```python
# Instead of text bullets, use colored squares
for i, bullet in enumerate(bullets):
    y_pos = 1.8 + (i * 1.0)

    # Square marker
    marker = slide.shapes.add_shape(
        MSO_SHAPE.RECTANGLE,
        left=Inches(0.8), top=Inches(y_pos + 0.12),
        width=Inches(0.12), height=Inches(0.12)
    )
    marker.fill.solid()
    marker.fill.fore_color.rgb = Style.PRIMARY
    marker.line.fill.background()

    # Text to the right of marker
    text_box = slide.shapes.add_textbox(
        Inches(1.15), Inches(y_pos), Inches(11), Inches(0.8)
    )
    # ... style text
```

## Slide Types

The template script supports these slide types:

| Type | Use Case | Visual Style |
|------|----------|--------------|
| `title` | Opening slide | White bg, vertical accent bar, horizontal line |
| `section` | Section dividers | Solid primary bg, white text, accent line |
| `content` | Bullet point slides | White bg, top border line, square bullets |
| `closing` | Thank you / contact | Dark bg, centered text, accent line |
| `blank` | Custom layouts | White bg, optional title |

## Style Configuration

```python
class Style:
    # Use bold, saturated colors
    PRIMARY = RGBColor(0, 82, 147)         # Strong blue
    SECONDARY = RGBColor(214, 102, 75)     # Coral accent
    ACCENT = RGBColor(218, 175, 65)        # Gold highlight

    # Clean backgrounds
    BG_WHITE = RGBColor(255, 255, 255)
    BG_DARK = RGBColor(33, 37, 41)

    # Text colors
    TEXT_PRIMARY = RGBColor(33, 37, 41)
    TEXT_ON_DARK = RGBColor(255, 255, 255)

    # Safe fonts
    TITLE_FONT = "Arial"
    BODY_FONT = "Arial"
```

## Workflow Example

When user asks: "Create a presentation about Q4 results"

1. **Ask** where to save final `.pptx`
2. **Gather** content (title, sections, bullets)
3. **Ask** about brand colors or use professional defaults
4. **Set up** in temp: `cd /tmp/claude/pptx-project && uv init && uv add python-pptx`
5. **Write** script adapting template patterns
6. **Generate** and save to user's location
7. **Cleanup** temp directory

## Bundled Resources

### Scripts
- **`scripts/create_presentation.py`** - Complete template with all slide types

### References
- **`references/layouts.md`** - Layout indices and placeholder details
- **`references/styling.md`** - Extended color schemes and styling patterns

## Limitations

- No animations or transitions (static slides only)
- Limited master slide customization
- Complex charts need additional work
- For heavy customization, start from a `.pptx` template

## Tips

- Always use layout index 6 (Blank) for full positioning control
- Use `Inches()` and `Pt()` for consistent sizing
- Test in PowerPoint, Google Slides, and Keynote for compatibility
- Keep slides simple: 3-5 bullets max, large readable fonts
- Prefer shapes (`MSO_SHAPE.RECTANGLE`) over text characters for bullets
