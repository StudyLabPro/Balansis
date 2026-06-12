/- 
  ACT.EternalRatio — public theorem layer for E1–E4.
-/
import ACT.Absolute
import BalansisFormal.EternalRatio

namespace ACT

noncomputable section

abbrev EternalRatio := BalansisFormal.EternalRatio.EternalRatio
abbrev RatioRep := BalansisFormal.EternalRatio.RatioRep

namespace EternalRatio

abbrev mk (a b : AbsoluteValue) (hb : b ≠ 0) : EternalRatio :=
  BalansisFormal.EternalRatio.mk a b hb

abbrev toReal (r : EternalRatio) : ℝ := BalansisFormal.EternalRatio.toReal r
abbrev zero : EternalRatio := BalansisFormal.EternalRatio.zero
abbrev unity : EternalRatio := BalansisFormal.EternalRatio.unity

theorem e1_well_defined (a b : AbsoluteValue) (hb : b ≠ 0) :
    ∃! r : EternalRatio, toReal r = a.toReal / b.toReal :=
  BalansisFormal.EternalRatio.e1_well_defined a b hb

theorem e2_stability (r : EternalRatio) :
    ∃ rep : RatioRep, Quotient.mk _ rep = r ∧ rep.denominator ≠ 0 :=
  BalansisFormal.EternalRatio.e2_stability r

theorem e3_multiplicative_identity (r : EternalRatio) : r * unity = r :=
  BalansisFormal.EternalRatio.e3_multiplicative_identity r

theorem e3_multiplicative_identity_left (r : EternalRatio) : unity * r = r :=
  BalansisFormal.EternalRatio.e3_multiplicative_identity_left r

theorem e4_inverse (r : EternalRatio) (hr : r ≠ zero) : r * r⁻¹ = unity :=
  BalansisFormal.EternalRatio.e4_inverse r hr

end EternalRatio

end

end ACT
