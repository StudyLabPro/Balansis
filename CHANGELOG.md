# Changelog

All notable changes to the Balansis project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Changed
- Reworked repository licensing into a canonical dual-license layout: root `LICENSE` now contains the standard `AGPL-3.0` text, with `LICENSING.md` and `COMMERCIAL_LICENSE.md` documenting the commercial path
- Added legal support documents: `NOTICE`, `CLA.md`, and contribution guidance aligned with dual licensing
- Synced README, package metadata, `tnsim` metadata, and release workflow with the active licensing model
- Corrected outdated formal documentation so theorem names and architecture match the current Lean code
- Established a visible documentation architecture under `docs/`, moved legacy and research material out of the main canonical path, and redesigned the README as a value-first navigation hub

### Planned
- Balansis v0.7 (next milestone): stable API, complete `linalg/` (GEMM, SVD, QR), PyTorch integration
- ACT benchmark suite vs IEEE 754 and Kahan summation
- LaTeX paper draft for arxiv submission

---

## [0.6.1] — 2026-06-11 — Drift Alignment Edition

### Changed
- Unified package, subpackage, API, and documentation metadata on version `0.6.1`
- Restored compatibility shims for legacy `tnsim` import paths and Balansis integration symbols
- Aligned public documentation with the current coverage gate (`85%`) and active packaging metadata

---

## [0.2.0] — 2026-02-18 — Lean4 Formal Verification Edition

### Added

#### Lean4 Formal Proofs (`formal/`)
Initial repository integration of the Lean4 ACT formalization using Mathlib.
This historical entry marks the first formal-proof milestone and was later
superseded by the stronger `0.6.1` proof architecture, which now builds both
`BalansisFormal` and `ACT` and documents the public theorems A1–A5, E1–E4,
and S1–S3 directly.

- Introduced the `formal/` Lean project and Mathlib toolchain
- Added the first machine-checked ACT proof modules
- Wired formal build instructions into repository documentation

#### CI/CD
- `qa-gates.yml` in StudyNinja-Eco: lean-formal job now builds Balansis formal proofs in matrix strategy alongside MagicBrain

### Infrastructure
- `.gitignore` created for Python + Lean4 build artifacts
- Remote URL migrated to SSH + XTeam-Pro organization
- `development` branch established as default for active work

---

## [0.1.0] — 2025-01-XX — Initial Release

### Added
- Initial implementation of Absolute Compensation Theory (ACT)
- Core mathematical components:
  - `AbsoluteValue` class with magnitude and direction
  - `EternalRatio` class for stable fraction representation
  - `Compensator` engine for numerical stability
- Runtime algebra helpers:
  - `AbsoluteGroup` implementation for structured group-style runtime workflows
  - `EternityField` implementation for structured field-style runtime workflows
- Compensated arithmetic operations: `compensated_add`, `compensated_multiply`, `compensated_divide`, `compensated_power`
- Near-cancellation detection (threshold 1e-15), overflow/underflow protection
- `sequence_sum` (Kahan-compensated), `sequence_product`
- Linear algebra: `gemm.py` (compensated GEMM), `svd.py` (Golub-Kahan + QR), `qr.py` (Householder/Givens/Gram-Schmidt)
- ML optimizer: `EternalOptimizer`, `AdaptiveEternalOptimizer`, `EternalTorchOptimizer` (PyTorch subclass)
- Finance module: `finance/ledger.py` (exact cancellation accounting)
- NumPy integration: `numpy_integration.py` (vectorized ACT ops)
- Memory: `memory/arena.py` (value pooling)
- Initial Lean4 formal layer integration: early `formal/ACT/*` proof modules
- Comprehensive test suite with ≥95% coverage
- Example Jupyter notebooks demonstrating core concepts
- Poetry-based dependency management
- Type safety with MyPy strict mode
- Code quality tools: Black, isort, flake8, bandit, codespell, interrogate
- Theoretical documentation:
  - `docs/research/ACT_WHITEPAPER_v1.md` — retained historical whitepaper and axiomatic research material
  - `docs/archive/legacy/algebraic_proofs.ru.md` — retained historical algebraic proof notes
  - `docs/guides/precision-and-stability.md` — canonical guide entry for precision and stability topics

### Security
- No known security vulnerabilities in initial release

---

## Versioning Policy

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### API Stability Guarantees

| API Layer | Stability |
|-----------|-----------|
| Core types (`AbsoluteValue`, `EternalRatio`) | Stable — MAJOR version only |
| Runtime algebra helpers (`AbsoluteGroup`, `EternityField`) | Stable — MAJOR version only |
| Compensated operations | Stable — MAJOR version only |
| Utility functions, integration patterns | Evolving — MINOR version |
| Lean4 formal layer | Evolving — MINOR version |
| Private methods, test utilities | No guarantees |

### Deprecation Policy

Features marked for removal will:
1. Be deprecated for at least one MINOR version with warnings
2. Have migration paths documented in the changelog
3. Be removed only in MAJOR releases

---

*This changelog helps users and developers track the evolution of Balansis and make informed decisions about upgrades and compatibility.*
