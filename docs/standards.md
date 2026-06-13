# Documentation Standards

**Audience:** contributors and maintainers  
**Status:** canonical

## Purpose

These standards keep Balansis documentation consistent, discoverable, and
maintainable as the repository grows.

## Language Policy

- English is the canonical public documentation language.
- Do not mix languages in the same canonical file.
- Future translations must be derived from English source files.

## File Naming

- Use `kebab-case.md` for canonical docs.
- Do not use version suffixes like `_v1` for canonical files.
- Reserve explicit status words such as `draft`, `research`, or `archived` for
  non-canonical material only.

## Location Rules

- Put reader-facing documentation under `docs/`.
- Keep runnable assets in their execution directories:
  - notebooks in `examples/`
  - benchmark scripts in `benchmarks/`
  - Lean code in `formal/`
  - TNSIM runtime code in `tnsim/`
- Hidden `.trae` files are internal working material and cannot act as public
  canonical documentation.

## Required Metadata

Substantial docs should begin with these fields when practical:

- audience
- status
- source of truth

## Status Vocabulary

Use a small fixed vocabulary for document status:

- `canonical`: current source of truth
- `derived`: adapted from canonical material for a specific delivery channel
- `research`: exploratory or publication-oriented material
- `draft`: active working material not yet authoritative
- `archived`: retained for history only

Do not invent status labels when one of the above is sufficient.

## Markdown Rules

- One H1 per document.
- Start with a short summary or purpose statement.
- Use short, stable section names.
- Prefer tables for inventories and comparisons.
- Keep code blocks runnable or clearly label them as pseudocode.

## Cross-Linking Rules

- Every major canonical document must be reachable from `README.md` or
  `docs/index.md`.
- Readers should reach any important topic within 2-3 clicks.
- Do not leave links to missing files.
- Prefer linking to canonical docs rather than to archived material.
- When archived material is linked, label it clearly as historical context.

## Scope Rules

- Keep public product and user documentation in `README.md`, root governance
  files, and `docs/`.
- Keep strategic planning in root files such as `ROADMAP.md`, but align terms
  and architecture claims with the canonical docs tree.
- Keep archived or mixed-language historical material out of canonical
  navigation paths.

## Diagrams

- Prefer text-based diagrams such as Mermaid for source control friendliness.
- Do not use screenshots as the only representation of architecture.

## Examples

- State prerequisites.
- State whether the example is tested, illustrative, or experimental.
- Link examples back to the relevant concept or API docs.

## Mathematics and Formal Material

- Keep notation consistent with `docs/glossary.md`.
- Distinguish clearly between:
  - mathematical definitions
  - proof sketches
  - formal Lean theorems
  - Python runtime behavior
  - heuristics or implementation notes

## Governance

- Review documentation changes alongside code changes.
- Run link checks before release.
- Mark legacy docs as archived rather than leaving them mixed into canonical
  directories.
- When a legacy document remains valuable, replace it with an English canonical
  page plus a clearly marked archived source, rather than editing the archived
  file in place.
