# Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
#
# This file is part of Balansis.
# Balansis is dual-licensed under:
#   1. GNU Affero General Public License v3.0 (AGPLv3) for open-source use.
#   2. A Commercial License for proprietary and corporate use.
#
# See the LICENSE file in the project root for full licensing terms.
# For commercial licensing: andrew@xteam.pro
from decimal import Decimal, getcontext
from typing import List, Dict, Tuple
from balansis.core.absolute import AbsoluteValue

getcontext().prec = 50

class LedgerEntry:
    def __init__(self, account: str, amount: AbsoluteValue, memo: str = ""):
        self.account = account
        self.amount = amount
        self.memo = memo

class Ledger:
    def __init__(self):
        self.entries: List[LedgerEntry] = []

    def post_entry(self, account: str, amount: Decimal, memo: str = ""):
        sign = 1 if amount >= 0 else -1
        value = AbsoluteValue(magnitude=abs(float(amount)), direction=sign)
        self.entries.append(LedgerEntry(account, value, memo))

    def transfer(self, debit_account: str, credit_account: str, amount: Decimal, memo: str = ""):
        self.post_entry(debit_account, amount, memo)
        self.post_entry(credit_account, -amount, memo)

    def balance(self) -> AbsoluteValue:
        total = AbsoluteValue.absolute()
        for e in self.entries:
            total = total + e.amount
        return total

    def account_balance(self, account: str) -> AbsoluteValue:
        total = AbsoluteValue.absolute()
        for e in self.entries:
            if e.account == account:
                total = total + e.amount
        return total
