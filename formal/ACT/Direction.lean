/- 
  ACT.Direction — public sign theory facade.
-/
import BalansisFormal.Direction

namespace ACT

abbrev Direction := BalansisFormal.Direction

namespace Direction

abbrev negate := BalansisFormal.Direction.negate
abbrev mul := BalansisFormal.Direction.mul
abbrev toReal := BalansisFormal.Direction.toReal

theorem negate_involutive (d : Direction) : negate (negate d) = d :=
  BalansisFormal.Direction.negate_involutive d

theorem mul_comm (d₁ d₂ : Direction) : mul d₁ d₂ = mul d₂ d₁ :=
  BalansisFormal.Direction.mul_comm d₁ d₂

theorem mul_assoc (d₁ d₂ d₃ : Direction) :
    mul (mul d₁ d₂) d₃ = mul d₁ (mul d₂ d₃) :=
  BalansisFormal.Direction.mul_assoc d₁ d₂ d₃

end Direction

end ACT
