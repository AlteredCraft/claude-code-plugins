---
name: obsidian-cli
description: Use the Obsidian CLI to manage knowledge in an Obsidian vault — daily notes, search, tasks, tags, link graph analysis, properties, templates, and file operations. This skill should be used when the user asks to interact with their Obsidian vault, manage daily notes, search notes, manage tasks, explore tags or backlinks, set properties, use templates, or perform vault maintenance.
allowed-tools: Bash, Read, Glob, Grep
---

# Obsidian CLI — Knowledge Management Skill

Use the `obsidian` CLI to interact with a running Obsidian instance from the terminal. The CLI connects to the running app and provides access to Obsidian-native capabilities: search indexing, the link graph, template variable resolution, frontmatter-aware property management, and task checkbox semantics.

## Prerequisites

- **Obsidian 1.12+** must be running (CLI connects to the running instance)
- **CLI enabled**: Settings > General > Enable "Command line interface"
- **Binary**: `/Applications/Obsidian.app/Contents/MacOS/obsidian` (added to PATH via `~/.zprofile`)

If the CLI returns connection errors, ask the user to ensure Obsidian is running.

## When to Use CLI vs. Native Tools

**Use the Obsidian CLI for:**
| Capability | Why CLI wins |
|---|---|
| Search | Uses Obsidian's indexed search — faster, respects aliases and tags |
| Backlinks / orphans / deadends | Requires Obsidian's link graph |
| Tasks | Checkbox semantics — toggle, done, todo, custom status characters |
| Properties | Frontmatter-aware — typed values (date, list, checkbox, number) |
| Templates | Variable resolution (`{{date}}`, `{{time}}`, `{{title}}`) |
| Daily notes | Respects daily note plugin settings (folder, format, template) |
| Outline / word count | Parsed heading tree, accurate word counts |
| Version history | Access Obsidian's file recovery and sync history |

**Use native tools (Read, Write, Grep, Glob) for:**
- Bulk file reads or multi-file edits
- Regex-based content search across many files
- File creation without templates
- Structural code or markdown changes
- Reading file contents when you need line numbers for Edit tool

**Combine both** when appropriate — e.g., use CLI `search` to find relevant files, then `Read` to inspect and `Edit` to modify.

## Syntax Conventions

```
obsidian <command> [parameter=value ...] [flags ...]
```

- **Parameters** take values: `parameter=value` or `parameter="value with spaces"`
- **Flags** are boolean switches with no value: `silent`, `overwrite`, `total`, `verbose`
- **Multiline content**: use `\n` for newline, `\t` for tab
- **Vault targeting**: `vault=<name>` must be the first parameter: `obsidian vault=Notes daily`
- **File targeting**: `file=<name>` resolves like wikilinks (name without path/extension); `path=<path>` requires exact path from vault root
- **Copy output**: add `--copy` to any command to copy output to clipboard
- **Output formats**: many commands support `format=json|text|csv|tsv|md|yaml|paths`

## Command Reference

### Daily Notes

| Command | Description |
|---|---|
| `daily` | Open today's daily note (creates if needed) |
| `daily:read` | Read daily note contents |
| `daily:append content=<text>` | Append content to daily note |
| `daily:prepend content=<text>` | Prepend content to daily note |

**Flags**: `paneType=tab|split|window`, `inline`, `silent`

```bash
# Read today's daily note
obsidian daily:read

# Add a task to today's note
obsidian daily:append content="- [ ] Review pull requests"

# Prepend a heading inline (no blank line separator)
obsidian daily:prepend content="## Morning Tasks" inline
```

### Search & Discovery

| Command | Description |
|---|---|
| `search query=<text>` | Search vault using Obsidian's index |
| `tags` | List tags (default: active file) |
| `tag name=<tag>` | Get tag info and usage |
| `backlinks` | List backlinks to a file |
| `links` | List outgoing links from a file |
| `orphans` | Files with no incoming links |
| `deadends` | Files with no outgoing links |
| `unresolved` | Unresolved (broken) wikilinks in vault |

**Search parameters**: `path=<folder>`, `limit=<n>`, `format=text|json`, `total`, `matches`, `case`

**Tags parameters**: `file=<name>`, `path=<path>`, `sort=count`, `all`, `total`, `counts`

**Link commands parameters**: `file=<name>`, `path=<path>`, `counts`, `total`, `verbose`

```bash
# Full-text search limited to a folder
obsidian search query="meeting notes" path=Work limit=10

# All tags with counts, sorted by frequency
obsidian tags all counts sort=count

# Files linking to a specific note
obsidian backlinks file="Project Alpha"

# Find broken links
obsidian unresolved verbose

# Find orphaned notes
obsidian orphans
```

### Reading & Writing

| Command | Description |
|---|---|
| `read file=<name>` | Read file contents |
| `create name=<name>` | Create a new file |
| `append file=<name> content=<text>` | Append content to file |
| `prepend file=<name> content=<text>` | Prepend content after frontmatter |
| `open file=<name>` | Open file in Obsidian |

**Create parameters**: `path=<path>`, `content=<text>`, `template=<name>`, `overwrite`, `silent`, `newtab`

```bash
# Create a note from a template
obsidian create name="Trip to Paris" path=Travel template=Travel

# Append a section to an existing note
obsidian append file="Meeting Notes" content="\n## Action Items\n- [ ] Follow up with team"

# Read a specific file
obsidian read path="Projects/Alpha/status.md"
```

### Task Management

| Command | Description |
|---|---|
| `tasks` | List tasks in vault or file |
| `task` | Show or update a specific task |

**Tasks parameters**: `file=<name>`, `path=<path>`, `status="<char>"`, `all`, `daily`, `total`, `done`, `todo`, `verbose`

**Task parameters**: `ref=<path:line>`, `file=<name>`, `path=<path>`, `line=<n>`, `status="<char>"`, `toggle`, `daily`, `done`, `todo`

```bash
# List incomplete tasks from daily note
obsidian tasks daily todo

# List all completed tasks
obsidian tasks done

# Count tasks in a file
obsidian tasks file="Sprint 12" total

# List tasks with file paths and line numbers
obsidian tasks verbose

# Toggle a task checkbox
obsidian task ref="Recipe.md:8" toggle

# Mark a daily note task as done
obsidian task daily line=3 done

# Set a custom status character
obsidian task file=Recipe line=8 status=-

# Filter by custom status
obsidian tasks 'status=?'
```

### Properties (Frontmatter)

| Command | Description |
|---|---|
| `properties` | List properties for a file or vault |
| `property:set name=<n> value=<v>` | Set a frontmatter property |
| `property:read name=<n>` | Read a property value |
| `property:remove name=<n>` | Remove a property |
| `aliases` | List aliases for a file or vault |

**Properties parameters**: `file=<name>`, `path=<path>`, `name=<name>`, `sort=count`, `format=yaml|tsv`, `all`, `total`, `counts`

**Property:set parameters**: `type=text|list|number|checkbox|date|datetime`, `file=<name>`, `path=<path>`

```bash
# List all properties used in vault with counts
obsidian properties all counts sort=count

# Set a typed property
obsidian property:set file="Project Alpha" name=status value=active type=text

# Set a date property
obsidian property:set file="Meeting" name=date value=2026-02-13 type=date

# Read a property
obsidian property:read file="Project Alpha" name=status

# Remove a property
obsidian property:remove file="Old Note" name=deprecated-field
```

### Templates

| Command | Description |
|---|---|
| `templates` | List available templates |
| `template:read name=<template>` | Read template content |
| `template:insert name=<template>` | Insert template into active file |

**Template:read flags**: `title=<title>`, `resolve` (processes `{{date}}`, `{{time}}`, `{{title}}`)

```bash
# List templates
obsidian templates

# Preview a template with variables resolved
obsidian template:read name=Meeting resolve title="Sprint Planning"

# Create a file using a template
obsidian create name="Weekly Review" path=Reviews template="Weekly Review"
```

### File & Folder Info

| Command | Description |
|---|---|
| `file file=<name>` | Show file metadata |
| `files` | List files in vault |
| `folder path=<path>` | Show folder info |
| `folders` | List folders in vault |
| `outline` | Show heading tree for a file |
| `wordcount` | Count words and characters |

**Files parameters**: `folder=<path>`, `ext=<extension>`, `total`

**Folder parameters**: `info=files|folders|size`

**Outline parameters**: `file=<name>`, `path=<path>`, `format=tree|md`, `total`

**Wordcount parameters**: `file=<name>`, `path=<path>`, `words`, `characters`

```bash
# List all markdown files in a folder
obsidian files folder=Projects ext=md

# Get heading structure
obsidian outline file="Architecture Doc" format=tree

# Count words
obsidian wordcount file="Draft Post"

# Folder size info
obsidian folder path=Attachments info=size
```

### Vault Maintenance

| Command | Description |
|---|---|
| `move file=<name> to=<path>` | Move or rename a file |
| `delete file=<name>` | Delete a file (to trash by default) |
| `bookmarks` | List bookmarks |
| `bookmark file=<path>` | Add a bookmark |

**Move parameters**: `path=<path>`

**Delete flags**: `permanent`

**Bookmark parameters**: `subpath=<subpath>`, `folder=<path>`, `search=<query>`, `url=<url>`, `title=<title>`

```bash
# Move a file
obsidian move file="Old Note" to="Archive/Old Note.md"

# Delete to trash
obsidian delete file="Scratch"

# Bookmark a file
obsidian bookmark file="Projects/Alpha/README.md" title="Alpha Project"
```

### Version History

| Command | Description |
|---|---|
| `diff` | List or compare file versions |
| `history file=<name>` | List local history versions |
| `history:list` | List all files with local history |
| `history:read file=<name> version=<n>` | Read a specific version |
| `history:restore file=<name> version=<n>` | Restore a version |

**Diff parameters**: `file=<name>`, `path=<path>`, `from=<n>`, `to=<n>`, `filter=local|sync`

```bash
# Compare latest version to current file
obsidian diff file=Recipe from=1

# Compare two historical versions
obsidian diff file=Recipe from=2 to=1

# List version history
obsidian history file="Important Doc"

# Read a specific version
obsidian history:read file="Important Doc" version=2

# Restore a previous version
obsidian history:restore file="Important Doc" version=3
```

### Vault Info

| Command | Description |
|---|---|
| `vault` | Show current vault info |
| `vaults` | List known vaults |
| `vault info=name` | Show just vault name |
| `vault info=path` | Show vault path |

```bash
obsidian vault
obsidian vault info=name
```

## Common Patterns

### Daily Task Review

```bash
# See today's tasks
obsidian tasks daily

# See incomplete tasks across vault
obsidian tasks todo

# Mark tasks done
obsidian task daily line=5 done
```

### Orphan Cleanup

```bash
# Find orphaned notes (no incoming links)
obsidian orphans

# For each orphan, check if it should be linked or archived
obsidian backlinks file="Orphan Note"
obsidian move file="Orphan Note" to="Archive/Orphan Note.md"
```

### Link Health Audit

```bash
# Find broken links
obsidian unresolved verbose

# Find dead-end notes (no outgoing links)
obsidian deadends

# Check specific file's connections
obsidian backlinks file="Hub Note" counts
obsidian links file="Hub Note"
```

### Tag Inventory

```bash
# Full tag report
obsidian tags all counts sort=count

# Find files with a specific tag
obsidian tag name=project-alpha verbose
```

### Template-Based Note Creation

```bash
# List available templates
obsidian templates

# Create note from template
obsidian create name="Client Meeting 2026-02-13" path=Meetings template=Meeting

# Append to newly created note
obsidian append file="Client Meeting 2026-02-13" content="\n## Notes\n- Discussed timeline"
```
