# Scientific Computing

**Audience:** developers, researchers, evaluators  
**Status:** canonical  
**Source of truth:** this page for scientific-computing usage patterns

This guide shows how to approach Balansis in workloads where unstable sums and
near-cancellation matter more than raw float convenience.

## When To Use This Guide

Use this guide when your workload includes:

- large reductions with small meaningful residuals
- near-cancellation between large positive and negative terms
- evaluation workflows where the correction itself is useful information

## Current Code-Backed Entry Points

The most direct current entry points are:

- `Operations.sequence_sum`
- `Operations.compensated_add`

### Large-Scale Aggregation

```python
from balansis import AbsoluteValue as Bv, Operations

values = [
    Bv.from_float(1e16),
    Bv.from_float(1.0),
    Bv.from_float(-1e16),
]

result, compensation = Operations.sequence_sum(values)
```

`sequence_sum` uses compensated summation and returns both the result and an
explicit compensation signal.

### Near-Cancellation

```python
from balansis import AbsoluteValue as Bv, Operations

a = Bv.from_float(1e16)
b = Bv.from_float(-1e16)

result, compensation = Operations.compensated_add(a, b)
```

`compensated_add` is designed to avoid misleading exact-zero results when the
floating-point representation has hidden a meaningful residual.

## Interpretation Pattern

In current Balansis usage, the pair `(result, compensation)` should be read as:

- `result`: the ACT-aware output value
- `compensation`: a signal that the computation passed through a numerically sensitive path

This is useful in scientific evaluation pipelines where a result alone is not
enough to explain confidence in the computation.

## Current Limits

- this guide covers the current arithmetic entry points, not a full scientific framework
- benchmark methodology lives separately from usage guidance
- linear algebra scenarios need deeper canonical documentation in a later pass

## Reader Paths

- precision framing: [Precision and Stability](precision-and-stability.md)
- benchmark rules: [Benchmark Methodology](../benchmarks/methodology.md)
- mathematical layer: [ACT Definitions and Notation](../mathematics/act-definitions.md)
