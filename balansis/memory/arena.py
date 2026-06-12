# Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
#
# This file is part of Balansis.
# Balansis is dual-licensed under:
#   1. GNU Affero General Public License v3.0 (AGPLv3) for open-source use.
#   2. A Commercial License for proprietary and corporate use.
#
# See the LICENSE file in the project root for full licensing terms.
# For commercial licensing: andrew@xteam.pro
class AbsoluteArena:
    def __init__(self):
        self._cache = {}

    def alloc(self, magnitude: float, direction: int):
        key = (float(magnitude), int(direction))
        val = self._cache.get(key)
        if val is None:
            from balansis.core.absolute import AbsoluteValue
            val = AbsoluteValue(magnitude=key[0], direction=key[1])
            self._cache[key] = val
        return val

    def size(self) -> int:
        return len(self._cache)
