# Claim Registry

**Audience:** maintainers, contributors, reviewers  
**Status:** canonical  
**Source of truth:** this page for high-value public claim tracking

This registry tracks the strongest public claims made by Balansis documentation.
Each claim must resolve to one of these states:

- `proved`: backed by a compiled Lean theorem
- `implemented`: backed by runtime code and executable checks
- `measured`: backed by benchmarks and methodology
- `research`: intentionally outside the current product contract

## Usage Rule

Before adding a strong statement to `README.md`, `docs/`, root governance files,
or major notebooks, add or update its registry entry.

Each entry should answer:

- what is being claimed
- where the claim appears publicly
- what kind of claim it is
- what artifact makes it true
- what still blocks acceptance

## Public Contract Claims

| ID | Claim | Type | Current status | Public source | Target artifact | Acceptance rule |
|---|---|---|---|---|---|---|
| `CLM-001` | `AbsoluteValue` is the core ACT-aware runtime value with explicit magnitude and direction | runtime | `implemented` | `README.md`, `docs/concepts/`, `docs/api/core/absolute-value.md` | `balansis/core/absolute.py`, examples, runtime smoke | object imports, constructs, and behaves as documented |
| `CLM-002` | `ABSOLUTE` is the ACT additive identity in the runtime model | runtime | `implemented` | `README.md`, `docs/glossary.md`, examples | exported runtime constant and object behavior | examples and tests show identity semantics without terminology drift |
| `CLM-003` | `EternalRatio` is the canonical structured ratio object | runtime + formal | `implemented` / `proved` | `README.md`, `docs/mathematics/`, `docs/formal/`, `docs/api/core/eternal-ratio.md` | runtime constructor, Lean quotient model, proof map | runtime and formal docs use the same canonical name and link to real artifacts |
| `CLM-004` | denominator safety is enforced structurally for `EternalRatio` | runtime + formal | `implemented` / `proved` | `README.md`, `docs/formal/proof-map.md`, notebooks | constructor guard, `E1-E4` theorem layer, tests | invalid denominator path is guarded in runtime and described honestly in docs |
| `CLM-005` | low-level compensated operations expose explicit compensation factors | runtime | `implemented` | `README.md`, `docs/api/core/operations.md`, examples | `balansis/core/operations.py`, notebooks, smoke execution | docs show tuple-returning behavior that matches imports and runtime output |
| `CLM-006` | `Compensator` provides higher-level stability-oriented workflows over low-level primitives | runtime | `implemented` | `README.md`, `docs/guides/`, `docs/api/integrations/compatibility.md`, examples | `balansis/logic/compensator.py`, examples, tests | high-level API examples execute and do not call removed methods |
| `CLM-007` | A1-A5 are proved theorems in the public ACT Lean layer | proof | `proved` | `docs/formal/overview.md`, `docs/formal/proof-map.md`, `formal/README.md` | `formal/ACT/Absolute.lean`, `FormalAudit.lean` | every named theorem compiles and is auditable |
| `CLM-008` | E1-E4 are proved theorems on `EternalRatio` | proof | `proved` | `docs/formal/overview.md`, `docs/formal/proof-map.md`, `formal/README.md` | `formal/ACT/EternalRatio.lean`, `FormalAudit.lean` | theorem names and descriptions match the compiled Lean layer |
| `CLM-009` | S1-S3 summarize the structural algebra laws for `AbsoluteValue` and `EternalRatio` | proof | `proved` | `docs/formal/proof-map.md`, `docs/mathematics/algebraic-structure.md` | `formal/ACT/Algebra.lean`, `FormalAudit.lean` | public docs never describe stronger algebra than the audited theorem family |
| `CLM-010` | the formal layer exports audited field structure for the target types it documents | proof | `proved` | `docs/formal/proof-map.md`, `formal/README.md` | field instances in `formal/BalansisFormal/*`, audit checks | documented instances appear in Lean and in the smoke audit |
| `CLM-011` | Balansis preserves meaningful residuals in cancellation-sensitive aggregation scenarios better than plain float examples | runtime + measured | `implemented` / `measured` | `README.md`, `docs/guides/precision-and-stability.md`, examples | notebooks, targeted tests, benchmark scenarios | every showcased scenario has a runnable example or measured scenario artifact |
| `CLM-012` | examples notebooks are runnable against the current public API | runtime | `implemented` | `examples/README.md`, notebook files, `docs/examples/` | notebook execution in CI | all canonical notebooks execute without stale imports or removed methods |
| `CLM-013` | API reference is code-backed and documents shipped symbols only | runtime governance | `implemented` | `docs/api/index.md` and child pages | `scripts/validate_api_docs.py`, docs pages, import checks | no canonical API page describes a removed symbol |
| `CLM-014` | documentation in `docs/` is the canonical public source of truth | governance | `implemented` | `docs/index.md`, `docs/standards.md` | canonical docs tree, shadow-doc notices, CI wording checks | `.trae` cannot present itself as current public docs |
| `CLM-015` | English is the canonical public documentation language | governance | `implemented` | `docs/index.md`, `docs/standards.md` | docs tree audit, archive policy | canonical docs avoid mixed-language drift; archive is explicitly exempted |
| `CLM-016` | benchmark claims are backed by published methodology and interpretation rules | measured governance | `implemented` / `partial` | `docs/benchmarks/` | methodology, interpretation docs, result artifacts | any numeric performance claim links to measured evidence |
| `CLM-017` | finance, scientific-computing, and integration value claims are grounded in runnable guides and examples | runtime + measured | `implemented` / `partial` | `README.md`, `docs/guides/`, `docs/examples/` | vertical guides, examples, smoke artifacts | each major value claim links to at least one runnable asset |
| `CLM-018` | singular division states are representable through `ExtendedRatio`, policy-resolved at runtime, propagated into selected pipelines, and their semantic core is formalized in Lean | runtime + measured + proved | `implemented` / `measured` / `partial proved` | `docs/api/core/extended-ratio.md`, `docs/api/linalg/svd.md`, `docs/formal/extended-ratio-runtime-parity.md`, `docs/benchmarks/claim-closure-results.md`, formal docs | runtime type and API, policy events, optimizer and SVD telemetry, tests, parity map, baseline artifact, `formal/ACT/ExtendedRatio.lean` | finite, infinite, and indeterminate states are constructible in runtime artifacts, policy handling is benchmarked and test-backed, selected high-level pipelines expose telemetry, and division classification plus semantic operation/policy laws compile in Lean with runtime parity tests |

## Legacy And Research Claims

These claim families appear in shadow or historical materials but are not yet
part of the canonical product truth.

| ID | Claim family | Current status | Where it appears | Required action before canonization |
|---|---|---|---|---|
| `RSH-001` | metric-space claims on ACT objects | `research` | `.trae/documents/theory/absolute-eternity-axioms.md` | formal statement, proof plan, and research doc |
| `RSH-002` | category-theoretic claims about ACT algebras | `research` | `.trae/documents/theory/algebraic-structures.md` | move to research scope and remove fact wording |
| `RSH-003` | algebraic extension claims over `ℚ` | `research` | `.trae/documents/theory/algebraic-structures.md` | formalize or keep as research-only |
| `RSH-004` | broad bounded-relative-error theorems for ACT operations | `research` | `.trae/documents/theory/algebraic-structures.md` | benchmark evidence or formal theorem, not prose alone |
| `RSH-005` | multidimensional ACT structures as shipped surface | `research` | `.trae/documents/theory/algebraic-structures.md` | exported symbols, API docs, tests, and guides |
| `RSH-006` | BalansisLLM-style speculative product claims | `research` | `.trae/documents/*` | isolate in research notes or archive |

## Immediate Remediation Queue

| Priority | Task | Linked claims |
|---|---|---|
| `P1` | remove `.trae` as an apparent public source of truth | `CLM-014`, `CLM-015` |
| `P1` | add docs drift enforcement to CI | `CLM-013`, `CLM-014`, `CLM-015` |
| `P1` | keep proof map and formal docs aligned with exported theorems and instances | `CLM-007`, `CLM-008`, `CLM-009`, `CLM-010` |
| `P2` | attach explicit tests or measured scenarios to all README stability examples | `CLM-011`, `CLM-017` |
| `P2` | publish benchmark result artifacts for any remaining numeric performance wording | `CLM-016` |
| `P2` | keep `ExtendedRatio` docs, tests, and benchmark artifact aligned as M3 evolves | `CLM-018` |
| `P3` | formalize or isolate long-horizon research mathematics | `RSH-001` to `RSH-006` |

## Completion Rule

A claim is fully closed only when:

- the public wording matches the real artifact exactly
- the artifact is linked from canonical docs
- CI protects against obvious regression of that wording or artifact surface
