# Why Balansis

**Audience:** decision makers, technical leads, developers  
**Status:** canonical

Balansis is a numerical computing library built for scenarios where silent error
accumulation is unacceptable.

## The Problem

IEEE 754 floating-point arithmetic is fast and universal, but some classes of
problems remain hard to reason about:

- accumulated rounding across long reductions
- catastrophic cancellation in near-equal subtraction
- unstable divide-by-zero edge handling
- error propagation across simulations and financial ledgers

## What Balansis Changes

Balansis exposes the numerical edge cases as structured concepts instead of
leaving them implicit:

- `AbsoluteValue` models signed magnitude explicitly
- `ABSOLUTE` acts as the ACT additive identity
- `EternalRatio` provides a structured ratio abstraction
- compensated operations return both a result and a compensation factor

## Why It Matters

Balansis is useful when you need:

- auditable aggregation behavior
- explicit handling of compensation and cancellation
- mathematically motivated runtime objects instead of ad hoc edge checks
- a research path from Python runtime code to Lean-backed theorem statements

## Next Steps

- Read the product overview in [README.md](../../README.md)
- Start using the library in [Quick Start](quickstart.md)
- Review the theory surface in [Mathematics](../mathematics/index.md)
- Review formal claims in [Formal Verification](../formal/overview.md)
