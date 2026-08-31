# Contributing to Balansis

Thank you for your interest in Balansis.

Balansis is maintained as a scientific and engineering codebase, so good
contributions improve not only the code, but also its documentation,
testability, and conceptual clarity.

## Conduct

Contribute respectfully, constructively, and professionally.

We value:

- respect for other contributors
- evidence-based technical discussion
- clear reproduction steps and examples
- honesty about limitations, assumptions, and trade-offs

## Before You Contribute

Read these documents first:

- [README.md](README.md)
- [docs/index.md](docs/index.md)
- [docs/standards.md](docs/standards.md)
- [LICENSING.md](LICENSING.md)
- [CLA.md](CLA.md)
- [SECURITY.md](SECURITY.md)

## Licensing and CLA

Balansis uses a dual-license model:

- open-source track: `AGPL-3.0`
- commercial track: separate commercial terms

By contributing substantial material, you confirm that you have the right to do
so and that the contribution can participate in the repository's dual-license
model. See:

- [LICENSING.md](LICENSING.md)
- [COMMERCIAL_LICENSE.md](COMMERCIAL_LICENSE.md)
- [CLA.md](CLA.md)

## Local Development Setup

Requirements:

- Python 3.10+
- Poetry
- Git

```bash
git clone https://github.com/StudyLabPro/Balansis.git
cd Balansis
poetry install
poetry run pre-commit install
```

Related contributor setup docs:

- [docs/contributor/development-setup.md](docs/contributor/development-setup.md)
- [docs/architecture/repository-map.md](docs/architecture/repository-map.md)

## Quality Gates

Run these before opening a pull request:

```bash
poetry run pytest
poetry run mypy balansis/
poetry run black balansis/ tests/ --check
poetry run isort balansis/ tests/ --check-only
poetry run flake8 balansis/
```

If you touch the Lean layer:

```bash
cd formal
lake build
lake build BalansisFormal
lake build ACT
```

## Documentation Expectations

- update documentation when behavior changes
- keep canonical public docs in English
- avoid creating new shadow documentation outside `docs/`
- keep research material, archive material, and canonical docs clearly separated
- do not introduce broken links or placeholder pages in the public docs tree

## Workflow

Recommended process:

1. Open an issue for large changes.
2. Create a focused branch from `main`.
3. Keep commits small and reviewable.
4. Add or update tests when the change affects behavior.
5. Update relevant docs in the same pull request.

Suggested commit prefixes:

- `feat:`
- `fix:`
- `docs:`
- `test:`
- `refactor:`
- `perf:`
- `ci:`

## Pull Request Checklist

- [ ] The change is scoped and described clearly
- [ ] Tests were added or updated when needed
- [ ] Documentation was updated when needed
- [ ] No stale claims were introduced
- [ ] The contribution is compatible with the dual-license model
- [ ] Local quality checks pass

## Where Help Is Most Valuable

- documentation architecture and API reference quality
- benchmark methodology and reproducible comparisons
- formal-verification exposition that bridges Lean and Python
- practical examples for finance, scientific computing, and simulations
- cleanup of `tnsim` documentation and status boundaries

## Questions

- Open a GitHub issue for bugs or proposals
- Raise larger design questions before implementing them
- Use [SECURITY.md](SECURITY.md) for private vulnerability disclosure

## Contact

Contribution, licensing, and repository questions:

- `andrew@xteam.pro`
