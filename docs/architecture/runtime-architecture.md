# Runtime Architecture

**Audience:** contributors and technical readers  
**Status:** canonical  
**Source of truth:** this page for the Python runtime package boundaries

This page explains how the shipped Python runtime is organized and how the
major package areas relate to each other.

## Top-Level Runtime Surface

The main Python package is `balansis/`.

High-level entrypoints are re-exported from [__init__.py](../../balansis/__init__.py), including:

- `AbsoluteValue`
- `EternalRatio`
- `Operations`
- `Compensator`
- `AbsoluteGroup`
- `EternityField`
- finance helpers and compatibility shims

## Package Boundaries

| Package area | Role |
|---|---|
| `balansis.core` | core runtime objects and compensated arithmetic |
| `balansis.logic` | higher-level compensation workflow layer |
| `balansis.algebra` | algebra-oriented runtime classes |
| `balansis.finance` | finance-oriented helpers such as `Ledger` |
| `balansis.linalg` | linear algebra routines |
| `balansis.ml` | optimizer-related experimental work |
| `balansis.sets` | set-oriented utilities and generators |
| `balansis.compat` | compatibility layer for older integrations and adjacent code |

## Core Runtime Flow

The current runtime flow is:

1. build or convert values into `AbsoluteValue`
2. apply low-level compensated operations through `Operations`
3. use `Compensator` when a higher-level orchestration layer is more useful
4. move into finance, algebra, or integration layers as needed

## Object Roles

| Object | Role |
|---|---|
| `AbsoluteValue` | signed-magnitude runtime object |
| `EternalRatio` | structured ratio object with non-`ABSOLUTE` denominator |
| `Operations` | low-level compensated arithmetic entrypoints |
| `Compensator` | higher-level compensation engine over the low-level operations |
| `Ledger` | finance-oriented cancellation-aware helper |

## Formal Boundary

The Python runtime and the Lean formalization describe the same theory, but
they serve different purposes:

- `balansis/`: numerical runtime behavior on Python and IEEE 754 hardware
- `formal/`: theorem proving and structural certification

Reader-facing theory claims should be routed through `docs/mathematics/` and
`docs/formal/`, not inferred from runtime class names alone.

## Subproject Boundary

`tnsim/` is not part of the main `balansis` package surface. It is a repository
subproject that can integrate with Balansis runtime objects and operations, but
it has its own lifecycle and documentation track.

## Reader Paths

- repository structure: [Repository Map](repository-map.md)
- API surface: [API Reference](../api/index.md)
- theory surface: [Mathematics](../mathematics/index.md)
- TNSIM boundary: [TNSIM Runtime Status](../tnsim/runtime-status.md)
