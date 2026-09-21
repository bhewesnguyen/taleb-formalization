import AuditRepairs.WeightedSums
import Mathlib.Probability.Distributions.Pareto
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

/-!
# The exact Pareto law: support, distribution functions and moments (Stage A)

Backlog slices: T021 (exact-Pareto moments), T028 (exact-Pareto survival/cdf), and the first
concrete instance of the T029 weighted-sum theorem. Source: the Pareto survival `(L/x)^α` and the
moment threshold `p < α` are used throughout the book (e.g. §3.2, §4, §8); the specific pages are
recorded in the ledger rows.

This module works against **Mathlib's pinned law** `ProbabilityTheory.paretoMeasure L α =
volume.withDensity (paretoPDF L α)` with density `α L^α x^{−(α+1)}` on `[L, ∞)` — no parallel
Pareto measure is introduced. For `L > 0`, `α > 0`:

* support: `paretoMeasure L α (Iic x) = 0` for `x < L`, no atom at `L`;
* strict survival `P(X > x) = 1` for `x < L` and `(L/x)^α` for `x ≥ L` (value `1` at `x = L`);
  cdf `0` for `x < L` and `1 − (L/x)^α` for `x ≥ L` (value `0` at `x = L`);
* the `p`-th moment as an **extended nonnegative integral** `∫⁻ x, ofReal (x^p)`: equal to
  `ofReal (α L^p/(α − p))` when `p < α`, and equal to `⊤` when `α ≤ p` (including the boundary
  `p = α`, where the density-weighted integrand is `α L^α x^{−1}`);
* the real integral `∫ x, x^p = α L^p/(α − p)` for `p < α` (and `= 1` at `p = 0`), with
  `Integrable (fun x => x^p) (paretoMeasure L α) ↔ p < α`; absolute moments agree because the
  law lives on `[L, ∞) ⊆ (0, ∞)`;
* the survival function of the actual law has finite log-tail exponent `α`, so the T029 theorem
  applies to coordinates with Pareto laws (`hasFiniteTailExponent_weightedSum_pareto`).

A totalized real integral is never used as evidence of finiteness: finiteness is read off the
extended integral, and the real formula is derived only inside the integrable range.
-/

set_option autoImplicit false

open MeasureTheory ProbabilityTheory Filter Topology Set
open scoped ENNReal

namespace AuditPareto

variable {L α : ℝ}

/-! ### Support -/

/-- Below the endpoint the law has no mass. -/
theorem paretoMeasure_Iic_of_lt {x : ℝ} (hx : x < L) : paretoMeasure L α (Iic x) = 0 := by
  rw [paretoMeasure, withDensity_apply _ measurableSet_Iic,
    setLIntegral_congr_fun measurableSet_Iic
      (fun y (hy : y ≤ x) => paretoPDF_of_lt (lt_of_le_of_lt hy hx))]
  simp

theorem paretoMeasure_Iio_endpoint : paretoMeasure L α (Iio L) = 0 := by
  rw [paretoMeasure, withDensity_apply _ measurableSet_Iio]
  exact lintegral_paretoPDF_of_le le_rfl

/-- No atom at the endpoint (the law is absolutely continuous). -/
theorem paretoMeasure_singleton_endpoint : paretoMeasure L α {L} = 0 :=
  withDensity_absolutelyContinuous volume _ (Real.volume_singleton)

theorem measurable_paretoPDF (L α : ℝ) : Measurable (paretoPDF L α) :=
  (measurable_paretoPDFReal L α).ennreal_ofReal

/-! ### Survival and distribution functions -/

/-- Tail algebra: `α L^α · ∫_x^∞ y^{−(α+1)} dy = (L/x)^α` for `x > 0`. -/
theorem pareto_tail_algebra (hL : 0 < L) (hα : 0 < α) {x : ℝ} (hx : 0 < x) :
    α * L ^ α * (-x ^ (-(α + 1) + 1) / (-(α + 1) + 1)) = (L / x) ^ α := by
  have hxα : 0 < x ^ α := Real.rpow_pos_of_pos hx α
  rw [show -(α + 1) + 1 = -α by ring, Real.rpow_neg hx.le, Real.div_rpow hL.le hx.le]
  field_simp

/-- The strict survival function `P(X > x)`: `1` below the endpoint (including at `x = L`,
where the formula also gives `(L/L)^α = 1`), `(L/x)^α` above it. -/
theorem survival_paretoMeasure (hL : 0 < L) (hα : 0 < α) (x : ℝ) :
    AuditProbability.survival (paretoMeasure L α) x = if x < L then 1 else (L / x) ^ α := by
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  unfold AuditProbability.survival
  split_ifs with hx
  · rw [← compl_Iic, measureReal_compl measurableSet_Iic, measureReal_univ_eq_one, measureReal_def,
      paretoMeasure_Iic_of_lt hx]
    simp
  · have hx' : L ≤ x := not_lt.mp hx
    have hx0 : 0 < x := hL.trans_le hx'
    have hint : IntegrableOn (fun y : ℝ => α * L ^ α * y ^ (-(α + 1))) (Ioi x) :=
      (integrableOn_Ioi_rpow_of_lt (by linarith) hx0).const_mul _
    have hnn : 0 ≤ᵐ[volume.restrict (Ioi x)] fun y : ℝ => α * L ^ α * y ^ (-(α + 1)) := by
      refine (ae_restrict_iff' measurableSet_Ioi).mpr (ae_of_all _ fun y (hy : x < y) => ?_)
      have hy0 : 0 < y := hx0.trans hy
      positivity
    rw [measureReal_def, paretoMeasure, withDensity_apply _ measurableSet_Ioi,
      setLIntegral_congr_fun measurableSet_Ioi
        (fun y (hy : x < y) => paretoPDF_of_le (hx'.trans hy.le)),
      ← ofReal_integral_eq_lintegral_ofReal hint hnn, integral_const_mul,
      integral_Ioi_rpow_of_lt (by linarith) hx0, pareto_tail_algebra hL hα hx0,
      ENNReal.toReal_ofReal (by positivity)]

theorem survival_paretoMeasure_of_le (hL : 0 < L) (hα : 0 < α) {x : ℝ} (hx : L ≤ x) :
    AuditProbability.survival (paretoMeasure L α) x = (L / x) ^ α := by
  rw [survival_paretoMeasure hL hα, if_neg (not_lt.mpr hx)]

theorem survival_paretoMeasure_endpoint (hL : 0 < L) (hα : 0 < α) :
    AuditProbability.survival (paretoMeasure L α) L = 1 := by
  rw [survival_paretoMeasure_of_le hL hα le_rfl, div_self hL.ne', Real.one_rpow]

/-- The distribution function: `0` below the endpoint (including at `x = L`), `1 − (L/x)^α` above. -/
theorem cdf_paretoMeasure (hL : 0 < L) (hα : 0 < α) (x : ℝ) :
    cdf (paretoMeasure L α) x = if x < L then 0 else 1 - (L / x) ^ α := by
  haveI : IsProbabilityMeasure (paretoMeasure L α) := isProbabilityMeasure_paretoMeasure hL hα
  have h : cdf (paretoMeasure L α) x = 1 - AuditProbability.survival (paretoMeasure L α) x := by
    rw [cdf_eq_real, AuditProbability.survival, ← compl_Ioi, measureReal_compl measurableSet_Ioi,
      measureReal_univ_eq_one]
  rw [h, survival_paretoMeasure hL hα]
  split_ifs <;> simp

theorem cdf_paretoMeasure_endpoint (hL : 0 < L) (hα : 0 < α) : cdf (paretoMeasure L α) L = 0 := by
  rw [cdf_paretoMeasure hL hα, if_neg (lt_irrefl L), div_self hL.ne', Real.one_rpow, sub_self]

/-! ### Moments as extended nonnegative integrals -/

/-- The `p`-th moment of the Pareto law as an extended nonnegative integral. -/
noncomputable def momentLintegral (L α p : ℝ) : ℝ≥0∞ :=
  ∫⁻ x, ENNReal.ofReal (x ^ p) ∂(paretoMeasure L α)

/-- Reduction to a Lebesgue integral over the support: the density-weighted integrand is
`α L^α x^{p−α−1}` on `(L, ∞)` (the endpoint is a null set). -/
theorem momentLintegral_eq (hL : 0 < L) (hα : 0 < α) (p : ℝ) :
    momentLintegral L α p = ∫⁻ x in Ioi L, ENNReal.ofReal (α * L ^ α * x ^ (p - α - 1)) := by
  have hg : Measurable fun x : ℝ => ENNReal.ofReal (x ^ p) :=
    (measurable_id.pow_const p).ennreal_ofReal
  rw [momentLintegral, paretoMeasure, lintegral_withDensity_eq_lintegral_mul volume
    (measurable_paretoPDF L α) hg, ← lintegral_add_compl _ measurableSet_Ici, compl_Ici]
  have h1 : ∫⁻ x in Iio L, (paretoPDF L α * fun x : ℝ => ENNReal.ofReal (x ^ p)) x = 0 := by
    rw [setLIntegral_congr_fun measurableSet_Iio (g := fun _ => 0)
      (fun x (hx : x < L) => by simp [Pi.mul_apply, paretoPDF_of_lt hx])]
    simp
  have h2 : ∫⁻ x in Ici L, (paretoPDF L α * fun x : ℝ => ENNReal.ofReal (x ^ p)) x =
      ∫⁻ x in Ici L, ENNReal.ofReal (α * L ^ α * x ^ (p - α - 1)) := by
    refine setLIntegral_congr_fun measurableSet_Ici (fun x (hx : L ≤ x) => ?_)
    have hx0 : 0 < x := hL.trans_le hx
    rw [Pi.mul_apply, paretoPDF_of_le hx, ← ENNReal.ofReal_mul (by positivity), mul_assoc,
      ← Real.rpow_add hx0, show -(α + 1) + p = p - α - 1 by ring]
  rw [h1, h2, add_zero, ← Measure.restrict_congr_set Ioi_ae_eq_Ici]

/-- Finite range `p < α`: the moment is `α L^p/(α − p)`, as an extended integral. -/
theorem momentLintegral_of_lt (hL : 0 < L) (hα : 0 < α) {p : ℝ} (hp : p < α) :
    momentLintegral L α p = ENNReal.ofReal (α * L ^ p / (α - p)) := by
  rw [momentLintegral_eq hL hα p]
  have hint : IntegrableOn (fun x : ℝ => α * L ^ α * x ^ (p - α - 1)) (Ioi L) :=
    (integrableOn_Ioi_rpow_of_lt (by linarith) hL).const_mul _
  have hnn : 0 ≤ᵐ[volume.restrict (Ioi L)] fun x : ℝ => α * L ^ α * x ^ (p - α - 1) := by
    refine (ae_restrict_iff' measurableSet_Ioi).mpr (ae_of_all _ fun x (hx : L < x) => ?_)
    have hx0 : 0 < x := hL.trans hx
    positivity
  rw [← ofReal_integral_eq_lintegral_ofReal hint hnn, integral_const_mul,
    integral_Ioi_rpow_of_lt (by linarith) hL]
  congr 1
  have h1 : α - p ≠ 0 := (sub_pos.mpr hp).ne'
  have h3 : p - α ≠ 0 := (sub_neg.mpr hp).ne
  have hLα : 0 < L ^ α := Real.rpow_pos_of_pos hL α
  rw [show p - α - 1 + 1 = p - α by ring, Real.rpow_sub hL]
  field_simp
  ring

/-- Divergent range `α ≤ p` (including the boundary `p = α`): the extended moment is `⊤`.
The density-weighted integrand `α L^α x^{p−α−1}` has exponent `≥ −1`, hence is not integrable
on `(L, ∞)`; for a nonnegative measurable function this is exactly `∫⁻ = ⊤`. -/
theorem momentLintegral_eq_top (hL : 0 < L) (hα : 0 < α) {p : ℝ} (hp : α ≤ p) :
    momentLintegral L α p = ⊤ := by
  rw [momentLintegral_eq hL hα p]
  set g : ℝ → ℝ := fun x => α * L ^ α * x ^ (p - α - 1) with hg
  have hc : α * L ^ α ≠ 0 := by positivity
  have hnot : ¬ IntegrableOn g (Ioi L) := by
    intro h
    have h' : IntegrableOn (fun x : ℝ => x ^ (p - α - 1)) (Ioi L) :=
      IntegrableOn.congr_fun (h.const_mul (α * L ^ α)⁻¹) (fun x _ => inv_mul_cancel_left₀ hc _)
        measurableSet_Ioi
    have := (integrableOn_Ioi_rpow_iff hL).mp h'
    linarith
  have hmeas : Measurable g := (measurable_id.pow_const _).const_mul _
  have hnn : 0 ≤ᵐ[volume.restrict (Ioi L)] g := by
    refine (ae_restrict_iff' measurableSet_Ioi).mpr (ae_of_all _ fun x (hx : L < x) => ?_)
    have hx0 : 0 < x := hL.trans hx
    simp only [hg, Pi.zero_apply]
    positivity
  by_contra hne
  exact hnot ⟨hmeas.aestronglyMeasurable, (hasFiniteIntegral_iff_ofReal hnn).mpr
    (lt_top_iff_ne_top.mpr hne)⟩

/-! ### Real moments in the integrable range -/

/-- `x ↦ x^p` is nonnegative almost everywhere for the law (the law lives on `[L, ∞) ⊆ (0, ∞)`). -/
theorem ae_nonneg_rpow_paretoMeasure (hL : 0 < L) (p : ℝ) :
    0 ≤ᵐ[paretoMeasure L α] fun x : ℝ => x ^ p := by
  refine measure_mono_null (fun x hx => ?_) (paretoMeasure_Iio_endpoint (L := L) (α := α))
  simp only [Pi.zero_apply, mem_Iio] at hx ⊢
  by_contra hxL
  exact hx (Real.rpow_nonneg (hL.le.trans (not_lt.mp hxL)) p)

/-- Integrability of `x^p` under the Pareto law holds exactly for `p < α`. -/
theorem integrable_rpow_paretoMeasure_iff (hL : 0 < L) (hα : 0 < α) (p : ℝ) :
    Integrable (fun x : ℝ => x ^ p) (paretoMeasure L α) ↔ p < α := by
  have hmeas : AEStronglyMeasurable (fun x : ℝ => x ^ p) (paretoMeasure L α) :=
    (measurable_id.pow_const p).aestronglyMeasurable
  rw [Integrable, hasFiniteIntegral_iff_ofReal (ae_nonneg_rpow_paretoMeasure hL p)]
  change _ ∧ momentLintegral L α p < ⊤ ↔ _
  constructor
  · rintro ⟨-, hlt⟩
    by_contra hp
    rw [momentLintegral_eq_top hL hα (not_lt.mp hp)] at hlt
    exact lt_irrefl _ hlt
  · intro hp
    exact ⟨hmeas, by rw [momentLintegral_of_lt hL hα hp]; exact ENNReal.ofReal_lt_top⟩

/-- The `p`-th moment for `p < α`: `∫ x^p dPareto(L, α) = α L^p/(α − p)`. -/
theorem integral_rpow_paretoMeasure (hL : 0 < L) (hα : 0 < α) {p : ℝ} (hp : p < α) :
    ∫ x, x ^ p ∂(paretoMeasure L α) = α * L ^ p / (α - p) := by
  rw [integral_eq_lintegral_of_nonneg_ae (ae_nonneg_rpow_paretoMeasure hL p)
    (measurable_id.pow_const p).aestronglyMeasurable]
  change (momentLintegral L α p).toReal = _
  rw [momentLintegral_of_lt hL hα hp, ENNReal.toReal_ofReal]
  have hLp : 0 < L ^ p := Real.rpow_pos_of_pos hL p
  have : 0 < α - p := sub_pos.mpr hp
  positivity

/-- Sanity value: the zeroth moment is `1` (the law is a probability measure). -/
theorem integral_rpow_zero_paretoMeasure (hL : 0 < L) (hα : 0 < α) :
    ∫ x, x ^ (0 : ℝ) ∂(paretoMeasure L α) = 1 := by
  rw [integral_rpow_paretoMeasure hL hα hα, Real.rpow_zero, mul_one, sub_zero, div_self hα.ne']

/-- Absolute moments coincide with moments: `|x| = x` on the support. -/
theorem integral_abs_rpow_paretoMeasure (hL : 0 < L) (hα : 0 < α) {p : ℝ} (hp : p < α) :
    ∫ x, |x| ^ p ∂(paretoMeasure L α) = α * L ^ p / (α - p) := by
  rw [← integral_rpow_paretoMeasure hL hα hp]
  refine integral_congr_ae ?_
  refine measure_mono_null (fun x hx => ?_) (paretoMeasure_Iio_endpoint (L := L) (α := α))
  simp only [mem_Iio] at hx ⊢
  by_contra hxL
  exact hx (by
    show |x| ^ p = x ^ p
    rw [abs_of_nonneg (hL.le.trans (not_lt.mp hxL))])

/-! ### Tail exponent of the actual law, and the first concrete instance of Property 5.1 -/

/-- The survival function of `paretoMeasure L α` has finite log-tail exponent `α`
(it equals `L^α x^{−α}` from the endpoint on). -/
theorem hasFiniteTailExponent_survival_paretoMeasure (hL : 0 < L) (hα : 0 < α) :
    AuditTails.HasFiniteTailExponent (AuditProbability.survival (paretoMeasure L α)) α := by
  have hf := AuditTails.pareto_hasFiniteTailExponent (C := L ^ α) (α := α)
    (Real.rpow_pos_of_pos hL α)
  have hev : (fun x : ℝ => L ^ α * x ^ (-α)) =ᶠ[atTop]
      AuditProbability.survival (paretoMeasure L α) := by
    filter_upwards [eventually_ge_atTop L] with x hx
    rw [survival_paretoMeasure_of_le hL hα hx, Real.div_rpow hL.le (hL.trans_le hx).le,
      Real.rpow_neg (hL.trans_le hx).le, div_eq_mul_inv]
  refine ⟨(hf.1.and hev).mono fun x ⟨h1, h2⟩ => h2 ▸ h1, hf.2.congr' ?_⟩
  filter_upwards [hev] with x hx
  rw [hx]

/-- **Property 5.1 instantiated for Pareto coordinates**: for nonnegative measurable `X, Y` with
laws `Pareto(L₁, α₁)` and `Pareto(L₂, α₂)` and positive weights, the law of `aX + bY` has survival
exponent `min α₁ α₂`. No independence is assumed. -/
theorem hasFiniteTailExponent_weightedSum_pareto {Ω : Type*} [MeasurableSpace Ω]
    {P : Measure Ω} [IsProbabilityMeasure P] {X Y : Ω → ℝ} {a b L₁ α₁ L₂ α₂ : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hX0 : ∀ ω, 0 ≤ X ω) (hY0 : ∀ ω, 0 ≤ Y ω)
    (hXm : Measurable X) (hYm : Measurable Y)
    (hL₁ : 0 < L₁) (hα₁ : 0 < α₁) (hL₂ : 0 < L₂) (hα₂ : 0 < α₂)
    (hX : P.map X = paretoMeasure L₁ α₁) (hY : P.map Y = paretoMeasure L₂ α₂) :
    AuditTails.HasFiniteTailExponent
      (AuditProbability.survival (P.map fun ω => a * X ω + b * Y ω)) (min α₁ α₂) := by
  refine AuditProbability.hasFiniteTailExponent_survival_map_weightedSum ha hb hX0 hY0 hXm hYm ?_ ?_
  · rw [hX]
    exact hasFiniteTailExponent_survival_paretoMeasure hL₁ hα₁
  · rw [hY]
    exact hasFiniteTailExponent_survival_paretoMeasure hL₂ hα₂

end AuditPareto

#print axioms AuditPareto.survival_paretoMeasure
#print axioms AuditPareto.cdf_paretoMeasure
#print axioms AuditPareto.momentLintegral_of_lt
#print axioms AuditPareto.momentLintegral_eq_top
#print axioms AuditPareto.integrable_rpow_paretoMeasure_iff
#print axioms AuditPareto.integral_rpow_paretoMeasure
#print axioms AuditPareto.hasFiniteTailExponent_survival_paretoMeasure
#print axioms AuditPareto.hasFiniteTailExponent_weightedSum_pareto
