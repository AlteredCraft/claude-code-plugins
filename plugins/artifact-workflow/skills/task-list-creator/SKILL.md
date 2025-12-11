---
name: task-list-creator
description: Create or update the task list artifact from gathered requirements
---

You are creating the **Task List artifact** (`todo.md`) for an artifact-driven development workflow.

## Input Context

You have access to the interrogation context from the conversation—requirements, scope, constraints, and success criteria gathered from the user.

## Your Task

Create `.artifacts/bld-<project-slug>/todo.md` (create the directory if it doesn't exist).

## Task Structure

Organize tasks into three phases with hierarchical nesting:

### Planning Phase
Research, design decisions, and technical approach tasks that happen before coding.

### Implementation Phase
The actual build work. Group related tasks under parent items with subtasks:
- Parent task (e.g., "Implement backend API aggregation service")
  - Subtask (e.g., "Integrate multiple weather data sources")
  - Subtask (e.g., "Implement data normalization layer")

### Verification Phase
Testing, validation, and documentation tasks.

## Task Decomposition Principles

1. **Phase-first thinking** — What research/design must happen before building? What verification happens after?

2. **Hierarchical grouping** — Group related implementation work under parent tasks. Subtasks should be completable independently but contribute to the parent goal.

3. **Atomic subtasks** — Each subtask is a single, verifiable unit. Parent tasks complete when all subtasks complete.

4. **Include the unsexy work** — Error handling, edge cases, fallbacks deserve explicit tasks.

5. **Verification is a phase** — Not an afterthought. Testing, edge case validation, and documentation are first-class tasks.

## For Existing Codebases

If working within an existing codebase:
- Add planning tasks for exploring/understanding current patterns
- Note integration points in implementation subtasks
- Add verification tasks for regression testing

## Artifact Structure

```markdown
---
status: in-progress
created: <timestamp> (ex: 2025-12-09 08:47:19 -0800)
updated: <timestamp> (ex: 2025-12-09 08:49:30 -0800)
project: <project-slug>
description: "<one-line summary>"
---

# <Project Name>

## Planning Phase
- [x] Research X and their capabilities
- [x] Design system architecture and data flow
- [ ] Create implementation plan document
- [ ] Get user approval on technical approach

## Implementation Phase
- [ ] Set up project structure and dependencies
- [ ] Implement backend service
  - [ ] Subtask one
  - [ ] Subtask two
  - [ ] Subtask three
- [ ] Build frontend interface
  - [ ] Subtask one
  - [ ] Subtask two
- [ ] Add error handling and fallbacks

## Verification Phase
- [ ] Test with multiple scenarios
- [ ] Verify core functionality
- [ ] Test edge cases and error scenarios
- [ ] Create walkthrough documentation
```

## Updating the Task List

As work progresses, update checkboxes:
- `- [ ]` → pending
- `- [~]` → in-progress (optional, for visibility)
- `- [x]` → complete

**IMPORTANT**: Every time you modify `todo.md`, update the `updated:` field in the frontmatter with the current timestamp.

## After Creation

Present the artifact to the user for review before proceeding.

**When presenting**, always:
1. Show the file path at the top: `📄 .artifacts/bld-<project-slug>/todo.md`
2. Display the full markdown content as it appears in the file
3. Use checkbox format showing current state:

```
[x] Completed task
[ ] Pending task
  [ ] Nested subtask
  [x] Completed subtask
```

This format makes progress immediately visible to the user.
