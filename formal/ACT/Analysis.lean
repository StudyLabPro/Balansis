import ACT.Algebra
import BalansisFormal.Analysis

/-!
  ACT.Analysis — public theorem layer for order, metric, completeness, and continuity.
-/

namespace ACT

noncomputable section

namespace AbsoluteValue

theorem order_reflexive (a : AbsoluteValue) : a ≤ a :=
  BalansisFormal.AbsoluteValue.order_reflexive a

theorem order_antisymmetric {a b : AbsoluteValue} (hab : a ≤ b) (hba : b ≤ a) : a = b :=
  BalansisFormal.AbsoluteValue.order_antisymmetric hab hba

theorem order_transitive {a b c : AbsoluteValue} (hab : a ≤ b) (hbc : b ≤ c) : a ≤ c :=
  BalansisFormal.AbsoluteValue.order_transitive hab hbc

theorem metric_nonneg (a b : AbsoluteValue) : 0 ≤ dist a b :=
  BalansisFormal.AbsoluteValue.metric_nonneg a b

theorem metric_symmetry (a b : AbsoluteValue) : dist a b = dist b a :=
  BalansisFormal.AbsoluteValue.metric_symmetry a b

theorem metric_triangle (a b c : AbsoluteValue) : dist a c ≤ dist a b + dist b c :=
  BalansisFormal.AbsoluteValue.metric_triangle a b c

theorem complete : CompleteSpace AbsoluteValue :=
  BalansisFormal.AbsoluteValue.complete

theorem continuous_add : Continuous fun p : AbsoluteValue × AbsoluteValue => p.1 + p.2 :=
  BalansisFormal.AbsoluteValue.continuous_add

theorem continuous_mul : Continuous fun p : AbsoluteValue × AbsoluteValue => p.1 * p.2 :=
  BalansisFormal.AbsoluteValue.continuous_mul

end AbsoluteValue

namespace EternalRatio

theorem order_reflexive (r : EternalRatio) : r ≤ r :=
  BalansisFormal.EternalRatio.order_reflexive r

theorem order_antisymmetric {r s : EternalRatio} (hrs : r ≤ s) (hsr : s ≤ r) : r = s :=
  BalansisFormal.EternalRatio.order_antisymmetric hrs hsr

theorem order_transitive {r s t : EternalRatio} (hrs : r ≤ s) (hst : s ≤ t) : r ≤ t :=
  BalansisFormal.EternalRatio.order_transitive hrs hst

theorem metric_nonneg (r s : EternalRatio) : 0 ≤ dist r s :=
  BalansisFormal.EternalRatio.metric_nonneg r s

theorem metric_symmetry (r s : EternalRatio) : dist r s = dist s r :=
  BalansisFormal.EternalRatio.metric_symmetry r s

theorem metric_triangle (r s t : EternalRatio) : dist r t ≤ dist r s + dist s t :=
  BalansisFormal.EternalRatio.metric_triangle r s t

theorem complete : CompleteSpace EternalRatio :=
  BalansisFormal.EternalRatio.complete

theorem continuous_add : Continuous fun p : EternalRatio × EternalRatio => p.1 + p.2 :=
  BalansisFormal.EternalRatio.continuous_add

theorem continuous_mul : Continuous fun p : EternalRatio × EternalRatio => p.1 * p.2 :=
  BalansisFormal.EternalRatio.continuous_mul

end EternalRatio

end

end ACT
