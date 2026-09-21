import AuditRepairs.ParetoLaw
import AuditRepairs.ExtremeValueAffine
import Mathlib.Probability.ConditionalProbability

/-!
# The exact Pareto law: conditioning, excess and positive powers (Stage B)

Backlog slices: T005 (exact-Pareto conditional/excess law and means) and T032 (exact-Pareto
positive-power pushforward as an equality of laws). Sources: eq. (2.10) printed p. 18 (PDF 32,
proof p. 260 / PDF 274) for the tail-integral and excess identities; Property 5.2 and eq. (5.8),
printed p. 100 (PDF 114), for the power transformation.

Everything is stated for Mathlib's pinned `paretoMeasure L α` (`L > 0`, `α > 0`) and reuses the
pinned conditioning API `ProbabilityTheory.cond μ s = (μ s)⁻¹ • μ.restrict s` (notation `μ[|s]`)
and the location/scale pushforward `AuditEVTLaws.affineLaw` of v0.2.6:

* **threshold law**: for `L ≤ K`, `(paretoMeasure L α)[|Ioi K] = paretoMeasure K α` — an equality
  of probability measures (through `Measure.eq_of_cdf`); `K = L` is included because the law has
  no atom at `L`, so the conditioning event has probability one there;
* **excess law**: `excessLaw L α K := affineLaw ((paretoMeasure L α)[|Ioi K]) (−K) 1`, the law of
  `X − K` given `X > K`, with cdf `0` for `y < 0`, `1 − (K/(K+y))^α` for `y ≥ 0` and strict survival
  `1` for `y < 0`, `(K/(K+y))^α` for `y ≥ 0` (value `1` at `y = 0`);
* **positive powers**: for `q > 0`, `(paretoMeasure L α).map (· ^ q) = paretoMeasure (L^q) (α/q)`
  — an equality of laws, proved on the positive support (the totalized real power on negative
  bases never enters: the law has no mass below `L > 0`);
* **means** (from Stage A, since the conditional law *is* `Pareto(K, α)`): for `α > 1`,
  `E[X | X > K] = αK/(α−1)` and the mean excess `E[X − K | X > K] = K/(α−1)`, kept distinct; for
  `α ≤ 1` the conditional first moment diverges as an extended nonnegative integral.

Not claimed: the general tail-integral identity (2.10) for arbitrary nonnegative laws, conditional
formulas for other laws, or any power with `q ≤ 0`.
-/

set_option autoImplicit false

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal ProbabilityTheory

namespace AuditPareto

variable {L α K q : ℝ}

/-! ### Measure values in `ℝ≥0∞` form, from Stage A -/

theorem paretoMeasure_Ioi (hL : 0 < L) (hα : 0 < α) {x : ℝ} (hx : L ≤ x) :
    paretoMeasure L α (Ioi x) = ENNReal.ofReal ((L / x) ^ α) := by
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  have h : (paretoMeasure L α).real (Ioi x) = (L / x) ^ α := survival_paretoMeasure_of_le hL hα hx
  rw [measureReal_def] at h
  rw [← h, ENNReal.ofReal_toReal (measure_ne_top _ _)]

theorem paretoMeasure_Ioi_ne_zero (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) :
    paretoMeasure L α (Ioi K) ≠ 0 := by
  rw [paretoMeasure_Ioi hL hα hK]
  exact (ENNReal.ofReal_pos.mpr (Real.rpow_pos_of_pos (div_pos hL (hL.trans_le hK)) α)).ne'

/-! ### Conditioning above a threshold -/

theorem isProbabilityMeasure_cond_paretoMeasure (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) :
    IsProbabilityMeasure ((paretoMeasure L α)[|Ioi K]) := by
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  exact cond_isProbabilityMeasure (paretoMeasure_Ioi_ne_zero hL hα hK)

/-- The cdf of the law of `X` given `X > K`: `0` below `K`, `1 − (K/x)^α` from `K` on. -/
theorem cdf_cond_paretoMeasure (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) (x : ℝ) :
    cdf ((paretoMeasure L α)[|Ioi K]) x = if x < K then 0 else 1 - (K / x) ^ α := by
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  haveI := isProbabilityMeasure_cond_paretoMeasure hL hα hK
  have hK0 : 0 < K := hL.trans_le hK
  have hS : (paretoMeasure L α).real (Ioi K) = (L / K) ^ α := survival_paretoMeasure_of_le hL hα hK
  rw [cdf_eq_real, measureReal_def, cond_apply measurableSet_Ioi, ENNReal.toReal_mul,
    ENNReal.toReal_inv, Ioi_inter_Iic, ← measureReal_def, ← measureReal_def, hS]
  split_ifs with hx
  · rw [Ioc_eq_empty (not_lt.mpr hx.le)]
    simp
  · have hx' : K ≤ x := not_lt.mp hx
    have hIoc : Ioc K x = Iic x \ Iic K := by
      ext y
      simp only [mem_Ioc, mem_diff, mem_Iic, not_le]
      constructor <;> rintro ⟨h1, h2⟩ <;> exact ⟨by linarith, by linarith⟩
    rw [hIoc, measureReal_diff (Iic_subset_Iic.mpr hx') measurableSet_Iic, ← cdf_eq_real,
      ← cdf_eq_real, cdf_paretoMeasure hL hα, cdf_paretoMeasure hL hα,
      if_neg (not_lt.mpr (hK.trans hx')), if_neg (not_lt.mpr hK)]
    have hLK : 0 < (L / K) ^ α := Real.rpow_pos_of_pos (div_pos hL hK0) α
    have hx0 : 0 < x := hK0.trans_le hx'
    have e : (L / x) ^ α / (L / K) ^ α = (K / x) ^ α := by
      rw [← Real.div_rpow (by positivity) (by positivity)]
      congr 1
      field_simp
    rw [inv_mul_eq_div, sub_sub_sub_cancel_left, sub_div, div_self hLK.ne', e]

/-- **Threshold law.** For `L ≤ K`, the law of `X` given `X > K` is `Pareto(K, α)`, as an equality
of probability measures. `K = L` is included: the conditioning event has probability one. -/
theorem cond_paretoMeasure_Ioi (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) :
    (paretoMeasure L α)[|Ioi K] = paretoMeasure K α := by
  have hK0 : 0 < K := hL.trans_le hK
  haveI := isProbabilityMeasure_cond_paretoMeasure hL hα hK
  haveI : IsProbabilityMeasure (paretoMeasure K α) := isProbabilityMeasure_paretoMeasure hK0 hα
  refine Measure.eq_of_cdf _ _ (StieltjesFunction.ext fun x => ?_)
  rw [cdf_cond_paretoMeasure hL hα hK, cdf_paretoMeasure hK0 hα]

/-- The endpoint case: conditioning on `X > L` changes nothing (no atom at `L`). -/
theorem cond_paretoMeasure_Ioi_endpoint (hL : 0 < L) (hα : 0 < α) :
    (paretoMeasure L α)[|Ioi L] = paretoMeasure L α :=
  cond_paretoMeasure_Ioi hL hα le_rfl

/-! ### The excess law -/

/-- The law of the excess `X − K` given `X > K`: the conditional law pushed forward by `x ↦ x − K`
(`affineLaw ν (−K) 1`). -/
noncomputable def excessLaw (L α K : ℝ) : Measure ℝ :=
  AuditEVTLaws.affineLaw ((paretoMeasure L α)[|Ioi K]) (-K) 1

theorem excessLaw_eq (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) :
    excessLaw L α K = AuditEVTLaws.affineLaw (paretoMeasure K α) (-K) 1 := by
  rw [excessLaw, cond_paretoMeasure_Ioi hL hα hK]

theorem isProbabilityMeasure_excessLaw (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) :
    IsProbabilityMeasure (excessLaw L α K) := by
  haveI := isProbabilityMeasure_cond_paretoMeasure hL hα hK
  exact AuditEVTLaws.affineLaw_isProbabilityMeasure _ _ _

/-- cdf of the excess: `0` for `y < 0`, `1 − (K/(K+y))^α` for `y ≥ 0`. -/
theorem cdf_excessLaw (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) (y : ℝ) :
    cdf (excessLaw L α K) y = if y < 0 then 0 else 1 - (K / (K + y)) ^ α := by
  have hK0 : 0 < K := hL.trans_le hK
  haveI : IsProbabilityMeasure (paretoMeasure K α) := isProbabilityMeasure_paretoMeasure hK0 hα
  rw [excessLaw_eq hL hα hK, AuditEVTLaws.cdf_affineLaw one_pos, cdf_paretoMeasure hK0 hα,
    sub_neg_eq_add, div_one]
  by_cases hy : y < 0
  · rw [if_pos (by linarith), if_pos hy]
  · rw [if_neg (by linarith), if_neg hy, add_comm]

/-- Strict survival of the excess: `1` for `y < 0` (including the value `1` at `y = 0` from the
other branch), `(K/(K+y))^α` for `y ≥ 0`. -/
theorem survival_excessLaw (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) (y : ℝ) :
    AuditProbability.survival (excessLaw L α K) y = if y < 0 then 1 else (K / (K + y)) ^ α := by
  haveI := isProbabilityMeasure_excessLaw hL hα hK
  have h : AuditProbability.survival (excessLaw L α K) y = 1 - cdf (excessLaw L α K) y := by
    rw [cdf_eq_real, AuditProbability.survival, ← compl_Iic, measureReal_compl measurableSet_Iic,
      measureReal_univ_eq_one]
  rw [h, cdf_excessLaw hL hα hK]
  split_ifs <;> simp

theorem survival_excessLaw_zero (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) :
    AuditProbability.survival (excessLaw L α K) 0 = 1 := by
  have hK0 : 0 < K := hL.trans_le hK
  rw [survival_excessLaw hL hα hK, if_neg (lt_irrefl 0), add_zero, div_self hK0.ne', Real.one_rpow]

/-! ### Conditional means (for `α > 1`) and their divergence (for `α ≤ 1`) -/

/-- Conditional moments are Stage A moments of `Pareto(K, α)`. -/
theorem integral_rpow_cond_paretoMeasure (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K) {p : ℝ}
    (hp : p < α) :
    ∫ x, x ^ p ∂((paretoMeasure L α)[|Ioi K]) = α * K ^ p / (α - p) := by
  rw [cond_paretoMeasure_Ioi hL hα hK]
  exact integral_rpow_paretoMeasure (hL.trans_le hK) hα hp

/-- `E[X | X > K] = αK/(α − 1)` for `α > 1`. -/
theorem integral_id_cond_paretoMeasure (hL : 0 < L) (hK : L ≤ K) (hα1 : 1 < α) :
    ∫ x, x ∂((paretoMeasure L α)[|Ioi K]) = α * K / (α - 1) := by
  have h := integral_rpow_cond_paretoMeasure hL (zero_lt_one.trans hα1) hK hα1
  simpa only [Real.rpow_one] using h

/-- Mean excess `E[X − K | X > K] = K/(α − 1)` for `α > 1` — distinct from the conditional mean. -/
theorem integral_id_excessLaw (hL : 0 < L) (hK : L ≤ K) (hα1 : 1 < α) :
    ∫ y, y ∂(excessLaw L α K) = K / (α - 1) := by
  have hα : 0 < α := zero_lt_one.trans hα1
  have hK0 : 0 < K := hL.trans_le hK
  haveI : IsProbabilityMeasure (paretoMeasure K α) := isProbabilityMeasure_paretoMeasure hK0 hα
  have hint : Integrable (fun x : ℝ => x) (paretoMeasure K α) := by
    have h := (integrable_rpow_paretoMeasure_iff hK0 hα 1).mpr hα1
    simpa only [Real.rpow_one] using h
  rw [excessLaw_eq hL hα hK, AuditEVTLaws.affineLaw,
    integral_map (f := fun y : ℝ => y) (AuditEVTLaws.measurable_affine (-K) 1).aemeasurable
      measurable_id.aestronglyMeasurable]
  simp only [one_mul]
  rw [integral_add (integrable_const _) hint, integral_const, measureReal_univ_eq_one, one_smul]
  have h1 : ∫ x, x ∂(paretoMeasure K α) = α * K / (α - 1) := by
    have h := integral_rpow_paretoMeasure hK0 hα (p := 1) hα1
    simpa only [Real.rpow_one] using h
  rw [h1]
  have : α - 1 ≠ 0 := (sub_pos.mpr hα1).ne'
  field_simp
  ring

/-- For `α ≤ 1` the conditional first moment diverges, as an extended nonnegative integral. -/
theorem lintegral_id_cond_paretoMeasure_eq_top (hL : 0 < L) (hα : 0 < α) (hK : L ≤ K)
    (hα1 : α ≤ 1) :
    ∫⁻ x, ENNReal.ofReal x ∂((paretoMeasure L α)[|Ioi K]) = ⊤ := by
  rw [cond_paretoMeasure_Ioi hL hα hK]
  have h := momentLintegral_eq_top (hL.trans_le hK) hα (p := 1) hα1
  rw [momentLintegral] at h
  simpa only [Real.rpow_one] using h

/-! ### Positive powers -/

/-- The law charges only its support: `μ A = μ (A ∩ Ici L)`. -/
theorem paretoMeasure_apply_inter_Ici (A : Set ℝ) :
    paretoMeasure L α A = paretoMeasure L α (A ∩ Ici L) := by
  have hsub : A \ Ici L ⊆ Iio L := by
    intro y hy
    rw [mem_diff, mem_Ici] at hy
    rw [mem_Iio]
    exact not_le.mp hy.2
  have hnull : paretoMeasure L α (A \ Ici L) = 0 :=
    measure_mono_null hsub (paretoMeasure_Iio_endpoint (L := L) (α := α))
  rw [← measure_inter_add_diff A measurableSet_Ici, hnull, add_zero]

/-- Below `L^q` no point of the support has `y^q ≤ x`. -/
theorem preimage_rpow_Iic_inter_Ici_eq_empty (hL : 0 < L) (hq : 0 < q) {x : ℝ} (hx : x < L ^ q) :
    (fun y : ℝ => y ^ q) ⁻¹' Iic x ∩ Ici L = ∅ := by
  ext y
  simp only [mem_inter_iff, mem_preimage, mem_Iic, mem_Ici, mem_empty_iff_false, iff_false, not_and]
  intro hyx hy
  have : L ^ q ≤ y ^ q := Real.rpow_le_rpow hL.le hy hq.le
  linarith

/-- From `L^q` on, the support part of `{y | y^q ≤ x}` is `[L, x^{1/q}]`, written as
`Iic (x^{1/q}) \ Iio L` so that the null set `Iio L` can be dropped. -/
theorem preimage_rpow_Iic_inter_Ici (hL : 0 < L) (hq : 0 < q) {x : ℝ} (hx : L ^ q ≤ x) :
    (fun y : ℝ => y ^ q) ⁻¹' Iic x ∩ Ici L = Iic (x ^ q⁻¹) \ Iio L := by
  have hx0 : 0 ≤ x := (Real.rpow_pos_of_pos hL q).le.trans hx
  ext y
  simp only [mem_inter_iff, mem_preimage, mem_Iic, mem_Ici, mem_diff, mem_Iio, not_lt]
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨(Real.le_rpow_inv_iff_of_pos (hL.le.trans h2) hx0 hq).mpr h1, h2⟩
  · rintro ⟨h1, h2⟩
    exact ⟨(Real.le_rpow_inv_iff_of_pos (hL.le.trans h2) hx0 hq).mp h1, h2⟩

/-- Exponent algebra: `(L / x^{1/q})^α = (L^q / x)^{α/q}` for `x ≥ 0`. -/
theorem pareto_power_algebra (hL : 0 < L) (hq : 0 < q) {x : ℝ} (hx0 : 0 ≤ x) (α : ℝ) :
    (L / x ^ q⁻¹) ^ α = (L ^ q / x) ^ (α / q) := by
  have hLq : 0 ≤ L ^ q := (Real.rpow_pos_of_pos hL q).le
  have e1 : L / x ^ q⁻¹ = (L ^ q / x) ^ q⁻¹ := by
    rw [Real.div_rpow hLq hx0, Real.rpow_rpow_inv hL.le hq.ne']
  rw [e1, ← Real.rpow_mul (div_nonneg hLq hx0), inv_mul_eq_div]

/-- **Power law.** For `q > 0`, `X^q` is `Pareto(L^q, α/q)`, as an equality of laws. The preimage
computation is carried out on the support `[L, ∞) ⊆ (0, ∞)`, where `y ↦ y^q` is monotone with
inverse `x ↦ x^{1/q}`; below `L` the law has no mass, so the totalized power never matters. -/
theorem map_rpow_paretoMeasure (hL : 0 < L) (hα : 0 < α) (hq : 0 < q) :
    (paretoMeasure L α).map (fun x : ℝ => x ^ q) = paretoMeasure (L ^ q) (α / q) := by
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  have hLq : 0 < L ^ q := Real.rpow_pos_of_pos hL q
  have hαq : 0 < α / q := div_pos hα hq
  haveI : IsProbabilityMeasure (paretoMeasure (L ^ q) (α / q)) :=
    isProbabilityMeasure_paretoMeasure hLq hαq
  have hm : Measurable fun x : ℝ => x ^ q := measurable_id.pow_const q
  haveI : IsProbabilityMeasure ((paretoMeasure L α).map fun x : ℝ => x ^ q) :=
    Measure.isProbabilityMeasure_map hm.aemeasurable
  refine Measure.eq_of_cdf _ _ (StieltjesFunction.ext fun x => ?_)
  rw [cdf_eq_real, measureReal_def, Measure.map_apply hm measurableSet_Iic,
    paretoMeasure_apply_inter_Ici, cdf_paretoMeasure hLq hαq]
  split_ifs with hx
  · rw [preimage_rpow_Iic_inter_Ici_eq_empty hL hq hx]
    simp
  · have hx' : L ^ q ≤ x := not_lt.mp hx
    have hx0 : 0 ≤ x := hLq.le.trans hx'
    have hLt : L ≤ x ^ q⁻¹ := (Real.le_rpow_inv_iff_of_pos hL.le hx0 hq).mpr hx'
    rw [preimage_rpow_Iic_inter_Ici hL hq hx',
      measure_diff_null (paretoMeasure_Iio_endpoint (L := L) (α := α)), ← measureReal_def,
      ← cdf_eq_real, cdf_paretoMeasure hL hα, if_neg (not_lt.mpr hLt), pareto_power_algebra hL hq hx0]

/-- Sanity corollary of the power law: the moment threshold of `X^q` is `p·q < α`, i.e. the
`p`-th moment of `X^q` is finite exactly when `p < α/q` (Stage A applied to the identified law). -/
theorem integrable_rpow_map_rpow_paretoMeasure_iff (hL : 0 < L) (hα : 0 < α) (hq : 0 < q)
    (p : ℝ) :
    Integrable (fun x : ℝ => x ^ p) ((paretoMeasure L α).map fun x : ℝ => x ^ q) ↔ p < α / q := by
  rw [map_rpow_paretoMeasure hL hα hq]
  exact integrable_rpow_paretoMeasure_iff (Real.rpow_pos_of_pos hL q) (div_pos hα hq) p

end AuditPareto

#print axioms AuditPareto.cond_paretoMeasure_Ioi
#print axioms AuditPareto.cdf_excessLaw
#print axioms AuditPareto.survival_excessLaw
#print axioms AuditPareto.integral_id_cond_paretoMeasure
#print axioms AuditPareto.integral_id_excessLaw
#print axioms AuditPareto.lintegral_id_cond_paretoMeasure_eq_top
#print axioms AuditPareto.map_rpow_paretoMeasure
#print axioms AuditPareto.integrable_rpow_map_rpow_paretoMeasure_iff
