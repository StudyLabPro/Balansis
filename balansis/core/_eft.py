# Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
#
# This file is part of Balansis.
# Balansis is dual-licensed under:
#   1. GNU Affero General Public License v3.0 (AGPLv3) for open-source use.
#   2. A Commercial License for proprietary and corporate use.
#
# See LICENSING.md in the project root for license selection details.
# For commercial licensing: andrew@xteam.pro
"""Error-free transformations (EFT) — the numerical primitives behind ACT.

These are the classical building blocks that make compensated arithmetic
*actually* recover lost precision rather than merely tracking it:

- ``two_sum(a, b)``     — Knuth (1969): ``a + b = s + e`` exactly, no FMA needed.
- ``two_product(a, b)`` — Dekker (1971): ``a * b = p + e`` exactly, via splitting.
- ``dot2(a, b)``        — Ogita–Rump–Oishi (2005): a dot product accumulated
  through TwoProduct + exact summation, giving a *correctly rounded* result
  even for catastrophically ill-conditioned inputs.

``dot2`` is the honest core of the whitepaper's accuracy claims: the naive
``sum(a[i] * b[i])`` loses precision in two places — each product rounds, and
the running sum accumulates error. Kahan summation only fixes the second.
TwoProduct captures the per-product rounding error, and ``math.fsum`` sums the
full set of high/low terms with a single correct rounding.
"""
from __future__ import annotations

import math
from typing import Tuple

import numpy as np

# 2^27 + 1 — the Dekker splitting constant for float64 (26-bit halves).
_SPLIT = 134217729.0


def two_sum(a: float, b: float) -> Tuple[float, float]:
    """Return ``(s, e)`` with ``s = fl(a + b)`` and ``a + b == s + e`` exactly."""
    s = a + b
    bb = s - a
    err = (a - (s - bb)) + (b - bb)
    return s, err


def two_product(a: float, b: float) -> Tuple[float, float]:
    """Return ``(p, e)`` with ``p = fl(a * b)`` and ``a * b == p + e`` exactly."""
    p = a * b
    c = _SPLIT * a
    ah = c - (c - a)
    al = a - ah
    d = _SPLIT * b
    bh = d - (d - b)
    bl = b - bh
    err = ((ah * bh - p) + ah * bl + al * bh) + al * bl
    return p, err


def _split_arr(v: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    c = _SPLIT * v
    hi = c - (c - v)
    lo = v - hi
    return hi, lo


def two_product_arr(a: np.ndarray, b: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    """Vectorized :func:`two_product`. Returns ``(p, e)`` arrays with ``a*b == p+e``."""
    p = a * b
    ah, al = _split_arr(a)
    bh, bl = _split_arr(b)
    err = ((ah * bh - p) + ah * bl + al * bh) + al * bl
    return p, err


def dot2(a, b) -> float:
    """Correctly rounded dot product (Ogita–Rump–Oishi Dot2 via exact summation).

    Captures every product's rounding error with TwoProduct, then sums the full
    set of high and low parts with :func:`math.fsum` (a single correct rounding
    of the exact dot product). Delivers full float64 accuracy regardless of the
    condition number, as long as the individual products are finite.
    """
    a = np.asarray(a, dtype=np.float64).ravel()
    b = np.asarray(b, dtype=np.float64).ravel()
    if a.size == 0:
        return 0.0
    p, e = two_product_arr(a, b)
    finite = np.isfinite(p) & np.isfinite(e)
    if not finite.all():
        # Overflow/underflow in a product: fall back to the plain dot for those
        # positions so we never return NaN from an otherwise-finite computation.
        return float(np.dot(a, b))
    return math.fsum(np.concatenate([p, e]))


def comp_sum(values) -> float:
    """Correctly rounded sum of a 1-D set of floats (exact summation)."""
    arr = np.asarray(values, dtype=np.float64).ravel()
    if arr.size == 0:
        return 0.0
    if not np.isfinite(arr).all():
        return float(np.sum(arr))
    return math.fsum(arr)
