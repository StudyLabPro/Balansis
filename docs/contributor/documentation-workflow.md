# Documentation Workflow

**Audience:** contributors and maintainers  
**Status:** canonical  
**Source of truth:** this page for documentation update and archival workflow

This page defines how documentation changes should be made in the Balansis
repository.

## Core Rule

Every meaningful code or architecture change should be evaluated for its
documentation impact in the same change window.

## Update Flow

1. identify the canonical document that owns the topic
2. update the canonical page first
3. update navigation hubs if discoverability changed
4. update archive or research routing only if an old document was moved or demoted
5. verify that new links resolve and terminology matches `docs/glossary.md`

## Canonical Ownership Rules

- product positioning belongs in `README.md`
- reader-facing topic docs belong in `docs/`
- runnable assets belong in `examples/` and `benchmarks/`
- theorem and proof details belong in `docs/formal/` and `formal/`
- historical material belongs in `docs/archive/legacy/`

## When To Archive Instead Of Edit

Archive a document instead of editing it in place when:

- it is mixed-language legacy content
- it makes historical claims that are no longer current
- it duplicates a new canonical page
- it no longer matches repository structure or proof status

In that case:

1. create or update the new English canonical page
2. move the old page to `docs/archive/legacy/` when appropriate
3. label it as archived through location and context
4. reroute links from canonical surfaces to the new page

## Required Checks

Before finishing a documentation change:

- verify changed markdown files have no diagnostics
- check for stale links or moved-path references
- confirm that the page is reachable from a hub when it is meant to be public
- avoid adding placeholders for code that does not exist

## Common Change Types

| Change type | Minimum documentation action |
|---|---|
| new runtime API | update or add code-backed API docs |
| new theory or proof claim | update mathematics or formal docs |
| moved or removed doc | reroute links and archive history correctly |
| new example or benchmark | update the corresponding docs hub and execution README |
| new contributor process | update contributor docs and standards |

## Reader Paths

- development setup: [development-setup.md](development-setup.md)
- terminology rules: [Glossary](../glossary.md)
- standards: [Documentation Standards](../standards.md)
