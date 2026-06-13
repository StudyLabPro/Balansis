# Quick Start

**Audience:** developers  
**Status:** canonical

```python
from balansis import AbsoluteValue, Operations, ABSOLUTE

a = AbsoluteValue(magnitude=5.0, direction=1)
b = AbsoluteValue(magnitude=5.0, direction=-1)

result, compensation = Operations.compensated_add(a, b)

print(result)        # additive result in ACT
print(compensation)  # explicit compensation factor
print(ABSOLUTE)      # additive identity
```

## What To Try Next

- Review the value proposition in [Why Balansis](why-balansis.md)
- Learn the core terms in [Glossary](../glossary.md)
- Browse the code-backed docs in [API Reference](../api/index.md)
- Run notebooks from [Examples](../examples/index.md)
