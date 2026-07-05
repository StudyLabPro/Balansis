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
local instance : DecidableEq FiniteRatio := Classical.decEq _

inductive SingularPolicy where
  | raise : SingularPolicy
  | propagate : SingularPolicy
  | saturate : SingularPolicy
  deriving DecidableEq, Repr

def isSingular : ExtendedRatio → Prop
  | .finite _ => False
  | .infinite _ => True
  | .indeterminate => True

def negate : ExtendedRatio → ExtendedRatio
  | .finite r => .finite (-r)
  | .infinite d => .infinite d.negate
  | .indeterminate => .indeterminate

def add : ExtendedRatio → ExtendedRatio → ExtendedRatio
  | .indeterminate, _ => .indeterminate
  | _, .indeterminate => .indeterminate
  | .finite r, .finite s => .finite (r + s)
  | .finite _, .infinite d => .infinite d
  | .infinite d, .finite _ => .infinite d
  | .infinite d₁, .infinite d₂ => if d₁ = d₂ then .infinite d₁ else .indeterminate

def mul : ExtendedRatio → ExtendedRatio → ExtendedRatio
  | .indeterminate, _ => .indeterminate
  | _, .indeterminate => .indeterminate
  | .finite r, .finite s => .finite (r * s)
  | .finite r, .infinite d => if r = 0 then .indeterminate else .infinite d
  | .infinite d, .finite r => if r = 0 then .indeterminate else .infinite d
  | .infinite _, .infinite _ => .infinite Direction.pos

def saturate : ExtendedRatio → ExtendedRatio
  | .infinite d => .finite (EternalRatio.ofReal d.toReal)
  | x => x

def applyPolicy : SingularPolicy → ExtendedRatio → Option ExtendedRatio
  | .raise, .finite r => some (.finite r)
  | .raise, .infinite _ => none
  | .raise, .indeterminate => none
  | .propagate, x => some x
  | .saturate, x => some (saturate x)

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

@[simp] theorem add_indeterminate_left (x : ExtendedRatio) :
    add .indeterminate x = .indeterminate := by
  cases x <;> rfl

@[simp] theorem add_indeterminate_right (x : ExtendedRatio) :
    add x .indeterminate = .indeterminate := by
  cases x <;> rfl

@[simp] theorem mul_indeterminate_left (x : ExtendedRatio) :
    mul .indeterminate x = .indeterminate := by
  cases x <;> rfl

@[simp] theorem mul_indeterminate_right (x : ExtendedRatio) :
    mul x .indeterminate = .indeterminate := by
  cases x <;> rfl

theorem add_opposite_infinities_indeterminate (d : Direction) :
    add (.infinite d) (.infinite d.negate) = .indeterminate := by
  cases d <;> simp [add, Direction.negate]

theorem add_same_infinities (d : Direction) :
    add (.infinite d) (.infinite d) = .infinite d := by
  simp [add]

theorem mul_finite_zero_infinite_indeterminate (d : Direction) :
    mul (.finite 0) (.infinite d) = .indeterminate := by
  simp [mul]

theorem mul_infinite_finite_zero_indeterminate (d : Direction) :
    mul (.infinite d) (.finite 0) = .indeterminate := by
  simp [mul]

theorem negate_indeterminate : negate .indeterminate = .indeterminate := rfl

theorem saturate_infinite (d : Direction) :
    saturate (.infinite d) = .finite (EternalRatio.ofReal d.toReal) := rfl

@[simp] theorem saturate_finite (r : FiniteRatio) :
    saturate (.finite r) = .finite r := rfl

@[simp] theorem saturate_indeterminate :
    saturate .indeterminate = .indeterminate := rfl

theorem applyPolicy_raise_finite (r : FiniteRatio) :
    applyPolicy .raise (.finite r) = some (.finite r) := rfl

theorem applyPolicy_raise_infinite (d : Direction) :
    applyPolicy .raise (.infinite d) = none := rfl

theorem applyPolicy_raise_indeterminate :
    applyPolicy .raise .indeterminate = none := rfl

theorem applyPolicy_propagate (x : ExtendedRatio) :
    applyPolicy .propagate x = some x := by
  cases x <;> rfl

theorem applyPolicy_saturate (x : ExtendedRatio) :
    applyPolicy .saturate x = some (saturate x) := by
  cases x <;> rfl

theorem extendedRatio_not_field_carrier :
    ∃ x : ExtendedRatio, applyPolicy .raise x = none :=
  ⟨.indeterminate, rfl⟩

end ExtendedRatio

end

end BalansisFormal
