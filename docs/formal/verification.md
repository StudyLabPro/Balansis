# Formal Verification of Absolute Compensation Theory

## Overview

This document describes the current machine-checked verification of the public
ACT theorem surface using Lean 4 and Mathlib `v4.28.0`.

The current architecture has two layers:

- `BalansisFormal`: constructive core and technical lemmas
- `ACT`: public theorem facade exporting A1–A5, E1–E4, and S1–S3

The shipped proof tree contains **0 `sorry`**, **0 `axiom` declarations**, and
builds through `lake build`, `lake build BalansisFormal`, and `lake build ACT`.

## Mathematical Framework

### Core Types

**AbsoluteValue** replaces IEEE 754 floating-point representation with an
explicit decomposition into non-negative magnitude and sign direction:

```
AbsoluteValue := (magnitude : NNReal, direction : Direction, wf : magnitude = 0 -> direction = pos)
```

where `Direction := {pos, neg}` and the well-formedness condition `wf` enforces
a canonical zero representation (the *absolute* element).

**EternalRatio** replaces IEEE 754 infinity/NaN with a structurally safe ratio
defined as a quotient of ratio representatives:

```
RatioRep := (numerator : AbsoluteValue, denominator : AbsoluteValue, den_nonzero : denominator ≠ 0)
EternalRatio := Quotient RatioRep.Rel
```

Division by zero is eliminated at the representative level: each constructor
requires a proof that the denominator is nonzero.

### The toReal Bridge

The central proof technique is a bridge to the real numbers:

```
toReal : AbsoluteValue -> R
toReal(a) = direction.toReal * magnitude

toReal : EternalRatio -> R
toReal(r) = representative.numerator.toReal / representative.denominator.toReal
```

Key bridge theorems establish that ACT operations correspond to standard real
arithmetic:

| Bridge Theorem | Statement |
|---------------|-----------|
| `toReal_add` | `(a + b).toReal = a.toReal + b.toReal` |
| `toReal_mul` | `(a * b).toReal = a.toReal * b.toReal` |
| `toReal_neg` | `(-a).toReal = -a.toReal` |
| `toReal_injective` | `toReal(a) = toReal(b) => a = b` |

The proof pattern for algebraic properties is:
1. Prove the identity on `R` (using `ring`, `nlinarith`, or `field_simp`)
2. Apply `toReal_injective` to lift structural equality

This strategy delegates algebraic reasoning to Lean's powerful `ring` tactic
while the bridge theorems handle the translation between ACT's structured
representation and standard reals.

## Public Theorems

### A1-A5: AbsoluteValue Axioms

| # | Axiom | Lean Theorem | Proof Strategy |
|---|-------|-------------|----------------|
| A1 | **Existence and uniqueness** | `a1_exists_unique` | `fromReal`/`toReal` round-trip + injectivity |
| A2 | **Non-negativity** | `a2_nonneg` | Structural from `NNReal` |
| A3 | **Compensation** | `a3_compensation` | Case analysis on direction and magnitude |
| A4 | **Identity** | `a4_additive_identity` / `a4_additive_identity_left` | Structural equality on the type |
| A5 | **Direction Preservation**: `c > 0 => dir(c*a) = dir(a)` | `a5_direction_preservation` | Case split on sign; `nlinarith` |

**A2 highlights structural type safety**: Non-negativity of magnitude is not
proved by runtime check but is *structurally encoded* via Mathlib's `NNReal`
(non-negative real number) type.  A negative magnitude is a type error caught
at compile time.

### E1-E4: EternalRatio Axioms

| # | Axiom | Lean Theorem | Proof Strategy |
|---|-------|-------------|----------------|
| E1 | **Well-definedness** | `e1_well_defined` | Quotient representative construction + uniqueness |
| E2 | **Stability** | `e2_stability` | Representative existence with nonzero denominator proof |
| E3 | **Multiplicative Identity** | `e3_multiplicative_identity` / `e3_multiplicative_identity_left` | Structural equality on `EternalRatio` |
| E4 | **Inverse** | `e4_inverse` | Field reasoning after transport through `toReal` |

**E2 highlights type-level safety**: The stability axiom is not a runtime
assertion but a *proof obligation at construction time*.  Any code that creates
an `EternalRatio` must supply a proof that the denominator is non-zero.  This
is the formal counterpart to ACT's claim that "Eternity replaces infinity."

### S1-S3: Algebraic Structure Axioms

| # | Axiom | Lean Theorems | Proof Strategy |
|---|-------|--------------|----------------|
| S1 | **Additive laws on `AbsoluteValue`** | `ACT.AbsoluteValue.s1_*` | Structural equality on the type |
| S2 | **Multiplicative laws on `AbsoluteValue`** | `ACT.AbsoluteValue.s2_*`, `mul_add_distrib` | Structural equality + field transport |
| S3 | **Field laws on `EternalRatio`** | `ACT.EternalRatio.s3_*` | Structural equality on the quotient type |

The quotient-based `EternalRatio` also carries a Lean `Field` instance, and the
public smoke module `formal/FormalAudit.lean` checks that the theorem surface
and instances are importable.

## File Structure

```
formal/
  lakefile.lean                    -- Lean 4 project config (Mathlib v4.28.0)
  lean-toolchain                   -- leanprover/lean4:v4.28.0
  BalansisFormal.lean              -- Root import for constructive layer
  ACT.lean                         -- Root import for public theorem layer
  FormalAudit.lean                 -- Smoke import audit
  BalansisFormal/
    Direction.lean                 -- Sign type and technical lemmas
    AbsoluteValue.lean             -- Constructive core for A1-A5
    EternalRatio.lean              -- Quotient-based ratio core for E1-E4
    Algebra.lean                   -- Structural algebra theorems and instances
  ACT/
    Direction.lean                 -- Public sign facade
    Absolute.lean                  -- Public A1-A5 facade
    EternalRatio.lean              -- Public E1-E4 facade
    Algebra.lean                   -- Public S1-S3 facade
```

## Verification

```bash
cd formal
lake build
lake build BalansisFormal
lake build ACT
lake env lean FormalAudit.lean
```

## Relationship to Python Implementation

The Lean formalization and the Python library (`balansis/`) are independent
implementations of the same mathematical theory:

| Aspect | Lean (formal/) | Python (balansis/) |
|--------|---------------|-------------------|
| Purpose | Mathematical certification | Numerical computation |
| `AbsoluteValue` | `NNReal x Direction` (exact) | `Pydantic model (float, int)` (IEEE 754) |
| Addition | Exact on `NNReal` | Compensated with error tracking |
| Guarantees | Logical soundness (proof) | Numerical stability (runtime) |
| Axiom status | All 12 proven as theorems | Validated via 673+ unit tests |

The formal proofs certify that ACT's algebraic structure is *mathematically
consistent* — the types and operations form valid groups and fields.  The Python
implementation then provides a *numerically stable* realization of these
operations on IEEE 754 hardware, with compensated arithmetic to minimize
floating-point error.
