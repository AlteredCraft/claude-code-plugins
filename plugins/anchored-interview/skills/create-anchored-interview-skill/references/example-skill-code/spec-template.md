# Feature Spec Template

Use this template verbatim when writing the spec. Section headers, order, and emphasis are intentional — readers should be able to skim by header and find what they need.

Replace everything in `{{ braces }}` with content from the interview. Delete the inline guidance (italicized hints) once you've filled the section.

---

```markdown
# Feature Spec: {{ feature name }}

**Status:** Draft
**Author:** {{ user's name, or omit if not provided }}
**Date:** {{ YYYY-MM-DD }}

## TL;DR

{{ One or two sentences. What is this feature, and what changes for the user when it ships? Written so a stakeholder skimming this can decide in 10 seconds whether to read further. }}

## Motivation

{{ Why this feature, why now. Quote the user's framing if it captured the why well — don't paraphrase a strong quote into mush. Cover: what problem this solves, who is asking, what happens if it doesn't ship. }}

## User-facing behavior

{{ What changes for the end user. Be concrete: entry points, the happy path step by step, the most important edge cases. Prefer "user clicks Export → gets a CSV with columns A, B, C" over "the system supports data export." If there's a UI element, name it; if there's a CLI flag, write it out. }}

### Happy path

{{ Numbered steps describing the primary flow end-to-end. }}

### Edge cases worth naming

{{ Bullet list of edge cases that are explicitly in scope. Empty input, partial failures, permission-denied, etc. — only the ones the team should think about now, not an exhaustive QA matrix. }}

## Scope

### In scope

{{ Bullet list of what this feature includes. }}

### Out of scope

{{ Bullet list of what this feature explicitly does NOT include. This section is high-leverage — readers will scan for it. Include things the user might assume are in scope but aren't (related features, edge cases being deferred, integrations not happening this round). If the user said "let's not worry about X for now," that's an out-of-scope item. }}

## Affected code & data

{{ The parts of the codebase this feature touches. Reference real paths and symbols where you have them. }}

### Code

- `{{ path/to/file.ext }}` — {{ what changes here }}
- `{{ path/to/another.ext:Symbol }}` — {{ what changes here }}

### Data

{{ Schema changes, new tables/columns, migrations, new data the system will need to capture. If none, write "No schema changes." }}

### Integration points

{{ External APIs, queues, services, configs, feature flags, or other systems this feature reads from or writes to. If none, write "No external integrations." }}

## Risks and open questions

### Risks

{{ Things that could go wrong or make this harder than it looks. Performance concerns, security/privacy considerations, backwards compatibility, observability gaps, data migration risks. One bullet per risk; keep each one to a sentence or two. }}

### Open questions

{{ Things the user wasn't sure about during the interview, or that need a decision before/during implementation. Be honest — an explicit unknown is more valuable than a confident-sounding answer that gets reversed mid-build. }}

- [ ] {{ Question 1 }}
- [ ] {{ Question 2 }}

### Blockers / contradictions surfaced during spec

{{ Only include this subsection if you flagged a blocker or contradiction during the interview. Examples: a contradiction between the proposed behavior and existing code, a missing capability the feature depends on, a conflict with another in-progress change. State the blocker, what was decided (or that no decision was made), and what would need to be true for the feature to proceed. Omit the subsection entirely if there are none. }}

## Acceptance criteria

{{ A short checklist a developer or reviewer can use to confirm the feature is done. Each item should be testable — "user can export a CSV containing columns A, B, C from the reports page" beats "CSV export works." Don't list every possible test; list the must-pass conditions for shipping. }}

- [ ] {{ Criterion 1 }}
- [ ] {{ Criterion 2 }}
- [ ] {{ Criterion 3 }}
```

---

## Notes on filling this in

- **Date** comes from running `date '+%Y-%m-%d'` — don't guess.
- **Empty sections are OK to omit** if a whole section truly doesn't apply (e.g., no data changes at all → keep "No schema changes" as the body of the Data subsection rather than removing the subsection). Keep the top-level sections (TL;DR, Motivation, User-facing behavior, Scope, Affected code & data, Risks and open questions, Acceptance criteria) — those define the document.
- **The "Blockers / contradictions" subsection is conditional.** Include it only if you flagged something during the interview. If everything was smooth, omit the subsection entirely.
- **Quote the user where their phrasing is good.** Specs read by other people benefit from the originator's voice in the motivation section.
- **Keep it tight.** A good spec is 1–3 pages of markdown, not 10. If it's getting long, the scope is probably too big and should be split.
