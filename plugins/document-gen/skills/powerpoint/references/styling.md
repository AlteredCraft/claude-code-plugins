# PowerPoint Styling Reference

## Color Schemes

### Corporate/Professional

```python
from pptx.dml.color import RGBColor

# Classic Blue
PRIMARY = RGBColor(0, 82, 147)      # #005293 - Navy blue
SECONDARY = RGBColor(0, 123, 192)   # #007BC0 - Sky blue
ACCENT = RGBColor(255, 165, 0)      # #FFA500 - Orange
TEXT = RGBColor(51, 51, 51)         # #333333 - Dark gray
LIGHT = RGBColor(240, 240, 240)     # #F0F0F0 - Light gray

# Consulting Style
PRIMARY = RGBColor(0, 51, 102)      # #003366 - Deep blue
SECONDARY = RGBColor(51, 102, 153)  # #336699 - Medium blue
ACCENT = RGBColor(204, 102, 0)      # #CC6600 - Bronze
```

### Modern/Startup

```python
# Dark Mode
PRIMARY = RGBColor(33, 37, 41)      # #212529 - Near black
SECONDARY = RGBColor(73, 80, 87)    # #495057 - Gray
ACCENT = RGBColor(13, 110, 253)     # #0D6EFD - Bright blue
HIGHLIGHT = RGBColor(25, 135, 84)   # #198754 - Green

# Gradient-Ready
GRADIENT_START = RGBColor(102, 126, 234)  # #667EEA - Purple
GRADIENT_END = RGBColor(118, 75, 162)     # #764BA2 - Deep purple
```

### Minimalist

```python
# Monochrome
PRIMARY = RGBColor(0, 0, 0)         # #000000 - Black
SECONDARY = RGBColor(128, 128, 128) # #808080 - Gray
TEXT = RGBColor(64, 64, 64)         # #404040 - Dark gray
BACKGROUND = RGBColor(255, 255, 255) # #FFFFFF - White

# Soft
PRIMARY = RGBColor(45, 55, 72)      # #2D3748 - Slate
SECONDARY = RGBColor(113, 128, 150) # #718096 - Gray
ACCENT = RGBColor(237, 242, 247)    # #EDF2F7 - Light
```

### Tech/Engineering

```python
# Developer Theme
PRIMARY = RGBColor(30, 30, 30)      # #1E1E1E - VS Code dark
SECONDARY = RGBColor(86, 156, 214)  # #569CD6 - Blue keyword
ACCENT = RGBColor(78, 201, 176)     # #4EC9B0 - Teal type
HIGHLIGHT = RGBColor(206, 145, 120) # #CE9178 - String orange
```

## Typography

### Font Stacks

**Sans-Serif (Modern, Clean):**
- Arial - Universal compatibility
- Calibri - Microsoft default, professional
- Helvetica - Clean, modern (Mac)
- Segoe UI - Windows modern

**Serif (Traditional, Formal):**
- Times New Roman - Classic
- Georgia - Screen-optimized
- Cambria - Microsoft professional

**Display (Headers Only):**
- Impact - Bold statements
- Trebuchet MS - Friendly headers

### Font Size Guidelines

| Element | Size | Weight |
|---------|------|--------|
| Title Slide Title | 40-54pt | Bold |
| Title Slide Subtitle | 20-28pt | Regular |
| Slide Title | 32-40pt | Bold |
| Body Text | 18-24pt | Regular |
| Bullet Points | 18-22pt | Regular |
| Sub-bullets | 16-18pt | Regular |
| Captions | 12-14pt | Regular/Italic |
| Footnotes | 10-12pt | Regular |

### Applying Fonts

```python
from pptx.util import Pt

paragraph = text_frame.paragraphs[0]

# Font family
paragraph.font.name = "Arial"

# Size
paragraph.font.size = Pt(24)

# Weight and style
paragraph.font.bold = True
paragraph.font.italic = False
paragraph.font.underline = False

# Color
paragraph.font.color.rgb = RGBColor(51, 51, 51)
```

## Shape Styling

### Fill Colors

```python
from pptx.dml.color import RGBColor
from pptx.enum.dml import MSO_THEME_COLOR

shape = slide.shapes.add_shape(...)

# Solid fill
shape.fill.solid()
shape.fill.fore_color.rgb = RGBColor(0, 82, 147)

# No fill (transparent)
shape.fill.background()

# Theme color
shape.fill.solid()
shape.fill.fore_color.theme_color = MSO_THEME_COLOR.ACCENT_1
```

### Line/Border Styling

```python
from pptx.util import Pt
from pptx.enum.dml import MSO_LINE_DASH_STYLE

# Line color
shape.line.color.rgb = RGBColor(0, 0, 0)

# Line width
shape.line.width = Pt(2)

# Line style
shape.line.dash_style = MSO_LINE_DASH_STYLE.SOLID
# Options: SOLID, DASH, DASH_DOT, LONG_DASH, ROUND_DOT, SQUARE_DOT

# No line
shape.line.fill.background()
```

### Shadows (Limited Support)

```python
# Note: python-pptx has limited shadow support
# For complex shadows, create in PowerPoint and use as template
```

## Table Styling

```python
table = slide.shapes.add_table(rows=3, cols=3, ...).table

# Header row styling
for cell in table.rows[0].cells:
    cell.fill.solid()
    cell.fill.fore_color.rgb = RGBColor(0, 82, 147)
    paragraph = cell.text_frame.paragraphs[0]
    paragraph.font.color.rgb = RGBColor(255, 255, 255)
    paragraph.font.bold = True

# Alternating row colors
for i, row in enumerate(table.rows[1:], start=1):
    for cell in row.cells:
        if i % 2 == 0:
            cell.fill.solid()
            cell.fill.fore_color.rgb = RGBColor(240, 240, 240)

# Cell padding
for row in table.rows:
    for cell in row.cells:
        cell.margin_left = Inches(0.1)
        cell.margin_right = Inches(0.1)
        cell.margin_top = Inches(0.05)
        cell.margin_bottom = Inches(0.05)
```

## Image Handling

### Adding Images

```python
from pptx.util import Inches

# Basic image
slide.shapes.add_picture(
    "image.png",
    left=Inches(1),
    top=Inches(2),
    width=Inches(4)  # Height auto-calculated to maintain ratio
)

# Specific dimensions (may distort)
slide.shapes.add_picture(
    "image.png",
    left=Inches(1),
    top=Inches(2),
    width=Inches(4),
    height=Inches(3)
)
```

### Image from URL

```python
from io import BytesIO
import requests

response = requests.get("https://example.com/image.png")
image_stream = BytesIO(response.content)

slide.shapes.add_picture(
    image_stream,
    left=Inches(1),
    top=Inches(2),
    width=Inches(4)
)
```

### Centering an Image

```python
from pptx.util import Inches

img_width = Inches(6)
img_height = Inches(4)

left = (prs.slide_width - img_width) / 2
top = (prs.slide_height - img_height) / 2

slide.shapes.add_picture(
    "image.png",
    left=left,
    top=top,
    width=img_width,
    height=img_height
)
```

## Professional Patterns

### Consistent Header Bar

```python
def add_header_bar(slide, title: str):
    """Add a colored header bar with title."""
    # Background bar
    bar = slide.shapes.add_shape(
        MSO_SHAPE.RECTANGLE,
        left=0,
        top=0,
        width=prs.slide_width,
        height=Inches(1.2)
    )
    bar.fill.solid()
    bar.fill.fore_color.rgb = RGBColor(0, 82, 147)
    bar.line.fill.background()

    # Title text
    title_box = slide.shapes.add_textbox(
        left=Inches(0.5),
        top=Inches(0.35),
        width=Inches(12),
        height=Inches(0.5)
    )
    tf = title_box.text_frame
    tf.paragraphs[0].text = title
    tf.paragraphs[0].font.color.rgb = RGBColor(255, 255, 255)
    tf.paragraphs[0].font.size = Pt(28)
    tf.paragraphs[0].font.bold = True
```

### Footer with Page Numbers

```python
def add_footer(slide, page_num: int, total_pages: int):
    """Add footer with page number."""
    footer = slide.shapes.add_textbox(
        left=prs.slide_width - Inches(1.5),
        top=prs.slide_height - Inches(0.5),
        width=Inches(1),
        height=Inches(0.3)
    )
    tf = footer.text_frame
    tf.paragraphs[0].text = f"{page_num} / {total_pages}"
    tf.paragraphs[0].font.size = Pt(10)
    tf.paragraphs[0].font.color.rgb = RGBColor(128, 128, 128)
    tf.paragraphs[0].alignment = PP_ALIGN.RIGHT
```

### Logo Placement

```python
def add_logo(slide, logo_path: str, position: str = "top-right"):
    """Add logo to slide corner."""
    positions = {
        "top-right": (prs.slide_width - Inches(1.5), Inches(0.3)),
        "top-left": (Inches(0.3), Inches(0.3)),
        "bottom-right": (prs.slide_width - Inches(1.5), prs.slide_height - Inches(0.8)),
        "bottom-left": (Inches(0.3), prs.slide_height - Inches(0.8)),
    }

    left, top = positions.get(position, positions["top-right"])

    slide.shapes.add_picture(
        logo_path,
        left=left,
        top=top,
        height=Inches(0.5)  # Width auto-calculated
    )
```
