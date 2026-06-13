# Balansis Formal Verification (Lean 4 + Mathlib)

Machine-checked proofs for the public ACT theorem surface and its constructive
core using Lean 4 and Mathlib.

## Toolchain

- **Lean**: `leanprover/lean4:v4.28.0`
- **Mathlib**: `v4.28.0`

## Building

```bash
cd formal
lake build
```

A successful build certifies that the shipped proof surface compiles with no
`sorry`, no `axiom` declarations, and no unfinished proofs.

## Architecture

| File | Content | Theorems |
|------|---------|----------|
| `BalansisFormal/Direction.lean` | Constructive sign theory | Technical lemmas on directions and sign interpretation |
| `BalansisFormal/AbsoluteValue.lean` | Signed-magnitude constructive core | `a1_exists_unique`, `a2_nonneg`, `a3_compensation`, `a4_*`, `a5_direction_preservation` |
| `BalansisFormal/EternalRatio.lean` | Quotient type of ratio representatives | `e1_well_defined`, `e2_stability`, `e3_*`, `e4_inverse` |
| `BalansisFormal/Algebra.lean` | Structural algebra laws on the actual Lean types | `s1_*`, `s2_*`, `s3_*`, field witness for `EternalRatio` |
| `ACT/*.lean` | Public theorem facade | Re-exports A1–A5, E1–E4, S1–S3 with public names |
| `FormalAudit.lean` | Smoke import audit | Checks theorem and instance availability across public API |

## Public Theorem Surface

### AbsoluteValue (A1-A5)

| Axiom | Theorem name | Statement |
|-------|-------------|-----------|
| **A1** | `a1_exists_unique` | `∃! a : AbsoluteValue, a.toReal = x` |
| **A2** | `a2_nonneg` | non-negativity of the structural magnitude |
| **A3** | `a3_compensation` | exact cancellation under equal magnitude and opposite direction |
| **A4** | `a4_additive_identity`, `a4_additive_identity_left` | additive identity on the type itself |
| **A5** | `a5_direction_preservation` | positive scaling preserves direction for nonzero values |

### EternalRatio (E1-E4)

| Axiom | Theorem name | Statement |
|-------|-------------|-----------|
| **E1** (Well-definedness) | `e1_well_defined` | Denominator is structurally non-absolute |
| **E2** (Stability) | `e2_stability` | every representative has a nonzero denominator proof |
| **E3** (Identity) | `e3_multiplicative_identity`, `e3_multiplicative_identity_left` | structural multiplicative identity |
| **E4** (Inverse) | `e4_inverse` | `r * r⁻¹ = unity` for non-zero `r` |

### Algebraic Structures (S1-S3)

| Axiom | Theorem names | Statement |
|-------|--------------|-----------|
| **S1** | `ACT.AbsoluteValue.s1_*` | additive structure laws on `AbsoluteValue` |
| **S2** | `ACT.AbsoluteValue.s2_*`, `mul_add_distrib` | multiplicative laws on `AbsoluteValue` and distributivity |
| **S3** | `ACT.EternalRatio.s3_*` | additive, multiplicative, inverse, and distributive laws on `EternalRatio` |

## Instances and Verification

The constructive layer exposes algebraic instances directly:

- `Field BalansisFormal.AbsoluteValue`
- `Field BalansisFormal.EternalRatio.EternalRatio`

Recommended verification commands:

```bash
cd formal
lake build
lake build BalansisFormal
lake build ACT
lake env lean ACT/Absolute.lean
lake env lean ACT/Algebra.lean
lake env lean FormalAudit.lean
```
