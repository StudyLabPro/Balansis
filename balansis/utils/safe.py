# Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
#
# This file is part of Balansis.
# Balansis is dual-licensed under:
#   1. GNU Affero General Public License v3.0 (AGPLv3) for open-source use.
#   2. A Commercial License for proprietary and corporate use.
#
# See LICENSING.md in the project root for license selection details.
# For commercial licensing: andrew@xteam.pro
from functools import wraps
from balansis.core.absolute import AbsoluteValue

def safe_computation(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        conv = []
        for a in args:
            if isinstance(a, AbsoluteValue):
                conv.append(a)
            elif isinstance(a, (int, float)):
                conv.append(AbsoluteValue.from_float(float(a)))
            else:
                conv.append(a)
        res = fn(*conv, **kwargs)
        if isinstance(res, AbsoluteValue):
            try:
                return float(res.to_float())
            except Exception:
                return res
        return res
    return wrapper
