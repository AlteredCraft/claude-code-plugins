---
name: walkthrough-creator
description: Create and maintain the walkthrough artifact during implementation
---

You are maintaining the **Walkthrough artifact** (`walkthrough.md`) for an artifact-driven development workflow.

## Purpose

The Walkthrough documents **what was built**—a clear summary of the resulting system organized by architecture, not by task sequence. It serves as proof of completion and a reference for the finished work.

## Input Context

- Read `.artifacts/bld-<project-slug>/todo.md` for completed tasks
- Read `.artifacts/bld-<project-slug>/implementation-plan.md` for planned architecture
- Reference actual implementation from the conversation

## Your Task

Create/update `.artifacts/bld-<project-slug>/walkthrough.md` as implementation proceeds.

## Walkthrough Structure

### Overview
One paragraph summarizing what was accomplished:

> I've successfully built a [description of what was built] that [key capabilities]. [Additional context on approach or notable features].

### What Was Built

Organize by logical layers or areas (Backend Services, Frontend Components, Configuration, etc.).

For each component:

**1. Component Name** (`filename.ext`)

Brief description of what this component does:
- Capability or responsibility one
- Capability or responsibility two
- Capability or responsibility three

Example:
```
**1. Weather Provider Integrations** (`weatherProviders.js`)

Integrated three weather APIs with data normalization:
- **OpenWeatherMap**: 3-hour interval forecasts
- **Open-Meteo**: High-resolution hourly forecasts (no API key required)
- **WeatherAPI.com**: 14-day hourly forecasts

Each provider's data is normalized to a standard format with:
- Temperature (°C)
- Feels-like temperature
- Precipitation amount and probability
```

### API Reference (if applicable)

Use tables for structured information:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/random-location` | GET | Generate random coordinates |
| `/api/weather?lat={lat}&lon={lon}` | GET | Get aggregated forecast |

### How to Run

Quick instructions to start/use the implementation:
```bash
npm install
npm run dev
# Open http://localhost:3000
```

### Known Limitations

Any constraints, deferred features, or edge cases not handled.

## Artifact Structure

```markdown
---
status: in-progress
created: <timestamp>
updated: <timestamp>
---

# <Project Name> - Walkthrough

## Overview
<One paragraph summary of what was accomplished>

## What Was Built

### <Layer/Area Name>

**1. Component Name** (`filename.ext`)

Description:
- Point one
- Point two

**2. Component Name** (`filename.ext`)

Description:
- Point one
- Point two

### <Another Layer/Area>
...

## API Reference
| Endpoint | Method | Description |
|----------|--------|-------------|
| ... | ... | ... |

## How to Run
...

## Known Limitations
...
```

## When to Update

Update incrementally as major components are completed—don't wait until the end. Each significant piece of functionality should be documented when it's working.

**IMPORTANT**: Every time you modify `walkthrough.md`, update the `updated:` field in the frontmatter with the current timestamp.

## Completion

When implementation is complete:
- Update `status: complete`
- Ensure Overview accurately reflects the full accomplishment
- Present to user as the terminus of the workflow

**When presenting**, always:
1. Show the file path at the top: `📄 .artifacts/bld-<project-slug>/walkthrough.md`
2. If the document is reasonably sized, display the full markdown content
3. If the document is large, provide an overview and instruct the user: "See the full walkthrough at the file path above."
