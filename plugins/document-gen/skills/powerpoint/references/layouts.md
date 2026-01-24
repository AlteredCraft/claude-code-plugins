# PowerPoint Slide Layouts Reference

## Built-in Layout Indices

When using `prs.slide_layouts[index]`, these are the standard layouts:

| Index | Name | Placeholders | Best For |
|-------|------|--------------|----------|
| 0 | Title Slide | title, subtitle | Opening slide |
| 1 | Title and Content | title, content | Standard bullet slides |
| 2 | Section Header | title, subtitle | Section dividers |
| 3 | Two Content | title, 2 content areas | Side-by-side comparison |
| 4 | Comparison | title, 2 headers, 2 content | Feature comparison |
| 5 | Title Only | title | Custom content below |
| 6 | Blank | none | Full control |
| 7 | Content with Caption | title, content, caption | Image with description |
| 8 | Picture with Caption | title, picture, caption | Photo slides |

## Placeholder Indices

### Layout 0 (Title Slide)
- `placeholders[0]` - Title
- `placeholders[1]` - Subtitle

### Layout 1 (Title and Content)
- `placeholders[0]` - Title
- `placeholders[1]` - Content (text frame for bullets)

### Layout 2 (Section Header)
- `placeholders[0]` - Title
- `placeholders[1]` - Subtitle

### Layout 3 (Two Content)
- `placeholders[0]` - Title
- `placeholders[1]` - Left content
- `placeholders[2]` - Right content

### Layout 5 (Title Only)
- `placeholders[0]` - Title

## Accessing Placeholders

```python
# By index
title = slide.placeholders[0]
content = slide.placeholders[1]

# By shape property (when available)
title = slide.shapes.title

# Iterate all
for shape in slide.placeholders:
    print(f"Index: {shape.placeholder_format.idx}, Type: {shape.placeholder_format.type}")
```

## Custom Layouts with Blank Slides

For full control, use layout 6 (Blank) and add shapes manually:

```python
slide = prs.slides.add_slide(prs.slide_layouts[6])

# Add textbox at specific position
textbox = slide.shapes.add_textbox(
    left=Inches(1),
    top=Inches(1),
    width=Inches(8),
    height=Inches(1)
)
tf = textbox.text_frame
tf.paragraphs[0].text = "Custom positioned text"
```

## Slide Dimensions

### Standard Dimensions

| Aspect Ratio | Width | Height | Use Case |
|--------------|-------|--------|----------|
| 16:9 | 13.333" | 7.5" | Modern widescreen (default) |
| 4:3 | 10" | 7.5" | Legacy displays |
| 16:10 | 13.333" | 8.333" | Some monitors |

### Setting Dimensions

```python
from pptx.util import Inches

# Widescreen 16:9
prs.slide_width = Inches(13.333)
prs.slide_height = Inches(7.5)

# Standard 4:3
prs.slide_width = Inches(10)
prs.slide_height = Inches(7.5)
```

## Working with Text Frames

### Paragraph Properties

```python
tf = shape.text_frame
p = tf.paragraphs[0]

# Alignment
from pptx.enum.text import PP_ALIGN
p.alignment = PP_ALIGN.CENTER  # LEFT, CENTER, RIGHT, JUSTIFY

# Spacing
from pptx.util import Pt
p.space_before = Pt(12)
p.space_after = Pt(6)
p.line_spacing = 1.5  # Multiplier

# Indentation (for bullets)
p.level = 0  # 0-8, higher = more indented
```

### Text Frame Properties

```python
tf = shape.text_frame

# Word wrap
tf.word_wrap = True

# Vertical alignment
from pptx.enum.text import MSO_ANCHOR
tf.paragraphs[0].vertical_anchor = MSO_ANCHOR.MIDDLE

# Auto-size
from pptx.enum.text import MSO_AUTO_SIZE
tf.auto_size = MSO_AUTO_SIZE.TEXT_TO_FIT_SHAPE
```

## Shape Positioning

### Position Properties

```python
shape.left = Inches(1)    # From left edge
shape.top = Inches(2)     # From top edge
shape.width = Inches(4)
shape.height = Inches(3)
```

### Common Position Patterns

```python
# Centered horizontally
shape.left = (prs.slide_width - shape.width) / 2

# Centered vertically
shape.top = (prs.slide_height - shape.height) / 2

# Right-aligned with margin
shape.left = prs.slide_width - shape.width - Inches(0.5)

# Bottom-aligned with margin
shape.top = prs.slide_height - shape.height - Inches(0.5)
```
