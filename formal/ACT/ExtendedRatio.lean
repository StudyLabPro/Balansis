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

namespace ExtendedRatio

abbrev fromDivision := BalansisFormal.ExtendedRatio.fromDivision

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

end ExtendedRatio

end

end ACT
