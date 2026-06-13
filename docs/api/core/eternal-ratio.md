# EternalRatio API

**Audience:** developers  
**Status:** canonical

`EternalRatio` is the strict finite ratio object in Balansis.

## Purpose

It stores:

- a numerator `AbsoluteValue`
- a denominator `AbsoluteValue`

The denominator cannot be `ABSOLUTE`.
If your workflow must represent `infinite` or `indeterminate` division states
as values, use `ExtendedRatio` instead of weakening the `EternalRatio`
contract.

## Common Entry Points

```python
from balansis import AbsoluteValue, EternalRatio

num = AbsoluteValue.from_float(6.0)
den = AbsoluteValue.from_float(2.0)
ratio = EternalRatio(numerator=num, denominator=den)
```

## Common Operations

- `value()`
- `signed_value()`
- `numerical_value()`
- `is_stable()`
- `simplify()`

## Contract Boundary

- `EternalRatio` is for finite structured ratios only
- invalid denominators remain rejected explicitly
- singular runtime semantics now live in `ExtendedRatio`

## Related Docs

- [ExtendedRatio API](extended-ratio.md)
- [ACT Definitions and Notation](../../mathematics/act-definitions.md)
- [Operations API](operations.md)
- [Proof Map](../../formal/proof-map.md)
