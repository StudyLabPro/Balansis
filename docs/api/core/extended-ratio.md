# ExtendedRatio API

**Audience:** developers  
**Status:** canonical

`ExtendedRatio` is the opt-in runtime object for singular arithmetic in
Balansis. It extends the strict finite `EternalRatio` contract with explicit
states for infinity and indeterminate results.

## Purpose

Use `ExtendedRatio` when your pipeline must represent division edge cases as
data instead of raising immediately.

It currently models these states:

- `finite`
- `infinite`
- `indeterminate`

## Common Entry Points

```python
from balansis import AbsoluteValue, ExtendedRatio, Operations

finite = ExtendedRatio.from_division(
    AbsoluteValue.from_float(6.0),
    AbsoluteValue.from_float(2.0),
)

infinite = Operations.compensated_divide_extended(
    AbsoluteValue.from_float(6.0),
    AbsoluteValue.absolute(),
)[0]

indeterminate = ExtendedRatio.from_division(
    AbsoluteValue.absolute(),
    AbsoluteValue.absolute(),
)
```

## Core Methods

- `is_finite()`
- `is_infinite()`
- `is_indeterminate()`
- `is_singular()`
- `numerical_value()`
- `signed_value()`
- `finite_ratio()`
- `apply_policy()`
- `policy_event()`
- `saturate()`
- `to_json()`

## Current Semantics

- `finite / finite` stays in the strict `EternalRatio` model
- `finite / ABSOLUTE` becomes signed infinity
- `ABSOLUTE / ABSOLUTE` becomes indeterminate
- `+infinity + (-infinity)` becomes indeterminate
- `0 * infinity` becomes indeterminate

## Policy Layer

Balansis now exposes explicit singular-arithmetic policies for `ExtendedRatio`:

- `raise`: reject singular states immediately
- `propagate`: keep `infinite` or `indeterminate` as runtime data
- `saturate`: clamp infinite states to a finite bound while leaving `indeterminate` explicit

The policy layer also emits machine-readable `SingularArithmeticEvent` objects
that can be recorded in telemetry or benchmark artifacts.

## Boundary With EternalRatio

- `EternalRatio` remains the canonical finite structured ratio object
- `ExtendedRatio` is the wider runtime surface for singular states
- the current Lean theorem layer proves `ExtendedRatio` division-state classification
- the current Lean theorem layer proves semantic operation and policy laws for indeterminate propagation, infinity interactions, saturation, and policy application
- the current Lean theorem layer does not yet prove metric or topological laws for singular states

## Related Docs

- [EternalRatio API](eternal-ratio.md)
- [Operations API](operations.md)
- [Claim Closure Baseline Results](../../benchmarks/claim-closure-results.md)
- [Proof Map](../../formal/proof-map.md)
- [ExtendedRatio Runtime Parity](../../formal/extended-ratio-runtime-parity.md)
