# Dev Tools Plugin

Developer tools plugin with skills for journaling, productivity, and autonomous development workflows.

## Installation

```bash
/plugin install ac-dev-tools@alteredcraft-plugins
```

## Skills

### journal

A development journaling skill that helps developers reflect on and document their work using Claude Code activity data.

**Usage:**

```
Skill(ac-dev-tools:journal)
```

When triggered, the skill will:

1. Ask for a time period (if not specified)
2. Gather activity data from Claude Code directories
3. Synthesize a narrative journal entry
4. Offer to refine until you're satisfied

**Features:**

- **User-centric narratives**: Captures what you accomplished, not AI actions
- **Selective highlighting**: Gauges significance to highlight meaningful work
- **Multi-day summaries**: Provides highlights and day-by-day breakdowns
- **Iterative refinement**: Always offers to revise before finalizing

**Data Sources:**

- `~/.claude/history.jsonl` - Activity timeline
- `~/.claude/projects/` - Session transcripts
- `~/.claude/file-history/` - File modifications
- `~/.claude/todos/` - Task completion status
- `~/.claude/stats-cache.json` - Usage metrics

See `skills/journal/references/claude-code-directory.md` for detailed documentation of these data structures.

**Example Output:**

```markdown
## Dev Journal: January 3, 2026

You had a focused day on the Claude Explorer API. The highlight was implementing the activity summary endpoint—something you'd been planning for a while.

**Claude Explorer** - Implemented the activity summary endpoint
- Designed the response schema for cross-project aggregation
- Added date range filtering with proper timezone handling
- ✅ Add /activity/summary endpoint
- ✅ Add /activity endpoint for detailed timeline

*Also accomplished: Fixed a null pointer in the todos parser*
```

### ralph-method

Sets up autonomous coding tasks using the Ralph Wiggum methodology — structured requirements gathering (Phase 1) and implementation planning (Phase 2), then hands off to a building loop.

**Usage:**

```
Skill(ac-dev-tools:ralph-method) [task-name-and-description]
```

When triggered, the skill will:

1. Check if you're on `main` — offer to create a feature branch
2. Interview you about Jobs to Be Done
3. Decompose into topics (one-sentence test)
4. Generate specs in `specs/[task-name]/`
5. Create detailed implementation plan
6. Deploy `BUILD_PROMPT.md` and `ralph.sh` to project root
7. Hand off with instructions to run Phase 3

**Output Structure:**

```
your-project/
├── BUILD_PROMPT.md              # Instructions for each loop iteration
├── ralph.sh                     # Loop runner script
└── specs/
    └── [task-name]/             # Namespaced task specs
        ├── PRD.md               # Product requirements with checkboxes
        ├── IMPLEMENTATION_PLAN.md
        ├── BACKPRESSURE.md      # Feedback loops (tests, lint, build)
        ├── AGENTS.md            # Task-specific learnings
        └── 01-topic.md          # Topic specifications
```

**Running Phase 3:**

```bash
./ralph.sh                      # Lists tasks, prompts for selection
./ralph.sh [task-name]          # Run specific task directly
./ralph.sh [task-name] 20       # With custom max iterations
```

See `skills/ralph-method/README.md` for detailed documentation.

## License

MIT
