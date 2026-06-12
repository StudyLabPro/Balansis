# Security Policy

## Supported Versions

Balansis follows a best-effort support model until `1.0.0`, with security
fixes prioritized for the newest maintained line.

| Version line | Security support |
|--------------|------------------|
| `0.6.x` | Supported |
| Older than `0.6.x` | Not supported |
| Unreleased development branches | Best effort only |

`tnsim` is maintained inside the same repository and follows the same policy
unless a specific release note states otherwise.

## Reporting a Vulnerability

Please do **not** open a public GitHub issue for a suspected security problem.

Report vulnerabilities privately to:

- Email: `andrew@xteam.pro`

When possible, include:

- affected package/module and version
- impact summary
- reproduction steps or proof of concept
- conditions required for exploitation
- suggested mitigation, if known

## Response Process

Best-effort response targets:

- initial acknowledgement: within 5 business days
- triage decision: within 10 business days
- coordinated fix or mitigation timeline: as soon as reasonably possible based
  on severity and available maintainer capacity

These targets are operational goals, not contractual commitments, unless a
separate commercial support agreement states otherwise.

## Disclosure Expectations

Please allow reasonable time for triage and remediation before public
disclosure. If a fix requires a coordinated release, maintainers may ask for an
embargo window while a patch is prepared.

## Scope

This policy applies to:

- the `balansis` Python package
- the `formal/` Lean verification project where a defect could affect trust or
  integrity claims
- the `tnsim` code shipped in this repository
- release artifacts built from this repository

This policy does not create any bug bounty program, guaranteed SLA, or
commercial support obligation by itself.
