-- Copyright (c) 2024-2026 Andrey Tikhonov (XTeam-Pro). All rights reserved.
-- This file is part of Balansis, dual-licensed under AGPLv3 / Commercial.
-- See LICENSE in the project root. Commercial use: andrew@xteam.pro
/- 
  BalansisFormal.AbsoluteValue — constructive core for ACT.

  `AbsoluteValue` stores a non-negative magnitude and a direction. The
  canonical zero representation forces the zero magnitude to use `pos`.

  All public statements A1–A5 are proved in this file.
-/
import Mathlib
import BalansisFormal.Direction

open scoped NNReal

namespace BalansisFormal

structure AbsoluteValue where
  magnitude : NNReal
  direction : Direction
  wf : magnitude = 0 → direction = .pos := by
    intro h
    rfl

noncomputable section

namespace AbsoluteValue

theorem eq_mk {a b : AbsoluteValue}
    (hmag : a.magnitude = b.magnitude) (hdir : a.direction = b.direction) : a = b := by
  cases a
  cases b
  simp_all

def toReal (a : AbsoluteValue) : ℝ :=
  a.direction.toReal * (a.magnitude : ℝ)

def fromReal (x : ℝ) : AbsoluteValue :=
  if hx : 0 ≤ x then
    { magnitude := ⟨x, hx⟩
      direction := .pos }
  else
    { magnitude := ⟨-x, by linarith [not_le.mp hx]⟩
      direction := .neg
      wf := by
        intro h
        have h' : (((⟨-x, by linarith [not_le.mp hx]⟩ : NNReal) : NNReal) : ℝ) = 0 := by
          exact congrArg (fun t : NNReal => (t : ℝ)) h
        have h'' : -x = 0 := by simpa using h'
        exfalso
        linarith [not_le.mp hx] }

instance : Zero AbsoluteValue := ⟨fromReal 0⟩
instance : One AbsoluteValue := ⟨fromReal 1⟩
instance : Neg AbsoluteValue := ⟨fun a => fromReal (-a.toReal)⟩
instance : Add AbsoluteValue := ⟨fun a b => fromReal (a.toReal + b.toReal)⟩
instance : Sub AbsoluteValue := ⟨fun a b => fromReal (a.toReal - b.toReal)⟩
instance : Mul AbsoluteValue := ⟨fun a b => fromReal (a.toReal * b.toReal)⟩
instance : Inv AbsoluteValue := ⟨fun a => fromReal (a.toReal)⁻¹⟩
instance : Div AbsoluteValue := ⟨fun a b => fromReal (a.toReal / b.toReal)⟩
instance : NatCast AbsoluteValue := ⟨fun n => fromReal n⟩
instance : IntCast AbsoluteValue := ⟨fun z => fromReal z⟩
instance : Pow AbsoluteValue Nat := ⟨fun a n => fromReal (a.toReal ^ n)⟩
instance : Pow AbsoluteValue Int := ⟨fun a n => fromReal (a.toReal ^ n)⟩
instance : SMul ℕ AbsoluteValue := ⟨fun n a => fromReal (n • a.toReal)⟩
instance : SMul ℤ AbsoluteValue := ⟨fun n a => fromReal (n • a.toReal)⟩

def absolute : AbsoluteValue := 0

def isAbsolute (a : AbsoluteValue) : Prop := a.magnitude = 0

theorem fromReal_toReal (x : ℝ) : (fromReal x).toReal = x := by
  unfold fromReal
  split
  · simp [toReal, Direction.toReal_pos]
  · simp [toReal, Direction.toReal_neg]

@[simp] theorem toReal_zero : (0 : AbsoluteValue).toReal = 0 :=
  fromReal_toReal 0

@[simp] theorem toReal_one : (1 : AbsoluteValue).toReal = 1 :=
  fromReal_toReal 1

@[simp] theorem toReal_neg (a : AbsoluteValue) : (-a).toReal = -a.toReal :=
  fromReal_toReal (-a.toReal)

@[simp] theorem toReal_add (a b : AbsoluteValue) : (a + b).toReal = a.toReal + b.toReal :=
  fromReal_toReal (a.toReal + b.toReal)

@[simp] theorem toReal_sub (a b : AbsoluteValue) : (a - b).toReal = a.toReal - b.toReal :=
  fromReal_toReal (a.toReal - b.toReal)

@[simp] theorem toReal_mul (a b : AbsoluteValue) : (a * b).toReal = a.toReal * b.toReal :=
  fromReal_toReal (a.toReal * b.toReal)

@[simp] theorem toReal_inv (a : AbsoluteValue) : (a⁻¹).toReal = (a.toReal)⁻¹ :=
  fromReal_toReal ((a.toReal)⁻¹)

@[simp] theorem toReal_div (a b : AbsoluteValue) : (a / b).toReal = a.toReal / b.toReal :=
  fromReal_toReal (a.toReal / b.toReal)

@[simp] theorem toReal_natCast (n : ℕ) : ((n : AbsoluteValue).toReal) = n :=
  fromReal_toReal n

@[simp] theorem toReal_intCast (z : ℤ) : ((z : AbsoluteValue).toReal) = z :=
  fromReal_toReal z

@[simp] theorem toReal_pow_nat (a : AbsoluteValue) (n : ℕ) : (a ^ n).toReal = a.toReal ^ n :=
  fromReal_toReal (a.toReal ^ n)

@[simp] theorem toReal_pow_int (a : AbsoluteValue) (n : ℤ) : (a ^ n).toReal = a.toReal ^ n :=
  fromReal_toReal (a.toReal ^ n)

@[simp] theorem toReal_nsmul (n : ℕ) (a : AbsoluteValue) : (n • a).toReal = n • a.toReal :=
  fromReal_toReal (n • a.toReal)

@[simp] theorem toReal_zsmul (n : ℤ) (a : AbsoluteValue) : (n • a).toReal = n • a.toReal :=
  fromReal_toReal (n • a.toReal)

theorem fromReal_of_toReal (a : AbsoluteValue) : fromReal a.toReal = a := by
  cases a with
  | mk magnitude direction wf =>
      cases direction with
      | pos =>
          apply eq_mk
          · apply Subtype.ext
            simp [toReal, fromReal, Direction.toReal_pos]
          · simp [toReal, fromReal, Direction.toReal_pos]
      | neg =>
          have hmag_ne : magnitude ≠ 0 := by
            intro h
            have hdir := wf h
            simp at hdir
          have hmag_pos : 0 < (magnitude : ℝ) := by
            exact_mod_cast (show 0 < magnitude from pos_iff_ne_zero.mpr hmag_ne)
          have hnot : ¬0 ≤ -(magnitude : ℝ) := by
            linarith
          apply eq_mk
          · apply Subtype.ext
            simp [toReal, fromReal, Direction.toReal_neg, hnot]
          · simp [toReal, fromReal, Direction.toReal_neg, hnot]

theorem toReal_injective : Function.Injective toReal := by
  intro a b h
  rw [← fromReal_of_toReal a, ← fromReal_of_toReal b, h]

theorem ext {a b : AbsoluteValue} (h : a.toReal = b.toReal) : a = b :=
  toReal_injective h

theorem isAbsolute_iff_toReal_zero (a : AbsoluteValue) : isAbsolute a ↔ a.toReal = 0 := by
  constructor
  · intro h
    cases a with
    | mk magnitude direction wf =>
        simp [isAbsolute, toReal] at h ⊢
        simp [h, wf h]
  · intro h
    cases a with
    | mk magnitude direction wf =>
        dsimp [isAbsolute, toReal] at h ⊢
        by_cases hmag : magnitude = 0
        · exact hmag
        · have hmag' : (magnitude : ℝ) ≠ 0 := by
            exact_mod_cast hmag
          cases direction <;> simp [Direction.toReal, hmag'] at h

theorem isAbsolute_iff_eq_zero (a : AbsoluteValue) : isAbsolute a ↔ a = 0 := by
  constructor
  · intro h
    apply toReal_injective
    rw [(isAbsolute_iff_toReal_zero a).1 h, toReal_zero]
  · intro h
    subst h
    simpa using (isAbsolute_iff_toReal_zero (0 : AbsoluteValue)).2 (by simp)

theorem nonzero_toReal_ne_zero {a : AbsoluteValue} (ha : a ≠ 0) : a.toReal ≠ 0 := by
  intro h
  exact ha ((isAbsolute_iff_eq_zero a).mp ((isAbsolute_iff_toReal_zero a).mpr h))

theorem fromReal_injective : Function.Injective fromReal := by
  intro x y h
  exact by simpa [fromReal_toReal x, fromReal_toReal y] using congrArg toReal h

theorem a1_exists_unique (x : ℝ) : ∃! a : AbsoluteValue, a.toReal = x := by
  refine ⟨fromReal x, fromReal_toReal x, ?_⟩
  intro a ha
  exact toReal_injective <| by simpa [fromReal_toReal x] using ha

theorem a2_nonneg (a : AbsoluteValue) : (0 : ℝ) ≤ (a.magnitude : ℝ) :=
  NNReal.coe_nonneg _

theorem a3_compensation (a b : AbsoluteValue)
    (hmag : a.magnitude = b.magnitude)
    (hdir : a.direction = b.direction.negate) : a + b = 0 := by
  apply toReal_injective
  have hsum : a.toReal + b.toReal = 0 := by
    cases a with
    | mk amag ad awf =>
        cases b with
        | mk bmag bd bwf =>
            cases ad <;> cases bd <;>
              simp_all [toReal, Direction.negate, Direction.toReal]
  simpa [toReal_add, toReal_zero] using hsum

theorem a4_additive_identity (a : AbsoluteValue) : a + 0 = a := by
  apply toReal_injective
  simp

theorem a4_additive_identity_left (a : AbsoluteValue) : (0 : AbsoluteValue) + a = a := by
  apply toReal_injective
  simp

theorem a5_direction_preservation (a : AbsoluteValue) (c : ℝ)
    (ha : a ≠ 0) (hc : 0 < c) :
    (fromReal (c * a.toReal)).direction = a.direction := by
  cases a with
  | mk magnitude direction wf =>
      cases direction with
      | pos =>
          have hnonneg : 0 ≤ c * (magnitude : ℝ) := by
            nlinarith [NNReal.coe_nonneg magnitude, hc]
          simp [toReal, fromReal, Direction.toReal_pos, hnonneg]
      | neg =>
          have hmag_ne : magnitude ≠ 0 := by
            intro h
            have hzero_mag : (0 : AbsoluteValue).magnitude = 0 := by
              change (fromReal 0).magnitude = 0
              simp [fromReal]
            apply ha
            apply eq_mk
            · calc
                magnitude = 0 := h
                _ = (0 : AbsoluteValue).magnitude := hzero_mag.symm
            · exfalso
              simpa using wf h
          have hmag_pos : 0 < (magnitude : ℝ) := by
            exact_mod_cast (show 0 < magnitude from pos_iff_ne_zero.mpr hmag_ne)
          have hcmag_pos : 0 < c * (magnitude : ℝ) := by
            nlinarith
          have hbranch : ¬c * (magnitude : ℝ) ≤ 0 := not_le.mpr hcmag_pos
          simp [toReal, fromReal, Direction.toReal_neg, hbranch]

instance : CommRing AbsoluteValue :=
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

noncomputable def ringEquivReal : AbsoluteValue ≃+* ℝ where
  toFun := toReal
  invFun := fromReal
  left_inv := fromReal_of_toReal
  right_inv := fromReal_toReal
  map_mul' := toReal_mul
  map_add' := toReal_add

noncomputable instance : Field AbsoluteValue :=
  (ringEquivReal.toMulEquiv.isField (Field.toIsField ℝ)).toField

theorem mul_ne_zero_of_ne_zero {a b : AbsoluteValue} (ha : a ≠ 0) (hb : b ≠ 0) : a * b ≠ 0 := by
  simpa using (mul_ne_zero ha hb : a * b ≠ (0 : AbsoluteValue))

abbrev NonzeroAbsoluteValue := Units AbsoluteValue

end AbsoluteValue

end

end BalansisFormal
