# [CURRENTLY BROKEN] Obsidian CLI Plugin

Obsidian CLI integration for knowledge management. Teaches Claude Code when and how to use the `obsidian` CLI (Obsidian 1.12+) to interact with a running Obsidian vault.

## Installation

```bash
/plugin install ac-obsidian-cli@alteredcraft-plugins
```

## Prerequisites

- Obsidian 1.12+ running with CLI enabled (Settings > General > Command line interface)
- CLI binary on PATH (`/Applications/Obsidian.app/Contents/MacOS/obsidian`)

## Features

- **Daily notes** — read, append, prepend to today's note
- **Search** — full-text search using Obsidian's indexed search
- **Tasks** — list, toggle, complete tasks with checkbox semantics
- **Tags** — list, count, and explore tag usage
- **Link graph** — backlinks, orphans, deadends, unresolved links
- **Properties** — typed frontmatter management (text, date, list, number, checkbox)
- **Templates** — list templates, create files with template variable resolution
- **File operations** — read, create, move, delete, outline, word count
- **Version history** — diff, history, restore previous versions
- **CLI vs. native tool guidance** — decision matrix for when to use the CLI vs. Read/Write/Grep/Glob

## Skills

### obsidian-cli

Complete command reference for the Obsidian CLI organized by knowledge management workflow. Includes syntax, parameters, flags, examples, and common workflow patterns.

**Usage:**

```
Skill(ac-obsidian-cli:obsidian-cli)
```

The skill triggers automatically when you ask Claude Code to interact with your Obsidian vault — searching notes, managing tasks, exploring tags or backlinks, setting properties, using templates, or performing vault maintenance.

## Examples

```bash
# Read today's daily note
obsidian daily:read

# Search for notes
obsidian search query="meeting notes" path=Work

# List incomplete tasks
obsidian tasks daily todo

# Find orphaned notes
obsidian orphans

# Create a note from a template
obsidian create name="Sprint Planning" template=Meeting

# Set a property
obsidian property:set file="Project" name=status value=active
```

## License

MIT
