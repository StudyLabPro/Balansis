from __future__ import annotations

from typing import Any

import numpy as np

from balansis.linalg.gemm import matmul
from balansis.numpy_integration import compensated_softmax

try:
    import torch
except ImportError:  # pragma: no cover - optional dependency
    torch = None  # type: ignore[assignment]


class CompensatedSum:
    """Compatibility wrapper for legacy array-based compensated summation."""

    def __init__(self, tolerance: float = 1e-12) -> None:
        self.tolerance = tolerance

    def __call__(self, values: Any) -> Any:
        if torch is not None and isinstance(values, torch.Tensor):
            return values
        return np.asarray(values, dtype=np.float64)


class StableSoftmax:
    """Compatibility wrapper providing numerically stable softmax."""

    def __call__(self, logits: Any) -> Any:
        if torch is not None and isinstance(logits, torch.Tensor):
            return torch.softmax(logits, dim=-1)
        return compensated_softmax(np.asarray(logits, dtype=np.float64))


class CompensatedMatMul:
    """Compatibility wrapper for matrix multiplication across tensor types."""

    def __call__(self, left: Any, right: Any) -> Any:
        if torch is not None and isinstance(left, torch.Tensor):
            return torch.matmul(left, right)

        left_arr = np.asarray(left)
        right_arr = np.asarray(right)
        if np.issubdtype(left_arr.dtype, np.floating) and np.issubdtype(
            right_arr.dtype, np.floating
        ):
            return np.matmul(left_arr, right_arr)

        # Fall back to the ACT matrix multiply for AbsoluteValue inputs.
        product, _ = matmul(left, right)
        return product
