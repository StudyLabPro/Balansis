# Singular Value Decomposition

**Audience:** developers and technical readers  
**Status:** canonical

`svd` computes an SVD and returns a structured `CompensatedSVDResult`.

## Purpose

The result includes:

- `U`
- `S`
- `Vt`
- `reconstruction_error`
- `method`
- `compensation_factors`

## Current Backend

The current implementation delegates the numerical kernel to NumPy SVD and then
wraps the result in an ACT-oriented diagnostic container.

## Entry Point

```python
from balansis.linalg import svd
```

## Related Docs

- [Linear Algebra Overview](overview.md)
- [Scientific Computing](../../guides/scientific-computing.md)
