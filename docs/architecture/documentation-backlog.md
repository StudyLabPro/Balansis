# Documentation Backlog

**Audience:** maintainers and contributors  
**Status:** canonical  
**Source of truth:** this page for documentation-gap tracking

This backlog captures the highest-value documentation work needed after the
Stage 1 architecture reset.

## Priority 1

| Area | Missing or weak document | Why it matters | Target location |
|---|---|---|---|

## Priority 2

| Area | Missing or weak document | Why it matters | Target location |
|---|---|---|---|

## Priority 3

| Area | Missing or weak document | Why it matters | Target location |
|---|---|---|---|

## Drift To Resolve In Existing Docs

| Document | Current issue | Required action |
|---|---|---|
| `ROADMAP.md` | Uses terms and architecture statements that are not yet aligned with the new documentation system | align terminology and cross-links with canonical docs |
| `docs/formal/verification.md` | valuable content exists, but it overlaps with `docs/formal/overview.md` and needs clearer role separation | keep as deep-dive reference and link it explicitly from overview |
| `examples/` notebooks | some prose remains legacy-style or mixed-language | normalize reader-facing notebook narration to English as notebooks are revised |
| `docs/mathematics/index.md` | currently a hub without deep canonical content | expand into real theory navigation pages |

## Completion Rule

A backlog item is complete only when:

- the document exists in its canonical location
- the page is linked from `README.md` or `docs/index.md` through an appropriate hub
- the page does not depend on archived material to explain current behavior
- terminology matches `docs/glossary.md`
