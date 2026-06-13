# Benchmark Methodology

**Audience:** decision makers, developers, researchers  
**Status:** canonical  
**Source of truth:** this page for benchmark design and reporting rules

This page defines how Balansis benchmarks should be framed, executed, and
reported. It does not claim that all scenarios already exist in runnable form.

## Goals

Balansis benchmarks should answer two separate questions:

- does the runtime preserve more useful numerical structure than plain IEEE 754
- what execution cost is paid for that behavior

Benchmark reporting must keep correctness-oriented results separate from
throughput-oriented results.

## Benchmark Categories

| Category | Primary question |
|---|---|
| accuracy | does Balansis preserve a meaningful residual or structure |
| stability | does Balansis avoid numerically misleading edge behavior |
| performance | what overhead exists relative to baseline arithmetic |
| regression | did a repository change materially worsen behavior |

## Required Scenario Shape

Each benchmark scenario should document:

- the problem being tested
- the baseline method
- the Balansis method
- the input distribution or fixture
- the reported metrics
- the interpretation rule

## Baselines

Use explicit baselines rather than vague claims.

Preferred baseline families:

- Python `float` or NumPy floating-point arithmetic for standard IEEE 754 behavior
- library-specific stabilized methods when the comparison is about engineering tradeoffs
- historical Balansis versions when measuring regression

## Reporting Rules

Every published benchmark result should include:

- environment details
- dataset or synthetic input description
- number of runs or repetitions
- summary statistics used
- the exact metric definitions
- a short interpretation of why the result matters

Do not merge accuracy claims and performance claims into a single headline
number.

## Recommended Metrics

| Category | Example metrics |
|---|---|
| accuracy | absolute error, relative error, residual preserved, exact identity reached |
| stability | count of unstable cases avoided, cancellation cases handled, invalid division prevented |
| performance | wall-clock time, throughput, memory overhead |
| regression | percentage change versus previous revision |

## Scenario Families

The benchmark suite should prioritize these scenario families:

- large-scale aggregation with cancellation
- near-cancellation examples
- finance-oriented offsetting entries
- long-running accumulation or simulation workloads
- linear algebra workloads where structure loss is visible

## Interpretation Rules

- a benchmark is useful only if the expected user decision is clear
- a slowdown without stability benefit is a negative result
- a stability improvement without reproducible setup is not a publishable result
- benchmark pages must state whether a scenario is implemented, planned, or historical

## Execution Entry Point

- runnable assets: [benchmarks/README.md](../../benchmarks/README.md)
- benchmark hub: [docs/benchmarks/index.md](index.md)
