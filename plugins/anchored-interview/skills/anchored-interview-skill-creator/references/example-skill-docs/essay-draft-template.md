# Essay Draft Template

Use this template verbatim when writing the draft. Section headers and order are intentional — the prose lives at the top, the metadata that produced it lives below, so a reader can read the essay without scrolling past planning notes.

Replace everything in `{{ braces }}` with content from the interview and the deep read. Delete the inline guidance (italicized hints) once filled.

---

```markdown
# {{ Working title }}

**Status:** Draft
**Author:** {{ user's name, or omit if not provided }}
**Date:** {{ YYYY-MM-DD }}
**Word count:** {{ approximate, e.g., ~1,800 words }}

## TL;DR

{{ One or two sentences. The essay distilled — what it argues and why a reader should care. Written so someone skimming can decide in 10 seconds whether to read further. Not the same as the thesis; this is the marketing version. }}

---

## Draft

### Lede

{{ The opening — 1–3 paragraphs of actual prose, not a placeholder. Match the hook style decided in the interview (scene, question, contrarian claim, anecdote, quote). Get the reader's attention and signal the angle without yet stating the thesis bluntly. }}

### {{ Body section 1 title — derived from the structure decided in the interview }}

{{ Full prose, paragraphs not bullets. Carry the argument forward. Quote sources from the research directory verbatim where they're strong; cite inline as `(from <filename>)`. }}

### {{ Body section 2 title }}

{{ Full prose. Each body section should advance the argument — if a section could be cut without weakening the piece, cut it. }}

### {{ Body section 3 title — add or remove sections to match the structure decided }}

{{ Full prose. }}

### Conclusion

{{ 1–2 paragraphs. Land the thesis and the so-what. Don't recap — readers just read the essay. Leave them with something to carry. }}

---

## Draft notes

*This section is for the writer's next pass, not the published piece. Keep it; it's what makes the draft revisable.*

### Thesis

{{ One sentence. The argument the essay is making, stated bluntly. Quote the user's framing if it was strong. }}

### Audience

{{ Who this is for and what they already believe. Quote the user's own framing. }}

### Sources used

{{ Bullet list of files from the research directory that load-bearing claims or quotes came from. Mark which ones supplied direct quotes. }}

- `{{ research-dir/file.md }}` — {{ how it was used: quoted / paraphrased / context }}
- `{{ research-dir/another.md }}` — {{ how it was used }}

### Sources NOT used

{{ Files in the directory that were inventoried but didn't make it into the draft. One line on why each — saves the user from re-relitigating "did we consider X?". Omit this subsection if the directory was small enough that everything was touched. }}

### Structure rationale

{{ One short paragraph. Why the essay flows in this order — what would break if a section were moved or cut. Helps the user (or a future editor) revise without losing the argumentative spine. }}

### Open questions

{{ Things the user wasn't sure about during the interview, places where the research was thin, claims that need a fact-check before publishing, alternative angles the user might want to consider. Be honest — explicit unknowns are more valuable than confident-sounding guesses. }}

- [ ] {{ Question or gap 1 }}
- [ ] {{ Question or gap 2 }}

### Blockers / contradictions surfaced during interview

{{ Only include this subsection if a real tension came up — thesis vs. evidence mismatch, contradictory sources on a load-bearing point, corpus too thin for the intended length. State the blocker, what was decided (or that no decision was made), and what would need to be true for the draft to hold up. Omit the subsection entirely if there are none. }}
```

---

## Notes on filling this in

- **Date** comes from running `date '+%Y-%m-%d'` — don't guess.
- **Word count** is the prose under `## Draft` only, not the whole file. A rough number is fine — `~1,800 words` beats `1,847 words` (which implies a precision you don't have on a draft).
- **The Draft section is real prose.** Full sentences, paragraphs, actual writing. If you find yourself writing `[expand on X here]` or bullet-pointing a section, the interview wasn't deep enough on that area — go back and ask, or trim the section out of the draft entirely.
- **Body section titles come from the structure decided in the interview.** Don't keep "Body section 1" — replace it with a real header. For some structures (essay-in-fragments, numbered list, single argument with no internal breaks) the body may not need section headers at all; in that case, drop the subheaders and write continuous prose under `## Draft`.
- **Quote the user verbatim** in Thesis and Audience when their phrasing was good. The draft is theirs; their voice belongs in the notes that produced it.
- **The "Blockers / contradictions" subsection is conditional.** Include it only if you flagged something during the interview. If everything was smooth, omit the subsection entirely.
- **Keep it tight.** A 1,200–2,500 word draft is the sweet spot for this template. Past ~4,000 words, the piece probably wants to be two essays — flag that in Open Questions rather than letting the draft sprawl.
