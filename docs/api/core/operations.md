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
- `compensated_power`
- `sequence_sum`
- `sequence_product`

## Typical Result Shape

Most low-level operations return a pair of:

- result object
- compensation factor

`compensated_divide` produces an `EternalRatio` together with compensation data.

## Related Docs

- [AbsoluteValue API](absolute-value.md)
- [EternalRatio API](eternal-ratio.md)
- [Scientific Computing](../../guides/scientific-computing.md)
