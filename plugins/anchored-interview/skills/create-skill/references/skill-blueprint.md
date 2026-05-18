# Produced-skill SKILL.md blueprint

The skeleton `create-skill` writes during step 7. This blueprint carries the **slot markers** and **section order**. For the **prose voice and depth** of each section, look at the worked examples — `example-skill-code/SKILL.md` for code-corpus shape, `example-skill-docs/SKILL.md` for document-corpus shape. That's where the register lives. Don't try to invent voice from this blueprint alone; read the examples.

## How to fill this in

1. Walk top to bottom. The slots constrain each other in order: identity → ARTIFACT framing → CORPUS framing → coverage targets → refuse/redirect cases.
2. Replace every `{{ ... }}` with content from the interview.
3. **Substitute CORPUS and ARTIFACT with concrete terms** when writing the produced skill — "the codebase," "the feature spec." The bare words `CORPUS`/`ARTIFACT` in this blueprint are markers for *you* (the writer); the produced skill should read naturally without them.
4. Italicized guidance below each header is for you. Strip it after filling.
5. Match the example's tone: direct, peer-to-peer, light on hedging, no preamble.

---

```markdown
---
name: {{ skill-name-in-kebab-case }}
description: {{ One sentence: what this skill produces and via what shape. }} Use whenever the user wants to {{ 3–4 realistic trigger phrasings, comma-separated; include at least one casual phrasing }}. Do NOT use for {{ 2–3 adjacent cases that should not fire this skill }}.
argument-hint: [{{ what the user supplies at invocation — a feature description, a topic, a folder path, a question, etc. }}]
---

# {{ Skill Display Name }}

{{ One paragraph (~50 words). Interview the user to produce a focused {{ concrete ARTIFACT name }} grounded in {{ concrete CORPUS name }}. Name who consumes the output next and what they do with it. }}

## Why this skill exists

{{ One paragraph. Name the failure mode this skill prevents — what goes wrong when this work is done WITHOUT grounding-before-interviewing. End with the invariant in this skill's vocabulary (e.g., "ground in the codebase first, ask anchored questions, then write the spec"). Quote the user's framing if it captured the why. See example for tone. }}

## Workflow

The sequence matters. Do not jump ahead.

### 1. Confirm the seed intent in one sentence

{{ Adapt to the artifact: what's the user's "one-sentence intent" for this kind of work? One or two lines is enough. }}

### 2. Strategic {{ CORPUS name }} scan to seed context

The grounding read is **steered by the seed, not exhaustive.** Read what the seed makes relevant; ignore what it doesn't. The goal is to know enough to ask sharp anchored questions in step 3 — not to internalize the whole corpus. Deep reading for the artifact, if the artifact pulls content from the corpus, happens after the interview narrows the focus (see step 7), not here.

{{ Concrete grounding instructions, sized to the seed:
   - What to read first — the most relevant N files or sections, named by pattern or example path.
   - What to skim or sample — adjacent material that provides context but isn't load-bearing.
   - What to skip or just inventory — binary files, archives, irrelevant subdirs.
   - What signals to extract — the categories of context that bear on the artifact (for a spec: similar features, data model, integration points; for an essay: latent thesis, tension points, gaps).
   - Use real paths and glob patterns where you can.
   End with "tell the user what you found in one paragraph so they can redirect." }}

### 3. Anchored interview

Drive the interview adaptively — match the tool to the question type:

- **`AskUserQuestion`** for **decision-style** questions — choices among 2–4 plausible options the {{ CORPUS name }} scan has surfaced. These are the high-leverage moments. Always include `"Other (I'll specify)"` so the user is never boxed in.
- **Free-form text** for **clarification-style** questions — places where the {{ CORPUS name }} is vague, contradictory, or silent and you need the user's own words to fill the gap.

One question per turn; follow up freely when an answer surfaces a new question or contradicts the {{ CORPUS name }}.

**Return to the {{ CORPUS name }} during the interview when needed.** The step-2 scan was strategic, not exhaustive. When an answer makes a new region of the {{ CORPUS name }} relevant — a claim to validate, a detail the user assumes, an area worth a closer read before the next question is sharp enough to ask — go back and read, search, or sample. Anchoring is continuous, not one-shot. Don't bluff past a question; if you need more from the {{ CORPUS name }} to ask it well or judge an answer, get it.

**Coverage targets** (must be covered before writing the {{ ARTIFACT name }}; order is up to you):

{{ 4–6 bullets from the coverage areas chosen in the interview. Each: bolded area name + one line on what to draw out. See coverage-area-presets.md for canonical sets. }}

The test for an anchored question: *could this have been asked before the scan?* If yes, it's generic — replace it with one the scan made possible.

**Examples of good interview behavior:**

{{ 1–2 short worked pairs grounded in the {{ CORPUS name }}, formatted like the example skills — blockquote, name what the scan revealed in italics, then the sharp question vs. a generic one with a one-line note on why the generic one fails. For decision-style good questions, model the `AskUserQuestion` shape by ending with inline option syntax `[Option A / Option B / Other]`. These illustrate the test above by demonstration, not by rule. Keep them concrete to this artifact — make up specific filenames, identifiers, or claims a realistic {{ CORPUS name }} would contain. }}

### 4. Surface blockers and contradictions as you go

{{ Tailor to the artifact: list 2–3 concrete failure modes likely for this CORPUS/ARTIFACT pair. Frame contradictions as questions, not assertions. }}

If a blocker is severe enough to change feasibility, pause and ask how to proceed.

### 5. Wrap up the interview

When you have enough to write the {{ ARTIFACT name }}, say so explicitly. Unknowns belong in an Open Questions section of the output, not in more interview turns.

### 6. Ask where to save

Use `AskUserQuestion` with 2–3 sensible path suggestions based on what you saw in {{ CORPUS name }}, plus "Other." Propose a filename slug from the seed. Do not silently pick.

### 7. Write the {{ ARTIFACT name }}

Use [`references/{{ artifact-slug }}-template.md`](references/{{ artifact-slug }}-template.md) verbatim — same sections, same order.

{{ Optional deep-read paragraph — include only if the artifact pulls content directly from {{ CORPUS name }} (essay quoting source documents, literature review using passages, anything where the prose embeds source material). State plainly that this is the step where deep reading happens: "go back to the {{ CORPUS units }} the user named as load-bearing and read them carefully — pull real quotes, verify claims, get specifics right. The scan in step 2 was for the interview; this read is for the artifact." Skip this paragraph entirely if the artifact is about decisions, not source content (specs, plans, ADRs). }}

- Be concrete. Reference real units of {{ CORPUS name }} by name or path.
- Quote the user's framing for {{ the most subjective coverage area — e.g., motivation, angle, voice }} when it captured the why well.
- Keep an explicit Open Questions list.
- {{ Out-of-scope / Boundaries / Non-goals — choose the term that fits this artifact }} gets its own bullet list, not a sentence buried in prose.

After writing, summarize in 2–3 sentences and stop.

### 8. Suggest next steps and stop

{{ 2–3 natural follow-ons specific to this artifact, offered in chat (not created as artifacts). }}

Then stop. The skill produces the {{ ARTIFACT name }} only.

## Behavior to avoid

- Don't skip the {{ CORPUS name }} scan. An artifact without grounding is just a wishlist.
- Don't batch interview questions into a single megaprompt.
- Don't fill in details the user didn't give you — write Open Questions instead.
- Don't paper over contradictions because they're awkward. Surface them.
- Don't write more than one file. The output is a single {{ ARTIFACT name }}.

## When to refuse / redirect

{{ 2–3 adjacent cases this skill is NOT for, each with a one-line redirect. Mirror the negative triggers from the description field. }}

If the user pushes back, defer and proceed.

## Reference files

- [`references/{{ artifact-slug }}-template.md`](references/{{ artifact-slug }}-template.md) — the template the produced skill fills in when writing the {{ ARTIFACT name }}.
```

---

## Companion: the output template

Write `references/{{ artifact-slug }}-template.md` alongside the produced SKILL.md. Model it on the worked-example templates — `example-skill-code/spec-template.md` (decision-only artifact) or `example-skill-docs/essay-draft-template.md` (artifact pulls content from corpus):

- A fenced markdown block with the artifact's section structure and `{{ ... }}` placeholders.
- Sections map to coverage areas (from step 3 of the interview), plus a TL;DR at the top and an Open Questions section at the bottom.
- After the fenced block, a short "Notes on filling this in" section: which date format to use, when a section can be omitted, when to quote the user verbatim, length expectations.

Keep it tight. A 1–3 page artifact beats a 10-page one — if it's getting long, the scope is probably too big and the skill should be split.
