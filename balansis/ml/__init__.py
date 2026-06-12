# Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
#
# This file is part of Balansis.
# Balansis is dual-licensed under:
#   1. GNU Affero General Public License v3.0 (AGPLv3) for open-source use.
#   2. A Commercial License for proprietary and corporate use.
#
# See the LICENSE file in the project root for full licensing terms.
# For commercial licensing: andrew@xteam.pro
"""Machine learning integration module for Balansis.

Provides ACT-aware optimizers for training neural networks with
enhanced numerical stability.
"""

from .optimizer import EternalOptimizer, AdaptiveEternalOptimizer

__all__ = ["EternalOptimizer", "AdaptiveEternalOptimizer"]

try:
    import torch  # noqa: F401
    from .optimizer import EternalTorchOptimizer

    __all__.append("EternalTorchOptimizer")
except ImportError:
    pass
