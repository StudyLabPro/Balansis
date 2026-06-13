# Formal Verification Overview

**Audience:** researchers, contributors, verification-oriented developers  
**Status:** canonical

Balansis ships a compiled Lean4 formalization of its public ACT theorem surface.

## Architecture

- `BalansisFormal`: constructive internal layer
- `ACT`: public theorem facade
- `FormalAudit.lean`: smoke import audit

## Current Proof Status

- public theorem groups A1-A5, E1-E4, and S1-S3 are compiled as Lean theorems
- `formal/` contains no `axiom`, `sorry`, or `admit`
- `lake build`, `lake build BalansisFormal`, and `lake build ACT` succeed

## Reader Paths

- local build instructions: [formal/README.md](../../formal/README.md)
- theorem-to-module map: [proof-map.md](proof-map.md)
- detailed verification reference: [verification.md](verification.md)
- high-level theory context: [Mathematics](../mathematics/index.md)
- repository overview: [README.md](../../README.md)
