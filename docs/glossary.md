# Balansis Glossary

**Audience:** all readers  
**Status:** canonical

## Core Terms

### Balansis

The Python library implementing Absolute Compensation Theory (ACT) as a
numerical computing runtime and experimentation surface.

### Absolute Compensation Theory (ACT)

The mathematical framework behind Balansis. ACT replaces unstable floating-point
edge behavior with explicit structured objects and algebraic laws.

### AbsoluteValue

The core signed-magnitude runtime object in Balansis. It combines a
non-negative magnitude with a direction and supports ACT-aware arithmetic.

### ABSOLUTE

The ACT additive identity used by the runtime model. It is a mathematical and
structural concept in Balansis documentation and should not be described as a
drop-in synonym for every use of IEEE 754 zero.

### EternalRatio

A structured ratio object used instead of unstable division edge behavior. In
the formal layer it is represented through a quotient construction; in the
runtime layer it is the stable ratio abstraction exposed to Python users.

### ExtendedRatio

The wider runtime ratio object for singular arithmetic. It keeps explicit
`finite`, `infinite`, and `indeterminate` states when division edge cases must
be preserved as data instead of rejected immediately.

### Compensation Factor

The explicit auxiliary value returned by low-level compensated operations to
make error handling visible rather than implicit.

### Compensator

The higher-level Balansis engine that exposes compensation-aware operations in a
friendlier interface than the low-level tuple-returning primitives.

### BalansisFormal

The constructive Lean layer containing the internal formal core and technical
lemmas.

### ACT (Lean Layer)

The public Lean theorem layer that re-exports the proved ACT statements from
`BalansisFormal`.

### TNSIM

The zero-sum infinite sets subproject maintained inside this repository. It has
its own runtime and docs surface, but it is not the canonical entrypoint for
the Balansis Python package.

### Canonical Document

The current source of truth for a topic.

### Derived Document

A document adapted from canonical material for a specific audience, format, or
delivery channel.

### Archived Document

A retained historical document that is no longer authoritative.

## Terminology Boundaries

### `ABSOLUTE` vs "additive identity"

Use `ABSOLUTE` when referring to the Python runtime constant. Use "additive
identity" when describing the mathematical role in theory or formal proofs.

### `EternalRatio` vs `Eternity`

Use `EternalRatio` in canonical documentation for the ratio object and its
formal counterpart. Use `Eternity` only when quoting or describing historical
materials, old file names, or legacy runtime naming.

### `EternalRatio` vs `ExtendedRatio`

Use `EternalRatio` for the strict finite ratio object. Use `ExtendedRatio` for
the opt-in runtime surface that represents singular states such as signed
infinity and indeterminate division results.

### `BalansisFormal` vs `ACT`

Use `BalansisFormal` for the constructive Lean implementation layer. Use `ACT`
for the public theorem-facing Lean layer that states the proved theorem
surface.

### Runtime algebra names vs theorem names

Runtime classes such as `AbsoluteGroup` and `EternityField` are Python module
names. They must not replace the canonical mathematical names of the objects
described in reader-facing theory documentation.
