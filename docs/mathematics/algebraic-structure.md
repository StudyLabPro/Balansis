# Algebraic Structure

**Audience:** researchers, contributors, verification-oriented developers  
**Status:** canonical  
**Source of truth:** this page for reader-facing algebraic structure summary

This page explains how the public ACT theorem groups relate to the main
mathematical objects used in Balansis.

## Theorem Families

Balansis organizes the public ACT theorem surface into three groups:

| Group | Object | Topic |
|---|---|---|
| `A1-A5` | `AbsoluteValue` | existence, non-negativity, compensation, identity, direction |
| `E1-E4` | `EternalRatio` | quotient-based ratio construction and multiplicative behavior |
| `S1-S3` | `AbsoluteValue`, `EternalRatio` | algebraic laws and field structure |

## `AbsoluteValue`

At the mathematical level, `AbsoluteValue` supports the additive structure used
to state compensation and identity laws.

Canonical consequences described by the public theorem surface:

- values can be constructed to represent real-number semantics
- magnitude is structurally non-negative
- equal magnitudes with opposite directions compensate to the additive identity
- the additive identity acts neutrally
- positive scaling preserves direction for non-identity values

In the formal layer, these statements are exposed through the `A1-A5` theorems
and extended with structural laws used by `S1` and `S2`.

## `EternalRatio`

`EternalRatio` is the structured ratio object of the theory.

The current formal architecture treats it as a quotient type, which means the
field-oriented statements are about the object itself rather than only about its
image under `toReal`.

Canonical consequences described by the public theorem surface:

- ratio construction is well-defined for nonzero denominators
- denominator safety is encoded into the representation
- multiplicative identity holds structurally
- inverses are stated on the type, with the expected nonzero side condition

## Structural Laws

The public `S1-S3` layer summarizes the algebraic laws proved in Lean:

| Group | Summary |
|---|---|
| `S1` | additive laws on `AbsoluteValue` |
| `S2` | multiplicative laws on nonzero `AbsoluteValue` values |
| `S3` | additive, multiplicative, and distributive laws on `EternalRatio` |

The formal layer also exports a `Field` instance for `EternalRatio`, and the
repository keeps a smoke import audit in `formal/FormalAudit.lean`.

## Runtime vs Formal Structure

Keep these layers distinct:

| Layer | Role |
|---|---|
| mathematics docs | explain the object and law in reader-facing terms |
| formal Lean docs | identify the proved theorem and module location |
| Python runtime docs | explain the operational API and numerical behavior |

Python runtime class names such as `AbsoluteGroup` and `EternityField` are part
of the shipped implementation surface. They are not the canonical names for the
mathematical theorem families.

## Reader Paths

- definitions and notation: [ACT Definitions and Notation](act-definitions.md)
- theorem-to-file mapping: [Proof Map](../formal/proof-map.md)
- verification overview: [Formal Verification](../formal/overview.md)
