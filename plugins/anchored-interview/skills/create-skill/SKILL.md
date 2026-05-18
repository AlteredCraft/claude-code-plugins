---
name: create-skill
description: Creates a new Claude Code skill that follows the Anchored Interview pattern — ground in a CORPUS, run an interview anchored by that grounding, then produce a single ARTIFACT. Use whenever the user wants to scaffold, generate, or design an interview-style skill — phrases like "make me an anchored interview skill", "create a skill that interviews me about X and produces Y", "scaffold a skill that reads my <corpus> and writes a <artifact>", "I want a skill for spec/draft/plan/findings creation via interview", or any request to build a skill that has the ground-then-ask-then-act shape. Do NOT use for: running an anchored interview on a specific task (this skill *creates* such skills, it doesn't perform them — for that, use or create the appropriate task-specific skill); editing an existing SKILL.md; one-shot transformations with no judgment calls; or skills where there is no corpus to ground in.
argument-hint: [Brief description of the skill you want to create — e.g., "a skill that drafts blog posts from my research notes"]
---

# Anchored Interview Skill Creator

Interview the user to produce a new Claude Code skill that follows the **Anchored Interview pattern**: grounded in a CORPUS, run an interview sharpened by that grounding, then produce a single ARTIFACT. The output is a complete skill directory (`SKILL.md` + `references/<artifact>-template.md`, optional scripts) the user can drop into their project, user-global skills, or a plugin.

## Why this skill exists

The Anchored Interview is a recurring shape: skills that ground in something concrete (a codebase, a notes folder, a docs site, a transcript archive) and then run a short, adaptive interview whose questions reference what was found in the grounding. The questions get sharper because something concrete preceded them. Done well, the pattern recovers a lot of the value lost to vague or generic skill interviews.

This meta-skill is itself an instance of that pattern — its CORPUS is two bundled worked-example skills (one code-corpus, one docs-corpus) plus a parameterized blueprint; its ARTIFACT is a new skill directory. The recursion is intentional. The most reliable way to teach someone (human or model) to produce something is to walk them through producing it, anchored in real exemplars.

The pattern's invariant: **ground before you interview; interview before you act.** Anything that breaks that invariant doesn't belong in this skill's output.

## Workflow

The sequence matters. Do not jump ahead.

### 1. Confirm the seed intent in one sentence

Before reading any source material, get the user's intent in one sentence: *what type of Anchored Interview skill do you want to create?*

If they already said it clearly in the prompt, paraphrase it back and ask "is that right?" — don't make them repeat themselves. If their seed is vague ("I want a skill for my writing"), ask one or more clarifying questions to narrow it before grounding. Grounding the wrong area is wasted work. DO NOT go too deep at this point — just enough to shape the grounding step.

**Watch for the misuse case.** This skill *creates* anchored-interview skills; it doesn't *perform* them. If the seed sounds like "use this to spec my feature," "interview me about my article," or "ground in my codebase and produce a plan" — the user is trying to use this skill as the thing rather than to create the thing. Don't proceed; correct gently: explain the distinction, ask whether they want (a) the existing task-specific skill (if one fits) or (b) to create a new one via this skill. See "When to refuse / redirect" for the phrasing.

### 2. Ground in the bundled example and blueprint

Read these sources before asking the first interview question. They define the shape of the output and the realistic options to offer the user.

- [`references/example-skill-code/SKILL.md`](references/example-skill-code/SKILL.md) and [`references/example-skill-code/spec-template.md`](references/example-skill-code/spec-template.md) — the **code-corpus** worked example, `feature-spec-creator`. CORPUS = a codebase; ARTIFACT = a feature spec (a decision document, not source-quoting prose).
- [`references/example-skill-docs/SKILL.md`](references/example-skill-docs/SKILL.md) and [`references/example-skill-docs/essay-draft-template.md`](references/example-skill-docs/essay-draft-template.md) — the **docs-corpus** worked example, `essay-draft-from-research`. CORPUS = a directory of research documents; ARTIFACT = a long-form essay draft that quotes from the corpus (note the deep-read paragraph in its step 7, which the code-corpus example doesn't need).

Read both end to end. They're short, and seeing the pattern applied across a code corpus and a document corpus reinforces what's invariant (the ground-then-interview-then-act shape) versus what varies (which files to read, what to extract, whether step 7 needs a deep-read pass). The examples carry the pattern's voice, posture, and depth; the blueprint below carries the slot markers.

- [`references/skill-blueprint.md`](references/skill-blueprint.md) — the parameterized SKILL.md the produced skill will be written from. Names the slots the interview must surface and the section order. Skim now; fill in during step 7.
- [`references/coverage-area-presets.md`](references/coverage-area-presets.md) — common ARTIFACT types mapped to typical coverage areas. Use as defaults when interviewing about coverage areas in step 3.

### 3. Anchored interview

Drive the interview adaptively — match the tool to the question type. Look at the worked examples' step 3 for the posture: short, sharp, responsive to what the seed and the grounding already told you.

**Two question types, two tools:**

- **`AskUserQuestion`** for **decision-style** questions — choices among 2–4 seed-anchored options. Always include `"Other (I'll specify)"` so the user is never boxed in. Fits coverage targets with a clean menu: skill name, CORPUS shape, ARTIFACT type, seed-intent shape, install location.
- **Free-form text** for **clarification-style** questions — places where the seed and the examples are vague, contradictory, or silent and you need the user's own words to fill the gap. For list-style targets (trigger phrases, negative triggers, coverage areas, output template sections), draft a starting list inline based on the seed and the presets file, then ask the user to confirm / edit / replace — clarification with a starting point.

One question per turn; follow up freely whenever an answer raises a new question or contradicts the examples.

**If the seed intent already named the answer, paraphrase and confirm — don't re-ask.** If the user said "drafts notes from my research-findings folder," CORPUS = a research-findings folder and ARTIFACT = a note draft. Restate those and move on. Re-asking what the user just told you erodes trust.

**Vocabulary note** to avoid confusion below: this section's bulleted list contains **coverage targets** for *this* skill's interview (the 8 items the meta-skill must surface). One of those targets is named *"coverage areas for the produced skill's own interview"* — those are the 4–6 dimensions the *produced* skill will ask about, looked up from `coverage-area-presets.md`. Two levels.

**Coverage targets** (must be surfaced before writing the skill; order is up to you):

- **Skill name (kebab-case slug).** Propose a slug derived from the seed (e.g., `draft-from-research`, `anchored-feature-spec`) and let the user confirm or edit. Pick-one with the proposed slug as the default option; this becomes the produced skill's `name` field and its install directory.
- **CORPUS for the produced skill.** What will the produced skill read before asking questions? Anchor suggestions on the user's seed — if they said "drafts blog posts from my research notes," propose options like "a folder of research notes the user names at invocation," "a single findings markdown file," or "a docs site URL." If the user can't name a real corpus that already exists or can be built on the fly, flag it as a blocker — see step 4.
- **ARTIFACT.** The single output the produced skill will write. Offer artifact-typed options (feature spec, article draft, research findings, implementation plan, meeting prep, editorial review, decision doc / ADR) plus "Other." One artifact per skill — resist bundling.
- **Seed intent shape.** What the user will type when invoking the produced skill (`/skill-name <seed>`). A feature description, a topic, a path to a folder, a question? This determines the produced skill's `argument-hint` and how step 1 of its workflow phrases the confirmation.
- **Trigger phrases (positive).** Draft 3–4 realistic phrasings of "I want to use this skill," anchored on the ARTIFACT type — present inline and ask the user to confirm or edit. These go in the produced `description` field.
- **Negative triggers.** Draft 2–3 adjacent cases that should NOT fire the produced skill (e.g., for a feature-spec skill: bug fixes, pure refactors, greenfield projects). Present inline and ask the user to confirm or edit. These go in the produced `description` field's "Do NOT use for..." clause and in the produced skill's "When to refuse / redirect" section.
- **Coverage areas for the produced skill's own interview.** The 4–6 dimensions the produced skill must surface in its own step-3 interview. Look up artifact-typed defaults in `references/coverage-area-presets.md`, present the preset list inline, and ask the user to confirm, adjust, or replace.
- **Install location.** Pick-one. Default suggestions:
  - Project-local: `<project-root>/.claude/skills/<skill-name>/` (the skill is scoped to one project)
  - User-global: `~/.claude/skills/<skill-name>/` (the skill works across projects)
  - Plugin-namespaced: `<plugin-root>/skills/<skill-name>/` (the skill ships as part of a plugin the user maintains)
- **Output template sections.** Draft the section list inline (coverage areas + TL;DR + Open Questions, in that order is the sensible default) and ask the user to reorder, drop, or add. This becomes the section structure of `references/<artifact>-template.md` in the produced skill.

**Interview discipline:**

- After each answer, decide: enough to move on, or do I need a follow-up? Follow-ups are cheap. Use them whenever an answer surfaces a contradiction or a new question.
- Suggested options should be **seed-anchored**. The seed intent is the agent's grounding — use it.
- The test for an anchored question: *could this have been asked before I read the seed and the examples?* If yes, it's generic — sharpen it.

### 4. Surface blockers and contradictions as you go

The pattern doesn't fit every request that looks adjacent. Flag these as soon as you spot them — don't bury them in the produced skill:

- **No real CORPUS.** The user can't name a body of material the produced skill would ground in. Without a corpus, the interview can't be anchored — it degenerates to "what do you want?" which the pattern explicitly fixes. Redirect to a different shape (a prompt template, a regular slash command, a checklist).
- **No real interview needed.** The user wants a one-shot transformation (e.g., "convert this YAML to JSON"). An interview adds nothing. Redirect to a regular command or a script.
- **Multiple artifacts bundled.** The user wants the skill to produce a spec *and* a plan *and* a task folder. Pick one artifact for this skill; the others belong in follow-on skills the user can chain.
- **Duplicate / collision.** A skill with the proposed name already exists at the chosen install location. Check before writing.
- **Editing an existing skill.** If the user has a SKILL.md they want to modify, this skill is the wrong tool — they should edit it directly or use the `skill-creator` improvement workflow.

Frame blockers as questions ("I noticed there's already a `~/.claude/skills/foo/` — is that this skill, or do we need a different name?"). If a blocker is severe enough to change feasibility, pause and ask how to proceed.

### 5. Wrap up the interview

When you have enough to write the skill, say so explicitly: "I think I have enough — let me draft the skill. I'll flag anything I'm still unsure about in the produced skill's comments." Don't drag the interview out chasing 100% certainty — unknowns can go in TODO comments inside the produced SKILL.md.

### 6. Confirm the install path and skill name

Restate: name (kebab-case slug), install path, and the produced skill's `argument-hint`. Use `AskUserQuestion` to confirm with the resolved path as the recommended option. **Do not silently pick a path.**

Check whether the directory already exists; if it does, surface that before writing anything.

### 7. Write the produced skill

Two files, written in one pass:

1. **`<install-path>/SKILL.md`** — read `references/skill-blueprint.md` and fill it in from the interview. Replace every `{{...}}` placeholder; preserve the section headers and order from the blueprint. The blueprint is intentionally close to the worked examples' shape — that consistency is part of the pattern's value.
2. **`<install-path>/references/<artifact-slug>-template.md`** — the output template the produced skill will fill in when it runs. Use the worked-example templates as structural models — `example-skill-code/spec-template.md` for decision-only artifacts (specs, plans, ADRs), `example-skill-docs/essay-draft-template.md` for artifacts that embed source material (essays, literature reviews). Each is a fenced markdown block with `{{...}}` placeholders plus a short "Notes on filling this in" section after the fence. The section structure comes from the user's answer to "output template sections."

Rules when filling the blueprint:

- **Draft the description's lead sentence yourself** from CORPUS + ARTIFACT ("Produces a feature spec from a codebase via an interview workflow"). This isn't an interview question — it falls out of answers already collected in step 3.
- **Be concrete.** When the produced skill's grounding step names what to read, use the concrete corpus the user described. "Read the user-supplied research-notes folder and skim the 3 most recent files" beats "scan the relevant content."
- **Size the produced skill's grounding read to the interview, not the artifact.** The produced skill's step 2 should be a strategic, seed-steered scan — what's needed to ask sharp questions, no more. Phrasings like "read every document end-to-end" or "the whole codebase thoroughly" before the interview are anti-pattern: they burn context on material the interview will narrow away. If the artifact pulls content from the corpus directly (e.g., an essay draft using source quotes), name the deep read in the produced skill's step 7, *after* the interview locks the focus — not in step 2.
- **Quote the user's framing** in the produced skill's `description` field when their phrasing was good. Trigger language should sound like a real user, not like documentation.
- **Trigger pushiness.** Skills tend to undertrigger. Make the produced `description` slightly pushier than feels natural — list 3–4 trigger phrasings, name the adjacent cases as negative triggers.
- **One artifact, one template.** Do not generate two reference templates. Do not create scripts unless the user explicitly asked for one with a clear justification.

After writing both files, briefly summarize (2–3 sentences) what was produced and where it lives. Do not recap the entire interview.

### 8. Suggest next steps and stop

End with a short list of next moves in chat — *do not* create them as artifacts. Examples:

- "Want to test-fire the produced skill? Try it with a real seed and see what comes back."
- "Should I run the description-optimizer pass on the produced skill to tune its triggering?"
- "Want me to add a script to the produced skill for [specific repetitive operation you noticed in the interview]?"

Then stop. This skill produces the new skill directory only.

## Behavior to avoid

- **Don't skip the grounding step.** The whole point of this pattern is that the interview is anchored in concrete material. A produced skill whose grounding step is "read whatever seems relevant" misses the value — the user's produced skill will then run generic interviews.
- **Don't tell the produced skill to read exhaustively in step 2.** The grounding read is for the *interview*, not the artifact. "Read every document end-to-end" before the interview is the same anti-pattern as a generic interview — both ignore that the seed is doing work. Seed-steered, strategic reads sized to the questions you're about to ask; deep reading for the artifact happens later if needed.
- **Don't batch the interview into a single megaprompt.** Adaptivity is the value. One question, get the answer, decide next.
- **Don't invent CORPUS or ARTIFACT for the user.** If they can't name a real corpus to ground in, the pattern doesn't fit — redirect rather than produce a skill that will fail at runtime.
- **Don't bundle artifacts.** One artifact per produced skill. If the user wants three outputs, that's three skills (and probably a fourth that chains them).
- **Don't write more than the two required files** (`SKILL.md` + one template). No task folders, no helper scripts unless explicitly requested, no README. The skill-creator workflow can be re-invoked later to add scripts if a clear need emerges.
- **Don't silently choose the install path.** Always confirm with the user. Skills installed in the wrong place are invisible.

## When to refuse / redirect

If the request is for one of these, redirect rather than produce a skill:

- **Trying to use this skill as the anchored interview itself.** "I think there's a mix-up — this skill *creates* anchored-interview skills, it doesn't run them on a specific task. If you want an anchored interview to spec a feature / draft an article / plan a deploy, you either want the existing task-specific skill (if one exists in your setup) or you want to create one first using me. Which is it?"
- **Editing an existing skill.** "If you want to modify a SKILL.md you already have, just open it and edit — or use the `skill-creator` skill's improvement workflow. This skill is for creating new Anchored Interview skills from scratch."
- **One-shot transform with no judgment calls.** "An interview adds nothing here — a regular slash command or a script fits better. Want help writing one of those instead?"
- **No corpus to anchor on (true greenfield).** "The Anchored Interview pattern needs something concrete to ground in. For a greenfield design, you probably want a brief or a discovery doc first — want help with that instead?"
- **A skill that doesn't produce a single artifact.** "This pattern produces one output per run. If you want a skill that takes multiple actions or doesn't write a file at all, the shape is different — let's talk about what you actually need."

If the user pushes back, defer and proceed.

## Reference files

All bundled — no external paths required.

- [`references/example-skill-code/SKILL.md`](references/example-skill-code/SKILL.md) — the code-corpus worked example (`feature-spec-creator`). One filled-in instance of the pattern. Carries voice and depth.
- [`references/example-skill-code/spec-template.md`](references/example-skill-code/spec-template.md) — the code-corpus example's output template. Model on this when the artifact is a decision document.
- [`references/example-skill-docs/SKILL.md`](references/example-skill-docs/SKILL.md) — the docs-corpus worked example (`essay-draft-from-research`). Same pattern, different corpus shape — the artifact pulls source content from the corpus, so step 7 includes a deep-read paragraph the code-corpus example doesn't need.
- [`references/example-skill-docs/essay-draft-template.md`](references/example-skill-docs/essay-draft-template.md) — the docs-corpus example's output template. Model on this when the artifact embeds source material.
- [`references/skill-blueprint.md`](references/skill-blueprint.md) — the parameterized SKILL.md the produced skill is written from. Carries the slot markers and section order; defers to the examples for voice.
- [`references/coverage-area-presets.md`](references/coverage-area-presets.md) — ARTIFACT types and their typical coverage areas. Use as defaults in the step-3 interview.
