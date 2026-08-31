# Documentation Architecture

**Audience:** contributors and maintainers  
**Status:** canonical

Balansis documentation follows a domain-based structure.

## Public Canonical Layers

- `README.md`: product landing page and top-level navigation
- `docs/`: reader-facing documentation by domain and audience
- `examples/`: runnable notebooks and example assets
- `benchmarks/`: runnable benchmark code and benchmark docs entrypoint
- `formal/`: Lean source code and local formal build instructions
- `tnsim/`: subproject-specific runtime and documentation surface

## Non-Canonical Layers

- `docs/research/`: exploratory or publication-oriented material
- `docs/archive/legacy/`: retained historical documents

## Design Rules

- every major topic has one canonical home
- English is the canonical language
- reader-facing docs live in `docs/`
- runnable assets stay close to the code they describe
- archived material must be visibly non-canonical
