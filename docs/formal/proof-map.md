# Proof Map

**Audience:** researchers, contributors, verification-oriented developers  
**Status:** canonical  
**Source of truth:** this page for the public theorem-to-module map

This page maps the public ACT theorem surface to the Lean modules that expose
and audit it.

## Runtime/Formal Boundary

The current proved ratio object is the finite `EternalRatio` model. The newer
runtime `ExtendedRatio` surface now has a proved Lean semantic core for
division-state transitions, indeterminate propagation, infinity interactions,
saturation, and policy application. It intentionally does not claim field-like
algebraic structure or parity with the finite `EternalRatio` theory.

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

## ExtendedRatio Semantic Proofs

| Theorem family | Public module | Constructive module |
|---|---|---|
| finite classification for non-zero denominator | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |
| indeterminate classification for `0 / 0` | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |
| infinite classification for non-zero over zero | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |
| indeterminate propagation for `add` and `mul` | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |
| opposite infinity addition and same-infinity addition | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |
| zero-times-infinity multiplication | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |
| saturation and policy application laws | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |
| non-field-like singular behavior witness | `formal/ACT/ExtendedRatio.lean` | `formal/BalansisFormal/ExtendedRatio.lean` |

## Audit Surface

The public smoke audit currently checks at least these representative items:

- `ACT.a1_exists_unique`
- `ACT.a2_nonneg`
- `ACT.a3_compensation`
- `ACT.a4_additive_identity`
- `ACT.a5_direction_preservation`
- `ACT.EternalRatio.e1_well_defined`
- `ACT.EternalRatio.e4_inverse`
- `ACT.ExtendedRatio.fromDivision_of_den_nonzero`
- `ACT.ExtendedRatio.indeterminate_iff_zero_zero`
- `ACT.ExtendedRatio.add_indeterminate_left`
- `ACT.ExtendedRatio.mul_indeterminate_right`
- `ACT.ExtendedRatio.add_opposite_infinities_indeterminate`
- `ACT.ExtendedRatio.saturate_infinite`
- `ACT.ExtendedRatio.applyPolicy_saturate`
- `ACT.ExtendedRatio.extendedRatio_not_field_carrier`
- `ACT.AbsoluteValue.s1_associativity`
- `ACT.AbsoluteValue.s2_mul_inverse`
- `ACT.EternalRatio.s3_distributivity`
- `Field ACT.AbsoluteValue`
- `Field ACT.EternalRatio`

See [FormalAudit.lean](../../formal/FormalAudit.lean).

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
- ExtendedRatio runtime theorem parity: [ExtendedRatio Runtime Parity](extended-ratio-runtime-parity.md)
- next formalization target: [ExtendedRatio Formalization Outline](extended-ratio-outline.md)
