[![Version](https://img.shields.io/badge/version-0.6.1-blue.svg)](https://github.com/XTeam-Pro/Balansis)
[![Python](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://python.org)
[![Coverage](https://img.shields.io/badge/coverage-85%25%2B-brightgreen.svg)](https://github.com/XTeam-Pro/Balansis)
[![Lean4](https://img.shields.io/badge/Lean4-A1--A5%2C%20E1--E4%2C%20S1--S3%20proved-blueviolet.svg)](./formal/)
[![License](https://img.shields.io/badge/license-AGPL--3.0%20%2F%20Commercial-blue.svg)](./LICENSING.md)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

# Balansis

**Python mathematical library implementing Absolute Compensation Theory (ACT) — a numerically stable arithmetic framework that replaces IEEE 754 zero and infinity with structurally sound alternatives.**

[Theory Whitepaper](docs/theory/act_whitepaper.md) | [Changelog](CHANGELOG.md) | [Formal Proofs](formal/) | [tnsim API](tnsim/)

---

## What is ACT?

Absolute Compensation Theory is a mathematical framework that eliminates the root causes of numerical instability in floating-point computation:

- **Replaces zero** with `ABSOLUTE` — an additive identity `AbsoluteValue(magnitude=0.0, direction=1)` that prevents division-by-zero at the type level rather than at runtime.
- **Replaces infinity** with `EternalRatio` — a structurally bounded representation of a ratio whose denominator is guaranteed non-Absolute, making unbounded results impossible to construct.
- **Compensated arithmetic** — every operation in `Operations` returns a `(result, compensation_factor)` tuple so accumulated error is tracked explicitly rather than silently absorbed.
- **Formally verified** — all 12 algebraic axioms are proven in Lean4 (Mathlib v4.28.0) with zero `sorry`, zero errors, and zero admitted axioms.

---

## Installation

```bash
# Core library (Pydantic + NumPy)
pip install balansis

# With specific extras
pip install balansis[plot]      # + matplotlib, plotly
pip install balansis[notebook]  # + jupyter, ipykernel
pip install balansis[torch]     # + torch (EternalTorchOptimizer)
pip install balansis[all]       # everything
```

| Extra | Additional dependencies |
|-------|------------------------|
| `plot` | matplotlib, plotly |
| `notebook` | jupyter, ipykernel |
| `torch` | torch |
| `all` | all of the above |

Core dependencies: `pydantic >= 2.5`, `numpy >= 1.24`. Python 3.10, 3.11, and 3.12 are supported.

---

## Quick Start

### Core types and compensated operations

```python
from balansis import AbsoluteValue, EternalRatio, Operations, Compensator
from balansis import ABSOLUTE, UNIT_POSITIVE, UNIT_NEGATIVE
from balansis import B  # convenience constructor: B(5.0) == AbsoluteValue.from_float(5.0)

# AbsoluteValue: immutable (Pydantic frozen=True), magnitude >= 0, direction in {-1, 1}
a = AbsoluteValue(magnitude=5.0, direction=1)    # +5
b = AbsoluteValue(magnitude=3.0, direction=-1)   # -3

# ABSOLUTE is the additive identity — the ACT replacement for zero
zero = AbsoluteValue(magnitude=0.0, direction=1)  # same as ABSOLUTE

# Inspect values
print(a.to_float())      # 5.0
print(a.is_absolute())   # False
print(a.is_positive())   # True

# Round-trip from Python float
c = AbsoluteValue.from_float(-3.5)  # AbsoluteValue(magnitude=3.5, direction=-1)

# Standard arithmetic operators are overloaded
print(a + b)    # AbsoluteValue(magnitude=2.0, direction=1)   — perfect cancellation
print(a - b)    # AbsoluteValue(magnitude=8.0, direction=1)
print(a * 2.0)  # AbsoluteValue(magnitude=10.0, direction=1)
print(a / 2.0)  # AbsoluteValue(magnitude=2.5, direction=1)
print(-a)       # AbsoluteValue(magnitude=5.0, direction=-1)
print(abs(a))   # AbsoluteValue(magnitude=5.0, direction=1)

# Low-level compensated operations return (result, compensation_factor) tuples
result, comp = Operations.compensated_add(a, b)
result, comp = Operations.compensated_multiply(a, b)
result, comp = Operations.compensated_power(a, 2.0)
result, comp = Operations.compensated_sqrt(a)
result, comp = Operations.compensated_log(a)
result, comp = Operations.compensated_exp(a)

# Kahan-compensated aggregation
total, comp = Operations.sequence_sum([a, b, a])
product, comp = Operations.sequence_product([a, b])

# EternalRatio: structurally safe ratio — denominator cannot be ABSOLUTE
ratio = EternalRatio(numerator=a, denominator=b)
print(ratio.numerical_value())  # -5.0/3.0 (signed float)
print(ratio.is_stable())        # True
simplified = ratio.simplify()

# Division always returns EternalRatio, never raises ZeroDivisionError
ratio = Operations.compensated_divide(a, b)

# High-level Compensator returns AbsoluteValue directly (no tuples)
comp = Compensator()
result = comp.compensate_addition(a, b)        # AbsoluteValue
result = comp.compensate_multiplication(a, b)  # AbsoluteValue
ratio  = comp.compensate_division(a, b)        # EternalRatio
result = comp.compensate_power(a, 2.0)         # AbsoluteValue
```

### Algebraic structures

```python
from balansis.algebra.absolute_group import AbsoluteGroup, GroupElement

# Infinite additive group — identity is ABSOLUTE
add_group = AbsoluteGroup.additive_group()

# Infinite multiplicative group — identity is UNIT_POSITIVE
mul_group = AbsoluteGroup.multiplicative_group()

# Finite cyclic group of given order
cyc_group = AbsoluteGroup.finite_cyclic_group(order=6)

elem_a = GroupElement(value=AbsoluteValue(magnitude=2.0, direction=1))
elem_b = GroupElement(value=AbsoluteValue(magnitude=3.0, direction=1))

result   = add_group.operate(elem_a, elem_b)
identity = add_group.identity_element()
inverse  = add_group.inverse_element(elem_a)
print(add_group.is_abelian())  # True
print(cyc_group.order())       # 6
```

### Linear algebra with ACT compensation

```python
from balansis.linalg.gemm import matmul
from balansis.linalg.qr import qr_decompose
from balansis.linalg.svd import svd

# Matrices are List[List[AbsoluteValue]]
A = [[AbsoluteValue(1.0, 1), AbsoluteValue(2.0, 1)],
     [AbsoluteValue(3.0, 1), AbsoluteValue(4.0, 1)]]

B = [[AbsoluteValue(5.0, 1), AbsoluteValue(6.0, 1)],
     [AbsoluteValue(7.0, 1), AbsoluteValue(8.0, 1)]]

C        = matmul(A, B)     # List[List[AbsoluteValue]]
Q, R     = qr_decompose(A)  # Gram-Schmidt QR decomposition
U, S, Vt = svd(A)           # SVD (requires numpy)
```

### Finance ledger with exact cancellation

```python
from balansis.finance.ledger import Ledger
from decimal import Decimal

ledger = Ledger()
ledger.post_entry("assets",   Decimal("1000.00"), "initial deposit")
ledger.post_entry("assets",   Decimal("500.00"),  "additional funding")
ledger.transfer("assets", "expenses", Decimal("250.00"), "vendor payment")

total = ledger.balance()                   # AbsoluteValue — global balance
assets = ledger.account_balance("assets")  # AbsoluteValue — per-account balance
```

---

## Module Overview

| Module | Import path | Description |
|--------|-------------|-------------|
| Core types | `balansis` | `AbsoluteValue`, `EternalRatio`, `ABSOLUTE`, `UNIT_POSITIVE`, `UNIT_NEGATIVE`, `B` |
| Operations | `balansis` | `Operations` — compensated arithmetic returning `(result, comp)` tuples |
| Compensator | `balansis` | `Compensator` — high-level engine returning `AbsoluteValue` directly |
| Algebra | `balansis.algebra.absolute_group` | `AbsoluteGroup`, `GroupElement` — group theory (axioms A1-A5) |
| Algebra | `balansis.algebra.eternity_field` | `EternityField`, `FieldElement` — field theory (axioms E1-E4, S1-S3) |
| Linear algebra | `balansis.linalg.gemm` | `matmul` — ACT-compensated matrix multiplication |
| Linear algebra | `balansis.linalg.qr` | `qr_decompose` — Gram-Schmidt QR decomposition |
| Linear algebra | `balansis.linalg.svd` | `svd` — Golub-Kahan SVD with NumPy fallback |
| ML optimizer | `balansis.ml.optimizer` | `EternalOptimizer`, `EternalTorchOptimizer` (PyTorch subclass) |
| Sets | `balansis.sets.eternal_set` | `EternalSet` — zero-sum infinite sets |
| Sets | `balansis.sets.generators` | `harmonic_generator`, `grandis_generator` |
| Sets | `balansis.sets.resolver` | `global_compensate`, `verify_zero_sum`, `stream_compensate` |
| Finance | `balansis.finance.ledger` | `Ledger` — double-entry bookkeeping with ACT compensation |
| NumPy | `balansis.numpy_integration` | `to_numpy`, `from_numpy`, `add_arrays` — vectorized bridge |
| Vectorized | `balansis.vectorized` | `batch_add`, `batch_mul_scalar`, `batch_to_float` |
| Arrow | `balansis.arrow_integration` | `to_table`, `from_table` — Apache Arrow integration (requires pyarrow) |
| Pandas | `balansis.pandas_ext` | `AbsoluteValueDtype`, `AbsoluteArray` — pandas extension type (requires pandas) |
| Memory | `balansis.memory.arena` | `AbsoluteArena` — value pool / allocation cache |

---

## Formal Verification

Version 0.6.1 ships a compiled Lean4 formalization of ACT on Mathlib v4.28.0.

- `BalansisFormal` is the constructive core: `Direction`, `AbsoluteValue`, quotient-based `EternalRatio`, and structural algebra lemmas.
- `ACT` is the public theorem layer: it re-exports the proved ACT statements as Lean theorems with the same public names.
- `formal/` contains **0 `axiom`, 0 `sorry`, 0 `admit`**.
- `lake build`, `lake build BalansisFormal`, and `lake build ACT` all succeed.
- `EternalRatio` has a Lean `Field` instance. In Lean/Mathlib, `Field` is already commutative.

### Proof Status

| Group | Public Lean module | Theorems | Status |
|-------|--------------------|----------|--------|
| A1–A5 | `ACT/Absolute.lean` | `a1_exists_unique`, `a2_nonneg`, `a3_compensation`, `a4_additive_identity`, `a4_additive_identity_left`, `a5_direction_preservation` | proved |
| E1–E4 | `ACT/EternalRatio.lean` | `e1_well_defined`, `e2_stability`, `e3_multiplicative_identity`, `e3_multiplicative_identity_left`, `e4_inverse` | proved |
| S1 | `ACT/Algebra.lean` | `ACT.AbsoluteValue.s1_closure`, `s1_associativity`, `s1_commutativity`, `s1_identity_right`, `s1_identity_left`, `s1_inverse` | proved |
| S2 | `ACT/Algebra.lean` | `ACT.AbsoluteValue.s2_closure`, `s2_mul_associativity`, `s2_mul_commutativity`, `s2_mul_identity_right`, `s2_mul_identity_left`, `s2_mul_inverse`, `mul_add_distrib` | proved |
| S3 | `ACT/Algebra.lean` | `ACT.EternalRatio.s3_add_assoc`, `s3_add_comm`, `s3_add_identity`, `s3_add_inverse`, `s3_mul_assoc`, `s3_mul_comm`, `s3_mul_identity`, `s3_mul_inverse`, `s3_distributivity` | proved |

### Architecture

- `formal/BalansisFormal/Direction.lean`: sign theory and bridge lemmas to `ℝ`.
- `formal/BalansisFormal/AbsoluteValue.lean`: constructive signed-magnitude model, A1–A5 core proofs, and `Field AbsoluteValue`.
- `formal/BalansisFormal/EternalRatio.lean`: quotient of ratio representatives by cross-multiplication equivalence, E1–E4, and `Field EternalRatio`.
- `formal/BalansisFormal/Algebra.lean`: structural S1–S3 laws on the actual Lean types.
- `formal/ACT.lean` and `formal/ACT/*.lean`: public theorem facade over the compiled core.
- `formal/FormalAudit.lean`: smoke module importing the public surface and checking key theorem and instance availability.

To verify locally:

```bash
cd formal
lake build
lake build BalansisFormal
lake build ACT
lake env lean ACT/Absolute.lean
lake env lean ACT/Algebra.lean
lake env lean FormalAudit.lean
```

---

## Testing

```bash
# Run full test suite with coverage enforcement (>= 85% required)
poetry run pytest

# Run specific modules
poetry run pytest tests/test_absolute.py -v
poetry run pytest tests/test_operations.py -v
poetry run pytest tests/test_algebra.py -v
poetry run pytest tests/test_numpy_integration.py -v
poetry run pytest tests/test_finance.py -v
```

Code quality gates:

```bash
poetry run mypy balansis/        # strict type checking
poetry run black balansis/ tests/
poetry run isort balansis/ tests/
poetry run flake8 balansis/
poetry run pre-commit run --all-files
```

The CI configuration enforces `--cov-fail-under=85` — the build fails if coverage drops below 85%.

---

## Contributing

Contributions are welcome, but Balansis is maintained under a dual-license
model. Before opening a substantial pull request, read:

- [CONTRIBUTING.md](CONTRIBUTING.md)
- [CLA.md](CLA.md)
- [LICENSING.md](LICENSING.md)
- [NOTICE](NOTICE)
- [SECURITY.md](SECURITY.md)

This is especially important for externally sourced code, employer-owned work,
and contributions that may later ship in both the open-source and commercial
tracks.

---

## tnsim: Zero-Sum Infinite Sets Simulator

`tnsim/` is a standalone FastAPI service for experimenting with zero-sum infinite sets. It is **not included in the pip package** and must be run from the repository.

```bash
uvicorn tnsim.api.main:app --port 8010
```

| Component | Description |
|-----------|-------------|
| `ZeroSumInfiniteSet` | Mathematical implementation of zero-sum infinite sets |
| `parallel_tnsim` | Parallel set operations |
| `tnsim_cache` | Redis-backed result cache |
| REST API | FastAPI endpoints for set management |
| PostgreSQL | Persistent set state storage |

---

## License

Balansis is **dual-licensed**:

- **AGPL-3.0**: the canonical open-source license text is in [LICENSE](LICENSE).
- **Commercial License**: proprietary commercial terms are in [COMMERCIAL_LICENSE.md](COMMERCIAL_LICENSE.md).
- **Overview and routing guide**: see [LICENSING.md](LICENSING.md) to decide which path applies to your use case.

Practical rule:

- choose **AGPL-3.0** if you are prepared to comply with AGPL obligations;
- choose the **commercial license** if you need proprietary, internal
  enterprise, SaaS, OEM, or other closed-source commercial rights.

GitHub license detection is driven by the canonical open-source text in the
root `LICENSE` file. The repository therefore keeps the standard AGPL text in
`LICENSE` and documents the commercial option separately in `LICENSING.md` and
`COMMERCIAL_LICENSE.md`.

Commercial deals can be structured using the repository baseline documents:

- [COMMERCIAL_LICENSE.md](COMMERCIAL_LICENSE.md)
- [ORDER_FORM_TEMPLATE.md](ORDER_FORM_TEMPLATE.md)
- [SECURITY.md](SECURITY.md) for responsible vulnerability disclosure

Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.

---

Balansis is MAGIC Level 1 (MetaBalansis) in the [StudyNinja-Eco](https://github.com/XTeam-Pro/StudyNinja-Eco) ecosystem — the mathematical foundation on which higher AGI layers are built.
