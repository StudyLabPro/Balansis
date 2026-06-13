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

#check ACT.ExtendedRatio.fromDivision_of_den_nonzero
#check ACT.ExtendedRatio.fromDivision_zero_zero
#check ACT.ExtendedRatio.fromDivision_of_num_nonzero_den_zero
#check ACT.ExtendedRatio.finite_iff_den_nonzero
#check ACT.ExtendedRatio.indeterminate_iff_zero_zero

#check ACT.AbsoluteValue.s1_associativity
#check ACT.AbsoluteValue.s2_mul_inverse
#check ACT.EternalRatio.s3_distributivity

#check ACT.AbsoluteValue.order_reflexive
#check ACT.AbsoluteValue.order_antisymmetric
#check ACT.AbsoluteValue.order_transitive
#check ACT.AbsoluteValue.metric_nonneg
#check ACT.AbsoluteValue.metric_symmetry
#check ACT.AbsoluteValue.metric_triangle
#check ACT.AbsoluteValue.complete
#check ACT.AbsoluteValue.continuous_add
#check ACT.AbsoluteValue.continuous_mul

#check ACT.EternalRatio.order_reflexive
#check ACT.EternalRatio.order_antisymmetric
#check ACT.EternalRatio.order_transitive
#check ACT.EternalRatio.metric_nonneg
#check ACT.EternalRatio.metric_symmetry
#check ACT.EternalRatio.metric_triangle
#check ACT.EternalRatio.complete
#check ACT.EternalRatio.continuous_add
#check ACT.EternalRatio.continuous_mul

#check (inferInstance : Field ACT.AbsoluteValue)
#check (inferInstance : Field ACT.EternalRatio)
#check (inferInstance : LinearOrder ACT.AbsoluteValue)
#check (inferInstance : LinearOrder ACT.EternalRatio)
#check (inferInstance : MetricSpace ACT.AbsoluteValue)
#check (inferInstance : MetricSpace ACT.EternalRatio)
#check (inferInstance : CompleteSpace ACT.AbsoluteValue)
#check (inferInstance : CompleteSpace ACT.EternalRatio)

noncomputable def eternalRatioFieldWitness : Field ACT.EternalRatio :=
  ACT.EternalRatio.eternal_ratio_field

end FormalAudit
