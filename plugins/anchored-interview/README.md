# Anchored Interview Plugin

A meta-skill that scaffolds new Claude Code skills built around the **Anchored Interview pattern** — ground in a corpus, run a short interview sharpened by what was found, then produce a single artifact.

## Why this pattern

Half the information an agent needs to do good work isn't in the corpus. It's in your head: intent, preferences, constraints you haven't written down.

Two common shapes break on that split. Read-only approaches lean on the corpus and produce a competent average of it. Generic "what do you want?" interviews lean on you, but can't draw out the in-your-head half because nothing concrete is steering the questions. Neither alone produces the artifact you actually want.

The Anchored Interview does both, in sequence, and lets the corpus shape the interview:

1. **Scope** — capture the seed intent in one sentence
2. **Ground** — read the relevant corpus (codebase, docs site, notes folder, transcripts)
3. **Anchored interview** — questions sharpened by what step 2 surfaced
4. **Act** — emit a single artifact

The seed steers the grounding. The grounding sharpens the questions. The questions tighten the artifact.

## Installation

```bash
/plugin install ac-anchored-interview@alteredcraft-plugins
```

## Skills

### anchored-interview-skill-creator

Interviews you to produce a new skill that follows the Anchored Interview pattern. Output is a complete skill directory — `SKILL.md` plus a `references/<artifact>-template.md` — ready to drop into a project, your user-global skills, or another plugin.

**Usage:**

```
Skill(ac-anchored-interview:anchored-interview-skill-creator) a skill that drafts blog posts from my research notes
```

Or describe what you want in natural language:

```
I want a skill that reads my research-findings folder and helps me draft long-form essays
```

```
Make me an anchored interview skill for spec'ing features in this codebase
```

The skill walks you through:

1. Confirming the seed intent
2. Grounding in bundled worked examples (one code-corpus, one docs-corpus) and a parameterized blueprint
3. A short, adaptive interview covering: skill name, corpus shape, artifact type, seed-intent shape, trigger phrases, negative triggers, coverage areas, install location, output template sections
4. Surfacing blockers (no real corpus, bundled artifacts, name collisions)
5. Confirming the install path
6. Writing both files in one pass

## When to use it

Reach for this plugin when the workflow you're trying to automate has the shape: *something concrete exists to ground in, and the agent needs a few sharp questions answered before it can produce the artifact well.*

Typical fits:

- A skill that drafts feature specs from a codebase
- A skill that drafts essays or articles from a research-notes directory
- A skill that produces implementation plans from a project's docs and recent commits
- A skill that prepares meeting briefs from a transcript archive
- A skill that runs editorial review on a draft against a style-guide corpus

## When not to use it

- You want to *run* an anchored interview on a specific task — this plugin *creates* such skills, it doesn't perform them
- You want to edit an existing SKILL.md
- The workflow is a one-shot transformation with no judgment calls (a regular slash command fits better)
- There's no real corpus to anchor on — true greenfield work needs a brief or discovery doc first

## License

MIT
