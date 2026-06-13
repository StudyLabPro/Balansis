# Shadow Document Triage

**Audience:** maintainers and contributors  
**Status:** canonical  
**Source of truth:** this page for `.trae` classification and migration decisions

This inventory classifies the hidden `.trae/documents` layer so it cannot
silently compete with the canonical `docs/` tree.

## Policy

- `.trae/documents/*` is internal working material, not public source of truth.
- A shadow file may be:
  - `migration-source`: useful raw material for canonical docs
  - `research`: exploratory or speculative content
  - `archived`: historical material kept only for reference
  - `remove-from-active-use`: should not be cited or presented as current
- Do not repair shadow files as if they were canonical docs. Migrate their
  useful content into `docs/` or `docs/research/`, then leave a clear notice.

## Triage Table

| Path | Domain | Drift type | Canonical replacement or owner | Fate |
|---|---|---|---|---|
| `.trae/documents/README.md` | governance | source-of-truth drift | `docs/index.md`, `docs/standards.md` | `remove-from-active-use` |
| `.trae/documents/docs_index.md` | navigation | broken-index drift | `docs/index.md` | `remove-from-active-use` |
| `.trae/documents/technical_architecture.md` | architecture | architecture drift | `docs/architecture/runtime-architecture.md`, `docs/architecture/repository-map.md` | `archived` |
| `.trae/documents/theory/act-overview.md` | theory | duplication + terminology drift | `docs/getting-started/why-balansis.md`, `docs/mathematics/act-definitions.md` | `migration-source` |
| `.trae/documents/theory/absolute-eternity-axioms.md` | theory | proof and terminology drift | `docs/mathematics/act-definitions.md`, `docs/formal/proof-map.md` | `migration-source` |
| `.trae/documents/theory/algebraic-structures.md` | theory | theorem inflation + legacy naming drift | `docs/mathematics/algebraic-structure.md`, `docs/formal/proof-map.md` | `archived` |
| `.trae/documents/zero_sum_infinite_sets_theory.md` | theory / research | speculative theory drift | `docs/tnsim/overview.md`, `docs/research/` | `research` |
| `.trae/documents/tnsim_technical_architecture.md` | architecture / subproject | mixed runtime and speculative architecture drift | `docs/tnsim/runtime-status.md` and future `docs/tnsim/*` | `migration-source` |
| `.trae/documents/balansis_llm_project.md` | product | orphan product drift | `docs/research/` only if retained | `research` |
| `.trae/documents/balansis_llm_technical_architecture.md` | architecture | orphan speculative architecture drift | `docs/research/` only if retained | `research` |
| `.trae/documents/product_requirements.md` | product | non-canonical product scope drift | root governance docs and canonical docs tree | `archived` |

## Highest-Risk Files

These files require explicit notices because a reader could mistake them for the
current truth:

- `.trae/documents/README.md`
- `.trae/documents/theory/act-overview.md`
- `.trae/documents/theory/absolute-eternity-axioms.md`
- `.trae/documents/theory/algebraic-structures.md`

## Migration Rules

When useful content exists in a shadow file:

1. extract the fact or explanation
2. classify it as `proved`, `implemented`, `measured`, or `research`
3. move it into canonical docs only after it has a matching artifact
4. keep the shadow file marked as non-canonical

## Completion Rule

Shadow-document triage is complete only when:

- each high-risk `.trae` file has a visible non-canonical notice
- no canonical page points readers into `.trae/documents`
- useful content from `.trae` has a documented migration target or a research/archive classification
