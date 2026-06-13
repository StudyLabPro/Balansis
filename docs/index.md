# Balansis Documentation

**Audience:** all readers  
**Status:** canonical  
**Source of truth:** this `docs/` tree and the repository root governance files

Balansis documentation is organized by audience and by task:

- **Decision makers:** start with [Why Balansis](getting-started/why-balansis.md)
- **Developers:** start with [Quick Start](getting-started/quickstart.md) and [API Reference](api/index.md)
- **Researchers:** start with [Mathematics](mathematics/index.md) and [Formal Verification](formal/overview.md)
- **Contributors:** start with [Contributing](../CONTRIBUTING.md), [Documentation Standards](standards.md), and [Contributor Docs](contributor/development-setup.md)

## Sections

- [Getting Started](getting-started/why-balansis.md): value proposition, installation, quick start, adoption paths
- [Concepts](concepts/index.md): the core vocabulary of ACT and the Balansis runtime model
- [Guides](guides/index.md): usage patterns for finance, scientific computing, simulations, and integrations
- [Architecture](architecture/index.md): repository map, library structure, formal-layer layout, and documentation system
- [API Reference](api/index.md): code-backed reference for the shipped Python surface
- [Mathematics](mathematics/index.md): ACT definitions, notation, algebraic structure, and proof-oriented material
- [Formal Verification](formal/overview.md): Lean architecture, theorem map, and verification commands
- [Examples](examples/index.md): runnable notebooks and example walkthroughs
- [Benchmarks](benchmarks/index.md): methodology, scenarios, and result interpretation
- [TNSIM](tnsim/overview.md): overview and status of the zero-sum infinite sets subproject
- [Contributor Docs](contributor/development-setup.md): development workflow, testing, release process, and documentation maintenance
- [Research](research/index.md): whitepapers and non-canonical research material
- [Archive](archive/legacy/README.md): retained but non-canonical legacy material

## Documentation Governance

- [Glossary](glossary.md): canonical terminology and naming boundaries
- [Documentation Standards](standards.md): file, language, linking, and governance rules
- [Claims Execution Plan](architecture/claims-execution-plan.md): repository-wide remediation sequence for making documentation claims true
- [Claim Registry](architecture/claim-registry.md): tracked inventory of strong public claims and their evidence state
- [Shadow Document Triage](architecture/shadow-doc-triage.md): classification of hidden `.trae` materials and migration rules
- [Documentation Backlog](architecture/documentation-backlog.md): prioritized missing-document plan
- [Reading Paths](concepts/reading-paths.md): audience-specific routes through the docs tree

## Canonical Language

English is the canonical source language for public documentation. Future
translations should be derived from the English versions and stored separately
from the canonical tree.

## Status Labels

Use these labels consistently across documentation:

- **canonical**: current source of truth for a topic
- **derived**: adapted from a canonical source for a specific audience
- **research**: exploratory or publication-oriented material
- **draft**: incomplete working document
- **archived**: retained for history, not authoritative
