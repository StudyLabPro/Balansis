# TNSIM Runtime Status

**Audience:** developers, researchers, maintainers  
**Status:** canonical  
**Source of truth:** this page for the current documented state of the `tnsim/` subproject

This page describes what `tnsim/` currently is in the repository and where its
claims should be read cautiously.

## Current Role

`tnsim/` is a repository-managed subproject for zero-sum infinite set
experimentation and related integrations.

It currently includes:

- a `ZeroSumInfiniteSet` runtime class
- cache and parallel helpers
- a FastAPI application surface
- optional database integration
- Balansis-aware integration code

It is not the primary entrypoint for the `balansis` package.

## What Is Clearly Present

Code-backed areas visible in the repository today include:

- `tnsim/core/sets/zero_sum_infinite_set.py`
- `tnsim/api/main.py`
- `tnsim/database/`
- `tnsim/integrations/`
- `tnsim/tests/`

## Capability Notes

The current codebase supports these statements safely:

- TNSIM exposes a FastAPI app with a root endpoint and a health endpoint
- TNSIM includes a zero-sum set runtime model and compensated summation paths
- TNSIM can integrate with Balansis operations when Balansis is available
- parts of the subproject rely on optional dependencies such as database drivers

This page does not treat every claim in `tnsim/README.md` as equally mature or
equally production-ready.

## Integration Boundary

The current `ZeroSumInfiniteSet` implementation can delegate compensated
summation to `balansis.Operations.sequence_sum` when Balansis runtime objects
are available. When they are not, it falls back to NumPy summation.

That means the integration exists, but the subproject should still be read as a
separate runtime surface with its own dependency and maturity profile.

## Operational Caveats

- database-backed behavior depends on environment and optional dependencies
- API health checks depend on repository/database availability
- the README inside `tnsim/` contains broader product-style claims than this
  canonical status page
- readers should prefer this page for current status and use the subproject
  README as a legacy-rich deep reference

## Recommended Reader Path

1. start here for scope and maturity
2. use [tnsim/README.md](../../tnsim/README.md) for broader historical context
3. inspect code or tests for behavior that needs stronger assurance

## Related Docs

- overview: [overview.md](overview.md)
- repository boundary: [Runtime Architecture](../architecture/runtime-architecture.md)
- main repo docs: [Documentation Index](../index.md)
