# Coverage area presets by artifact type

When interviewing the user about the produced skill's coverage areas (step 3, "Coverage areas for the produced skill's own interview"), use these presets as starting suggestions. Each row gives 4–6 coverage areas typical for that artifact type. Let the user reorder, drop, or add — these are defaults, not requirements.

These also drive the section structure of the produced skill's `references/<artifact-slug>-template.md`. Section headers in the output template usually map 1:1 to coverage areas, plus a TL;DR at the top and an Open Questions section at the bottom.

| ARTIFACT type | Coverage areas | Notes |
|---|---|---|
| **Feature spec** | Motivation · User-facing behavior · Scope & boundaries · Affected systems · Risks & open questions | The worked example. "Scope & boundaries" is the highest-leverage area — always ask at least one out-of-scope question. |
| **Article draft (long-form)** | Thesis · Lede & hook · Evidence & examples · Audience fit · Structure & flow | "Audience fit" is where most drafts die — quote the user's own framing of who this is for. |
| **Article draft (short / note)** | One-tweet thesis · Lede · Supporting beat · Takeaway / so-what | Notes are 200–600 words — coverage areas should reflect that brevity. Skip "Structure" — there isn't one. |
| **Research findings** | Question · Sources & quality · Key findings · Gaps & contradictions · Open questions | Findings files seed later drafting skills. The "Gaps & contradictions" section is what makes the file load-bearing rather than decorative. |
| **Implementation plan** | Goal · Sequenced steps · Dependencies · Risks · Acceptance criteria | "Sequenced steps" should be ordered and have an estimate of effort or duration per step. |
| **Meeting prep** | Attendees & stakes · Objectives · Talking points · Decisions needed · Follow-ups | "Decisions needed" is the section the user actually wants — without it, prep is just notes. |
| **Editorial review** | Hook strength · Persona alignment · Voice & tone · Structure · Suggested edits | Review skills produce findings, not edits — the artifact is a report, not a rewritten draft. |
| **Decision doc / ADR** | Context · Options considered · Decision · Consequences · Rejected alternatives | "Rejected alternatives" is what distinguishes an ADR from a decision memo — name what was considered and why it was passed over. |
| **Bug investigation report** | Repro context · Observed vs expected · Root cause hypothesis · Affected behavior · Fix sketch · Validation plan | Different from a feature spec — the corpus is the bug report + the code, the artifact is the investigation result, not a plan to fix. |
| **Onboarding doc** | Audience & prerequisites · The 10-minute story · First task to try · Where to go next · Known gotchas | "First task to try" makes the doc earn its place — abstract onboarding docs don't get read. |

## How to use this file in the interview

When you reach the "coverage areas for the produced skill" question (step 3 of the parent workflow):

1. Look up the user's ARTIFACT type in the table above.
2. Offer the row's areas as the suggested option in `AskUserQuestion`: "Based on the artifact type, here are the standard coverage areas: [list]. Use these as-is, modify the set, or define your own?"
3. If they say "modify" or "Other," ask which to drop / add / reorder.
4. If the user's ARTIFACT type isn't in the table, ask the user to propose 4–6 areas. Sanity-check: each area should be something the produced skill's interview will *ask about* — not a section to *describe* statically. "Background" is usually a bad coverage area (no interview question lives there); "Motivation" is a good one (the question is "why now?").

## What makes a good coverage area

Each coverage area should:

- **Map to at least one interview question** the produced skill will ask. If nothing in the interview lives there, it doesn't belong as a coverage area — it's a header.
- **Have non-obvious answers.** "What's the artifact's title?" doesn't need a coverage area. "What's the angle?" does.
- **Be artifact-specific enough that a generic answer is wrong.** "Risks" tailored to a deploy plan is different from "Risks" tailored to a publication — the question and the kind of answer you're listening for change.
- **Be coverable in 1–3 questions.** If a coverage area needs 8 questions to surface, it's actually 2–3 coverage areas pretending to be one.

Five is the most common count. Four works for tight artifacts (short notes, decision docs). Six is the upper limit before the interview starts feeling like a form.
