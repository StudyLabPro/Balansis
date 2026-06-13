# Eternal Ratios And Compensation

**Audience:** developers and evaluators  
**Status:** canonical

This walkthrough corresponds to `examples/02_eternal_ratios_and_compensation.ipynb`.

## What It Covers

- how `EternalRatio` is used in the runtime
- how compensated operations expose auxiliary information
- how ratio-oriented behavior differs from plain division workflows
- where the strict finite `EternalRatio` contract stops and `ExtendedRatio` begins

## M3 Runtime Extension

Balansis now exposes two ratio layers:

- `EternalRatio` for strict finite ratios with explicit denominator guard
- `ExtendedRatio` for opt-in singular arithmetic with `finite`, `infinite`, and `indeterminate` states

Use the strict layer when invalid division should fail fast. Use the extended
layer when edge states must remain visible inside a longer-running computation.

## Recommended Use

- read this after the ACT introduction
- compare it with the mathematical definitions in `docs/mathematics/`

## Execution Entry Point

- notebook: [examples/README.md](../../examples/README.md)
- previous step: [Introduction To ACT Walkthrough](introduction-to-act.md)
- next step: [Algebraic Structures and Applications](algebraic-structures-and-applications.md)
