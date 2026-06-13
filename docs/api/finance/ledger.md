# Ledger API

**Audience:** developers and applied users  
**Status:** canonical

`Ledger` is the current finance-oriented helper exposed by `balansis.finance`.

## Purpose

It provides a simple accounting-style surface where posted values are converted
into `AbsoluteValue` instances and aggregated through the ACT-aware runtime.

## Common Entry Points

```python
from decimal import Decimal
from balansis.finance.ledger import Ledger

ledger = Ledger()
ledger.post_entry("cash", Decimal("250.00"))
ledger.post_entry("cash", Decimal("-250.00"))
balance = ledger.balance()
```

## Common Operations

- `post_entry()`
- `transfer()`
- `balance()`
- `account_balance()`

## Related Docs

- [Finance Workflows](../../guides/finance-workflows.md)
- [AbsoluteValue API](../core/absolute-value.md)
