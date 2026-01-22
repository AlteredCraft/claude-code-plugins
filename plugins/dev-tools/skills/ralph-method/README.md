# Ralph Method

A Claude Code skill for setting up autonomous coding tasks using the Ralph Wiggum methodology.

## What is Ralph?

Ralph Wiggum is an AI-assisted development technique created by [Geoffrey Huntley](https://ghuntley.com/ralph/). Named after the Simpsons character who "makes mistakes but never stops," it runs an AI coding agent in a loop until objective completion criteria are met.

The key insight most implementations miss: **each iteration spawns fresh context**. Memory persists only through the filesystem (git commits, markdown files, the codebase itself). This avoids "context rot" from accumulating conversation history.

## What This Skill Does

This skill executes **Phases 1 and 2** of the Ralph methodology:

| Phase | What Happens | Output |
|-------|--------------|--------|
| **Phase 1: Requirements** | Structured interview to define JTBD, topics, success criteria | `specs/[task-name]/PRD.md`, topic specs, `BACKPRESSURE.md`, `AGENTS.md` |
| **Phase 2: Planning** | Detailed implementation plan with ordered tasks | `specs/[task-name]/IMPLEMENTATION_PLAN.md` |

It then **stops** and hands off to the user with instructions to run Phase 3 (the building loop) via `./ralph.sh`.

## Why Separate Setup from Building?

1. **Human oversight**: Requirements and planning benefit from human judgment and iteration
2. **Quality specs**: "The vaguer the task, the greater the risk" — poor specs cascade into poor outcomes
3. **Clear handoff**: User consciously decides when to start autonomous execution
4. **Sandboxing**: Building loop runs with `--dangerously-skip-permissions` and should be sandboxed

## Usage

```bash
# In your project directory
/ralph-method receipt-upload-ui
```

The skill will:
1. Check if you're on `main` — offer to create a feature branch
2. Interview you about Jobs to Be Done
3. Decompose into topics (one-sentence test)
4. Generate specs in `specs/receipt-upload-ui/`
5. Create detailed implementation plan
6. Deploy `BUILD_PROMPT.md` and `ralph.sh` to project root
7. Hand off with instructions

Then run Phase 3:
```bash
# One task at a time (HITL - watch the output)
./ralph-one.sh                      # Lists tasks, prompts for selection
./ralph-one.sh receipt-upload-ui    # Run specific task directly

# Full loop (AFK - autonomous until done)
./ralph.sh                      # Lists tasks, prompts for selection
./ralph.sh receipt-upload-ui    # Run specific task directly
./ralph.sh receipt-upload-ui 20 # With custom max iterations
```

## File Structure

After running the skill:

```
your-project/
├── BUILD_PROMPT.md              # Instructions for each loop iteration
├── ralph.sh                     # Loop runner script (AFK mode)
├── ralph-one.sh                 # Single-task runner (HITL mode)
└── specs/
    └── receipt-upload-ui/       # Namespaced task specs
        ├── PRD.md               # Product requirements with checkboxes
        ├── IMPLEMENTATION_PLAN.md # Ordered tasks with verification steps
        ├── BACKPRESSURE.md      # Feedback loops (tests, lint, build)
        ├── AGENTS.md            # Task-specific learnings, updated during building (<60 lines)
        ├── 01-topic-one.md      # Topic specification
        └── 02-topic-two.md      # Topic specification
```

## Key Concepts

### Jobs to Be Done (JTBD)
Focus on outcomes, not features. "User needs to authenticate securely" not "add login form."

### One-Sentence Test
Each topic must be describable in one sentence without "and." If you need "and," split into multiple topics.

### Backpressure
Automated signals that reject invalid work: tests, type checks, linters, build. The agent can't commit unless all pass.

### Fresh Context Per Iteration
Each loop iteration starts a new Claude session. The filesystem (specs, git, code) is the only memory. This prevents context degradation on long-running tasks.

### Sit on the Loop, Not in It
Monitor the loop but don't intervene unless you see:
- `<result>STUCK</result>` markers in output (loop auto-stops)
- `<result>COMPLETE</result>` signal (loop auto-stops)
- Same error 3+ iterations
- Agent going in circles

### AGENTS.md: Living Documentation
Unlike CLAUDE.md (project-wide instructions), AGENTS.md is task-specific and lives in `specs/[task-name]/`. The building loop both **reads** and **updates** this file — when the agent discovers build quirks, gotchas, or patterns, it adds brief notes for future iterations.

### Branch Safety
The skill checks if you're on `main` or `master` before starting. If so, it offers to create a feature branch (`feature/[task-name]`). This keeps building loop commits off your main branch until you're ready to merge.

## Resources

- [how-to-ralph-wiggum](https://github.com/ghuntley/how-to-ralph-wiggum) - Original methodology
- [AI Hero's practical guide](https://www.aihero.dev/tips-for-ai-coding-with-ralph-wiggum) - 11 tips for effective Ralph usage
- [Anthropic's harness guidance](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) - Aligned patterns

## Execution Modes

### ralph-one.sh (HITL Mode)
Run a single task with visible output. Best for:
- Learning the methodology
- Debugging failing tasks
- Watching agent behavior in real-time
- Tasks requiring frequent human judgment

```bash
./ralph-one.sh task-name    # Execute next unchecked task, then exit
```

Output streams directly to terminal. Run again to continue to the next task.

### ralph.sh (AFK Mode)
Run the full loop autonomously until completion. Best for:
- Well-tested spec patterns
- Tasks with strong backpressure (tests, lint)
- Going AFK while work progresses

```bash
./ralph.sh task-name 20     # Run up to 20 iterations
```

## Loop Behavior

The `ralph.sh` script includes several safety features:

| Signal | Behavior |
|--------|----------|
| `<result>COMPLETE</result>` in output | Loop stops — all tasks done |
| `<result>STUCK</result>` in output | Loop stops — human review needed |
| Max iterations reached | Loop stops — default 15 |
| Ctrl+C | Manual stop |

The loop runs with `--verbose` for debugging visibility.

## Safety

The building loop requires `--dangerously-skip-permissions` for autonomous operation. **Run in a sandboxed environment:**

- Docker container with minimal access
- Restricted network connectivity
- No credentials or SSH keys accessible
- Iteration limits as circuit breakers (default: 15)

## Skill Contents

```
~/.claude/skills/ralph-method/
├── README.md           # This file
├── SKILL.md            # Skill instructions (Phases 1 + 2)
└── resources/
    ├── BUILD_PROMPT.md # Deployed to project for Phase 3
    ├── ralph.sh        # Loop runner for AFK execution
    └── ralph-one.sh    # Single-task runner for HITL observation
```
