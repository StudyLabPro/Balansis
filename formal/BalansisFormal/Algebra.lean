-- Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
-- This file is part of Balansis, dual-licensed under AGPLv3 / Commercial.
-- See LICENSE in the project root. Commercial use: andrew@xteam.pro
/- 
  BalansisFormal.Algebra — structural laws proved on the actual types.

  `AbsoluteValue` is the constructive signed-magnitude model.
  `EternalRatio` is the quotient field built from non-zero denominator pairs.
-/
import Mathlib
import BalansisFormal.EternalRatio

namespace BalansisFormal

noncomputable section

namespace AbsoluteValue

theorem s1_closure (a b : AbsoluteValue) : ∃ c : AbsoluteValue, c = a + b := ⟨a + b, rfl⟩

theorem s1_associativity (a b c : AbsoluteValue) : (a + b) + c = a + (b + c) := by
  apply toReal_injective
  ring_nf

theorem s1_commutativity (a b : AbsoluteValue) : a + b = b + a := by
  apply toReal_injective
  ring_nf

theorem s1_identity_right (a : AbsoluteValue) : a + 0 = a :=
  a4_additive_identity a

theorem s1_identity_left (a : AbsoluteValue) : (0 : AbsoluteValue) + a = a :=
  a4_additive_identity_left a

theorem s1_inverse (a : AbsoluteValue) : a + (-a) = 0 := by
  apply toReal_injective
  ring_nf

theorem s2_closure (a b : AbsoluteValue) (ha : a ≠ 0) (hb : b ≠ 0) : a * b ≠ 0 :=
  mul_ne_zero_of_ne_zero ha hb

theorem s2_mul_associativity (a b c : AbsoluteValue) : (a * b) * c = a * (b * c) := by
  apply toReal_injective
  ring_nf

theorem s2_mul_commutativity (a b : AbsoluteValue) : a * b = b * a := by
  apply toReal_injective
  ring_nf

theorem s2_mul_identity_right (a : AbsoluteValue) : a * 1 = a := by
  apply toReal_injective
  ring_nf

theorem s2_mul_identity_left (a : AbsoluteValue) : (1 : AbsoluteValue) * a = a := by
  apply toReal_injective
  ring_nf

theorem s2_mul_inverse (a : AbsoluteValue) (ha : a ≠ 0) : a * a⁻¹ = 1 := by
  apply toReal_injective
  have hreal : a.toReal ≠ 0 := AbsoluteValue.nonzero_toReal_ne_zero ha
  simp [hreal]

theorem mul_add_distrib (a b c : AbsoluteValue) : a * (b + c) = a * b + a * c := by
  apply toReal_injective
  ring_nf

end AbsoluteValue

namespace EternalRatio

theorem s3_add_assoc (r₁ r₂ r₃ : EternalRatio) : (r₁ + r₂) + r₃ = r₁ + (r₂ + r₃) := by
  apply toReal_injective
  ring_nf

theorem s3_add_comm (r₁ r₂ : EternalRatio) : r₁ + r₂ = r₂ + r₁ := by
  apply toReal_injective
  ring_nf

theorem s3_add_identity (r : EternalRatio) : r + zero = r := by
  apply toReal_injective
  simp [zero]

theorem s3_add_inverse (r : EternalRatio) : r + (-r) = zero := by
  apply toReal_injective
  simp [zero]

theorem s3_mul_assoc (r₁ r₂ r₃ : EternalRatio) : (r₁ * r₂) * r₃ = r₁ * (r₂ * r₃) := by
  apply toReal_injective
  ring_nf

theorem s3_mul_comm (r₁ r₂ : EternalRatio) : r₁ * r₂ = r₂ * r₁ := by
  apply toReal_injective
  ring_nf

theorem s3_mul_identity (r : EternalRatio) : r * unity = r :=
  e3_multiplicative_identity r

theorem s3_mul_inverse (r : EternalRatio) (hr : r ≠ zero) : r * r⁻¹ = unity :=
  e4_inverse r hr

theorem s3_distributivity (a b c : EternalRatio) : a * (b + c) = a * b + a * c := by
  apply toReal_injective
  ring_nf

noncomputable def eternal_ratio_field : Field EternalRatio := inferInstance

end EternalRatio

end

end BalansisFormal
