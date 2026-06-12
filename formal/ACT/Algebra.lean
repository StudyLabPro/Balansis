/- 
  ACT.Algebra — public theorem layer for S1–S3 and the field structure.
-/
import ACT.Absolute
import ACT.EternalRatio
import BalansisFormal.Algebra

namespace ACT

noncomputable section

namespace AbsoluteValue

theorem s1_closure (a b : AbsoluteValue) : ∃ c : AbsoluteValue, c = a + b :=
  BalansisFormal.AbsoluteValue.s1_closure a b

theorem s1_associativity (a b c : AbsoluteValue) : (a + b) + c = a + (b + c) :=
  BalansisFormal.AbsoluteValue.s1_associativity a b c

theorem s1_commutativity (a b : AbsoluteValue) : a + b = b + a :=
  BalansisFormal.AbsoluteValue.s1_commutativity a b

theorem s1_identity_right (a : AbsoluteValue) : a + 0 = a :=
  BalansisFormal.AbsoluteValue.s1_identity_right a

theorem s1_identity_left (a : AbsoluteValue) : (0 : AbsoluteValue) + a = a :=
  BalansisFormal.AbsoluteValue.s1_identity_left a

theorem s1_inverse (a : AbsoluteValue) : a + (-a) = 0 :=
  BalansisFormal.AbsoluteValue.s1_inverse a

theorem s2_closure (a b : AbsoluteValue) (ha : a ≠ 0) (hb : b ≠ 0) : a * b ≠ 0 :=
  BalansisFormal.AbsoluteValue.s2_closure a b ha hb

theorem s2_mul_associativity (a b c : AbsoluteValue) : (a * b) * c = a * (b * c) :=
  BalansisFormal.AbsoluteValue.s2_mul_associativity a b c

theorem s2_mul_commutativity (a b : AbsoluteValue) : a * b = b * a :=
  BalansisFormal.AbsoluteValue.s2_mul_commutativity a b

theorem s2_mul_identity_right (a : AbsoluteValue) : a * 1 = a :=
  BalansisFormal.AbsoluteValue.s2_mul_identity_right a

theorem s2_mul_identity_left (a : AbsoluteValue) : (1 : AbsoluteValue) * a = a :=
  BalansisFormal.AbsoluteValue.s2_mul_identity_left a

theorem s2_mul_inverse (a : AbsoluteValue) (ha : a ≠ 0) : a * a⁻¹ = 1 :=
  BalansisFormal.AbsoluteValue.s2_mul_inverse a ha

theorem mul_add_distrib (a b c : AbsoluteValue) : a * (b + c) = a * b + a * c :=
  BalansisFormal.AbsoluteValue.mul_add_distrib a b c

end AbsoluteValue

namespace EternalRatio

theorem s3_add_assoc (r₁ r₂ r₃ : EternalRatio) : (r₁ + r₂) + r₃ = r₁ + (r₂ + r₃) :=
  BalansisFormal.EternalRatio.s3_add_assoc r₁ r₂ r₃

theorem s3_add_comm (r₁ r₂ : EternalRatio) : r₁ + r₂ = r₂ + r₁ :=
  BalansisFormal.EternalRatio.s3_add_comm r₁ r₂

theorem s3_add_identity (r : EternalRatio) : r + zero = r :=
  BalansisFormal.EternalRatio.s3_add_identity r

theorem s3_add_inverse (r : EternalRatio) : r + (-r) = zero :=
  BalansisFormal.EternalRatio.s3_add_inverse r

theorem s3_mul_assoc (r₁ r₂ r₃ : EternalRatio) : (r₁ * r₂) * r₃ = r₁ * (r₂ * r₃) :=
  BalansisFormal.EternalRatio.s3_mul_assoc r₁ r₂ r₃

theorem s3_mul_comm (r₁ r₂ : EternalRatio) : r₁ * r₂ = r₂ * r₁ :=
  BalansisFormal.EternalRatio.s3_mul_comm r₁ r₂

theorem s3_mul_identity (r : EternalRatio) : r * unity = r :=
  BalansisFormal.EternalRatio.s3_mul_identity r

theorem s3_mul_inverse (r : EternalRatio) (hr : r ≠ zero) : r * r⁻¹ = unity :=
  BalansisFormal.EternalRatio.s3_mul_inverse r hr

theorem s3_distributivity (a b c : EternalRatio) : a * (b + c) = a * b + a * c :=
  BalansisFormal.EternalRatio.s3_distributivity a b c

noncomputable def eternal_ratio_field : Field EternalRatio :=
  BalansisFormal.EternalRatio.eternal_ratio_field

end EternalRatio

end

end ACT
