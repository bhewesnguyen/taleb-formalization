import AuditRepairs.ParetoConditional
import Mathlib.Probability.Moments.Variance
import Mathlib.MeasureTheory.Function.L2Space

/-!
# The exact Pareto law: centered moments and the STD/MAD ratio (T021 slice)

Book: §4.4.2–4.4.4, eq. (4.14), printed p. 86 (PDF p. 100): for the Pareto law with minimum
value (and scale) `L` and density `αL^α x^{−α−1}`, the standard deviation is `√(α/(α−2)) · L/(α−1)`
and the ratio of standard deviation to mean absolute deviation is
`1/(2√(α−2) (α−1)^{α−1} α^{1/2−α})`.

Against Mathlib's pinned `paretoMeasure L α` (`L > 0`), using Stage A (moments) and Stage B
(threshold and excess laws):

* mean `m = αL/(α−1)` for `α > 1`, and `L < m`;
* the **centered mean absolute deviation** `∫ |x − m| = 2L(α−1)^{α−2}/α^{α−1}` for `α > 1`. Route:
  `|t| = 2 max t 0 − t` and `∫ (x − m) = 0` give `MAD = 2 ∫ max (x−m) 0`; the positive part is the
  upper-tail integral `∫_{x > m} (x − m)`, which equals `ν(Ioi m) · E[X − m | X > m]` through the
  definition of `cond` (`integral_smul_measure`); Stage B at `K = m` (legitimate because `m > L`)
  gives `E[X − m | X > m] = m/(α−1)` and Stage A gives `ν(Ioi m) = (L/m)^α`. No new density integral;
* **variance** `αL²/((α−1)²(α−2))` for `α > 2`, via `MemLp 2` (from Stage A's second raw moment) and
  Mathlib's `variance_eq_sub`; standard deviation `L/(α−1) · √(α/(α−2))`;
* the **STD/MAD ratio** `α^{α−1/2}/(2√(α−2)(α−1)^{α−1})` for `α > 2` (the book's (4.14) in inverted
  form), with `MAD > 0` proved before dividing;
* sanity values at `L = 1, α = 3`: mean `3/2`, variance `3/4`, MAD `4/9`.

The centered MAD is distinct from the raw absolute moment `E|X|^p` of Stage A (equal to the raw
moment on the positive support) and from a median absolute deviation. Gaussian and Student
moments, and the general MAD/STD comparisons of §4.4, are not touched.
-/

set_option autoImplicit false

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal ProbabilityTheory

namespace AuditPareto

variable {L α : ℝ}

/-! ### Mean -/

/-- The mean `αL/(α−1)` of `Pareto(L, α)` (meaningful for `α > 1`). -/
noncomputable def paretoMean (L α : ℝ) : ℝ := α * L / (α - 1)

theorem integral_id_paretoMeasure (hL : 0 < L) (hα1 : 1 < α) :
    ∫ x, x ∂(paretoMeasure L α) = paretoMean L α := by
  have h := integral_rpow_paretoMeasure hL (zero_lt_one.trans hα1) (p := 1) hα1
  simpa only [Real.rpow_one, paretoMean] using h

theorem integrable_id_paretoMeasure (hL : 0 < L) (hα1 : 1 < α) :
    Integrable (fun x : ℝ => x) (paretoMeasure L α) := by
  have h := (integrable_rpow_paretoMeasure_iff hL (zero_lt_one.trans hα1) 1).mpr hα1
  simpa only [Real.rpow_one] using h

theorem lt_paretoMean (hL : 0 < L) (hα1 : 1 < α) : L < paretoMean L α := by
  unfold paretoMean
  rw [lt_div_iff₀ (sub_pos.mpr hα1)]
  nlinarith

theorem paretoMean_pos (hL : 0 < L) (hα1 : 1 < α) : 0 < paretoMean L α := hL.trans (lt_paretoMean hL hα1)

/-! ### The positive part of the centered variable, through the threshold law -/

/-- `E[X − K | X > K] = K/(α−1)` for `L ≤ K`, `α > 1` (the excess mean, read on the conditional law). -/
theorem integral_sub_const_cond_paretoMeasure (hL : 0 < L) {K : ℝ} (hK : L ≤ K) (hα1 : 1 < α) :
    ∫ x, (x - K) ∂((paretoMeasure L α)[|Ioi K]) = K / (α - 1) := by
  have hα : 0 < α := zero_lt_one.trans hα1
  have hK0 : 0 < K := hL.trans_le hK
  rw [cond_paretoMeasure_Ioi hL hα hK]
  haveI : IsProbabilityMeasure (paretoMeasure K α) := isProbabilityMeasure_paretoMeasure hK0 hα
  rw [integral_sub (integrable_id_paretoMeasure hK0 hα1) (integrable_const _), integral_id_paretoMeasure hK0 hα1,
    integral_const, measureReal_univ_eq_one, one_smul, paretoMean]
  have : α - 1 ≠ 0 := (sub_pos.mpr hα1).ne'
  field_simp
  ring

/-- The unnormalised upper-tail integral is the tail mass times the conditional integral: this is the
definition `ν[|A] = (ν A)⁻¹ • ν.restrict A` read backwards. -/
theorem setIntegral_eq_measureReal_mul_integral_cond (ν : Measure ℝ) [IsFiniteMeasure ν] {A : Set ℝ}
    (hA : ν A ≠ 0) (f : ℝ → ℝ) :
    ∫ x in A, f x ∂ν = ν.real A * ∫ x, f x ∂(ν[|A]) := by
  rw [ProbabilityTheory.cond, integral_smul_measure, ENNReal.toReal_inv, smul_eq_mul, measureReal_def, ← mul_assoc,
    mul_inv_cancel₀ (ENNReal.toReal_ne_zero.mpr ⟨hA, measure_ne_top _ _⟩), one_mul]

/-- `∫ max (x − m) 0 dν = (L/m)^α · m/(α−1)`: the positive part of the centered variable. -/
theorem integral_posPart_paretoMeasure (hL : 0 < L) (hα1 : 1 < α) :
    ∫ x, max (x - paretoMean L α) 0 ∂(paretoMeasure L α) =
      (L / paretoMean L α) ^ α * (paretoMean L α / (α - 1)) := by
  have hα : 0 < α := zero_lt_one.trans hα1
  set m := paretoMean L α with hm
  have hLm : L ≤ m := (lt_paretoMean hL hα1).le
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  -- The positive part is the indicator of `Ioi m` applied to `x − m`.
  have hind : (fun x : ℝ => max (x - m) 0) = (Ioi m).indicator (fun x => x - m) := by
    ext x
    by_cases hx : m < x
    · rw [indicator_of_mem (mem_Ioi.mpr hx), max_eq_left (by linarith)]
    · rw [indicator_of_notMem (by simpa using hx), max_eq_right (by linarith [not_lt.mp hx])]
  rw [hind, integral_indicator measurableSet_Ioi,
    setIntegral_eq_measureReal_mul_integral_cond _ (paretoMeasure_Ioi_ne_zero hL hα hLm),
    integral_sub_const_cond_paretoMeasure hL hLm hα1]
  congr 1
  exact survival_paretoMeasure_of_le hL hα hLm

/-! ### The centered mean absolute deviation -/

/-- Closed form of the Pareto mean absolute deviation about the mean: `2L(α−1)^{α−2}/α^{α−1}`. -/
noncomputable def paretoMAD (L α : ℝ) : ℝ := 2 * L * (α - 1) ^ (α - 2) / α ^ (α - 1)

theorem abs_eq_two_mul_max_sub (t : ℝ) : |t| = 2 * max t 0 - t := by
  rcases le_total 0 t with h | h
  · rw [abs_of_nonneg h, max_eq_left h]
    ring
  · rw [abs_of_nonpos h, max_eq_right h]
    ring

/-- Exponent algebra for the MAD: `2 (L/m)^α · m/(α−1) = 2L(α−1)^{α−2}/α^{α−1}` with `m = αL/(α−1)`. -/
theorem paretoMAD_algebra (hL : 0 < L) (hα1 : 1 < α) :
    2 * ((L / paretoMean L α) ^ α * (paretoMean L α / (α - 1))) = paretoMAD L α := by
  have hα : 0 < α := zero_lt_one.trans hα1
  have ha : 0 < α - 1 := sub_pos.mpr hα1
  have hm : paretoMean L α = α * L / (α - 1) := rfl
  -- `L / m = (α−1)/α`.
  have e1 : L / paretoMean L α = (α - 1) / α := by
    rw [hm]
    field_simp
  rw [paretoMAD, e1, Real.div_rpow ha.le hα.le, hm]
  -- Now: `2 * ((α−1)^α / α^α * (α L/(α−1) / (α−1))) = 2 L (α−1)^(α−2) / α^(α−1)`.
  have e2 : (α - 1) ^ (α - 2) = (α - 1) ^ α / (α - 1) ^ 2 := by
    rw [Real.rpow_sub ha, Real.rpow_two]
  have e3 : α ^ (α - 1) = α ^ α / α := by
    rw [Real.rpow_sub hα, Real.rpow_one]
  rw [e2, e3]
  have hαα : 0 < α ^ α := Real.rpow_pos_of_pos hα α
  have haa : 0 < (α - 1) ^ α := Real.rpow_pos_of_pos ha α
  field_simp

/-- **Centered mean absolute deviation** of `Pareto(L, α)` for `α > 1`: `∫ |x − m| dν = paretoMAD L α`. -/
theorem integral_abs_sub_mean_paretoMeasure (hL : 0 < L) (hα1 : 1 < α) :
    ∫ x, |x - paretoMean L α| ∂(paretoMeasure L α) = paretoMAD L α := by
  have hα : 0 < α := zero_lt_one.trans hα1
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  have hid := integrable_id_paretoMeasure hL hα1
  have hsub : Integrable (fun x : ℝ => x - paretoMean L α) (paretoMeasure L α) := hid.sub (integrable_const _)
  have hpos : Integrable (fun x : ℝ => max (x - paretoMean L α) 0) (paretoMeasure L α) := hsub.pos_part
  -- `|x − m| = 2 max (x − m) 0 − (x − m)` pointwise.
  have hpt : (fun x : ℝ => |x - paretoMean L α|) =
      fun x => 2 * max (x - paretoMean L α) 0 - (x - paretoMean L α) := by
    ext x
    exact abs_eq_two_mul_max_sub _
  rw [hpt, integral_sub (hpos.const_mul 2) hsub, integral_const_mul, integral_sub hid (integrable_const _),
    integral_id_paretoMeasure hL hα1, integral_const, measureReal_univ_eq_one, one_smul, sub_self, sub_zero,
    integral_posPart_paretoMeasure hL hα1, paretoMAD_algebra hL hα1]

theorem paretoMAD_pos (hL : 0 < L) (hα1 : 1 < α) : 0 < paretoMAD L α := by
  have hα : 0 < α := zero_lt_one.trans hα1
  have ha : 0 < α - 1 := sub_pos.mpr hα1
  unfold paretoMAD
  have h1 : 0 < (α - 1) ^ (α - 2) := Real.rpow_pos_of_pos ha _
  have h2 : 0 < α ^ (α - 1) := Real.rpow_pos_of_pos hα _
  positivity

/-! ### Variance and standard deviation -/

theorem integrable_sq_paretoMeasure (hL : 0 < L) (hα2 : 2 < α) :
    Integrable (fun x : ℝ => x ^ 2) (paretoMeasure L α) := by
  have h := (integrable_rpow_paretoMeasure_iff hL (by linarith) 2).mpr hα2
  simpa only [Real.rpow_two] using h

theorem memLp_two_id_paretoMeasure (hL : 0 < L) (hα2 : 2 < α) :
    MemLp (fun x : ℝ => x) 2 (paretoMeasure L α) :=
  (memLp_two_iff_integrable_sq measurable_id.aestronglyMeasurable).mpr (integrable_sq_paretoMeasure hL hα2)

theorem integral_sq_paretoMeasure (hL : 0 < L) (hα2 : 2 < α) :
    ∫ x, x ^ 2 ∂(paretoMeasure L α) = α * L ^ 2 / (α - 2) := by
  have h := integral_rpow_paretoMeasure hL (by linarith) (p := 2) hα2
  simpa only [Real.rpow_two] using h

/-- Closed form of the variance for `α > 2`. -/
noncomputable def paretoVariance (L α : ℝ) : ℝ := α * L ^ 2 / ((α - 1) ^ 2 * (α - 2))

/-- **Variance** of `Pareto(L, α)` for `α > 2`, through Mathlib's `variance` and `variance_eq_sub`. -/
theorem variance_id_paretoMeasure (hL : 0 < L) (hα2 : 2 < α) :
    Var[fun x : ℝ => x; paretoMeasure L α] = paretoVariance L α := by
  have hα : 0 < α := by linarith
  have hα1 : 1 < α := by linarith
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  rw [variance_eq_sub (memLp_two_id_paretoMeasure hL hα2)]
  have h2 : ∫ x, ((fun x : ℝ => x) ^ 2) x ∂(paretoMeasure L α) = α * L ^ 2 / (α - 2) := by
    simpa only [Pi.pow_apply] using integral_sq_paretoMeasure hL hα2
  rw [h2, integral_id_paretoMeasure hL hα1, paretoMean, paretoVariance]
  have h1 : α - 1 ≠ 0 := by linarith
  have h3 : α - 2 ≠ 0 := by linarith
  field_simp
  ring

/-- Standard deviation: the nonnegative square root of the variance. -/
noncomputable def paretoStd (L α : ℝ) : ℝ := Real.sqrt (Var[fun x : ℝ => x; paretoMeasure L α])

/-- `STD = L/(α−1) · √(α/(α−2))` for `α > 2` (the book's display on p. 86). -/
theorem paretoStd_eq (hL : 0 < L) (hα2 : 2 < α) :
    paretoStd L α = L / (α - 1) * Real.sqrt (α / (α - 2)) := by
  have hα : 0 < α := by linarith
  have ha : 0 < α - 1 := by linarith
  have hb : 0 < α - 2 := by linarith
  rw [paretoStd, variance_id_paretoMeasure hL hα2, paretoVariance]
  have e : α * L ^ 2 / ((α - 1) ^ 2 * (α - 2)) = (L / (α - 1)) ^ 2 * (α / (α - 2)) := by
    field_simp
  rw [e, Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq (div_pos hL ha).le]

/-! ### The STD/MAD ratio (4.14) -/

/-- `STD/MAD = α^{α−1/2} / (2 √(α−2) (α−1)^{α−1})` for `α > 2`; the book prints the reciprocal form
`1/(2√(α−2)(α−1)^{α−1} α^{1/2−α})`. -/
theorem paretoStd_div_paretoMAD (hL : 0 < L) (hα2 : 2 < α) :
    paretoStd L α / paretoMAD L α = α ^ (α - 1 / 2) / (2 * Real.sqrt (α - 2) * (α - 1) ^ (α - 1)) := by
  have hα : 0 < α := by linarith
  have hα1 : 1 < α := by linarith
  have ha : 0 < α - 1 := by linarith
  have hb : 0 < α - 2 := by linarith
  rw [paretoStd_eq hL hα2, paretoMAD, Real.sqrt_div hα.le, Real.sqrt_eq_rpow α]
  have e1 : (α - 1) ^ (α - 1) = (α - 1) ^ (α - 2) * (α - 1) := by
    rw [← Real.rpow_add_one ha.ne', show α - 2 + 1 = α - 1 by ring]
  have e2 : α ^ (α - 1 / 2) = α ^ (1 / (2 : ℝ)) * α ^ (α - 1) := by
    rw [← Real.rpow_add hα, show 1 / (2 : ℝ) + (α - 1) = α - 1 / 2 by ring]
  rw [e1, e2]
  have h1 : 0 < (α - 1) ^ (α - 2) := Real.rpow_pos_of_pos ha _
  have h2 : 0 < α ^ (α - 1) := Real.rpow_pos_of_pos hα _
  have h3 : 0 < Real.sqrt (α - 2) := Real.sqrt_pos.mpr hb
  have h4 : 0 < α ^ (1 / (2 : ℝ)) := Real.rpow_pos_of_pos hα _
  field_simp

/-! ### Sanity values at `L = 1`, `α = 3` -/

theorem paretoMean_one_three : paretoMean 1 3 = 3 / 2 := by
  unfold paretoMean
  norm_num

theorem paretoVariance_one_three : paretoVariance 1 3 = 3 / 4 := by
  unfold paretoVariance
  norm_num

theorem paretoMAD_one_three : paretoMAD 1 3 = 4 / 9 := by
  unfold paretoMAD
  rw [show (3 : ℝ) - 1 = 2 by norm_num, show (3 : ℝ) - 2 = 1 by norm_num, Real.rpow_one,
    show (3 : ℝ) ^ (2 : ℝ) = 9 by rw [Real.rpow_two]; norm_num]
  norm_num

end AuditPareto

#print axioms AuditPareto.integral_id_paretoMeasure
#print axioms AuditPareto.integral_posPart_paretoMeasure
#print axioms AuditPareto.integral_abs_sub_mean_paretoMeasure
#print axioms AuditPareto.variance_id_paretoMeasure
#print axioms AuditPareto.paretoStd_eq
#print axioms AuditPareto.paretoStd_div_paretoMAD
#print axioms AuditPareto.paretoMAD_one_three
