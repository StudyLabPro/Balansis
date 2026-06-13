# GEMM / Matrix Multiply

**Audience:** developers  
**Status:** canonical

`matmul` performs ACT-aware matrix multiplication over matrices of
`AbsoluteValue`.

## Purpose

It multiplies two matrices and returns:

- the product matrix
- an aggregate compensation factor

The current implementation combines `Operations.compensated_multiply` with a
compensated accumulation strategy for each output cell.

## Entry Point

```python
from balansis.linalg import matmul
```

## Input Shape

- left operand: `m x k`
- right operand: `k x n`
- matrix elements: `AbsoluteValue`

## Related Docs

- [Linear Algebra Overview](overview.md)
- [Operations API](../core/operations.md)
