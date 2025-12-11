# Artifact Workflow

An artifact-driven development workflow for Claude Code, inspired by Google Antigravity.

## What It Does

This plugin adds a `/build` command that guides you through a structured development workflow:

1. **Interrogation** — Claude asks clarifying questions until it has enough context
2. **Task List** — Creates `todo.md` breaking down the work into phases
3. **Implementation Plan** — Creates `implementation-plan.md` detailing the technical approach
4. **Execution** — Implements the plan while updating artifacts
5. **Walkthrough** — Documents what was built in `walkthrough.md`

All artifacts persist in `.artifacts/bld-<project-slug>/` within your project, creating a permanent record of how features evolved.

## Why Use It

Coding agents are capable, but disengagement leads to drift. Without checkpoints to review and redirect, small misalignments become large ones. This workflow keeps you engaged at the moments that matter:

- Review the task breakdown before planning begins
- Approve the implementation plan before code is written
- Verify results against expectations

## Installation

### From GitHub

```bash
# Add the marketplace
/plugin marketplace add AlteredCraft/claude-code-plugins

# Install the plugin
/plugin install artifact-workflow@alteredcraft-plugins
```

### Manual Installation

Clone this repository and add it as a local marketplace:

```bash
git clone https://github.com/AlteredCraft/claude-code-plugins.git
cd claude-code-plugins

# In Claude Code:
/plugin marketplace add ./
/plugin install artifact-workflow@alteredcraft-plugins
```

For more details on plugin installation and troubleshooting, see the [Claude Code Plugins documentation](https://code.claude.com/docs/en/plugins).

## Usage

### Start a new build

```bash
/build
```

Or with an initial description:

```bash
/build Add user authentication with OAuth support
```

### Resume an existing build

If you have existing builds, `/build` will detect them and ask if you want to continue one or start fresh:

```
I found these existing builds:
- bld-auth-system
- bld-api-refactor

Would you like to continue one of these, or start a new build?
```

The workflow reads artifact status to determine where you left off and resumes from the correct phase.

### Workflow phases

1. Ask clarifying questions about your requirements
2. Create a task list for your approval
3. Create an implementation plan for your approval
4. Execute the plan, updating artifacts as it goes
5. Present a walkthrough of what was built

## Artifacts

All artifacts live in `.artifacts/` at your project root:

```
.artifacts/
├── README.md           # Explains the artifacts system
├── ADR.md              # Architecture Decision Records (shared across builds)
└── bld-<project>/
    ├── todo.md                 # Task list with checkboxes
    ├── implementation-plan.md  # Technical approach
    └── walkthrough.md          # What was built
```

## Skills Included

- **task-list-creator** — Creates structured task breakdowns
- **implementation-plan-creator** — Creates technical implementation plans
- **walkthrough-creator** — Documents completed work
- **adr-manager** — Records architecture decisions

## Customization

The plugin files are plain markdown. Fork this repo and modify them to fit your workflow:

- Adjust the interrogation questions in `commands/build.md`
- Change the task structure in `skills/task-list-creator/SKILL.md`
- Modify the plan format in `skills/implementation-plan-creator/SKILL.md`

## License

MIT
