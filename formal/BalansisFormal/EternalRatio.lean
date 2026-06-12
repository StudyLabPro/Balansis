-- Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
-- This file is part of Balansis, dual-licensed under AGPLv3 / Commercial.
-- See LICENSE in the project root. Commercial use: andrew@xteam.pro
/- 
  BalansisFormal.EternalRatio — quotient model of structural ratios.

  The raw representatives are pairs `(numerator, denominator)` with a non-zero
  denominator. `EternalRatio` is the quotient by the standard cross-multiplication
  relation. All public statements E1–E4 are proved on the quotient itself.
-/
import Mathlib
import BalansisFormal.AbsoluteValue

set_option linter.dupNamespace false

namespace BalansisFormal

noncomputable section

namespace EternalRatio

open AbsoluteValue

structure RatioRep where
  numerator : AbsoluteValue
  denominator : AbsoluteValue
  den_nonzero : denominator ≠ 0

namespace RatioRep

def toReal (r : RatioRep) : ℝ :=
  r.numerator.toReal / r.denominator.toReal

def Rel (r s : RatioRep) : Prop :=
  r.numerator.toReal * s.denominator.toReal = s.numerator.toReal * r.denominator.toReal

theorem rel_iff_toReal_eq (r s : RatioRep) : Rel r s ↔ r.toReal = s.toReal := by
  have hr : r.denominator.toReal ≠ 0 := AbsoluteValue.nonzero_toReal_ne_zero r.den_nonzero
  have hs : s.denominator.toReal ≠ 0 := AbsoluteValue.nonzero_toReal_ne_zero s.den_nonzero
  unfold Rel toReal
  exact (div_eq_div_iff hr hs).symm

instance : Setoid RatioRep where
  r := Rel
  iseqv := by
    constructor
    · intro r
      exact (rel_iff_toReal_eq r r).2 rfl
    · intro r s hrs
      exact (rel_iff_toReal_eq s r).2 ((rel_iff_toReal_eq r s).1 hrs).symm
    · intro r s t hrs hst
      exact (rel_iff_toReal_eq r t).2 (((rel_iff_toReal_eq r s).1 hrs).trans ((rel_iff_toReal_eq s t).1 hst))

end RatioRep

abbrev EternalRatio := Quotient (inferInstance : Setoid RatioRep)

def mk (a b : AbsoluteValue) (hb : b ≠ 0) : EternalRatio :=
  Quotient.mk _ { numerator := a, denominator := b, den_nonzero := hb }

def toReal : EternalRatio → ℝ :=
  Quotient.lift RatioRep.toReal (fun r s h => (RatioRep.rel_iff_toReal_eq r s).1 h)

def ofReal (x : ℝ) : EternalRatio :=
  mk (AbsoluteValue.fromReal x) 1 one_ne_zero

theorem toReal_mk (a b : AbsoluteValue) (hb : b ≠ 0) :
    toReal (mk a b hb) = a.toReal / b.toReal := rfl

theorem toReal_ofReal (x : ℝ) : toReal (ofReal x) = x := by
  simp [ofReal, mk, toReal, RatioRep.toReal, AbsoluteValue.fromReal_toReal]

theorem ofReal_toReal (r : EternalRatio) : ofReal (toReal r) = r := by
  refine Quotient.inductionOn r ?_
  intro rep
  apply Quot.sound
  exact (RatioRep.rel_iff_toReal_eq _ _).2 <| by
    simpa [ofReal, mk, toReal, RatioRep.toReal] using
      AbsoluteValue.fromReal_toReal (rep.numerator.toReal / rep.denominator.toReal)

theorem toReal_injective : Function.Injective toReal := by
  intro r s h
  rw [← ofReal_toReal r, ← ofReal_toReal s, h]

theorem ext {r s : EternalRatio} (h : toReal r = toReal s) : r = s :=
  toReal_injective h

instance : Zero EternalRatio := ⟨ofReal 0⟩
instance : One EternalRatio := ⟨ofReal 1⟩
instance : Neg EternalRatio := ⟨fun r => ofReal (-toReal r)⟩
instance : Add EternalRatio := ⟨fun r s => ofReal (toReal r + toReal s)⟩
instance : Sub EternalRatio := ⟨fun r s => ofReal (toReal r - toReal s)⟩
instance : Mul EternalRatio := ⟨fun r s => ofReal (toReal r * toReal s)⟩
instance : Inv EternalRatio := ⟨fun r => ofReal (toReal r)⁻¹⟩
instance : Div EternalRatio := ⟨fun r s => ofReal (toReal r / toReal s)⟩
instance : NatCast EternalRatio := ⟨fun n => ofReal n⟩
instance : IntCast EternalRatio := ⟨fun z => ofReal z⟩
instance : Pow EternalRatio Nat := ⟨fun r n => ofReal (toReal r ^ n)⟩
instance : Pow EternalRatio Int := ⟨fun r n => ofReal (toReal r ^ n)⟩
instance : SMul ℕ EternalRatio := ⟨fun n r => ofReal (n • toReal r)⟩
instance : SMul ℤ EternalRatio := ⟨fun n r => ofReal (n • toReal r)⟩

def zero : EternalRatio := 0
def unity : EternalRatio := 1

@[simp] theorem toReal_zero : toReal (0 : EternalRatio) = 0 :=
  toReal_ofReal 0

@[simp] theorem toReal_one : toReal (1 : EternalRatio) = 1 :=
  toReal_ofReal 1

@[simp] theorem toReal_neg (r : EternalRatio) : toReal (-r) = -toReal r :=
  toReal_ofReal (-toReal r)

@[simp] theorem toReal_add (r s : EternalRatio) : toReal (r + s) = toReal r + toReal s :=
  toReal_ofReal (toReal r + toReal s)

@[simp] theorem toReal_sub (r s : EternalRatio) : toReal (r - s) = toReal r - toReal s :=
  toReal_ofReal (toReal r - toReal s)

@[simp] theorem toReal_mul (r s : EternalRatio) : toReal (r * s) = toReal r * toReal s :=
  toReal_ofReal (toReal r * toReal s)

@[simp] theorem toReal_inv (r : EternalRatio) : toReal r⁻¹ = (toReal r)⁻¹ :=
  toReal_ofReal ((toReal r)⁻¹)

@[simp] theorem toReal_div (r s : EternalRatio) : toReal (r / s) = toReal r / toReal s :=
  toReal_ofReal (toReal r / toReal s)

@[simp] theorem toReal_natCast (n : ℕ) : toReal (n : EternalRatio) = n :=
  toReal_ofReal n

@[simp] theorem toReal_intCast (z : ℤ) : toReal (z : EternalRatio) = z :=
  toReal_ofReal z

@[simp] theorem toReal_pow_nat (r : EternalRatio) (n : ℕ) : toReal (r ^ n) = toReal r ^ n :=
  toReal_ofReal (toReal r ^ n)

@[simp] theorem toReal_pow_int (r : EternalRatio) (n : ℤ) : toReal (r ^ n) = toReal r ^ n :=
  toReal_ofReal (toReal r ^ n)

@[simp] theorem toReal_nsmul (n : ℕ) (r : EternalRatio) : toReal (n • r) = n • toReal r :=
  toReal_ofReal (n • toReal r)

@[simp] theorem toReal_zsmul (n : ℤ) (r : EternalRatio) : toReal (n • r) = n • toReal r :=
  toReal_ofReal (n • toReal r)

instance : CommRing EternalRatio :=
  Function.Injective.commRing toReal toReal_injective
    toReal_zero
    toReal_one
    toReal_add
    toReal_mul
    toReal_neg
    toReal_sub
    toReal_nsmul
    toReal_zsmul
    toReal_pow_nat
    toReal_natCast
    toReal_intCast

noncomputable def ringEquivReal : EternalRatio ≃+* ℝ where
  toFun := toReal
  invFun := ofReal
  left_inv := ofReal_toReal
  right_inv := toReal_ofReal
  map_mul' := toReal_mul
  map_add' := toReal_add

noncomputable instance : Field EternalRatio :=
  (ringEquivReal.toMulEquiv.isField (Field.toIsField ℝ)).toField

theorem exists_rep (r : EternalRatio) : ∃ rep : RatioRep, Quotient.mk _ rep = r := by
  refine Quotient.inductionOn r ?_
  intro rep
  exact ⟨rep, rfl⟩

theorem rep_denominator_nonzero (rep : RatioRep) : rep.denominator ≠ 0 :=
  rep.den_nonzero

theorem e1_well_defined (a b : AbsoluteValue) (hb : b ≠ 0) :
    ∃! r : EternalRatio, toReal r = a.toReal / b.toReal := by
  refine ⟨mk a b hb, ?_, ?_⟩
  · exact toReal_mk a b hb
  · intro r hr
    apply toReal_injective
    simpa [toReal_mk] using hr

theorem e2_stability (r : EternalRatio) :
    ∃ rep : RatioRep, Quotient.mk _ rep = r ∧ rep.denominator ≠ 0 := by
  rcases exists_rep r with ⟨rep, hrep⟩
  exact ⟨rep, hrep, rep.den_nonzero⟩

theorem e3_multiplicative_identity (r : EternalRatio) : r * unity = r := by
  apply toReal_injective
  simp [unity]

theorem e3_multiplicative_identity_left (r : EternalRatio) : unity * r = r := by
  apply toReal_injective
  simp [unity]

theorem e4_inverse (r : EternalRatio) (hr : r ≠ 0) : r * r⁻¹ = unity := by
  apply toReal_injective
  have hreal : toReal r ≠ 0 := by
    intro h
    exact hr (toReal_injective <| by simpa using h)
  simp [unity, hreal]

theorem two_ne_zero_abs : (2 : AbsoluteValue) ≠ 0 := by
  intro h
  have hreal : (2 : AbsoluteValue).toReal = 0 := by
    simpa using congrArg AbsoluteValue.toReal h
  have htwo : (2 : AbsoluteValue).toReal = (2 : ℝ) := by
    simpa using (AbsoluteValue.toReal_natCast 2)
  have : (2 : ℝ) = 0 := by
    linarith
  norm_num at this

theorem one_eq_two_over_two :
    mk 1 (1 : AbsoluteValue) one_ne_zero =
      mk (2 : AbsoluteValue) (2 : AbsoluteValue) two_ne_zero_abs := by
  apply toReal_injective
  rw [toReal_mk, toReal_mk]
  have hleft : AbsoluteValue.toReal (1 : AbsoluteValue) / AbsoluteValue.toReal (1 : AbsoluteValue) = (1 : ℝ) := by
    norm_num [AbsoluteValue.toReal_natCast]
  have hright : AbsoluteValue.toReal (2 : AbsoluteValue) / AbsoluteValue.toReal (2 : AbsoluteValue) = (1 : ℝ) := by
    have htwo_ne : AbsoluteValue.toReal (2 : AbsoluteValue) ≠ 0 :=
      AbsoluteValue.nonzero_toReal_ne_zero two_ne_zero_abs
    field_simp [htwo_ne]
  exact hleft.trans hright.symm

end EternalRatio

end

end BalansisFormal
