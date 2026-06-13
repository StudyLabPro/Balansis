# Proof Map

**Audience:** researchers, contributors, verification-oriented developers  
**Status:** canonical  
**Source of truth:** this page for the public theorem-to-module map

This page maps the public ACT theorem surface to the Lean modules that expose
and audit it.

## Layer Roles

| Layer | Purpose |
|---|---|
| `BalansisFormal` | constructive core and technical lemmas |
| `ACT` | public theorem-facing facade |
| `FormalAudit.lean` | smoke import check for public theorems and instances |

## A1-A5

| Theorem | Public module | Constructive module |
|---|---|---|
| `a1_exists_unique` | `formal/ACT/Absolute.lean` | `formal/BalansisFormal/AbsoluteValue.lean` |
| `a2_nonneg` | `formal/ACT/Absolute.lean` | `formal/BalansisFormal/AbsoluteValue.lean` |
| `a3_compensation` | `formal/ACT/Absolute.lean` | `formal/BalansisFormal/AbsoluteValue.lean` |
| `a4_additive_identity` | `formal/ACT/Absolute.lean` | `formal/BalansisFormal/AbsoluteValue.lean` |
| `a4_additive_identity_left` | `formal/ACT/Absolute.lean` | `formal/BalansisFormal/AbsoluteValue.lean` |
| `a5_direction_preservation` | `formal/ACT/Absolute.lean` | `formal/BalansisFormal/AbsoluteValue.lean` |

## E1-E4

| Theorem | Public module | Constructive module |
|---|---|---|
| `e1_well_defined` | `formal/ACT/EternalRatio.lean` | `formal/BalansisFormal/EternalRatio.lean` |
| `e2_stability` | `formal/ACT/EternalRatio.lean` | `formal/BalansisFormal/EternalRatio.lean` |
| `e3_multiplicative_identity` | `formal/ACT/EternalRatio.lean` | `formal/BalansisFormal/EternalRatio.lean` |
| `e3_multiplicative_identity_left` | `formal/ACT/EternalRatio.lean` | `formal/BalansisFormal/EternalRatio.lean` |
| `e4_inverse` | `formal/ACT/EternalRatio.lean` | `formal/BalansisFormal/EternalRatio.lean` |

## S1-S3

| Theorem family | Public module | Constructive module |
|---|---|---|
| `s1_*` additive laws on `AbsoluteValue` | `formal/ACT/Algebra.lean` | `formal/BalansisFormal/Algebra.lean` |
| `s2_*` multiplicative laws on `AbsoluteValue` | `formal/ACT/Algebra.lean` | `formal/BalansisFormal/Algebra.lean` |
| `s3_*` field laws on `EternalRatio` | `formal/ACT/Algebra.lean` | `formal/BalansisFormal/Algebra.lean` |

## Audit Surface

The public smoke audit currently checks at least these representative items:

- `ACT.a1_exists_unique`
- `ACT.a2_nonneg`
- `ACT.a3_compensation`
- `ACT.a4_additive_identity`
- `ACT.a5_direction_preservation`
- `ACT.EternalRatio.e1_well_defined`
- `ACT.EternalRatio.e4_inverse`
- `ACT.AbsoluteValue.s1_associativity`
- `ACT.AbsoluteValue.s2_mul_inverse`
- `ACT.EternalRatio.s3_distributivity`
- `Field ACT.AbsoluteValue`
- `Field ACT.EternalRatio`

See [FormalAudit.lean](file:///root/StudyNinja-Eco/projects/Balansis/formal/FormalAudit.lean).

## Verification Commands

```bash
cd formal
lake build
lake build BalansisFormal
lake build ACT
lake env lean FormalAudit.lean
```

## Reader Paths

- overview: [Formal Verification Overview](overview.md)
- deep dive: [verification.md](verification.md)
- mathematical context: [Algebraic Structure](../mathematics/algebraic-structure.md)
