# Result Interpretation

**Audience:** decision makers, developers, researchers  
**Status:** canonical  
**Source of truth:** this page for reading Balansis benchmark outputs

This page explains how benchmark results should be interpreted once scenarios
and measurements are published.

## First Rule

A benchmark result is meaningful only if it helps a reader make a clearer
engineering or adoption decision.

## How To Read Accuracy Results

Accuracy-oriented results should answer questions such as:

- did Balansis preserve a residual that plain IEEE 754 lost
- did the runtime surface expose a meaningful compensation signal
- did a scenario avoid a misleading exact-zero or unstable edge case

Do not reduce these outcomes to a single performance headline.

## How To Read Performance Results

Performance-oriented results should answer questions such as:

- what runtime overhead is paid for the behavior
- where the overhead appears
- whether the tradeoff is stable across scenario families

Higher cost can be acceptable if the stability or interpretability benefit is
clear and reproducible.

## How To Compare Methods

When a benchmark compares Balansis with another method, read the result through
these lenses:

| Lens | Question |
|---|---|
| numerical outcome | what changed in the result |
| stability behavior | what class of failure was avoided or exposed |
| operational cost | what time or memory cost was paid |
| reproducibility | can another reader repeat the same setup |

## Negative Results

Negative results are still useful.

Examples:

- Balansis is slower without offering a meaningful stability benefit in a scenario
- a baseline method already handles the scenario sufficiently well
- the benchmark is too noisy to support a conclusion

These outcomes should be documented plainly rather than hidden.

## Reader Paths

- benchmark rules: [Benchmark Methodology](methodology.md)
- examples: [Examples](../examples/index.md)
- scientific usage framing: [Scientific Computing](../guides/scientific-computing.md)
