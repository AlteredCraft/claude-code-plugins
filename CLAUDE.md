# AlteredCraft Plugin Marketplace

IMPORTANT: Prior to any implementation, always review the Claude Marketplace Refernce: https://code.claude.com/docs/en/plugin-marketplaces.md

## Naming Convention

All plugins in this marketplace use the `ac-` prefix to avoid namespace collisions with other marketplaces:

| Plugin | Invocation |
|--------|------------|
| `ac-artifact-workflow` | `/ac-artifact-workflow:build` |
| `ac-ideation` | `/ac-ideation:dev-product-brainstorm` |
| `ac-dev-tools` | `Skill(ac-dev-tools:journal)` |

## Why `ac-`?

Claude Code plugins are namespaced by their plugin name (e.g., `plugin-name:command`). Without a vendor prefix, common names like `dev-tools` or `workflow` could collide with plugins from other marketplaces.

The `ac-` prefix:
- Is short enough to type comfortably
- Clearly identifies AlteredCraft plugins
- Prevents naming conflicts

## Plugin Structure

```
plugins/
├── artifact-workflow/    # ac-artifact-workflow
├── ideation/             # ac-ideation
└── dev-tools/            # ac-dev-tools
```

Note: Directory names don't need the prefix—only the `name` field in `plugin.json` and `marketplace.json` entries.

## Before Pushing to Main

Before merging or pushing changes to `main`, ensure:

1. **Update plugin version** in `.claude-plugin/plugin.json`
   - Patch (x.x.1): Bug fixes
   - Minor (x.1.0): New features, backwards compatible
   - Major (1.0.0): Breaking changes

2. **Update CHANGELOG.txt** at project root
   - Add entry with `[plugin-name vX.Y.Z] - YYYY-MM-DD`
   - Group changes under Added/Changed/Fixed/Removed
