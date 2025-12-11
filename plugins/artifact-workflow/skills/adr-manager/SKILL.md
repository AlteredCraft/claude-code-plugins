---
name: adr-manager
description: Add Architecture Decision Record (ADR) entries to an ADR file. This skill should be used when recording significant architectural decisions during development. It handles formatting and appending entries using Michael Nygard's ADR template. The skill operates in the caller's context and uses the ADR file path and any relevant context links from the conversation.
---

# ADR Manager

## Overview

This skill appends Architecture Decision Record entries to an ADR file. ADRs capture significant architectural decisions, providing future maintainers with context about why decisions were made.

Based on [Michael Nygard's ADR template](http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions).

## Adding an ADR Entry

Read the existing ADR file to determine the next sequential number, then append a new entry.

### Entry Format

```markdown
## ADR-<NNN>: <Title>

<context-link if provided>

### Status

<status>

### Context

<context>

### Decision

<decision>

### Consequences

<consequences>

---
```

### Field Guidance

- **ADR-NNN**: Sequential number (ADR-001, ADR-002, etc.). Read existing entries to determine next number.
- **Title**: Concise description of the decision (e.g., "Use PostgreSQL for persistence", "Adopt event-driven architecture")
- **Context link**: If provided by caller, include as `**Build:** [link](./path/)` or similar. Omit if not provided.
- **Status**: One of `proposed`, `accepted`, `rejected`, `deprecated`, `superseded`
- **Context**: The issue or situation motivating this decision. What forces are at play?
- **Decision**: What was decided and why. Be specific about the choice made.
- **Consequences**: What becomes easier or harder as a result. Include both positive and negative impacts.

### When to Add an Entry

Add an ADR entry when:
- Choosing between competing technologies or frameworks
- Selecting significant architectural patterns
- Making trade-offs with meaningful consequences
- Deviating from the original plan
- Making decisions that future maintainers would benefit from understanding

Do NOT add entries for:
- Routine implementation details
- Minor code organization choices
- Decisions that are easily reversible with no significant impact

### Quality Guidelines

- Keep entries concise — capture the "why" for future reference, not exhaustive documentation
- Focus on decisions with lasting impact
- Be honest about trade-offs and consequences
- Write for someone encountering this codebase months or years later
