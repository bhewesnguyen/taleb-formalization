import AuditRepairs.ProbabilityBridge
import Mathlib.Probability.Distributions.Gaussian.Real

/-!
# Gaussian instantiation of the stable bridge (backlog family T046)

`AuditProbability.stableS1_convolutionPower_eq` (the Proof16 replacement) is
conditional: it takes two probability measures together with the identities
between their characteristic functions and the S1 expression as premises. This
module shows that those premises are satisfiable, using Mathlib's Gaussian law:

* `charFun_gaussianReal_eq_stableS1Expr`: when `v = 2σ²`, `N(μ, v)` has characteristic
  function `stableS1Expr 2 β μ σ` (any `β`; the skewness parameter is irrelevant at
  `α = 2`). Only this direction is proved; a pointwise converse would be false (all
  these functions equal `1` at `t = 0`), and a converse quantified over all `t` is
  not needed here. The zero-scale case `σ = 0`, `v = 0` (Dirac mass at
  `μ`) is included because Mathlib's `charFun_gaussianReal` needs no `v ≠ 0`.
* `convolutionPower_gaussianReal_scale`: the bridge theorem applied to
  `N(m, 2σ²)` identifies its `n`-fold convolution power as `N(n m, 2 (n^{1/2} σ)²)`.
* `convolutionPower_gaussianReal`: the same in the variance parameterisation,
  `N(m, v)^{*n} = N(n m, n v)`.

Book anchor: Section 7.2.1, printed p. 140 (PDF p. 154): "the Gaussian … with
α = 2" and "χ(t)^n is the same form as χ(t), with µ → nµ and σ → n^{1/α}σ".
Scale convention (docs/SOURCE_GATES.md G05, REPLACEMENT_MAP row 12): the S1
scale `σ` corresponds to Gaussian variance `2σ²`, not `σ²`.

Mathlib already proves Gaussian convolution closure directly
(`gaussianReal_conv_gaussianReal`); the point here is not a new closure proof
but the non-vacuity of the conditional stable-law theorem at `α = 2`, which was
listed as open in the v0.2.1/v0.2.2 reviews.
-/

set_option autoImplicit false

open MeasureTheory ProbabilityTheory
open scoped NNReal

namespace AuditGaussian

/-- Gaussian variance corresponding to S1 scale `σ` at `α = 2`: `v = 2σ²`. -/
noncomputable def varianceOfScale (σ : ℝ) : ℝ≥0 := ⟨2 * σ ^ 2, by positivity⟩

@[simp]
theorem coe_varianceOfScale (σ : ℝ) : ((varianceOfScale σ : ℝ≥0) : ℝ) = 2 * σ ^ 2 := rfl

/-- When `v = 2σ²`, `N(μ, v)` has the S1 characteristic function at `α = 2` with scale `σ`
(one direction only). Any skewness `β` is allowed since `tan π = 0`. -/
theorem charFun_gaussianReal_eq_stableS1Expr {v : ℝ≥0} {μ σ β : ℝ}
    (hv : (v : ℝ) = 2 * σ ^ 2) (t : ℝ) :
    charFun (gaussianReal μ v) t = StableAudit.stableS1Expr 2 β μ σ t := by
  rw [charFun_gaussianReal, StableAudit.stableS1Expr_gaussian]
  congr 1
  apply Complex.ext
  · simp [pow_two, hv]
    ring
  · simp [pow_two]
    ring

/-- The admissible S1 parameter tuple of the Gaussian law `N(μ, 2σ²)`. -/
def gaussianParameters (μ σ : ℝ) (hσ : 0 ≤ σ) : StableAudit.StableParameters where
  alpha := 2
  beta := 0
  location := μ
  scale := σ
  alpha_pos := by norm_num
  alpha_le_two := le_rfl
  beta_bounds := by norm_num
  scale_nonneg := hσ

/-- Non-vacuity of the conditional stable convolution theorem at `α = 2`: both
characteristic-function premises of `stableS1_convolutionPower_eq` are satisfied by
Gaussian laws, and the theorem then identifies the `n`-fold convolution power of
`N(m, 2σ²)` as `N(n m, 2 (n^{1/2} σ)²)`. -/
theorem convolutionPower_gaussianReal_scale (m σ : ℝ) (hσ : 0 ≤ σ) (n : ℕ) :
    AuditProbability.convolutionPower (gaussianReal m (varianceOfScale σ)) n
      = gaussianReal (n * m) (varianceOfScale ((n : ℝ) ^ (1 / (2 : ℝ)) * σ)) := by
  refine AuditProbability.stableS1_convolutionPower_eq (gaussianParameters m σ hσ) n ?_ ?_
  · intro t
    exact charFun_gaussianReal_eq_stableS1Expr (coe_varianceOfScale σ) t
  · intro t
    exact charFun_gaussianReal_eq_stableS1Expr (coe_varianceOfScale _) t

/-- Variance form: `N(m, v)^{*n} = N(n m, n v)`, obtained through the stable bridge with
`σ = √(v/2)`. (Mathlib's `gaussianReal_conv_gaussianReal` gives the same result by
direct induction; this route exercises the S1 interface.) -/
theorem convolutionPower_gaussianReal (m : ℝ) (v : ℝ≥0) (n : ℕ) :
    AuditProbability.convolutionPower (gaussianReal m v) n = gaussianReal (n * m) (n * v) := by
  set σ : ℝ := Real.sqrt ((v : ℝ) / 2) with hσdef
  have hσ : 0 ≤ σ := Real.sqrt_nonneg _
  have hσsq : σ ^ 2 = (v : ℝ) / 2 := by
    rw [hσdef, Real.sq_sqrt (by positivity)]
  have hv : varianceOfScale σ = v := by
    ext
    rw [coe_varianceOfScale, hσsq]
    ring
  have hnv : varianceOfScale ((n : ℝ) ^ (1 / (2 : ℝ)) * σ) = n * v := by
    ext
    rw [coe_varianceOfScale, mul_pow, hσsq, ← Real.sqrt_eq_rpow, Real.sq_sqrt (Nat.cast_nonneg n),
      NNReal.coe_mul, NNReal.coe_natCast]
    ring
  calc AuditProbability.convolutionPower (gaussianReal m v) n
      = AuditProbability.convolutionPower (gaussianReal m (varianceOfScale σ)) n := by rw [hv]
    _ = gaussianReal (n * m) (varianceOfScale ((n : ℝ) ^ (1 / (2 : ℝ)) * σ)) :=
        convolutionPower_gaussianReal_scale m σ hσ n
    _ = gaussianReal (n * m) (n * v) := by rw [hnv]

end AuditGaussian

#print axioms AuditGaussian.charFun_gaussianReal_eq_stableS1Expr
#print axioms AuditGaussian.convolutionPower_gaussianReal_scale
#print axioms AuditGaussian.convolutionPower_gaussianReal
