import ACT.Absolute
import ACT.EternalRatio
import BalansisFormal.ExtendedRatio

/-!
  ACT.ExtendedRatio — public theorem layer for singular ratio classification.
-/

namespace ACT

noncomputable section

abbrev ExtendedRatio := BalansisFormal.ExtendedRatio.ExtendedRatio
abbrev FiniteRatio := BalansisFormal.ExtendedRatio.FiniteRatio
abbrev SingularPolicy := BalansisFormal.ExtendedRatio.SingularPolicy
abbrev ExtendedDirection := BalansisFormal.Direction

namespace ExtendedRatio

abbrev fromDivision := BalansisFormal.ExtendedRatio.fromDivision
abbrev add := BalansisFormal.ExtendedRatio.add
abbrev mul := BalansisFormal.ExtendedRatio.mul
abbrev negate := BalansisFormal.ExtendedRatio.negate
abbrev saturate := BalansisFormal.ExtendedRatio.saturate
abbrev applyPolicy := BalansisFormal.ExtendedRatio.applyPolicy

theorem fromDivision_of_den_nonzero (a b : AbsoluteValue) (hb : b ≠ 0) :
    fromDivision a b = .finite (BalansisFormal.EternalRatio.mk a b hb) :=
  BalansisFormal.ExtendedRatio.fromDivision_of_den_nonzero a b hb

theorem fromDivision_zero_zero :
    fromDivision (0 : AbsoluteValue) (0 : AbsoluteValue) = .indeterminate :=
  BalansisFormal.ExtendedRatio.fromDivision_zero_zero

theorem fromDivision_of_num_nonzero_den_zero (a : AbsoluteValue) (ha : a ≠ 0) :
    fromDivision a 0 = .infinite a.direction :=
  BalansisFormal.ExtendedRatio.fromDivision_of_num_nonzero_den_zero a ha

theorem finite_iff_den_nonzero (a b : AbsoluteValue) :
    (∃ r : FiniteRatio, fromDivision a b = .finite r) ↔ b ≠ 0 :=
  BalansisFormal.ExtendedRatio.finite_iff_den_nonzero a b

theorem indeterminate_iff_zero_zero (a b : AbsoluteValue) :
    fromDivision a b = .indeterminate ↔ a = 0 ∧ b = 0 :=
  BalansisFormal.ExtendedRatio.indeterminate_iff_zero_zero a b

theorem add_indeterminate_left (x : ExtendedRatio) : add .indeterminate x = .indeterminate :=
  BalansisFormal.ExtendedRatio.add_indeterminate_left x

theorem add_indeterminate_right (x : ExtendedRatio) : add x .indeterminate = .indeterminate :=
  BalansisFormal.ExtendedRatio.add_indeterminate_right x

theorem mul_indeterminate_left (x : ExtendedRatio) : mul .indeterminate x = .indeterminate :=
  BalansisFormal.ExtendedRatio.mul_indeterminate_left x

theorem mul_indeterminate_right (x : ExtendedRatio) : mul x .indeterminate = .indeterminate :=
  BalansisFormal.ExtendedRatio.mul_indeterminate_right x

theorem add_opposite_infinities_indeterminate (d : ExtendedDirection) :
    add (.infinite d) (.infinite d.negate) = .indeterminate :=
  BalansisFormal.ExtendedRatio.add_opposite_infinities_indeterminate d

theorem add_same_infinities (d : ExtendedDirection) : add (.infinite d) (.infinite d) = .infinite d :=
  BalansisFormal.ExtendedRatio.add_same_infinities d

theorem mul_finite_zero_infinite_indeterminate (d : ExtendedDirection) :
    mul (.finite 0) (.infinite d) = .indeterminate :=
  BalansisFormal.ExtendedRatio.mul_finite_zero_infinite_indeterminate d

theorem mul_infinite_finite_zero_indeterminate (d : ExtendedDirection) :
    mul (.infinite d) (.finite 0) = .indeterminate :=
  BalansisFormal.ExtendedRatio.mul_infinite_finite_zero_indeterminate d

theorem saturate_infinite (d : ExtendedDirection) :
    saturate (.infinite d) = .finite (BalansisFormal.EternalRatio.ofReal d.toReal) :=
  BalansisFormal.ExtendedRatio.saturate_infinite d

theorem applyPolicy_raise_infinite (d : ExtendedDirection) :
    applyPolicy .raise (.infinite d) = none :=
  BalansisFormal.ExtendedRatio.applyPolicy_raise_infinite d

theorem applyPolicy_raise_indeterminate : applyPolicy .raise .indeterminate = none :=
  BalansisFormal.ExtendedRatio.applyPolicy_raise_indeterminate

theorem applyPolicy_propagate (x : ExtendedRatio) : applyPolicy .propagate x = some x :=
  BalansisFormal.ExtendedRatio.applyPolicy_propagate x

theorem applyPolicy_saturate (x : ExtendedRatio) : applyPolicy .saturate x = some (saturate x) :=
  BalansisFormal.ExtendedRatio.applyPolicy_saturate x

theorem extendedRatio_not_field_carrier :
    ∃ x : ExtendedRatio, applyPolicy .raise x = none :=
  BalansisFormal.ExtendedRatio.extendedRatio_not_field_carrier

end ExtendedRatio

end

end ACT
