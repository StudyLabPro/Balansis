# NumPy Integration

**Audience:** developers and integrators  
**Status:** canonical

`balansis.numpy_integration` provides NumPy-oriented helpers around
`AbsoluteValue` arrays and compensated array operations.

## Current Entry Points

- `to_numpy`
- `from_numpy`
- `add_arrays`
- `compensated_array_add`
- `compensated_array_multiply`
- `compensated_dot_product`
- `compensated_outer_product`
- `compensated_softmax`

## Scope

This layer is an integration helper surface. It should be read as a practical
bridge to NumPy workflows, not as a claim that Balansis becomes a native NumPy
dtype ecosystem everywhere in the repository.

## Related Docs

- [Integration Patterns](../../guides/integration-patterns.md)
- [Scientific Computing](../../guides/scientific-computing.md)
