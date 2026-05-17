# Altered Craft Claude Code Plugins

A collection of plugins for [Claude Code](https://claude.com/claude-code).

## About Altered Craft
![alt text](docs/img/logo.v1.small.png)

These plugins are developed by [AlteredCraft](https://alteredcraft.com), a publication exploring AI-assisted development and the evolving craft of software engineering. Subscribe to follow along.

## Installation

```bash
# Add the marketplace
/plugin marketplace add AlteredCraft/claude-code-plugins

# Install a plugin
/plugin install <plugin-name>@alteredcraft-plugins
```
**Note**: You can also browse and install plugins directly in the Claude Code UI using the `/plugin` command.

![alt text](docs/img/cc-mp-browse.png)


For more details, see the [Claude Code Plugins documentation](https://code.claude.com/docs/en/plugins).

## Available Plugins

### [ac-artifact-workflow](./plugins/artifact-workflow/)

An artifact-driven development workflow inspired by Google Antigravity. Adds a `/ac-artifact-workflow:build` command that guides you through interrogation, planning, and execution phases with persistent artifacts for task lists, implementation plans, and walkthroughs.

```bash
/plugin install ac-artifact-workflow@alteredcraft-plugins
```

```bash
/ac-artifact-workflow:build --help
```

### [ac-ideation](./plugins/ideation/)

A structured product consultation workflow that helps refine project ideas into fully-formed design specifications through strategic questioning and iterative refinement.

```bash
/plugin install ac-ideation@alteredcraft-plugins
```

```bash
/ac-ideation:dev-product-brainstorm <your project idea>
```

### [ac-dev-tools](./plugins/dev-tools/)

Developer tools with skills for journaling, productivity, and autonomous development workflows.

```bash
/plugin install ac-dev-tools@alteredcraft-plugins
```

**Skills:**

- **journal** - Synthesizes Claude Code activity data into meaningful journal entries
  ```
  I want to journal the work I did today
  ```

- **ralph-method** - Sets up autonomous coding tasks using the Ralph Wiggum methodology (requirements interview + implementation planning), then hands off to a building loop
  ```
  Skill(ac-dev-tools:ralph-method) add-user-authentication
  ```

### [ac-document-gen](./plugins/document-gen/)

Document generation tools for creating professional presentations, QR codes, and other formatted output.

```bash
/plugin install ac-document-gen@alteredcraft-plugins
```

**Skills:**

- **powerpoint** - Create professional PowerPoint presentations with custom styling
  ```
  ac-document-gen:powerpoint
  ```

- **qr-code** - Generate QR codes (SVG/PNG/EPS/PDF) from URLs, text, or other data
  ```
  ac-document-gen:qr-code
  ```

### [ac-anchored-interview](./plugins/anchored-interview/)

A meta-skill that scaffolds new Claude Code skills built around the Anchored Interview pattern — ground in a corpus, run a short interview sharpened by what was found, then produce a single artifact. Use it whenever you spot a workflow where the answer the agent needs is in your head, not the corpus.

```bash
/plugin install ac-anchored-interview@alteredcraft-plugins
```

**Skills:**

- **create-anchored-interview-skill** - Interviews you to produce a complete skill directory (SKILL.md + output template) that follows the ground-then-interview-then-act shape
  ```
  /ac-anchored-interview:create-anchored-interview-skill a skill that drafts essays from my research notes
  ```

## License

MIT
