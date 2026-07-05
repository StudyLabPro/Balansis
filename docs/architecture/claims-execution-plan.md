# Claims Execution Plan

**Audience:** maintainers, contributors, verification-oriented developers  
**Status:** canonical  
**Source of truth:** this page for claim-remediation sequencing and acceptance

This plan turns documentation statements into one of four real outcomes:

- `proved`: backed by a compiled Lean theorem
- `implemented`: backed by shipped runtime code and tests
- `measured`: backed by benchmark artifacts and methodology
- `research`: explicitly outside the current product contract

No public documentation claim should remain outside these four states.

## Execution Rule

For every meaningful claim, complete these steps in order:

1. register the claim
2. classify the claim
3. attach the target artifact
4. implement, prove, or measure it
5. update canonical docs
6. enforce the result in CI

## Phase 1: Freeze The Contract

**Goal:** stop shadow and legacy material from acting as a hidden source of truth.

**Files:**

- `docs/architecture/claim-registry.md`
- `docs/architecture/shadow-doc-triage.md`
- `.trae/documents/README.md`

**Actions:**

- register all current public claims from `README.md`, root governance files, and `docs/`
- classify `.trae/documents/*` as internal draft, archive, research, or migration source
- add explicit notices to the highest-risk `.trae` theory files

**Acceptance:**

- every canonical strong claim has a registry entry
- `.trae` no longer presents itself as current public documentation

## Phase 2: Normalize Terminology

**Goal:** make one concept correspond to one canonical name.

**Primary boundaries:**

- `AbsoluteValue` vs additive identity wording
- `ABSOLUTE` as runtime constant
- `EternalRatio` as canonical object name
- `Eternity` and `EternityField` as legacy runtime naming only
- `BalansisFormal` vs `ACT`
- theorem surface vs runtime helper classes

**Files:**

- `docs/glossary.md`
- `docs/standards.md`
- `README.md`
- `formal/README.md`
- `tnsim/README.md`
- selected API docs and examples

**Acceptance:**

- no canonical doc uses runtime helper names as theorem-layer object names
- no canonical doc treats legacy `Eternity*` naming as the preferred mathematical vocabulary

## Phase 3: Formal Claim Closure

**Goal:** every proof claim in public docs maps to compiled Lean code.

**Files and modules:**

- `docs/formal/proof-map.md`
- `formal/ACT/*.lean`
- `formal/BalansisFormal/*.lean`
- `formal/FormalAudit.lean`
- CI workflow checks

**Required public formal surface:**

- `A1-A5`
- `E1-E4`
- `S1-S3`
- audited field and structural instances actually exported by the formal layer

**Acceptance:**

- each formal claim in docs points to a named theorem or audited instance
- CI fails on `axiom`, `sorry`, or `admit`

## Phase 4: Runtime Claim Closure

**Goal:** every runtime claim maps to shipped code and executable checks.

**Files and areas:**

- `balansis/core/*`
- `balansis/logic/*`
- `balansis/algebra/*`
- `balansis/numpy_integration.py`
- `examples/*.ipynb`
- runtime tests and smoke scripts

**Claim types:**

- object construction
- denominator guards
- explicit compensation factors
- stability-oriented workflows
- runtime helper classes

**Acceptance:**

- each runtime claim in docs has a matching symbol, example, and test or smoke artifact
- examples do not rely on removed or imaginary APIs

## Phase 5: Stability, Overflow, And Limit Claims

**Goal:** replace broad prose promises with bounded, testable contracts.

**Files:**

- `docs/guides/precision-and-stability.md`
- `docs/guides/integration-patterns.md`
- future `docs/guides/numerical-limits.md`
- tests and benchmarks for sensitive scenarios

**Mandatory scenario families:**

- catastrophic cancellation
- residual-preserving aggregation
- denominator safety
- near-cancellation correction
- large-magnitude operations

**Acceptance:**

- public docs state exactly which edge cases are preserved, guarded, or rejected
- no overflow or stability statement sounds stronger than the real runtime behavior

## Phase 6: Performance And Complexity Claims

**Goal:** move all performance claims from prose into measured artifacts.

**Files:**

- `docs/benchmarks/methodology.md`
- `docs/benchmarks/result-interpretation.md`
- benchmark scripts and result sets

**Claim types:**

- time complexity wording
- overhead percentages
- throughput comparisons
- scenario-dependent performance tradeoffs

**Acceptance:**

- every public numerical performance claim links to a benchmark artifact
- unsupported percentages and asymptotic claims are removed from canonical docs

## Phase 7: Vertical Application Claims

**Goal:** make domain claims true through runnable assets.

**Verticals:**

- finance
- scientific computing
- machine learning

**Required artifacts per vertical:**

- one canonical guide
- one runnable example
- one test or smoke artifact
- one benchmark or scenario note when performance is claimed

**Acceptance:**

- README-level domain claims link to runnable evidence

## Phase 8: Advanced Theory And Research Separation

**Goal:** isolate long-horizon mathematics from product claims.

**Examples of research-only material until implemented:**

- metric-space structure
- category-theoretic claims
- algebraic extension claims
- broad numerical error-bound theorems
- speculative multidimensional generalizations

**Required actions:**

- move them into `docs/research/`
- list them in the claim registry as `research`
- keep them out of public product and API promises

**Acceptance:**

- long-horizon theory remains visible, but never masquerades as shipped truth

## File-Level Execution Map

| File or area | Current risk | Required action | Acceptance |
|---|---|---|---|
| `README.md` | value claims can drift beyond evidence | keep links to canonical guides, examples, proofs, and benchmarks only | every strong statement has a linked artifact |
| `docs/formal/*` | proof wording can exceed theorem surface | keep theorem names and modules explicit | every proof claim maps to Lean |
| `docs/mathematics/*` | math summary can drift into proof claims | keep reader-facing summaries separate from theorem claims | summary wording matches proof map |
| `docs/api/*` | docs can describe symbols that no longer exist | keep code-backed references only | every documented symbol imports |
| `examples/*.ipynb` | runnable drift and stale APIs | keep notebooks executable in CI | all notebooks pass smoke execution |
| `benchmarks/*` and `docs/benchmarks/*` | unsupported numbers and vague speed claims | publish methodology and results together | all performance claims cite measured artifacts |
| `.trae/documents/*` | hidden competing source of truth | classify, warn, archive, or migrate | no shadow doc appears authoritative |

## Immediate Foundation Tasks

The repository should complete these tasks before deeper theory or benchmark work:

1. add the claim registry
2. add the shadow-doc triage inventory
3. downgrade `.trae` from apparent source of truth to internal draft storage
4. add CI checks for terminology and shadow-doc drift
5. keep canonical docs linked to the new governance pages

## Exit Criteria

This plan is complete only when:

- canonical docs contain only `proved`, `implemented`, `measured`, or clearly marked `research` claims
- hidden `.trae` material no longer competes with canonical docs
- CI catches the reintroduction of forbidden wording and shadow-link drift
- each major claim in the repository is traceable to a proof, test, example, benchmark, or research note
