# API Reference

**Audience:** developers  
**Status:** canonical

This API section is intentionally code-backed. It documents the shipped Python
surface that exists today and avoids placeholder pages.

## Current Coverage

- [Core: AbsoluteValue](core/absolute-value.md)
- [Core: EternalRatio](core/eternal-ratio.md)
- [Core: Operations](core/operations.md)
- [Algebra Runtime Overview](algebra/overview.md)
- [Linear Algebra Overview](linalg/overview.md)
- [Finance: Ledger](finance/ledger.md)
- [Integrations: Compatibility](integrations/compatibility.md)
- [Integrations: NumPy](integrations/numpy.md)
- [Sets Runtime Overview](sets/overview.md)

## Package Areas

- `balansis.core`: foundational runtime objects and compensated operations
- `balansis.algebra`: higher-level algebraic structures
- `balansis.linalg`: linear algebra routines
- `balansis.finance`: finance-oriented helpers such as ledgers
- `balansis.numpy_integration`: NumPy bridge
- `balansis.ml`: experimental optimizer-related work

## Documentation Policy

- only document modules that exist in the repository
- do not create placeholder API pages for planned surfaces
- move speculative API design into `docs/research/` or issue tracking
