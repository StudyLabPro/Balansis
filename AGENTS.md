# AGENTS.md

## Scope

These instructions apply to the public Balansis repository. Keep contributions
limited to the published library, tests, documentation, examples, and Lean
formalization present in this checkout.

## Sources of truth

- `README.md` and `docs/` describe the supported public surface.
- `pyproject.toml` defines the Python package and quality gates.
- `formal/lakefile.lean` and `formal/README.md` define the Lean environment.
- `LICENSING.md`, `LICENSE`, and `CONTRIBUTING.md` govern distribution and
  contributions; do not reinterpret their terms in code or documentation.

## Engineering rules

- Preserve Python 3.10+ compatibility and the public API unless a breaking
  change is explicitly requested and documented.
- Separate proved Lean theorems, tested runtime behaviour, and research
  hypotheses. Do not strengthen mathematical or accuracy claims beyond the
  evidence committed in the same change.
- Add or update tests for behavioural changes. Run `poetry run pytest` for the
  Python package; when `formal/` changes, also run `lake build` from that
  directory.
- Follow the configured Black, isort, Flake8, mypy, and coverage settings.
- Do not commit credentials, private datasets, generated environments, caches,
  unpublished patent/counsel material, or internal ecosystem documentation.
- Keep public documentation non-confidential and limited to mechanisms already
  present in the published source tree. Escalate any uncertain disclosure
  before publishing it.

## Change hygiene

Make focused commits, preserve unrelated work, and record only human project
authorship in Git history. Update the relevant public documentation whenever a
supported command, API, proof status, or compatibility contract changes.
