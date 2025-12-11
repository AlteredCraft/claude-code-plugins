# AlteredCraft Claude Code Plugins

A collection of plugins for [Claude Code](https://claude.com/claude-code).

## Installation

```bash
# Add the marketplace
/plugin marketplace add AlteredCraft/claude-code-plugins

# Install a plugin
/plugin install <plugin-name>@alteredcraft-plugins
```

For more details, see the [Claude Code Plugins documentation](https://code.claude.com/docs/en/plugins).

## Available Plugins

### [artifact-workflow](./plugins/artifact-workflow/)

An artifact-driven development workflow inspired by Google Antigravity. Adds a `/artifact-workflow:build` command that guides you through interrogation, planning, and execution phases with persistent artifacts for task lists, implementation plans, and walkthroughs.

```bash
/plugin install artifact-workflow@alteredcraft-plugins
```

Restart claude
```bash
/artifact-workflow:build --help
```

## License

MIT
