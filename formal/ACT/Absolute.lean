/-
  ACT.Absolute — public theorem layer for A1–A5.
-/
import BalansisFormal.AbsoluteValue

namespace ACT

noncomputable section

abbrev AbsoluteValue := BalansisFormal.AbsoluteValue

namespace AbsoluteValue

abbrev absolute : AbsoluteValue := (0 : BalansisFormal.AbsoluteValue)
abbrev isAbsolute (a : AbsoluteValue) : Prop := BalansisFormal.AbsoluteValue.isAbsolute a
abbrev toReal (a : AbsoluteValue) : ℝ := BalansisFormal.AbsoluteValue.toReal a
abbrev fromReal (x : ℝ) : AbsoluteValue := BalansisFormal.AbsoluteValue.fromReal x

end AbsoluteValue

theorem a1_exists_unique (x : ℝ) : ∃! a : AbsoluteValue, AbsoluteValue.toReal a = x :=
  BalansisFormal.AbsoluteValue.a1_exists_unique x

theorem a2_nonneg (a : AbsoluteValue) : (0 : ℝ) ≤ (a.magnitude : ℝ) :=
  BalansisFormal.AbsoluteValue.a2_nonneg a

theorem a3_compensation (a b : AbsoluteValue)
    (hmag : a.magnitude = b.magnitude)
    (hdir : a.direction = BalansisFormal.Direction.negate b.direction) :
    a + b = AbsoluteValue.absolute :=
  BalansisFormal.AbsoluteValue.a3_compensation a b hmag hdir

theorem a4_additive_identity (a : AbsoluteValue) : a + AbsoluteValue.absolute = a :=
  BalansisFormal.AbsoluteValue.a4_additive_identity a

theorem a4_additive_identity_left (a : AbsoluteValue) : AbsoluteValue.absolute + a = a :=
  BalansisFormal.AbsoluteValue.a4_additive_identity_left a

theorem a5_direction_preservation (a : AbsoluteValue) (c : ℝ)
    (ha : a ≠ AbsoluteValue.absolute) (hc : 0 < c) :
    (AbsoluteValue.fromReal (c * AbsoluteValue.toReal a)).direction = a.direction :=
  BalansisFormal.AbsoluteValue.a5_direction_preservation a c ha hc

end

end ACT
