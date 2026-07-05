# Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
#
# This file is part of Balansis.
# Balansis is dual-licensed under:
#   1. GNU Affero General Public License v3.0 (AGPLv3) for open-source use.
#   2. A Commercial License for proprietary and corporate use.
#
# See LICENSING.md in the project root for license selection details.
# For commercial licensing: andrew@xteam.pro
"""ACT-compensated Singular Value Decomposition.

``svd`` returns a :class:`CompensatedSVDResult` carrying U, S, Vᵀ together
with reconstruction error and per-singular-value compensation factors. The
underlying numerical kernel delegates to NumPy's ``np.linalg.svd`` (LAPACK
``gesdd``) for robustness on general dense matrices; the ACT layer adds the
diagnostic envelope and the AbsoluteValue lifting.
"""
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Iterator, List, Optional, Tuple, Union

import numpy as np

from balansis.core.absolute import AbsoluteValue
from balansis.core.eternity import SingularArithmeticEvent, SingularPolicy
from balansis.core.operations import Operations

Matrix = List[List[AbsoluteValue]]
Vector = List[AbsoluteValue]


@dataclass
class CompensatedSVDResult:
    """Result of an ACT-compensated SVD.

    Attributes:
        U: Left singular vectors of shape (m, k).
        S: Singular values of length k, sorted descending.
        Vt: Right singular vectors (transposed) of shape (k, n).
        reconstruction_error: ``||A - U·diag(S)·Vt||_F``.
        method: Algorithm used (``"numpy_gesdd"``).
        compensation_factors: Per-singular-value compensation factors.
    """

    U: Matrix
    S: Vector
    Vt: Matrix
    reconstruction_error: float
    method: str
    compensation_factors: List[float] = field(default_factory=list)
    singular_events: List[SingularArithmeticEvent] = field(default_factory=list)

    def singular_telemetry(self) -> List[dict[str, object]]:
        """Return machine-readable singular arithmetic telemetry for this decomposition."""
        return [event.model_dump(mode="json") for event in self.singular_events]

    def __iter__(self) -> Iterator[Union[Matrix, Vector]]:
        # Backwards-compatible tuple unpacking: U, S, Vt = svd(A)
        yield self.U
        yield self.S
        yield self.Vt


def _to_numpy(mat: Matrix) -> np.ndarray:
    return np.array([[v.to_float() for v in row] for row in mat], dtype=np.float64)


def _from_numpy(arr: np.ndarray) -> Matrix:
    return [[AbsoluteValue.from_float(float(arr[i, j])) for j in range(arr.shape[1])]
            for i in range(arr.shape[0])]


def svd(
    a: Matrix,
    method: str = "numpy_gesdd",
    singular_policy: SingularPolicy | str = SingularPolicy.PROPAGATE,
    saturation_limit: float = 1e12,
) -> CompensatedSVDResult:
    """ACT-compensated SVD.

    Args:
        a: Input matrix as list of rows of :class:`AbsoluteValue`. Must be
            non-empty.
        method: SVD backend; currently only ``"numpy_gesdd"`` is supported.

    Returns:
        :class:`CompensatedSVDResult` with U, S, Vᵀ, reconstruction error
        and per-singular-value compensation factors.

    Raises:
        ValueError: If ``a`` is empty or ``method`` is unknown.
    """
    if not a or (a and not a[0]):
        raise ValueError("Cannot decompose an empty / non-empty matrix")
    if method.lower() != "numpy_gesdd":
        raise ValueError(f"Unknown SVD method: {method}")

    A = _to_numpy(a)
    U_np, S_np, Vt_np = np.linalg.svd(A, full_matrices=False)

    # NumPy already returns singular values sorted in descending order.
    # Compensation per singular value: relative magnitude vs. the leading
    # singular value, in log10 scale (small singular values get higher comp).
    leading = float(S_np[0]) if S_np.size > 0 else 1.0
    compensations: List[float] = []
    singular_events: List[SingularArithmeticEvent] = []
    resolved_policy = SingularPolicy(singular_policy)
    leading_abs = AbsoluteValue.from_float(leading)
    for s in S_np:
        s_float = float(s)
        if leading == 0.0 or s_float == 0.0:
            compensations.append(1.0)
        else:
            compensations.append(1.0 + max(0.0, np.log10(leading / max(s_float, 1e-300))))

        _, _, event = Operations.compensated_divide_policy(
            leading_abs,
            AbsoluteValue.from_float(s_float),
            policy=resolved_policy,
            saturation_limit=saturation_limit,
        )
        if event is not None:
            singular_events.append(event)

    # Reconstruction error in original float space
    recon = U_np @ np.diag(S_np) @ Vt_np
    reconstruction_error = float(np.linalg.norm(A - recon))

    return CompensatedSVDResult(
        U=_from_numpy(U_np),
        S=[AbsoluteValue.from_float(float(s)) for s in S_np],
        Vt=_from_numpy(Vt_np),
        reconstruction_error=reconstruction_error,
        method=method.lower(),
        compensation_factors=compensations,
        singular_events=singular_events,
    )
