# Copyright (c) 2024-2026 Tikhonov Andrey. All rights reserved.
# SPDX-License-Identifier: MIT (non-commercial) | Commercial use: see COMMERCIAL_LICENSE.md
"""ACT-compensated linear algebra primitives.

Public API:
    matmul           — ACT-compensated GEMM (returns ``(C, compensation)``)
    qr_decompose     — QR decomposition via Householder/Givens/MGS
    svd              — Singular Value Decomposition
    CompensatedQRResult — structured QR result with diagnostics
    CompensatedSVDResult — structured SVD result with diagnostics
"""
from .gemm import matmul
from .qr import qr_decompose, CompensatedQRResult
from .svd import svd, CompensatedSVDResult

__all__ = [
    "matmul",
    "qr_decompose",
    "svd",
    "CompensatedQRResult",
    "CompensatedSVDResult",
]
