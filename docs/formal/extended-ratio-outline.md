# ExtendedRatio Formalization Outline

**Audience:** researchers, contributors  
**Status:** canonical planning note

This page describes the next formalization target for the runtime `ExtendedRatio`
surface. It is intentionally not part of the proved theorem map yet.

## Current Truth

- the proved Lean ratio object is the finite `EternalRatio` layer
- the shipped Python runtime now also exposes `ExtendedRatio`
- `ExtendedRatio` now has a minimal theorem-level Lean classifier for runtime division states
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
- [ExtendedRatio API](../api/core/extended-ratio.md)
- [Claim Closure Baseline Results](../benchmarks/claim-closure-results.md)
