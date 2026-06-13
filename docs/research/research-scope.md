# Research Scope

**Audience:** researchers, maintainers, technical readers  
**Status:** canonical  
**Source of truth:** this page for the boundary between research material and canonical repository claims

This page explains how to read research-oriented material in the Balansis
repository without confusing it with the canonical product, API, or theorem
surface.

## What Counts As Research

In this repository, research material includes:

- whitepaper drafts
- patent-oriented drafts
- exploratory theory writeups
- future-looking claims not yet promoted into canonical docs

These documents are valuable, but they are not the primary source of truth for
runtime behavior, packaging, repository governance, or public proof status.

## What Counts As Canonical

Canonical claims live in:

- `README.md` for product positioning and top-level navigation
- `docs/` for reader-facing topic documentation
- `formal/` and `docs/formal/` for proof status and theorem mapping
- code-backed API pages for the shipped Python runtime surface

## How To Read Research Files

Use research files for:

- motivation and broader framing
- historical context
- speculative or publication-oriented direction
- ideas that may later become canonical after implementation and verification

Do not use research files as the final authority for:

- exact API shape
- current theorem names or module layout
- support guarantees
- subproject maturity

## Promotion Rule

An idea moves from research into canonical documentation only when:

- the corresponding code or formal artifact exists
- the terminology matches `docs/glossary.md`
- the claim is routed through the appropriate canonical page
- old research wording is no longer needed to explain current repository state

## Current Research Materials

- `ACT_WHITEPAPER_v1.md`
- `PATENT_DRAFT_ACT.md`

These files remain useful, but they should be read through the boundary defined
on this page.

## Reader Paths

- research index: [index.md](index.md)
- theory surface: [Mathematics](../mathematics/index.md)
- proof surface: [Formal Verification](../formal/overview.md)
- documentation rules: [Documentation Standards](../standards.md)
