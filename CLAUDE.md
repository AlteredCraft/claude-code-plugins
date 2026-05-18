# AlteredCraft Plugin Marketplace

IMPORTANT: Prior to any implementation, always review the Claude Marketplace Reference: https://code.claude.com/docs/en/plugin-marketplaces.md

## Naming Convention

### Plugin names

All plugins use the `ac-<topic>` pattern to avoid namespace collisions:

| Directory | Plugin Name | Example Invocation |
|-----------|-------------|-------------------|
| `artifact-workflow/` | `ac-artifact-workflow` | `/ac-artifact-workflow:build` |
| `ideation/` | `ac-ideation` | `/ac-ideation:dev-product-brainstorm` |
| `dev-tools/` | `ac-dev-tools` | `/ac-dev-tools:journal` |
| `document-gen/` | `ac-document-gen` | `/ac-document-gen:powerpoint` |
| `anchored-interview/` | `ac-anchored-interview` | `/ac-anchored-interview:create-skill` |

Directory names don't need the prefix—only the `name` field in `plugin.json`.

Keep each plugin as its own namespace; don't collapse multiple plugins into a single global namespace. Per-plugin namespaces preserve install granularity and keep each plugin's topic visible in the slash command.

### Skill names

Skills live inside a plugin namespace, so the slash command already carries the plugin's topic. Keep skill names short and action-oriented — don't repeat the plugin's noun in the skill name.

- **Verb-first.** `create-skill`, `draft-essay`, `build`, `journal`. Reads as an action.
- **Don't repeat the plugin topic.** Inside `ac-anchored-interview`, the skill is `create-skill`, not `create-anchored-interview-skill`. The namespace already says "anchored interview."
- **Avoid noun-first phrasings** like `skill-creator` or `essay-creator` — they read like job titles rather than actions.

Good: `/ac-anchored-interview:create-skill` · `/ac-document-gen:powerpoint` · `/ac-dev-tools:journal`
Avoid: `/ac-anchored-interview:create-anchored-interview-skill` · `/ac-anchored-interview:anchored-interview-skill-creator`

## Plugin Directory Structure

Each plugin follows this structure:

```
plugins/<plugin-dir>/
├── .claude-plugin/
│   └── plugin.json        # Required: plugin metadata
├── README.md              # Required: documentation
├── skills/                # Optional: reusable skills
│   └── <skill-name>/
│       ├── SKILL.md       # Required for each skill
│       ├── scripts/       # Optional: executable scripts
│       ├── references/    # Optional: reference docs
│       └── resources/     # Optional: templates, assets
└── commands/              # Optional: slash commands
    └── <command-name>.md
```

## plugin.json Format

```json
{
  "name": "ac-<plugin-name>",
  "version": "1.0.0",
  "description": "Brief description of the plugin.",
  "author": { "name": "AlteredCraft" },
  "repository": "https://github.com/AlteredCraft/claude-code-plugins",
  "license": "MIT",
  "keywords": ["keyword1", "keyword2"]
}
```

## SKILL.md Format

Every skill requires a `SKILL.md` with YAML frontmatter:

```yaml
---
name: skill-name
description: One-line description shown in UI. Use trigger phrases.
argument-hint: [optional hints for arguments]
allowed-tools: Tool1, Tool2, Tool3
---

# Skill Title

Markdown body with instructions...
```

**Frontmatter fields:**
- `name` (required): kebab-case identifier
- `description` (required): Include trigger phrases like "This skill should be used when the user asks to..."
- `argument-hint` (optional): Hint for arguments passed via `$ARGUMENTS`
- `allowed-tools` (optional): Restrict which tools the skill can use

## Skill Subdirectories

| Directory | Purpose | Example |
|-----------|---------|---------|
| `scripts/` | Executable Python/Bash scripts | `create_presentation.py` |
| `references/` | Reference documentation loaded as needed | `layouts.md`, `styling.md` |
| `resources/` | Templates, assets, config files | `BUILD_PROMPT.md`, `ralph.sh` |

## README.md Conventions

Each plugin README should include:
1. **Title & description** - What the plugin does
2. **Skills list** - Available skills with brief descriptions
3. **Installation** - GitHub and manual install options
4. **Usage** - Example invocations
5. **How it works** - Brief workflow explanation
6. **License** - MIT

## Before Pushing to Main

1. **Update plugin version** in `.claude-plugin/plugin.json`
   - Patch (x.x.1): Bug fixes
   - Minor (x.1.0): New features, backwards compatible
   - Major (1.0.0): Breaking changes

2. **Update CHANGELOG.txt** at project root
   - Add entry: `[ac-plugin-name vX.Y.Z] - YYYY-MM-DD`
   - Group changes under Added/Changed/Fixed/Removed

## Testing Locally

```bash
# Test a plugin before committing
claude --plugin-dir ./plugins/<plugin-dir>

# Then invoke the skill to verify it works
```
