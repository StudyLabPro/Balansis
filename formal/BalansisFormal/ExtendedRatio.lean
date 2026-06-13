import BalansisFormal.AbsoluteValue
import BalansisFormal.EternalRatio

-- Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
-- This file is part of Balansis, dual-licensed under AGPLv3 / Commercial.
-- See LICENSE in the project root. Commercial use: andrew@xteam.pro
/-!
  BalansisFormal.ExtendedRatio — runtime-style singular ratio semantics.

  This module does not attempt to extend the finite `Field` structure of
  `EternalRatio`. Instead, it formalizes the deterministic classification used
  by the runtime `ExtendedRatio` layer:

  - finite when the denominator is non-zero,
  - infinite when a non-zero numerator is divided by zero,
  - indeterminate when zero is divided by zero.
-/

namespace BalansisFormal

noncomputable section

set_option linter.dupNamespace false

namespace ExtendedRatio

abbrev FiniteRatio := EternalRatio.EternalRatio

inductive ExtendedRatio where
  | finite : FiniteRatio → ExtendedRatio
  | infinite : Direction → ExtendedRatio
  | indeterminate : ExtendedRatio

local instance : DecidableEq AbsoluteValue := Classical.decEq _

def fromDivision (a b : AbsoluteValue) : ExtendedRatio :=
  if hb : b = 0 then
    if a = 0 then
      .indeterminate
    else
      .infinite a.direction
  else
    .finite (EternalRatio.mk a b hb)

theorem fromDivision_of_den_nonzero (a b : AbsoluteValue) (hb : b ≠ 0) :
    fromDivision a b = .finite (EternalRatio.mk a b hb) := by
  classical
  simp [fromDivision, hb]

@[simp] theorem fromDivision_zero_zero :
    fromDivision (0 : AbsoluteValue) (0 : AbsoluteValue) = .indeterminate := by
  classical
  simp [fromDivision]

theorem fromDivision_of_num_nonzero_den_zero (a : AbsoluteValue) (ha : a ≠ 0) :
    fromDivision a 0 = .infinite a.direction := by
  classical
  simp [fromDivision, ha]

theorem finite_iff_den_nonzero (a b : AbsoluteValue) :
    (∃ r : FiniteRatio, fromDivision a b = .finite r) ↔ b ≠ 0 := by
  classical
  constructor
  · intro h hb
    rcases h with ⟨r, hr⟩
    subst b
    by_cases ha : a = 0
    · simp [fromDivision, ha] at hr
    · simp [fromDivision, ha] at hr
  · intro hb
    exact ⟨EternalRatio.mk a b hb, fromDivision_of_den_nonzero a b hb⟩

theorem indeterminate_iff_zero_zero (a b : AbsoluteValue) :
    fromDivision a b = .indeterminate ↔ a = 0 ∧ b = 0 := by
  classical
  constructor
  · intro h
    by_cases hb : b = 0
    · by_cases ha : a = 0
      · exact ⟨ha, hb⟩
      · simp [fromDivision, hb, ha] at h
    · simp [fromDivision, hb] at h
  · rintro ⟨rfl, rfl⟩
    simp [fromDivision]

end ExtendedRatio

end

end BalansisFormal
