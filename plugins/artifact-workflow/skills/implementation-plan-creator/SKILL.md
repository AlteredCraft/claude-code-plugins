---
name: implementation-plan-creator
description: Create the implementation plan artifact from an approved task list
---

You are creating the **Implementation Plan artifact** (`implementation-plan.md`) for an artifact-driven development workflow.

## Input Context

- Read `.artifacts/bld-<project-slug>/todo.md` for the approved task list
- Reference the conversation context for requirements and constraints

## Your Task

Create `.artifacts/bld-<project-slug>/implementation-plan.md`.

## Plan Structure

### Project Summary
One paragraph describing what's being built and its core purpose.

### User Review Required
Surface decisions requiring user input **prominently at the top**. Use blockquote callouts:

> **IMPORTANT**
> **Technology Stack**: The plan uses X with Y. If you prefer Z, please let me know.

> **IMPORTANT**
> **[Decision Topic]**: The proposed approach uses [approach]. Alternative approaches include:
> - Alternative 1
> - Alternative 2
> - Alternative 3
>
> Please confirm the preferred approach.

This section ensures approval gates are visible, not buried.

### Proposed Changes
Organize by logical layer or area (Backend Service Layer, Frontend Components, Configuration, etc.).

For each file:

**[NEW]** `path/to/file.ext`

Brief description of this file's purpose:
- Responsibility one
- Responsibility two
- Responsibility three

**[MODIFY]** `path/to/existing.ext`

Changes to make:
- Add X functionality
- Update Y to support Z

### Testing Strategy
How the implementation will be verified. Keep it practical—what tests or checks prove it works.

## Artifact Structure

```markdown
---
status: pending
created: <timestamp>
updated: <timestamp>
---

# <Project Name>

<One paragraph project summary>

## User Review Required

> **IMPORTANT**
> **[Decision 1]**: ...

> **IMPORTANT**
> **[Decision 2]**: ...

## Proposed Changes

### <Layer/Area Name>

**[NEW]** `filename.ext`

Description:
- Point one
- Point two

**[MODIFY]** `filename.ext`

Changes:
- Change one
- Change two

### Testing Strategy

...
```

## After Creation

Present the artifact to the user. **This is an approval gate.**

**When presenting**, always:
1. Show the file path at the top: `📄 .artifacts/bld-<project-slug>/implementation-plan.md`
2. If the document is reasonably sized, display the full markdown content
3. If the document is large, provide an overview and instruct the user: "See the full plan at the file path above."

The "User Review Required" section makes explicit what needs confirmation. Do not proceed until:
- All IMPORTANT items are addressed
- User explicitly approves the approach

Once approved, update `status: in-progress`.

**IMPORTANT**: Every time you modify `implementation-plan.md`, update the `updated:` field in the frontmatter with the current timestamp.
