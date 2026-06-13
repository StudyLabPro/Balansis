# Linear Algebra Overview

**Audience:** developers and technical readers  
**Status:** canonical

The `balansis.linalg` package exposes ACT-aware linear algebra entrypoints for
matrix multiplication and decomposition workflows.

## Current Exports

- `matmul`
- `qr_decompose`
- `svd`
- `CompensatedQRResult`
- `CompensatedSVDResult`

## Scope

The current linear algebra layer is real and code-backed, but it is still a
runtime-oriented numerical surface rather than a formally verified matrix
algebra library.

## Related Docs

- [GEMM / Matrix Multiply](gemm.md)
- [QR Decomposition](qr.md)
- [SVD](svd.md)
- [Scientific Computing](../../guides/scientific-computing.md)
