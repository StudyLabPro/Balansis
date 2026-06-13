# Repository Map

**Audience:** contributors and technical readers  
**Status:** canonical

## Top-Level Layout

```text
Balansis/
├── balansis/        # Python package
├── docs/            # reader-facing documentation
├── examples/        # notebooks and walkthrough assets
├── benchmarks/      # runnable benchmark code
├── formal/          # Lean formalization
├── tests/           # Python tests
└── tnsim/           # zero-sum infinite sets subproject
```

## Responsibility Boundaries

- `balansis/` is the shipped Python library
- `docs/` explains the product, theory, API, and governance
- `examples/` demonstrates usage
- `benchmarks/` measures behavior and regressions
- `formal/` contains the machine-checked Lean layer
- `tnsim/` is a repository subproject, not the main package entrypoint
