# QR Decomposition

**Audience:** developers and technical readers  
**Status:** canonical

`qr_decompose` computes a QR decomposition and returns a structured
`CompensatedQRResult`.

## Purpose

The result includes:

- `Q`
- `R`
- `orthogonality_error`
- `method`
- `compensation_factors`

## Supported Methods

- `householder`
- `givens`
- `gram_schmidt`

## Entry Point

```python
from balansis.linalg import qr_decompose
```

## Related Docs

- [Linear Algebra Overview](overview.md)
- [Scientific Computing](../../guides/scientific-computing.md)
