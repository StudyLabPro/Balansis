# Operations API

**Audience:** developers  
**Status:** canonical

`Operations` is the low-level compensated arithmetic surface in Balansis.

## Purpose

Use `Operations` when you want direct access to the runtime arithmetic entry
points and explicit compensation metadata.

## Common Entry Points

- `compensated_add`
- `compensated_multiply`
- `compensated_divide`
- `compensated_divide_extended`
- `compensated_divide_policy`
- `compensated_power`
- `sequence_sum`
- `sequence_product`

## Typical Result Shape

Most low-level operations return a pair of:

- result object
- compensation factor

`compensated_divide` produces an `EternalRatio` together with compensation data.
`compensated_divide_extended` produces an `ExtendedRatio` when the calling code
must preserve `finite`, `infinite`, or `indeterminate` states instead of
raising on `ABSOLUTE` denominators.
`compensated_divide_policy` resolves the extended result through an explicit
policy layer and may also return a machine-readable telemetry event.

## Division Modes

- `compensated_divide`: strict finite contract, raises on `ABSOLUTE` denominator
- `compensated_divide_extended`: opt-in singular arithmetic contract for explicit runtime states
- `compensated_divide_policy`: explicit `raise / propagate / saturate` handling for singular states

## Example

```python
from balansis import AbsoluteValue, Operations

finite_ratio, _ = Operations.compensated_divide(
    AbsoluteValue.from_float(6.0),
    AbsoluteValue.from_float(2.0),
)

extended_ratio, _ = Operations.compensated_divide_extended(
    AbsoluteValue.from_float(6.0),
    AbsoluteValue.absolute(),
)

policy_ratio, _, event = Operations.compensated_divide_policy(
    AbsoluteValue.from_float(6.0),
    AbsoluteValue.absolute(),
    "saturate",
    saturation_limit=100.0,
)
```

## Related Docs

- [AbsoluteValue API](absolute-value.md)
- [EternalRatio API](eternal-ratio.md)
- [ExtendedRatio API](extended-ratio.md)
- [Scientific Computing](../../guides/scientific-computing.md)
