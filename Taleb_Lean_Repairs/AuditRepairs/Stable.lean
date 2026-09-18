import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.Convex.SpecificFunctions.Basic
import Mathlib.Data.Real.Sign
import Mathlib.Topology.Algebra.Order.Field


set_option autoImplicit false

/- Audit repairs, compiled in the Lean 4.24.0 / Mathlib v4.24.0 audit harness.
   The original tangent-only function is retained for algebraic comparisons.
   The final section defines a separate, corrected S1 expression. -/

namespace StableAudit

noncomputable def stableExpr (α β μ σ : ℝ) (t : ℝ) : ℂ :=
  let r : ℝ := |σ * t| ^ α
  let w : ℝ := Real.tan (Real.pi * α / 2) * Real.sign t
  Complex.exp ⟨-r, μ * t + r * β * w⟩

-- Corrected Proof12: μ = 0 and scale = σ, in that order.
theorem gaussian_specialization {σ t : ℝ} :
    stableExpr 2 0 0 σ t = Complex.exp ⟨-((σ * t) ^ 2), 0⟩ := by
  simp [stableExpr, mul_pow]

-- Strengthening: at α = 2 the skewness parameter disappears.
theorem gaussian_specialization_general {β μ σ t : ℝ} :
    stableExpr 2 β μ σ t = Complex.exp ⟨-((σ * t) ^ 2), μ * t⟩ := by
  simp [stableExpr, mul_pow]

-- Exact counterexample to submitted Proof12, at σ = t = 1.
theorem submitted_gaussian_counterexample :
    stableExpr 2 0 1 0 1 ≠ Complex.exp ⟨-((1 : ℝ) ^ 2), 0⟩ := by
  intro h
  have hnorm := congrArg (fun z : ℂ => ‖z‖) h
  have hc : (1 : ℝ) = Real.exp (-1) := by
    simpa [stableExpr, Complex.norm_exp] using hnorm
  have hlt : Real.exp (-1) < 1 :=
    Real.exp_lt_one_iff.mpr (by norm_num)
  exact (ne_of_gt hlt) hc

-- Original Proof13 argument, with explicit grouping and a redundant tactic removed.
theorem gaussian_stable_real {σ t : ℝ} (n : ℕ) :
    (Real.exp (-((σ * t) ^ 2))) ^ n
      = Real.exp (-((((n : ℝ) ^ (1 / 2 : ℝ)) * σ * t) ^ 2)) := by
  rw [← Real.exp_nat_mul]
  congr 1
  have hn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
  have h1 : (((n : ℝ) ^ (1 / 2 : ℝ)) * σ * t) ^ 2 = n * (σ * t) ^ 2 := by
    have h2 : ((n : ℝ) ^ (1 / 2 : ℝ)) ^ 2 = n := by
      rw [← Real.sqrt_eq_rpow, Real.sq_sqrt hn]
    calc (((n : ℝ) ^ (1 / 2 : ℝ)) * σ * t) ^ 2
        = ((n : ℝ) ^ (1 / 2 : ℝ)) ^ 2 * (σ * t) ^ 2 := by ring
      _ = n * (σ * t) ^ 2 := by rw [h2]
  rw [h1]
  ring

-- Optional shorter Proof13; the original argument is already sound.
theorem gaussian_stable_real_short {σ t : ℝ} (n : ℕ) :
    (Real.exp (-((σ * t) ^ 2))) ^ n
      = Real.exp (-((((n : ℝ) ^ (1 / 2 : ℝ)) * σ * t) ^ 2)) := by
  rw [← Real.exp_nat_mul, ← Real.sqrt_eq_rpow]
  congr 1
  simp only [mul_pow, Real.sq_sqrt (Nat.cast_nonneg n)]
  ring

-- Corrected Proof14. Nonnegative scale suffices, including Dirac scale zero.
theorem cauchy_specialization {σ t : ℝ} (hσ : 0 ≤ σ) :
    stableExpr 1 0 0 σ t = Complex.exp ⟨-(σ * |t|), 0⟩ := by
  simp [stableExpr, Real.rpow_one, abs_mul, abs_of_nonneg hσ]

-- Exact counterexample to submitted Proof14, satisfying σ > 0.
theorem submitted_cauchy_counterexample :
    stableExpr 1 0 1 0 1 ≠ Complex.exp ⟨-((1 : ℝ) * |1|), 0⟩ := by
  intro h
  have hnorm := congrArg (fun z : ℂ => ‖z‖) h
  have hc : (1 : ℝ) = Real.exp (-1) := by
    simpa [stableExpr, Complex.norm_exp] using hnorm
  have hlt : Real.exp (-1) < 1 :=
    Real.exp_lt_one_iff.mpr (by norm_num)
  exact (ne_of_gt hlt) hc

-- Original Proof15 argument, with a redundant tactic removed.
theorem cauchy_stable {σ t : ℝ} (n : ℕ) :
    (Real.exp (-(σ * |t|))) ^ n = Real.exp (-((n * σ) * |t|)) := by
  rw [← Real.exp_nat_mul]
  congr 1
  ring

-- Simplification candidate for Proof15, using the existing exponential law.
theorem cauchy_stable_short {σ t : ℝ} (n : ℕ) :
    (Real.exp (-(σ * |t|))) ^ n = Real.exp (-((n * σ) * |t|)) := by
  simpa [mul_neg, mul_assoc] using (Real.exp_nat_mul (-(σ * |t|)) n).symm

-- Original Proof16 algebra, retaining its actual scope and renamed function.
theorem stableExpr_power {α β μ σ : ℝ} (n : ℕ) (t : ℝ)
    (hα : 0 < α) :
    (stableExpr α β μ σ t) ^ n
      = stableExpr α β (n * μ) ((n : ℝ) ^ (1/α) * σ) t := by
  have hn : (0:ℝ) ≤ (n:ℝ) := Nat.cast_nonneg n
  have hα0 : α ≠ 0 := ne_of_gt hα
  have key : |((n:ℝ)^(1/α) * σ) * t| ^ α = n * |σ * t| ^ α := by
    have h1 : |(n:ℝ)^(1/α)| = (n:ℝ)^(1/α) :=
      abs_of_nonneg (Real.rpow_nonneg hn _)
    have e1 : |((n:ℝ)^(1/α) * σ) * t| = (n:ℝ)^(1/α) * (|σ| * |t|) := by
      rw [abs_mul, abs_mul, h1]; ring
    rw [e1, Real.mul_rpow (Real.rpow_nonneg hn _)
      (mul_nonneg (abs_nonneg _) (abs_nonneg _)),
      ← Real.rpow_mul hn, show (1/α : ℝ) * α = 1 by field_simp,
      Real.rpow_one, ← abs_mul]
  unfold stableExpr
  dsimp only
  rw [← Complex.exp_nat_mul, key]
  congr 1
  apply Complex.ext <;> simp
  ring

-- Diagnostic: the submitted α = 1 formula loses every skewness parameter.
theorem submitted_alpha_one_ignores_skew {β μ σ t : ℝ} :
    stableExpr 1 β μ σ t = Complex.exp ⟨-|σ * t|, μ * t⟩ := by
  simp [stableExpr, Real.rpow_one]

-- Correct S1 expression. Existence of a law is a separate theorem.
noncomputable def stableS1Expr (α β μ σ t : ℝ) : ℂ :=
  let r : ℝ := |σ * t| ^ α
  let phase : ℝ := if α = 1 then -(2 / Real.pi) * Real.log |t|
    else Real.tan (Real.pi * α / 2)
  Complex.exp ⟨-r, μ * t + r * β * phase * Real.sign t⟩

-- This repairs the α = 1 expression, while remaining an algebraic theorem.
-- Valid parameter bounds and a measure/characteristic-function bridge are
-- required before concluding a theorem about probability distributions.
theorem stableS1Expr_power {α β μ σ : ℝ} (n : ℕ) (t : ℝ)
    (hα : 0 < α) :
    (stableS1Expr α β μ σ t) ^ n
      = stableS1Expr α β (n * μ) ((n : ℝ) ^ (1 / α) * σ) t := by
  have hn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
  have hα0 : α ≠ 0 := ne_of_gt hα
  have key : |((n : ℝ) ^ (1 / α) * σ) * t| ^ α = n * |σ * t| ^ α := by
    have h1 : |(n : ℝ) ^ (1 / α)| = (n : ℝ) ^ (1 / α) :=
      abs_of_nonneg (Real.rpow_nonneg hn _)
    have e1 : |((n : ℝ) ^ (1 / α) * σ) * t|
        = (n : ℝ) ^ (1 / α) * (|σ| * |t|) := by
      rw [abs_mul, abs_mul, h1]
      ring
    rw [e1, Real.mul_rpow (Real.rpow_nonneg hn _)
      (mul_nonneg (abs_nonneg _) (abs_nonneg _)),
      ← Real.rpow_mul hn, show (1 / α : ℝ) * α = 1 by field_simp,
      Real.rpow_one, ← abs_mul]
  unfold stableS1Expr
  dsimp only
  rw [← Complex.exp_nat_mul, key]
  congr 1
  by_cases hα1 : α = 1 <;> apply Complex.ext <;> simp [hα1] <;> ring

structure StableParameters where
  alpha : ℝ
  beta : ℝ
  location : ℝ
  scale : ℝ
  alpha_pos : 0 < alpha
  alpha_le_two : alpha ≤ 2
  beta_bounds : -1 ≤ beta ∧ beta ≤ 1
  scale_nonneg : 0 ≤ scale

/-- Gaussian specialization of the repaired S1 expression. -/
theorem stableS1Expr_gaussian {β μ σ t : ℝ} :
    stableS1Expr 2 β μ σ t = Complex.exp ⟨-((σ * t) ^ 2), μ * t⟩ := by
  simp [stableS1Expr, mul_pow]

/-- Centered Cauchy specialization of the repaired S1 expression. -/
theorem stableS1Expr_cauchy {σ t : ℝ} (hσ : 0 ≤ σ) :
    stableS1Expr 1 0 0 σ t = Complex.exp ⟨-(σ * |t|), 0⟩ := by
  simp [stableS1Expr, Real.rpow_one, abs_mul, abs_of_nonneg hσ]

/-- The repaired expression has characteristic-function normalization at zero. -/
theorem stableS1Expr_at_zero {α β μ σ : ℝ} (hα : 0 < α) :
    stableS1Expr α β μ σ 0 = 1 := by
  simp only [stableS1Expr, mul_zero, abs_zero, Real.zero_rpow (ne_of_gt hα),
    neg_zero, zero_mul, add_zero]
  exact Complex.exp_zero

/- Probability-level targets still needed:
   1. A probability measure with characteristic function stableS1Expr p.
   The Mathlib multiplication and uniqueness theorems are now used in
   AuditRepairs.ProbabilityBridge. That module proves the conditional convolution
   power identification, but does not construct the stable laws themselves.
   Scale zero above denotes the Dirac measure; α = 1 with β ≠ 0 must use
   the logarithmic branch. No unproved probability claim is declared here. -/

end StableAudit

#print axioms StableAudit.gaussian_specialization
#print axioms StableAudit.gaussian_specialization_general
#print axioms StableAudit.submitted_gaussian_counterexample
#print axioms StableAudit.gaussian_stable_real
#print axioms StableAudit.gaussian_stable_real_short
#print axioms StableAudit.cauchy_specialization
#print axioms StableAudit.submitted_cauchy_counterexample
#print axioms StableAudit.cauchy_stable
#print axioms StableAudit.cauchy_stable_short
#print axioms StableAudit.stableExpr_power
#print axioms StableAudit.submitted_alpha_one_ignores_skew
#print axioms StableAudit.stableS1Expr_power
