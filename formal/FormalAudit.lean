import ACT

namespace FormalAudit

open ACT

#check ACT.a1_exists_unique
#check ACT.a2_nonneg
#check ACT.a3_compensation
#check ACT.a4_additive_identity
#check ACT.a4_additive_identity_left
#check ACT.a5_direction_preservation

#check ACT.EternalRatio.e1_well_defined
#check ACT.EternalRatio.e2_stability
#check ACT.EternalRatio.e3_multiplicative_identity
#check ACT.EternalRatio.e3_multiplicative_identity_left
#check ACT.EternalRatio.e4_inverse

#check ACT.AbsoluteValue.s1_associativity
#check ACT.AbsoluteValue.s2_mul_inverse
#check ACT.EternalRatio.s3_distributivity

#check (inferInstance : Field ACT.AbsoluteValue)
#check (inferInstance : Field ACT.EternalRatio)

noncomputable def eternalRatioFieldWitness : Field ACT.EternalRatio :=
  ACT.EternalRatio.eternal_ratio_field

end FormalAudit
