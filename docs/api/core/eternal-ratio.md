# EternalRatio API

**Audience:** developers  
**Status:** canonical

`EternalRatio` is the structured runtime ratio object in Balansis.

## Purpose

It stores:

- a numerator `AbsoluteValue`
- a denominator `AbsoluteValue`

The denominator cannot be `ABSOLUTE`.

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

## Related Docs

- [ACT Definitions and Notation](../../mathematics/act-definitions.md)
- [Operations API](operations.md)
- [Proof Map](../../formal/proof-map.md)
