# AbsoluteValue API

**Audience:** developers  
**Status:** canonical

`AbsoluteValue` is the central runtime object in Balansis.

## Purpose

It represents a value through:

- a non-negative magnitude
- a direction

## Common Entry Points

```python
from balansis import AbsoluteValue, ABSOLUTE

a = AbsoluteValue(magnitude=5.0, direction=1)
b = AbsoluteValue.from_float(-3.5)
z = ABSOLUTE
```

## Common Operations

- `to_float()`
- `from_float()`
- `is_absolute()`
- `is_positive()`
- arithmetic operators such as `+`, `-`, `*`, `/`, unary `-`

## Related Docs

- [Quick Start](../../getting-started/quickstart.md)
- [Glossary](../../glossary.md)
- [Mathematics](../../mathematics/index.md)
