import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.Convex.SpecificFunctions.Basic
import Mathlib.Data.Real.Sign
import Mathlib.Topology.Algebra.Order.Field
import Mathlib.Topology.Order.LiminfLimsup


set_option autoImplicit false

/- Repairs for Proof07-Proof11, checked in the pinned Lean 4.24.0 / Mathlib v4.24.0 audit environment. -/
namespace AuditTails

open Filter Topology

noncomputable def tailExponentReal (S : ℝ → ℝ) : ℝ :=
  Filter.liminf (fun x => -Real.log (S x) / Real.log x) atTop

/-- A restricted finite-index API, making existence and logarithm validity explicit. -/
def HasFiniteTailExponent (S : ℝ → ℝ) (α : ℝ) : Prop :=
  (∀ᶠ x in atTop, 0 < S x) ∧
    Tendsto (fun x => -Real.log (S x) / Real.log x) atTop (𝓝 α)

/-- Finite log-ratio limit for a positive multiple of a real power.
The analytic identity does not require a positive exponent. -/
theorem pareto_log_ratio_tendsto {C α : ℝ} (hC : 0 < C) :
    Tendsto (fun x => -Real.log (C * x ^ (-α)) / Real.log x) atTop (𝓝 α) := by
  have e : (fun x => -Real.log (C * x ^ (-α)) / Real.log x) =ᶠ[atTop]
      (fun x => α + -Real.log C / Real.log x) := by
    filter_upwards [eventually_gt_atTop 1] with x hx
    have hx0 : (0 : ℝ) < x := lt_trans zero_lt_one hx
    have hxα : x ^ (-α) ≠ 0 := ne_of_gt (Real.rpow_pos_of_pos hx0 _)
    have hlogx : Real.log x ≠ 0 := ne_of_gt (Real.log_pos hx)
    rw [Real.log_mul (ne_of_gt hC) hxα, Real.log_rpow hx0]
    field_simp [hlogx]
    ring
  have hdiv : Tendsto (fun x : ℝ => -Real.log C / Real.log x) atTop (𝓝 0) :=
    tendsto_const_nhds.div_atTop Real.tendsto_log_atTop
  have hadd : Tendsto (fun x : ℝ => α + -Real.log C / Real.log x)
      atTop (𝓝 (α + 0)) := tendsto_const_nhds.add hdiv
  exact Tendsto.congr' e.symm (by simpa only [add_zero] using hadd)

theorem pareto_hasFiniteTailExponent {C α : ℝ} (hC : 0 < C) :
    HasFiniteTailExponent (fun x => C * x ^ (-α)) α := by
  refine ⟨?_, pareto_log_ratio_tendsto hC⟩
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  exact mul_pos hC (Real.rpow_pos_of_pos hx _)

/-- The missing equality corollary for the package's finite real-valued definition. -/
theorem tailExponentReal_pareto {C α : ℝ} (hC : 0 < C) :
    tailExponentReal (fun x => C * x ^ (-α)) = α :=
  (pareto_log_ratio_tendsto hC).liminf_eq

/-- A diagnostic: totalized `Real.log` assigns exponent zero to an identically zero tail. -/
theorem tailExponentReal_zero : tailExponentReal (fun _ => 0) = 0 := by
  simp [tailExponentReal]

/-- Another diagnostic: real-valued liminf turns divergence to positive infinity into zero. -/
theorem real_liminf_of_tendsto_atTop {f : ℝ → ℝ} (hf : Tendsto f atTop atTop) :
    Filter.liminf f atTop = 0 := by
  rw [Filter.liminf_eq]
  have e : {a : ℝ | ∀ᶠ x in atTop, a ≤ f x} = Set.univ := by
    ext a
    simp only [Set.mem_setOf_eq, Set.mem_univ, iff_true]
    exact hf.eventually (eventually_ge_atTop a)
  rw [e, Real.sSup_univ]

/-- Transport a finite log-ratio limit across a nonzero finite tail-ratio limit.
This is an analytic relation, independent of a convolution model. -/
theorem tail_log_ratio_of_ratio_tendsto {S T : ℝ → ℝ} {α k : ℝ}
    (hk : k ≠ 0)
    (hratio : Tendsto (fun x => T x / S x) atTop (𝓝 k))
    (hS : Tendsto (fun x => -Real.log (S x) / Real.log x) atTop (𝓝 α))
    (hTnz : ∀ᶠ x in atTop, T x ≠ 0)
    (hSnz : ∀ᶠ x in atTop, S x ≠ 0) :
    Tendsto (fun x => -Real.log (T x) / Real.log x) atTop (𝓝 α) := by
  have e : (fun x => -Real.log (T x) / Real.log x) =ᶠ[atTop]
      (fun x => -Real.log (T x / S x) / Real.log x +
        -Real.log (S x) / Real.log x) := by
    filter_upwards [hTnz, hSnz] with x hxT hxS
    rw [Real.log_div hxT hxS]
    ring
  have hlog : Tendsto (fun x => Real.log (T x / S x)) atTop (𝓝 (Real.log k)) :=
    (Real.continuousAt_log hk).tendsto.comp hratio
  have hzero : Tendsto (fun x => -Real.log (T x / S x) / Real.log x)
      atTop (𝓝 0) := hlog.neg.div_atTop Real.tendsto_log_atTop
  exact Tendsto.congr' e.symm (by simpa only [zero_add] using hzero.add hS)

/-- Version of Proof08 with explicit tail-ratio language. -/
theorem subexponential_ratio_tailExponent {S T : ℝ → ℝ} {α : ℝ}
    (hratio : Tendsto (fun x => T x / S x) atTop (𝓝 2))
    (hS : Tendsto (fun x => -Real.log (S x) / Real.log x) atTop (𝓝 α))
    (hTnz : ∀ᶠ x in atTop, T x ≠ 0)
    (hSpos : ∀ᶠ x in atTop, 0 < S x) :
    Tendsto (fun x => -Real.log (T x) / Real.log x) atTop (𝓝 α) := by
  exact tail_log_ratio_of_ratio_tendsto (by norm_num : (2 : ℝ) ≠ 0)
    hratio hS hTnz (hSpos.mono fun _ hx => ne_of_gt hx)

/-- A direct Jensen proof, compatible with Mathlib 4.24.0. -/
theorem convexOn_rpow_neg_right {c : ℝ} (hc : 0 < c) :
    ConvexOn ℝ Set.univ (fun α : ℝ => c ^ (-α)) := by
  have e : (fun α : ℝ => c ^ (-α)) =
      (fun α : ℝ => Real.exp ((-Real.log c) * α)) := by
    funext α
    rw [Real.rpow_def_of_pos hc]
    congr 1
    ring
  rw [e]
  refine ⟨convex_univ, ?_⟩
  intro x _ y _ a b ha hb hab
  have h := convexOn_exp.2 (Set.mem_univ ((-Real.log c) * x))
    (Set.mem_univ ((-Real.log c) * y)) ha hb hab
  simp only [smul_eq_mul] at h ⊢
  convert h using 1
  congr 1
  ring

/-- Analytic Fréchet formula; the name explicitly avoids asserting global CDF properties. -/
noncomputable def frechetFormula (ξ x : ℝ) : ℝ :=
  Real.exp (-(x ^ (-1 / ξ)))

/-- Boundary diagnostic: Lean's totalized real power gives `0 ^ (-1/ξ) = 0` for
`ξ ≠ 0`, so the raw formula evaluates to `exp 0 = 1` at `x = 0`, where a Fréchet
distribution function must be `0` (book §9.1, printed p. 173: `G(x) = 0` for
`x ≤ b_n`). This is why `frechetCDF` below is defined piecewise. -/
theorem frechetFormula_zero {ξ : ℝ} (hξ : ξ ≠ 0) : frechetFormula ξ 0 = 1 := by
  have h : (-1 / ξ : ℝ) ≠ 0 := div_ne_zero (by norm_num) hξ
  simp [frechetFormula, Real.zero_rpow h]

/-- A genuine global Fréchet CDF formula when `0 < ξ`. -/
noncomputable def frechetCDF (ξ x : ℝ) : ℝ :=
  if 0 < x then frechetFormula ξ x else 0

theorem frechet_formula_maxstable {ξ : ℝ} (hξ : 0 < ξ)
    {x : ℝ} (hx : 0 < x) (n : ℕ) :
    (frechetFormula ξ x) ^ n = frechetFormula ξ ((n : ℝ) ^ (-ξ) * x) := by
  simp only [frechetFormula]
  have hn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
  have e : ((n : ℝ) ^ (-ξ) * x) ^ (-1 / ξ) = n * x ^ (-1 / ξ) := by
    rw [Real.mul_rpow (Real.rpow_nonneg hn _) (le_of_lt hx)]
    have h1 : ((n : ℝ) ^ (-ξ)) ^ (-1 / ξ) = n := by
      have hξ0 : ξ ≠ 0 := ne_of_gt hξ
      rw [← Real.rpow_mul hn]
      have h2 : (-ξ) * (-1 / ξ) = 1 := by field_simp
      rw [h2, Real.rpow_one]
    rw [h1]
  rw [e, ← Real.exp_nat_mul]
  congr 1
  ring

/-- Global formula with positive sample size; unlike the raw formula this excludes the
artificial totalization case at sample size zero. -/
theorem frechet_cdf_maxstable {ξ : ℝ} (hξ : 0 < ξ) (x : ℝ)
    (n : ℕ) (hn : 0 < n) :
    (frechetCDF ξ x) ^ n = frechetCDF ξ ((n : ℝ) ^ (-ξ) * x) := by
  have hnR : (0 : ℝ) < n := Nat.cast_pos.mpr hn
  have ha : 0 < (n : ℝ) ^ (-ξ) := Real.rpow_pos_of_pos hnR _
  by_cases hx : 0 < x
  · have hy : 0 < (n : ℝ) ^ (-ξ) * x := mul_pos ha hx
    simpa only [frechetCDF, if_pos hx, if_pos hy] using
      frechet_formula_maxstable hξ hx n
  · have hy : ¬0 < (n : ℝ) ^ (-ξ) * x :=
      not_lt_of_ge (mul_nonpos_of_nonneg_of_nonpos ha.le (le_of_not_gt hx))
    simp [frechetCDF, hx, hy, Nat.ne_of_gt hn]

noncomputable def gumbelCDF (x : ℝ) : ℝ :=
  Real.exp (-Real.exp (-x))

/-- Original Proof11 retained: its sign and positive sample-size hypothesis are correct. -/
theorem gumbel_maxstable {x : ℝ} (n : ℕ) (hn : 0 < n) :
    (gumbelCDF x) ^ n = gumbelCDF (x - Real.log n) := by
  simp only [gumbelCDF]
  have hn0 : (0 : ℝ) < n := Nat.cast_pos.mpr hn
  have e : Real.exp (-(x - Real.log n)) = n * Real.exp (-x) := by
    have h1 : -(x - Real.log n) = -x + Real.log n := by ring
    rw [h1, Real.exp_add, Real.exp_log hn0]
    ring
  rw [e, ← Real.exp_nat_mul]
  congr 1
  ring

end AuditTails

#print axioms AuditTails.pareto_log_ratio_tendsto
#print axioms AuditTails.pareto_hasFiniteTailExponent
#print axioms AuditTails.tailExponentReal_pareto
#print axioms AuditTails.tailExponentReal_zero
#print axioms AuditTails.real_liminf_of_tendsto_atTop
#print axioms AuditTails.tail_log_ratio_of_ratio_tendsto
#print axioms AuditTails.subexponential_ratio_tailExponent
#print axioms AuditTails.convexOn_rpow_neg_right
#print axioms AuditTails.frechetFormula_zero
#print axioms AuditTails.frechet_formula_maxstable
#print axioms AuditTails.frechet_cdf_maxstable
#print axioms AuditTails.gumbel_maxstable
