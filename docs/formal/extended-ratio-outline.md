# ExtendedRatio Formalization Outline

**Audience:** researchers, contributors  
**Status:** canonical formalization status note

This page tracks the formalization target for the runtime `ExtendedRatio`
surface. The current Lean layer now contains a proved semantic core, while the
broader algebraic/topological theory remains future work.

## Current Truth

- the proved Lean ratio object is the finite `EternalRatio` layer
- the shipped Python runtime now also exposes `ExtendedRatio`
- `ExtendedRatio` now has a theorem-level Lean classifier for runtime division states
- `ExtendedRatio` now has proved semantic operation laws for indeterminate propagation, opposite infinities, zero-times-infinity, saturation, and policy application
- the broader algebraic and topological theory for singular states is still not formalized

## Why A Separate Formal Track Is Needed

`ExtendedRatio` is not a simple field extension of the current finite model.
Once `infinite` and `indeterminate` states are admitted, some operations become:

- total but non-field-like
- partial in the classical algebraic sense
- dependent on explicit semantic transition rules

That means the current `Field EternalRatio` proofs cannot simply be renamed or
reused as-is.

## Minimal Formal Scope

The first honest Lean target for `ExtendedRatio` was to formalize:

1. the state space `finite | infinite | indeterminate`
2. the embedding of finite `EternalRatio` into the wider type
3. the runtime division rules:
   - finite / finite
   - finite / zero
   - zero / zero
4. theorem statements for the deterministic semantic transitions already shipped in Python
5. total semantic operations for `negate`, `add`, and `mul`
6. policy application for `raise`, `propagate`, and `saturate`
7. an explicit witness that `ExtendedRatio` has non-field-like singular behavior

That baseline now exists in:

- `formal/BalansisFormal/ExtendedRatio.lean`
- `formal/ACT/ExtendedRatio.lean`

## Deliberate Non-Claims

This page does not claim:

- a field instance on `ExtendedRatio`
- full theorem parity with `EternalRatio`
- continuity, completeness, or algebraic laws for the singular states

Those require a separate model decision and proof effort.

## Runtime Sources

- `balansis/core/eternity.py`
- `balansis/core/operations.py`
- `balansis/logic/compensator.py`
- `tests/test_extended_ratio.py`
- `benchmarks/results/claim_closure_baseline.json`
- `formal/BalansisFormal/ExtendedRatio.lean`
- `formal/ACT/ExtendedRatio.lean`

## Related Docs

- [Proof Map](proof-map.md)
- [ExtendedRatio Runtime Parity](extended-ratio-runtime-parity.md)
- [ExtendedRatio API](../api/core/extended-ratio.md)
- [Claim Closure Baseline Results](../benchmarks/claim-closure-results.md)
