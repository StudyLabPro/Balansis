# Installation

**Audience:** developers  
**Status:** canonical

## PyPI

```bash
pip install balansis
```

## pipx CLI Install

Balansis also ships a small CLI for release smoke checks and basic operations:

```bash
pipx install balansis
balansis --version
balansis doctor
balansis add 2 3 --json
```

Use `pipx reinstall balansis` to upgrade an existing isolated CLI install.

## Extras

```bash
pip install balansis[plot]
pip install balansis[notebook]
pip install balansis[torch]
pip install balansis[all]
```

## Supported Python Versions

- Python 3.10
- Python 3.11
- Python 3.12

## Core Dependencies

- `pydantic >= 2.5`
- `numpy >= 1.24`

## Wheel / Local Artifact Install

```bash
pip install dist/balansis-1.1.0-py3-none-any.whl
pipx install dist/balansis-1.1.0-py3-none-any.whl
```

## From Source

```bash
git clone https://github.com/XTeam-Pro/Balansis.git
cd Balansis
poetry install
```

## Related Surfaces

- Core package entrypoint: [README.md](../../README.md)
- API reference: [API Reference](../api/index.md)
- TNSIM subproject: [TNSIM Overview](../tnsim/overview.md)
