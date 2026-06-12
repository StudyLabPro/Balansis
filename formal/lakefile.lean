-- Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
-- This file is part of Balansis, dual-licensed under AGPLv3 / Commercial.
-- See LICENSE in the project root. Commercial use: andrew@xteam.pro
import Lake
open Lake DSL

package balansis_formal where
  moreLeanArgs := #[]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.28.0"

@[default_target]
lean_lib BalansisFormal

@[default_target]
lean_lib ACT
