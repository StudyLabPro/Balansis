# Release Process

**Audience:** maintainers  
**Status:** canonical

Balansis publishes stable Python distributions to PyPI and exposes both a
library API (`pip install balansis`) and a CLI entrypoint (`pipx install balansis`).

## Current Stable Release

- Package: `balansis`
- Version: `1.1.0`
- Python: `3.10`, `3.11`, `3.12`
- Distribution formats: wheel and sdist
- CLI command: `balansis`

## Local Release Verification

Run these checks before tagging:

```bash
python scripts/validate_version.py
python scripts/check_changelog.py
pytest tests/test_cli.py tests/test_extended_ratio.py tests/test_extended_ratio_semantic_parity.py --no-cov
cd formal && lake build && lake env lean FormalAudit.lean
```

Build and validate distributions from the repository root:

```bash
python -m venv .release-venv
.release-venv/bin/python -m pip install --upgrade pip build twine pipx
.release-venv/bin/python -m build
.release-venv/bin/twine check dist/*
```

Verify local `pip` install:

```bash
.release-venv/bin/python -m venv .pip-install-venv
.pip-install-venv/bin/python -m pip install --upgrade pip
.pip-install-venv/bin/python -m pip install dist/balansis-1.1.0-py3-none-any.whl
.pip-install-venv/bin/python -c "import balansis; assert balansis.__version__ == '1.1.0'"
.pip-install-venv/bin/balansis --version
.pip-install-venv/bin/balansis doctor
```

Verify local `pipx` install:

```bash
.release-venv/bin/pipx install --force dist/balansis-1.1.0-py3-none-any.whl
.release-venv/bin/pipx runpip balansis show balansis
.release-venv/bin/pipx run --spec dist/balansis-1.1.0-py3-none-any.whl balansis --version
```

## Publishing

The release workflow is `.github/workflows/release.yml`.

It runs on:

- `v*` tags
- manual `workflow_dispatch`

It performs:

1. version and changelog validation
2. license document validation
3. Python release smoke tests
4. wheel and sdist build
5. `twine check`
6. pip install smoke checks on Linux/macOS/Windows and Python 3.10/3.11/3.12
7. pipx install smoke checks on Linux
8. TestPyPI publication
9. PyPI publication
10. GitHub Release creation

Affected Lean sources are built and audited by `Release Validation` when they
merge to `master`. Run the manual `Heavy Validation` formal scope before a tag
when an additional full formal check is required.

Required GitHub secrets:

- `TEST_PYPI_API_TOKEN`
- `PYPI_API_TOKEN`

## Tagging

```bash
git tag v1.1.0
git push origin v1.1.0
```

Do not reuse a PyPI version after upload. If a published release must be fixed,
bump the version and publish a new release.

## End-user Installation

```bash
pip install balansis
pipx install balansis
```

Smoke check:

```bash
python -c "import balansis; print(balansis.__version__)"
balansis --version
balansis doctor
```
