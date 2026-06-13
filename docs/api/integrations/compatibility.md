# Compatibility Integrations

**Audience:** developers and integrators  
**Status:** canonical

Balansis ships a compatibility layer in `balansis.compat` for adjacent or
legacy integration surfaces.

## Current Exports

- `CompensatedSum`
- `StableSoftmax`
- `CompensatedMatMul`

These helpers exist to smooth usage from older code or neighboring projects.
They are integration-oriented adapters, not the primary mathematical API.

## Related Docs

- [Integration Patterns](../../guides/integration-patterns.md)
- [Runtime Architecture](../../architecture/runtime-architecture.md)
