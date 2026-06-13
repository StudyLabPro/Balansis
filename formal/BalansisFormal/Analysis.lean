import Mathlib
import BalansisFormal.Algebra

-- Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
-- This file is part of Balansis, dual-licensed under AGPLv3 / Commercial.
-- See LICENSE in the project root. Commercial use: andrew@xteam.pro
/-!
  BalansisFormal.Analysis — order, metric, completeness, and continuity layer.

  The current constructive core is definitionally equivalent to `ℝ` through the
  `toReal` / `fromReal` bridges. This file transports:

  - linear order,
  - metric space structure,
  - completeness,
  - continuity of addition and multiplication,

  to both `AbsoluteValue` and `EternalRatio`.
-/

namespace BalansisFormal

noncomputable section

namespace AbsoluteValue

instance : LinearOrder AbsoluteValue :=
  LinearOrder.lift' toReal toReal_injective

instance : MetricSpace AbsoluteValue :=
  MetricSpace.induced toReal toReal_injective Real.metricSpace

@[simp] theorem le_iff_toReal_le (a b : AbsoluteValue) : a ≤ b ↔ a.toReal ≤ b.toReal := Iff.rfl

@[simp] theorem lt_iff_toReal_lt (a b : AbsoluteValue) : a < b ↔ a.toReal < b.toReal := Iff.rfl

theorem order_reflexive (a : AbsoluteValue) : a ≤ a := le_rfl

theorem order_antisymmetric {a b : AbsoluteValue} (hab : a ≤ b) (hba : b ≤ a) : a = b :=
  le_antisymm hab hba

theorem order_transitive {a b c : AbsoluteValue} (hab : a ≤ b) (hbc : b ≤ c) : a ≤ c :=
  le_trans hab hbc

theorem dist_eq (a b : AbsoluteValue) : dist a b = |a.toReal - b.toReal| := rfl

theorem metric_nonneg (a b : AbsoluteValue) : 0 ≤ dist a b := dist_nonneg

theorem metric_symmetry (a b : AbsoluteValue) : dist a b = dist b a := dist_comm a b

theorem metric_triangle (a b c : AbsoluteValue) : dist a c ≤ dist a b + dist b c :=
  dist_triangle a b c

theorem uniformContinuous_toReal : UniformContinuous toReal :=
  uniformContinuous_comap

theorem isUniformEmbedding_toReal : IsUniformEmbedding toReal :=
  isUniformEmbedding_comap toReal_injective

theorem surjective_toReal : Function.Surjective toReal := fun x => ⟨fromReal x, fromReal_toReal x⟩

noncomputable def uniformEquivReal : AbsoluteValue ≃ᵤ ℝ :=
  ringEquivReal.toEquiv.toUniformEquivOfIsUniformInducing isUniformEmbedding_toReal.isUniformInducing

theorem continuous_toReal : Continuous toReal :=
  uniformEquivReal.continuous

theorem continuous_fromReal : Continuous fromReal :=
  uniformEquivReal.symm.continuous

instance : OrderTopology AbsoluteValue :=
  induced_orderTopology toReal (fun {_ _} => Iff.rfl) <| by
    intro x y hxy
    refine ⟨fromReal ((x + y) / 2), ?_, ?_⟩
    · have : x < (x + y) / 2 := by linarith
      simpa [fromReal_toReal] using this
    · have : (x + y) / 2 < y := by linarith
      simpa [fromReal_toReal] using this

theorem completeSpace_iff_real : CompleteSpace AbsoluteValue ↔ CompleteSpace ℝ :=
  isUniformEmbedding_toReal.isUniformInducing.completeSpace_congr surjective_toReal

theorem complete : CompleteSpace AbsoluteValue :=
  completeSpace_iff_real.2 inferInstance

instance : CompleteSpace AbsoluteValue :=
  complete

theorem continuous_add : Continuous fun p : AbsoluteValue × AbsoluteValue => p.1 + p.2 := by
  change Continuous (fun p : AbsoluteValue × AbsoluteValue => fromReal (p.1.toReal + p.2.toReal))
  exact continuous_fromReal.comp <|
    (continuous_toReal.comp continuous_fst).add (continuous_toReal.comp continuous_snd)

theorem continuous_mul : Continuous fun p : AbsoluteValue × AbsoluteValue => p.1 * p.2 := by
  change Continuous (fun p : AbsoluteValue × AbsoluteValue => fromReal (p.1.toReal * p.2.toReal))
  exact continuous_fromReal.comp <|
    (continuous_toReal.comp continuous_fst).mul (continuous_toReal.comp continuous_snd)

end AbsoluteValue

namespace EternalRatio

instance : LinearOrder EternalRatio :=
  LinearOrder.lift' toReal toReal_injective

instance : MetricSpace EternalRatio :=
  MetricSpace.induced toReal toReal_injective Real.metricSpace

@[simp] theorem le_iff_toReal_le (r s : EternalRatio) : r ≤ s ↔ toReal r ≤ toReal s := Iff.rfl

@[simp] theorem lt_iff_toReal_lt (r s : EternalRatio) : r < s ↔ toReal r < toReal s := Iff.rfl

theorem order_reflexive (r : EternalRatio) : r ≤ r := le_rfl

theorem order_antisymmetric {r s : EternalRatio} (hrs : r ≤ s) (hsr : s ≤ r) : r = s :=
  le_antisymm hrs hsr

theorem order_transitive {r s t : EternalRatio} (hrs : r ≤ s) (hst : s ≤ t) : r ≤ t :=
  le_trans hrs hst

theorem dist_eq (r s : EternalRatio) : dist r s = |toReal r - toReal s| := rfl

theorem metric_nonneg (r s : EternalRatio) : 0 ≤ dist r s := dist_nonneg

theorem metric_symmetry (r s : EternalRatio) : dist r s = dist s r := dist_comm r s

theorem metric_triangle (r s t : EternalRatio) : dist r t ≤ dist r s + dist s t :=
  dist_triangle r s t

theorem uniformContinuous_toReal : UniformContinuous toReal :=
  uniformContinuous_comap

theorem isUniformEmbedding_toReal : IsUniformEmbedding toReal :=
  isUniformEmbedding_comap toReal_injective

theorem surjective_toReal : Function.Surjective toReal := fun x => ⟨ofReal x, toReal_ofReal x⟩

noncomputable def uniformEquivReal : EternalRatio ≃ᵤ ℝ :=
  ringEquivReal.toEquiv.toUniformEquivOfIsUniformInducing isUniformEmbedding_toReal.isUniformInducing

theorem continuous_toReal : Continuous toReal :=
  uniformEquivReal.continuous

theorem continuous_ofReal : Continuous ofReal :=
  uniformEquivReal.symm.continuous

instance : OrderTopology EternalRatio :=
  induced_orderTopology toReal (fun {_ _} => Iff.rfl) <| by
    intro x y hxy
    refine ⟨ofReal ((x + y) / 2), ?_, ?_⟩
    · have : x < (x + y) / 2 := by linarith
      simpa [toReal_ofReal] using this
    · have : (x + y) / 2 < y := by linarith
      simpa [toReal_ofReal] using this

theorem completeSpace_iff_real : CompleteSpace EternalRatio ↔ CompleteSpace ℝ :=
  isUniformEmbedding_toReal.isUniformInducing.completeSpace_congr surjective_toReal

theorem complete : CompleteSpace EternalRatio :=
  completeSpace_iff_real.2 inferInstance

instance : CompleteSpace EternalRatio :=
  complete

theorem continuous_add : Continuous fun p : EternalRatio × EternalRatio => p.1 + p.2 := by
  change Continuous (fun p : EternalRatio × EternalRatio => ofReal (toReal p.1 + toReal p.2))
  exact continuous_ofReal.comp <|
    (continuous_toReal.comp continuous_fst).add (continuous_toReal.comp continuous_snd)

theorem continuous_mul : Continuous fun p : EternalRatio × EternalRatio => p.1 * p.2 := by
  change Continuous (fun p : EternalRatio × EternalRatio => ofReal (toReal p.1 * toReal p.2))
  exact continuous_ofReal.comp <|
    (continuous_toReal.comp continuous_fst).mul (continuous_toReal.comp continuous_snd)

end EternalRatio

end

end BalansisFormal
