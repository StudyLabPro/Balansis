# Contributor Development Setup

**Audience:** contributors  
**Status:** canonical

## Local Setup

```bash
git clone https://github.com/StudyLabPro/Balansis.git
cd Balansis
poetry install
```

## Core Checks

```bash
poetry run pytest
poetry run mypy balansis/
poetry run black balansis/ tests/
poetry run isort balansis/ tests/
poetry run flake8 balansis/
```

## Related Docs

- [Contributing](../../CONTRIBUTING.md)
- [Documentation Workflow](documentation-workflow.md)
- [Documentation Standards](../standards.md)
- [Repository Map](../architecture/repository-map.md)
