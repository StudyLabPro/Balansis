# Changelog

All notable changes to the Balansis project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [1.1.0] — 2026-08-31 — Honest Numerics Edition

This release makes the numerical core genuinely deliver the accuracy the
whitepaper describes, replaces a placeholder dot-product implementation with a
correctly-rounded one, adds a real ACT-compensated SVD backend, and aligns all
research documentation with what the code and the Lean proofs actually verify.
No patents are pursued; all patent material has been removed.

### Added
- `balansis/core/_eft.py` — error-free transforms: `two_sum` (Knuth/Møller),
  `two_product` (Dekker split, FMA-free), `two_product_arr`, and Ogita–Rump–Oishi
  `dot2` (correctly-rounded dot product via a single `math.fsum` over all
  high/low product terms) plus `comp_sum`. This is the honest numerical kernel.
- Genuine ACT-compensated SVD backend `svd(A, method="act_jacobi")`: a one-sided
  Jacobi SVD whose Gram inner products are computed with `dot2`, attaining high
  *relative* accuracy on the singular values of ill-conditioned matrices.
  `numpy_gesdd` (LAPACK) remains the default backend.
- `tests/test_act_accuracy.py` — accuracy regression tests that lock the
  whitepaper's summation (§5.2/5.3), dot-product (§4.6) and SVD (§4.3) claims
  against exact `fractions.Fraction` / NumPy references.

### Changed
- `numpy_integration.compensated_dot_product` now returns the correctly-rounded
  `dot2` result. The previous implementation summed naively-rounded products and
  recovered **zero** correct digits on ill-conditioned dot products; it now
  matches the exact result to full float64 precision regardless of condition
  number (as long as individual products are finite).
- `docs/research/ACT_WHITEPAPER_v1.md` reconciled with measured behaviour:
  Theorem 1 reframed as accumulation stability (pairwise recovery is impossible
  by the Sterbenz lemma); §4.3 documents the two real SVD backends (removing the
  earlier Golub–Kahan claim); §4.6 documents the correctly-rounded Dot2; §5.2/§5.4
  tables carry the measured figures; §3.5/§8.2 state precisely what Lean proves
  (the algebra of the ℝ-isomorphic idealized model, `sorry`-free, `#print axioms`
  clean) versus what is validated empirically (float64 stability).

### Removed
- `docs/research/PATENT_DRAFT_ACT.md` and all patent references from the research
  index and scope documents. Balansis pursues no patent; the work is released
  under the existing dual AGPL-3.0 / commercial license.

### Verified
- Lean4 formal audit: `lake build` completes with **0 errors / 0 `sorry`**
  (8041 jobs) on Mathlib `v4.28.0`; `#print axioms` on A1/A3, S1–S3 and the
  `Field EternalRatio` instance shows only `[propext, Classical.choice, Quot.sound]`
  — no `sorryAx`.
- `tests/test_act_accuracy.py` passes: TwoSum/TwoProduct exact vs `Fraction`;
  `dot2` and `compensated_dot_product` recover a condition-~1e17 dot product to
  <1e-14 relative error where naive `np.dot` exceeds 1e-2; `act_jacobi` SVD
  reconstruction/orthogonality <1e-12 and small-singular-value relative accuracy
  within 10%.

---

## [1.0.0] — 2026-07-06 — Stable Release

### Added
- Promoted Balansis to a stable `1.0.0` package release with production/stable PyPI classifiers
- Added the `balansis` console entrypoint for `pipx` and CLI smoke checks
- Added `balansis doctor` and `balansis add` commands for installation verification and basic ACT operations
- Added `ExtendedRatio` singular arithmetic runtime policy support and high-level telemetry propagation
- Added runtime-to-Lean parity tests for `ExtendedRatio` semantic laws

### Changed
- Hardened PyPI/TestPyPI release workflow and installation smoke checks across Python 3.10, 3.11, and 3.12
- Updated installation documentation for `pip`, `pipx`, wheel, and source installs
- Updated package metadata to describe the stable formal/runtime surface
- Reworked repository licensing into a canonical dual-license layout with root `LICENSE`, `LICENSING.md`, and `COMMERCIAL_LICENSE.md`
- Established a visible documentation architecture under `docs/`, moved legacy and research material out of the main canonical path, and redesigned the README as a value-first navigation hub

### Verified
- `pip install` from local wheel
- `pipx install` from local wheel
- CLI `balansis --version`, `balansis doctor`, and `balansis add`
- `twine check` for built distributions
- Lean formal audit through `lake build` and `FormalAudit.lean`

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
superseded by the stronger stable proof architecture, which now builds both
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
