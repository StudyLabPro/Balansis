# ACT Definitions and Notation

**Audience:** researchers and technically curious developers  
**Status:** canonical  
**Source of truth:** this page for reader-facing ACT definitions

This page defines the core mathematical objects used in Balansis documentation.
It is the canonical entry point for terminology and notation before moving into
formal proofs or Python APIs.

## Core Objects

### `AbsoluteValue`

`AbsoluteValue` is the signed-magnitude object used throughout ACT.

Reader-facing notation:

```text
a = (m, d)
```

where:

- `m >= 0` is the magnitude
- `d` is the direction

In the Lean formal layer, this idea is represented constructively with a
non-negative magnitude and a direction type, together with a well-formedness
condition for the zero-like case.

### `ABSOLUTE`

`ABSOLUTE` is the additive identity in the runtime model.

Reader-facing intuition:

```text
ABSOLUTE = (0, positive direction)
```

Use `ABSOLUTE` for the runtime constant and "additive identity" for the
mathematical role. Do not describe it as a blanket synonym for every IEEE 754
zero behavior.

### `EternalRatio`

`EternalRatio` is the structured ratio object used when the theory needs a
stable notion of division with an explicitly nonzero denominator.

Reader-facing notation:

```text
r = a / b
```

with the side condition that the denominator is not the additive identity.

In the Lean formal layer, `EternalRatio` is represented as a quotient of ratio
representatives rather than as a raw pair. This is what makes different
representations of the same ratio equal on the type itself.

### Compensation Factor

The compensation factor is the explicit auxiliary signal returned by
compensated runtime operations. It records that a numerically relevant
correction or scaling decision was applied during computation.

## Basic Notation

Use the following notation consistently in canonical docs:

| Symbol | Meaning |
|---|---|
| `a`, `b`, `c` | `AbsoluteValue` objects |
| `r`, `r1`, `r2` | `EternalRatio` objects |
| `ABSOLUTE` | runtime additive identity |
| `0` | additive identity in formal algebraic statements |
| `1` or `unity` | multiplicative identity |
| `toReal` | formal map from ACT objects into real-number semantics |

## Interpretation Rules

- theory pages describe the mathematical object
- formal pages describe the proved Lean encoding
- API pages describe the Python runtime surface
- benchmark pages describe empirical behavior, not theorem status

## Reader Paths

- terminology: [Glossary](../glossary.md)
- algebraic consequences: [Algebraic Structure](algebraic-structure.md)
- proof mapping: [Proof Map](../formal/proof-map.md)
- runtime entry point: [AbsoluteValue API](../api/core/absolute-value.md)
