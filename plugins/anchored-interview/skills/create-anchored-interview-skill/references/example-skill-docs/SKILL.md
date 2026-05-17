---
name: essay-draft-from-research
description: Produces a long-form essay draft grounded in a user-supplied directory of research documents via an interview workflow. Use whenever the user wants to "draft an essay from my research", "write an essay from these notes", "turn this research directory into an essay", "I've been collecting notes on X, help me draft an essay", or "draft a long-form piece using these sources". Do NOT use for: one-shot summarization of a single document, short notes or tweets under ~600 words, pure research-findings synthesis with no drafting, or essay drafting when there is no research corpus to ground in.
argument-hint: [Essay topic, angle, or working thesis; optionally a path to the research directory]
---

# Essay Draft from Research

Interview the user to produce a focused essay draft grounded in their research directory. The output is a single markdown file the user (or an editor) can read end-to-end as a first draft — not an outline, not a research summary — with enough of the user's voice and angle baked in that the next pass is revision, not generation.

## Why this skill exists

Drafting from a directory of notes usually fails in one of two directions: either the draft regurgitates the sources without finding an angle, or it asserts an angle the research doesn't actually support. Both happen because the draft gets written before the writer has interrogated the corpus *with their own thesis in hand.* The interview is what fixes that — it pulls the angle out of the writer, anchored on what's actually in the documents, before any prose gets written. The invariant: read the research first, sharpen the angle in conversation, then draft.

## Workflow

The sequence matters. Do not jump ahead.

### 1. Confirm the seed intent in one sentence

Before opening any document, get the user's intent in one sentence: *what essay do they want to draft, and where is the research?*

If they already named both clearly in the prompt, paraphrase and confirm — don't make them repeat themselves. If the topic is vague ("something about my notes on AI") or the research path is missing, ask one targeted question to nail down (a) the working topic or angle and (b) the path to the research directory. Reading the wrong directory is wasted work.

### 2. Strategic research-directory scan to seed context

The grounding read is **steered by the seed, not exhaustive.** Skim what the topic makes relevant; ignore what it doesn't. The goal is to know enough to ask sharp anchored questions in step 3 — not to internalize every document. Deep reading of specific sources for quoting and evidence happens *after* the interview locks the angle (see step 7).

Specifically:

- Run `ls` (or Glob `**/*.{md,txt,pdf,docx}`) on the research directory to inventory what's there. Note file counts, formats, and any obvious grouping (subdirs, naming patterns).
- Read 3–5 documents end-to-end — the ones whose titles or filenames look most central to the seed topic. If filenames are uninformative, read the 3–5 most recently modified.
- Skim the rest — first paragraph and any headers — to register what *kinds* of material exist (interviews, articles, raw quotes, the user's own notes, primary sources).
- Extract signals: what claims or threads recur across documents; where sources contradict each other; what's a strong quote vs. paraphrasable; the user's own voice if their notes are present; obvious gaps the seed topic might require.
- If the directory is large (>30 files) or unfamiliar, spawn an Explore subagent in parallel rather than reading serially. Tell it: "Inventory the research directory at `<path>` for an essay on `<topic>`. Identify (a) the 5 most central documents, (b) recurring themes, (c) contradictions or tensions across sources, (d) the strongest quotable passages, (e) obvious gaps. Report under 400 words."

After the scan, tell the user what you found in *one paragraph max* — the lay of the land, the tensions you noticed, and what looks like the most promising angle. Let them redirect ("no, that thread isn't what I care about").

### 3. Anchored interview

Drive the interview adaptively — match the tool to the question type:

- **`AskUserQuestion`** for **decision-style** questions — choices among 2–4 plausible options the scan has surfaced. Always include `"Other (I'll specify)"`. Suggested options should be concrete and grounded in what's actually in the research (e.g., "Frame it around the X/Y tension that came up in both `interview-3.md` and `notes-feb.md`" — not "Choose a frame").
- **Free-form text** for **clarification-style** questions — places where the research is vague, contradictory, or silent and you need the user's own words. Voice, audience nuance, and the user's personal stake usually want free-form.

One question per turn; follow up freely when an answer surfaces a new question or contradicts the research.

**Return to the research during the interview when needed.** The step-2 scan was strategic, not exhaustive. When an answer makes a new region of the directory relevant — a claim worth checking against a source the user just named, a thread the user wants to lean on that you only skimmed — go back and read. Anchoring is continuous; don't bluff past a question with vibes from a half-read note.

**Coverage targets** (must be covered before drafting; order is up to you):

- **Thesis** — what's the one sentence the essay is arguing or showing? Push for something falsifiable or at least non-obvious. "AI is changing software" is a topic, not a thesis. "AI shifts the bottleneck of software from typing to taste" is a thesis.
- **Lede & hook** — how does this open? A scene, a question, a contrarian claim, a personal anecdote, a striking quote from the research? Ground options in what's actually in the documents.
- **Evidence & examples** — which sources, quotes, examples from the directory will carry the argument? Name files. Push the user toward the strongest concrete material rather than abstractions.
- **Audience fit** — who is this for, and what do they already believe? "Tech-literate readers who are skeptical of AI hype" is useful; "general audience" is not. Quote the user's own framing here if they have one.
- **Structure & flow** — the rough arc. Is this a single linear argument, a tour through three cases, an essay-in-fragments? Anchor on what the evidence supports; some structures will obviously not work for the material at hand.

The test for an anchored question: *could this have been asked before the scan?* If yes, it's generic — replace it with one the scan made possible.

**Examples of good interview behavior:**

> User: "I want to write something about AI and how engineers are adapting."
> *(After scanning: 3 long pieces in the directory argue AI raises the *taste* bar; 2 shorter notes worry the productivity claims are overstated.)*
> Good question: "The strongest pieces here argue AI raises the *taste* bar rather than the typing-speed bar — is the thesis closer to that, or to the *productivity-claims-overstated* angle from the shorter notes? [Taste bar / Productivity overstated / Other]"
> Bad question: "What's your thesis?" *(Generic — the scan surfaced two viable candidates; ask which.)*

> User: "Let's anchor the essay on the interview with X."
> *(But `interview-X.md` is mostly process talk; the strongest quotes for the thesis the user just picked live in `research-notes-feb.md`, which they haven't flagged.)*
> Good followup: "The interview has the right voice but light on quotable lines for the thesis — `research-notes-feb.md` carries stronger evidence on that specific point. Want me to lead with the interview's tone but pull evidence from both, or stay strictly inside the interview?"

### 4. Surface blockers and contradictions as you go

Flag these as soon as you spot them — don't bury them in the draft:

- **The thesis doesn't match the evidence.** The user wants to argue X, but the research strongly supports not-X (or doesn't address X at all). Name it: "The strongest material in the directory is about Y, not X — is the thesis off, or is there source material elsewhere we should pull in?"
- **The corpus is too thin.** Three short notes and a tweet don't support a 2,000-word essay. Surface it before drafting: "The research is light for a long-form piece — want to draft a shorter note instead, or pause and gather more sources?"
- **Sources contradict each other on a load-bearing point** and the user hasn't picked a side. Ask which way the essay leans before drafting; an essay that papers over a real tension is worse than one that names it.
- **The user's stated angle is the same as a source's angle.** That's not an essay, that's a summary. Push for what the user is *adding* — a synthesis, a reframe, a counter, a personal stake.

Frame contradictions as questions, not assertions. If a blocker changes whether the draft is feasible at all, pause and ask how to proceed.

### 5. Wrap up the interview

When you have enough to draft, say so explicitly: "I think I have enough — let me draft the essay. I'll flag anything I'm still unsure about in the Open Questions section." Don't drag the interview out chasing perfection; unknowns belong in Open Questions, not in more turns.

### 6. Ask where to save

Use `AskUserQuestion` with 2–3 sensible suggestions based on what you saw — `<research-dir>/draft.md`, `<research-dir>/../drafts/<slug>.md`, `~/Documents/essays/<slug>.md`, or "Other." Propose a kebab-case filename slug derived from the thesis or working title, and let the user edit it. Do not silently pick a path.

### 7. Write the essay draft

Use [`references/essay-draft-template.md`](references/essay-draft-template.md) verbatim — same sections, same order.

This is the step where deep reading happens. Now that the angle is locked, go back to the documents the user named as load-bearing and read them carefully — pull real quotes, verify claims, get specifics right. The scan in step 2 was for the interview; this read is for the prose.

Rules when drafting:

- **Write actual prose, not an outline.** A draft means full sentences and paragraphs, not bullet points and `[expand here]` placeholders. If you don't have enough to write a real paragraph, write a shorter draft instead.
- **Quote the user's framing** for thesis and audience when their phrasing was strong. Their voice is what makes it theirs.
- **Cite sources from the directory inline** by filename — `(from research-notes/interview-3.md)` or similar. The user needs to be able to trace any claim back to where it came from.
- **Use real quotes verbatim** when the source has a strong line. Don't paraphrase good quotes into mush.
- **Keep Open Questions honest.** Anything you guessed at, anything the user wasn't sure about, anything that needs verification before publishing — write it down.
- **One draft, one file.** Don't generate alternative ledes or three versions.

After writing, summarize in 2–3 sentences (what the essay argues, roughly how long, where it lives) and stop.

### 8. Suggest next steps and stop

End with a short list in chat — *do not* create them as artifacts:

- "Want me to do a second pass tightening the lede?"
- "Want me to pull a few more quotes from sources I didn't touch?"
- "Should we walk through the open questions before you revise?"

Then stop. The skill produces one essay draft only.

## Behavior to avoid

- **Don't skip the research scan.** A draft without grounding is just a wishlist with paragraphs.
- **Don't batch the interview into a single megaprompt.** One question at a time; the angle is found by following the user's answers, not by extracting a form.
- **Don't fabricate quotes or claims.** If you cite a source, it must say what you're attributing to it. When in doubt, paraphrase and mark the citation clearly.
- **Don't fill in details the user didn't give you.** No invented anecdotes, no stylistic choices ("with a wry tone") they never asked for. Write Open Questions instead.
- **Don't paper over contradictions because they're awkward.** When sources disagree on a load-bearing point, or the seed thesis fights the evidence, surface it as a question in step 4. A draft that hedges past a real tension is worse than one that names it.
- **Don't write more than one file.** No alternate drafts, no outline file, no research summary on the side.
- **Don't read the entire directory end-to-end in step 2.** Strategic, seed-steered scan only — the deep read is in step 7 once the angle is locked.

## When to refuse / redirect

- **One-shot summarization of a single document** → "An interview adds nothing here — I can just summarize the doc directly. Want that instead?"
- **A short note or tweet (under ~600 words)** → "This skill is shaped for long-form drafting. For a short note, a one-shot prompt or the `note-from-research` shape fits better — want help with that?"
- **Research synthesis with no drafting** → "If you want a findings document over the research (key themes, contradictions, gaps) without committing to an essay angle yet, that's a different artifact — want me to do that instead?"
- **No research directory to ground in** → "This skill needs a corpus to anchor on. For a greenfield essay where you're starting from your own head, an outline or a brief fits better — want help with that?"

If the user pushes back, defer and proceed.

## Reference files

- [`references/essay-draft-template.md`](references/essay-draft-template.md) — the exact template structure to use when writing the draft.
