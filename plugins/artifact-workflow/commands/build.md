---
description: Initiate artifact-driven development workflow
allowed-tools: Skill(implementation-plan-creator), Skill(task-list-creator), Skill(walkthrough-creator), Skill(adr-manager), WebSearch
---

You are executing an artifact-driven development workflow inspired by Google's Antigravity. This workflow produces three living artifacts that scope work and track progress.

## Artifacts Location

**Per-build artifacts** live in `./.artifacts/bld-<project-slug>/`:
- `todo.md` — Task list (scope and progress)
- `implementation-plan.md` — Technical approach (architecture)
- `walkthrough.md` — Verification record (proof of completion)

**Shared artifact** at `./.artifacts/ADR.md`:
- Architecture Decision Records — significant decisions across all builds, each entry links to its related build

## Phase Detection

First, check if `.artifacts/` directory exists and contains any `bld-*` folders (`Search(pattern: ".artifacts/bld-*/**/*")`).

### If existing builds are found:

1. **STOP** — List all existing `bld-*` folders to the user
2. Ask: "I found these existing builds. Would you like to:
   - Continue one of these? (specify which)
   - Start a new build?"
3. Wait for user response before proceeding

### If user chooses to continue an existing build:

Read the artifacts in that folder to determine current phase:

1. **todo.md exists, status: in-progress** → Continue task list refinement or proceed to planning
2. **implementation-plan.md exists, status: pending** → Await user approval
3. **implementation-plan.md exists, status: in-progress** → Continue execution
4. **walkthrough.md exists, status: complete** → Workflow finished, summarize

### If user chooses to start a new build (or no existing builds found):

**If `.artifacts/` directory does not exist**, create it and add:
1. A `README.md` that explains:
   - What this directory is for (managed by the `/build` command)
   - The three per-build artifacts (`todo.md`, `implementation-plan.md`, `walkthrough.md`)
   - The shared `ADR.md` file for architecture decisions across all builds
   - A brief summary of the workflow phases
   - How to use the `/build` command
2. An `ADR.md` file with this template:
   ```markdown
   # Architecture Decision Records

   This file captures significant architectural decisions made during builds in this project.

   ---
   ```

Write the README as if explaining the build tool to someone discovering this directory for the first time.

**IMPORTANT: Do NOT write any code yet.** A new build MUST follow the full workflow:

1. → Go to **Phase 1: Interrogation** to gather requirements
2. → Then **Phase 2: Planning** to create task list and implementation plan
3. → Only after both artifacts are approved, proceed to **Phase 3: Execution**

Never skip directly to writing code. The artifacts must be created and approved first.

## Phase 1: Interrogation

The user's initial prompt `$ARGUMENTS` is a starting point, not sufficient context. You must gather:

- **Purpose**: What problem does this solve? Who is it for?
- **Scope**: What's in/out of scope for this build?
- **Requirements**: Specific features, behaviors, constraints
- **Technical context**: Stack preferences, existing codebase considerations
- **Success criteria**: How will we know it's done?

Ask ONE focused question at a time. Provide your reasoning and offer suggested answers when appropriate. Continue until you have sufficient context to create a meaningful task list.

When ready:
1. Create the `.artifacts/bld-<project-slug>/` directory (and `.artifacts/` with README.md and ADR.md if it doesn't exist)
2. Invoke the `task-list-creator` skill to create `todo.md`

## Phase 2: Planning

### 2a. Task List Approval Gate

After creating `todo.md` with the task-list-creator skill:

1. **STOP** — Do not proceed automatically
2. Present the full contents of `todo.md` to the user
3. Ask explicitly: "Does this task list look correct? Please confirm or suggest changes."
4. Wait for user approval before proceeding
5. Do NOT invoke the implementation-plan-creator skill until approval is received

### 2b. Implementation Plan Approval Gate

After creating `implementation-plan.md` with the implementation-plan-creator skill:

1. **STOP** — Do not proceed automatically
2. Present the full contents of `implementation-plan.md` to the user
3. Ask explicitly: "Does this implementation plan look correct? Please confirm to begin execution."
4. Wait for explicit user approval (e.g., "approved", "looks good", "proceed")
5. Do NOT begin execution until approval is received

## Phase 3: Execution

Work through tasks sequentially:

1. Update `todo.md` checkboxes as tasks complete
2. Update `walkthrough.md` with what was built (invoke `walkthrough-creator` skill)
3. **Write formal test files** for each testable component (see Testing Requirements below)
4. **Update `.artifacts/ADR.md`** when making significant architectural decisions (invoke `adr-manager` skill)

If you encounter blockers or ambiguity, **stop and ask the user** rather than making assumptions.

## Phase 4: Completion

When all tasks are complete:

1. Update `walkthrough.md` status to `complete`
2. **STOP** — Present the full contents of `walkthrough.md` to the user
3. Summarize: "The build is complete. Here's what was accomplished:"
4. Include instructions for running tests
5. This is the terminus of the workflow

## Testing Requirements

Tests must be **persisted as actual test files**, not just ad-hoc verification.

### For Python projects:
- Create `tests/` directory
- Write pytest-compatible test files (`test_*.py`)
- Include in walkthrough: "Run tests with `pytest`"

### For JavaScript/TypeScript projects:
- Create `__tests__/` directory or `*.test.ts` files
- Use appropriate framework (jest, vitest, etc.)
- Include in walkthrough: "Run tests with `npm test`"

### For other stacks:
- Use the standard testing convention for that stack
- Tests must be runnable by the user after implementation

**Ad-hoc verification is NOT sufficient.** Every testable component must have a corresponding test file that the user can run themselves.

## Key Principles

- **Artifacts are the source of truth** — Read them, update them, trust them
- **Interrogate before acting** — Never assume; ask until clear
- **Approval gates are mandatory** — STOP and wait for explicit user confirmation between phases
- **Log as you go** — The walkthrough builds incrementally, not as a summary at the end
- **Tests must persist** — Create runnable test files, not just ad-hoc verification
- **Capture the "why"** — Record architectural decisions in ADR.md for future reference
