import AuditRepairs.ExtremeValueBridge
import Mathlib.MeasureTheory.Measure.Stieltjes
import Mathlib.Probability.CDF

/-!
# Extreme-value laws as probability measures (backlog family T061, children 1–2)

`AuditTails.gumbelCDF` and `AuditTails.frechetCDF ξ` are so far *formulas*. This
module turns them into probability measures on `ℝ` by the Stieltjes route
recommended in the independent audit of v0.2.4: each distribution function is
shown monotone and right-continuous (bundled as a `StieltjesFunction`), its
Lebesgue–Stieltjes measure is taken, the endpoint limits `0` at `−∞` and `1` at
`+∞` give `IsProbabilityMeasure` (`StieltjesFunction.isProbabilityMeasure`) and
the identity `cdf (measure) = formula` (`cdf_measure_stieltjesFunction`).

With the measures in hand, the generic law theorem `AuditExtremes.cdf_map_maxRV`
is instantiated: for independent measurable coordinates with the constructed
common law, the maximum has distribution function `gumbelCDF (x − log n)` resp.
`frechetCDF ξ (n^{−ξ} x)`. This discharges the *CDF-realization premise* that
`measureReal_maxLeEvent_gumbel` / `_frechet` carried since v0.2.3; the
independence, measurability, common-law and positive-sample-size hypotheses are
ordinary hypotheses of the random-variable statements and remain.

Book anchor: Section 9.1, printed p. 173 (PDF p. 187) — Gumbel
`exp(−exp(−(x−b_n)/a_n))`, Fréchet `0` for `x ≤ b_n` and `exp(−((x−b_n)/a_n)^{−α})`
for `x > b_n` with `ξ = 1/α`; standardised here (`b_n = 0`, `a_n = 1`).

Not done (remaining T061 children): the reverse-Weibull family and the
location/scale wrappers `x ↦ μ + σ x` (`σ > 0`) for all three families.
-/

set_option autoImplicit false

open MeasureTheory ProbabilityTheory Filter Topology

namespace AuditEVTLaws

/-! ### Gumbel -/

theorem gumbelCDF_monotone : Monotone AuditTails.gumbelCDF := by
  intro x y hxy
  simp only [AuditTails.gumbelCDF]
  exact Real.exp_le_exp.mpr (neg_le_neg (Real.exp_le_exp.mpr (neg_le_neg hxy)))

theorem continuous_gumbelCDF : Continuous AuditTails.gumbelCDF := by
  unfold AuditTails.gumbelCDF
  fun_prop

theorem gumbelCDF_tendsto_atBot : Tendsto AuditTails.gumbelCDF atBot (𝓝 0) := by
  have h1 : Tendsto (fun x : ℝ => -x) atBot atTop := tendsto_neg_atBot_atTop
  have h2 : Tendsto (fun x : ℝ => Real.exp (-x)) atBot atTop := Real.tendsto_exp_atTop.comp h1
  have h3 : Tendsto (fun x : ℝ => -Real.exp (-x)) atBot atBot := tendsto_neg_atTop_atBot.comp h2
  exact Real.tendsto_exp_atBot.comp h3

theorem gumbelCDF_tendsto_atTop : Tendsto AuditTails.gumbelCDF atTop (𝓝 1) := by
  have h1 : Tendsto (fun x : ℝ => -x) atTop atBot := tendsto_neg_atTop_atBot
  have h2 : Tendsto (fun x : ℝ => Real.exp (-x)) atTop (𝓝 0) := Real.tendsto_exp_atBot.comp h1
  have h3 : Tendsto (fun x : ℝ => -Real.exp (-x)) atTop (𝓝 (-0)) := h2.neg
  rw [neg_zero] at h3
  have h4 := (Real.continuous_exp.tendsto 0).comp h3
  simpa [Function.comp_def, AuditTails.gumbelCDF] using h4

/-- The Gumbel distribution function bundled as a Stieltjes function. -/
noncomputable def gumbelStieltjes : StieltjesFunction where
  toFun := AuditTails.gumbelCDF
  mono' := gumbelCDF_monotone
  right_continuous' := fun _ => continuous_gumbelCDF.continuousAt.continuousWithinAt

/-- The standard Gumbel probability measure on `ℝ`. -/
noncomputable def gumbelMeasure : Measure ℝ := gumbelStieltjes.measure

instance gumbelMeasure_isProbabilityMeasure : IsProbabilityMeasure gumbelMeasure :=
  gumbelStieltjes.isProbabilityMeasure gumbelCDF_tendsto_atBot gumbelCDF_tendsto_atTop

theorem cdf_gumbelMeasure : cdf gumbelMeasure = gumbelStieltjes :=
  cdf_measure_stieltjesFunction gumbelStieltjes gumbelCDF_tendsto_atBot gumbelCDF_tendsto_atTop

/-- The constructed measure has exactly the Gumbel formula as distribution function. -/
theorem cdf_gumbelMeasure_apply (x : ℝ) : cdf gumbelMeasure x = AuditTails.gumbelCDF x := by
  rw [cdf_gumbelMeasure]
  rfl

/-- Max-stability instantiated for the constructed Gumbel law: the maximum of `n`
independent coordinates with law `gumbelMeasure` has distribution function
`gumbelCDF (x − log n)`. -/
theorem cdf_map_maxRV_gumbel {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    [IsProbabilityMeasure P] {ι : Type*} [Fintype ι] [Nonempty ι]
    (X : ι → Ω → ℝ) (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i))
    (hν : ∀ i, P.map (X i) = gumbelMeasure) (x : ℝ) :
    cdf (P.map (AuditExtremes.maxRV X)) x =
      AuditTails.gumbelCDF (x - Real.log (Fintype.card ι)) := by
  rw [AuditExtremes.cdf_map_maxRV X hX hm hν x, cdf_gumbelMeasure_apply,
    AuditTails.gumbel_maxstable _ Fintype.card_pos]

/-- An iid realization exists for every finite nonempty index type: on the product space
`ι → ℝ` carrying `Measure.pi (fun _ => gumbelMeasure)`, the coordinate maps are independent
with law `gumbelMeasure`, so the maximum has distribution function `gumbelCDF (x − log n)`. -/
theorem cdf_map_maxRV_pi_gumbel {ι : Type*} [Fintype ι] [Nonempty ι] (x : ℝ) :
    cdf ((Measure.pi fun _ : ι => gumbelMeasure).map
        (AuditExtremes.maxRV fun i (ω : ι → ℝ) => ω i)) x =
      AuditTails.gumbelCDF (x - Real.log (Fintype.card ι)) :=
  cdf_map_maxRV_gumbel _ (iIndepFun_pi fun _ => aemeasurable_id) (fun i => measurable_pi_apply i)
    (fun i => (measurePreserving_eval _ i).map_eq) x

/-! ### Fréchet, `0 < ξ` -/

section Frechet

variable {ξ : ℝ}

theorem frechetCDF_of_pos {x : ℝ} (hx : 0 < x) :
    AuditTails.frechetCDF ξ x = Real.exp (-(x ^ (-1 / ξ))) := by
  simp [AuditTails.frechetCDF, AuditTails.frechetFormula, hx]

theorem frechetCDF_of_nonpos {x : ℝ} (hx : x ≤ 0) : AuditTails.frechetCDF ξ x = 0 := by
  simp [AuditTails.frechetCDF, not_lt.mpr hx]

theorem frechetCDF_nonneg (x : ℝ) : 0 ≤ AuditTails.frechetCDF ξ x := by
  unfold AuditTails.frechetCDF
  split_ifs
  · exact (Real.exp_pos _).le
  · exact le_rfl

theorem neg_one_div_nonpos (hξ : 0 < ξ) : (-1 / ξ : ℝ) ≤ 0 := by
  rw [neg_div]
  exact neg_nonpos.mpr (div_nonneg zero_le_one hξ.le)

theorem frechetCDF_monotone (hξ : 0 < ξ) : Monotone (AuditTails.frechetCDF ξ) := by
  intro x y hxy
  by_cases hx : 0 < x
  · have hy : 0 < y := lt_of_lt_of_le hx hxy
    rw [frechetCDF_of_pos hx, frechetCDF_of_pos hy]
    exact Real.exp_le_exp.mpr (neg_le_neg
      (Real.rpow_le_rpow_of_exponent_nonpos hx hxy (neg_one_div_nonpos hξ)))
  · rw [frechetCDF_of_nonpos (not_lt.mp hx)]
    exact frechetCDF_nonneg y

/-- Right-continuity everywhere, including the support boundary `0`, where the one-sided
limit of `exp(−x^{−1/ξ})` as `x → 0⁺` is `0` because `x^{−1/ξ} → +∞`. -/
theorem frechetCDF_continuousWithinAt_Ici (hξ : 0 < ξ) (x₀ : ℝ) :
    ContinuousWithinAt (AuditTails.frechetCDF ξ) (Set.Ici x₀) x₀ := by
  rcases lt_trichotomy x₀ 0 with hneg | hzero | hpos
  · -- Locally identically zero.
    have hev : (fun _ : ℝ => (0 : ℝ)) =ᶠ[𝓝 x₀] AuditTails.frechetCDF ξ := by
      filter_upwards [Iio_mem_nhds hneg] with y hy
      exact (frechetCDF_of_nonpos hy.le).symm
    exact (continuousAt_const.congr hev).continuousWithinAt
  · subst hzero
    rw [ContinuousWithinAt, frechetCDF_of_nonpos le_rfl, ← Set.Ioi_insert, nhdsWithin_insert,
      tendsto_sup]
    refine ⟨by simpa [frechetCDF_of_nonpos le_rfl] using
      tendsto_pure_nhds (AuditTails.frechetCDF ξ) 0, ?_⟩
    have hev : (fun y : ℝ => Real.exp (-(Real.exp ((-1 / ξ) * Real.log y)))) =ᶠ[𝓝[Set.Ioi 0] 0]
        AuditTails.frechetCDF ξ := by
      filter_upwards [self_mem_nhdsWithin] with y hy
      rw [frechetCDF_of_pos hy, Real.rpow_def_of_pos hy, mul_comm]
    refine Tendsto.congr' hev ?_
    have hneg' : (-1 / ξ : ℝ) < 0 := by
      rw [neg_div]
      exact neg_neg_of_pos (div_pos one_pos hξ)
    have h1 : Tendsto (fun y : ℝ => (-1 / ξ) * Real.log y) (𝓝[Set.Ioi 0] 0) atTop :=
      Real.tendsto_log_nhdsGT_zero.const_mul_atBot_of_neg hneg'
    have h2 : Tendsto (fun y : ℝ => -Real.exp ((-1 / ξ) * Real.log y)) (𝓝[Set.Ioi 0] 0) atBot :=
      tendsto_neg_atTop_atBot.comp (Real.tendsto_exp_atTop.comp h1)
    exact Real.tendsto_exp_atBot.comp h2
  · -- Locally equal to the smooth formula on `Ioi 0`.
    have hev : (fun y : ℝ => Real.exp (-(y ^ (-1 / ξ)))) =ᶠ[𝓝 x₀] AuditTails.frechetCDF ξ := by
      filter_upwards [Ioi_mem_nhds hpos] with y hy
      exact (frechetCDF_of_pos hy).symm
    have hc : ContinuousAt (fun y : ℝ => Real.exp (-(y ^ (-1 / ξ)))) x₀ :=
      Real.continuous_exp.continuousAt.comp
        (Real.continuousAt_rpow_const x₀ (-1 / ξ) (Or.inl hpos.ne')).neg
    exact (hc.congr hev).continuousWithinAt

theorem frechetCDF_tendsto_atBot : Tendsto (AuditTails.frechetCDF ξ) atBot (𝓝 0) := by
  have hev : (fun _ : ℝ => (0 : ℝ)) =ᶠ[atBot] AuditTails.frechetCDF ξ := by
    filter_upwards [eventually_le_atBot (0 : ℝ)] with y hy
    exact (frechetCDF_of_nonpos hy).symm
  exact tendsto_const_nhds.congr' hev

theorem frechetCDF_tendsto_atTop (hξ : 0 < ξ) : Tendsto (AuditTails.frechetCDF ξ) atTop (𝓝 1) := by
  have hev : (fun y : ℝ => Real.exp (-(y ^ (-(1 / ξ))))) =ᶠ[atTop] AuditTails.frechetCDF ξ := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with y hy
    rw [frechetCDF_of_pos hy, neg_div]
  refine Tendsto.congr' hev ?_
  have h1 : Tendsto (fun y : ℝ => y ^ (-(1 / ξ))) atTop (𝓝 0) :=
    tendsto_rpow_neg_atTop (div_pos one_pos hξ)
  have h2 : Tendsto (fun y : ℝ => -(y ^ (-(1 / ξ)))) atTop (𝓝 (-0)) := h1.neg
  rw [neg_zero] at h2
  have h3 := (Real.continuous_exp.tendsto 0).comp h2
  simpa [Function.comp_def] using h3

/-- The Fréchet distribution function (`0 < ξ`) bundled as a Stieltjes function. -/
noncomputable def frechetStieltjes (ξ : ℝ) (hξ : 0 < ξ) : StieltjesFunction where
  toFun := AuditTails.frechetCDF ξ
  mono' := frechetCDF_monotone hξ
  right_continuous' := frechetCDF_continuousWithinAt_Ici hξ

/-- The standard Fréchet probability measure with shape `ξ > 0` (`α = 1/ξ`). -/
noncomputable def frechetMeasure (ξ : ℝ) (hξ : 0 < ξ) : Measure ℝ := (frechetStieltjes ξ hξ).measure

instance frechetMeasure_isProbabilityMeasure (ξ : ℝ) (hξ : 0 < ξ) :
    IsProbabilityMeasure (frechetMeasure ξ hξ) :=
  (frechetStieltjes ξ hξ).isProbabilityMeasure frechetCDF_tendsto_atBot (frechetCDF_tendsto_atTop hξ)

theorem cdf_frechetMeasure (hξ : 0 < ξ) : cdf (frechetMeasure ξ hξ) = frechetStieltjes ξ hξ :=
  cdf_measure_stieltjesFunction _ frechetCDF_tendsto_atBot (frechetCDF_tendsto_atTop hξ)

/-- The constructed measure has exactly the support-correct Fréchet formula as distribution
function (in particular `0` on `x ≤ 0`, unlike the raw `frechetFormula`). -/
theorem cdf_frechetMeasure_apply (hξ : 0 < ξ) (x : ℝ) :
    cdf (frechetMeasure ξ hξ) x = AuditTails.frechetCDF ξ x := by
  rw [cdf_frechetMeasure]
  rfl

/-- Max-stability instantiated for the constructed Fréchet law: the maximum of `n`
independent coordinates with law `frechetMeasure ξ hξ` has distribution function
`frechetCDF ξ (n^{−ξ} x)`. -/
theorem cdf_map_maxRV_frechet {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    [IsProbabilityMeasure P] {ι : Type*} [Fintype ι] [Nonempty ι] (hξ : 0 < ξ)
    (X : ι → Ω → ℝ) (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i))
    (hν : ∀ i, P.map (X i) = frechetMeasure ξ hξ) (x : ℝ) :
    cdf (P.map (AuditExtremes.maxRV X)) x =
      AuditTails.frechetCDF ξ ((Fintype.card ι : ℝ) ^ (-ξ) * x) := by
  rw [AuditExtremes.cdf_map_maxRV X hX hm hν x, cdf_frechetMeasure_apply,
    AuditTails.frechet_cdf_maxstable hξ x _ Fintype.card_pos]

/-- Product-space iid realization for the Fréchet law. -/
theorem cdf_map_maxRV_pi_frechet {ι : Type*} [Fintype ι] [Nonempty ι] (hξ : 0 < ξ) (x : ℝ) :
    cdf ((Measure.pi fun _ : ι => frechetMeasure ξ hξ).map
        (AuditExtremes.maxRV fun i (ω : ι → ℝ) => ω i)) x =
      AuditTails.frechetCDF ξ ((Fintype.card ι : ℝ) ^ (-ξ) * x) :=
  cdf_map_maxRV_frechet hξ _ (iIndepFun_pi fun _ => aemeasurable_id)
    (fun i => measurable_pi_apply i) (fun i => (measurePreserving_eval _ i).map_eq) x

end Frechet

/-! ### Reverse-Weibull (Type III), `0 < α`, upper endpoint `0`

Book §9.1, printed p. 173 (PDF p. 187): `exp(−(−(x−b_n)/a_n)^α)` for `x < b_n`, `1` for `x ≥ b_n`,
with extreme-value index `ξ = −1/α`; standardised here (`b_n = 0`, `a_n = 1`). This is the
upper-endpoint EVT family, not the right-supported Weibull lifetime law. Max-stability:
`W_α(x)^n = W_α(n^{1/α} x)`, so the maximum of `n` iid copies has scale `n^{−1/α}` and approaches
the endpoint from below (v0.2.6, T061 child 3). -/

section ReverseWeibull

variable {α : ℝ}

/-- Standard reverse-Weibull distribution function with shape `α`: `exp(−(−x)^α)` for `x < 0`,
`1` for `x ≥ 0`. Meaningful for `0 < α`. -/
noncomputable def reverseWeibullCDF (α x : ℝ) : ℝ := if x < 0 then Real.exp (-((-x) ^ α)) else 1

theorem reverseWeibullCDF_of_neg {x : ℝ} (hx : x < 0) :
    reverseWeibullCDF α x = Real.exp (-((-x) ^ α)) := if_pos hx

theorem reverseWeibullCDF_of_nonneg {x : ℝ} (hx : 0 ≤ x) : reverseWeibullCDF α x = 1 :=
  if_neg (not_lt.mpr hx)

theorem reverseWeibullCDF_le_one (x : ℝ) : reverseWeibullCDF α x ≤ 1 := by
  unfold reverseWeibullCDF
  split_ifs with hx
  · exact Real.exp_le_one_iff.mpr (neg_nonpos.mpr (Real.rpow_nonneg (neg_nonneg.mpr hx.le) _))
  · exact le_rfl

theorem reverseWeibullCDF_monotone (hα : 0 < α) : Monotone (reverseWeibullCDF α) := by
  intro x y hxy
  by_cases hy : y < 0
  · have hx : x < 0 := lt_of_le_of_lt hxy hy
    rw [reverseWeibullCDF_of_neg hx, reverseWeibullCDF_of_neg hy]
    exact Real.exp_le_exp.mpr (neg_le_neg
      (Real.rpow_le_rpow (neg_nonneg.mpr hy.le) (neg_le_neg hxy) hα.le))
  · rw [reverseWeibullCDF_of_nonneg (not_lt.mp hy)]
    exact reverseWeibullCDF_le_one x

/-- Right-continuity everywhere: locally constant `1` on `[0, ∞)`, the smooth formula on `(−∞, 0)`.
No hypothesis on `α` is needed for right-continuity alone. -/
theorem reverseWeibullCDF_continuousWithinAt_Ici (x₀ : ℝ) :
    ContinuousWithinAt (reverseWeibullCDF α) (Set.Ici x₀) x₀ := by
  rcases lt_or_ge x₀ 0 with hneg | hnonneg
  · have hev : (fun y : ℝ => Real.exp (-((-y) ^ α))) =ᶠ[𝓝 x₀] reverseWeibullCDF α := by
      filter_upwards [Iio_mem_nhds hneg] with y hy
      exact (reverseWeibullCDF_of_neg hy).symm
    have hc : ContinuousAt (fun y : ℝ => Real.exp (-((-y) ^ α))) x₀ :=
      Real.continuous_exp.continuousAt.comp
        ((Real.continuousAt_rpow_const (-x₀) α (Or.inl (neg_ne_zero.mpr hneg.ne))).comp
          continuous_neg.continuousAt).neg
    exact (hc.congr hev).continuousWithinAt
  · -- On `Ici x₀ ⊆ Ici 0` the function is identically `1`.
    exact continuousWithinAt_const.congr (fun y hy => reverseWeibullCDF_of_nonneg (hnonneg.trans hy))
      (reverseWeibullCDF_of_nonneg hnonneg)

theorem reverseWeibullCDF_tendsto_atTop : Tendsto (reverseWeibullCDF α) atTop (𝓝 1) := by
  have hev : (fun _ : ℝ => (1 : ℝ)) =ᶠ[atTop] reverseWeibullCDF α := by
    filter_upwards [eventually_ge_atTop (0 : ℝ)] with y hy
    exact (reverseWeibullCDF_of_nonneg hy).symm
  exact tendsto_const_nhds.congr' hev

theorem reverseWeibullCDF_tendsto_atBot (hα : 0 < α) : Tendsto (reverseWeibullCDF α) atBot (𝓝 0) := by
  have hev : (fun y : ℝ => Real.exp (-((-y) ^ α))) =ᶠ[atBot] reverseWeibullCDF α := by
    filter_upwards [eventually_lt_atBot (0 : ℝ)] with y hy
    exact (reverseWeibullCDF_of_neg hy).symm
  refine Tendsto.congr' hev ?_
  have h1 : Tendsto (fun y : ℝ => (-y) ^ α) atBot atTop :=
    (tendsto_rpow_atTop hα).comp tendsto_neg_atBot_atTop
  exact Real.tendsto_exp_atBot.comp (tendsto_neg_atTop_atBot.comp h1)

/-- The reverse-Weibull distribution function (`0 < α`) bundled as a Stieltjes function. -/
noncomputable def reverseWeibullStieltjes (α : ℝ) (hα : 0 < α) : StieltjesFunction where
  toFun := reverseWeibullCDF α
  mono' := reverseWeibullCDF_monotone hα
  right_continuous' := reverseWeibullCDF_continuousWithinAt_Ici

/-- The standard reverse-Weibull probability measure with shape `α > 0`. -/
noncomputable def reverseWeibullMeasure (α : ℝ) (hα : 0 < α) : Measure ℝ :=
  (reverseWeibullStieltjes α hα).measure

instance reverseWeibullMeasure_isProbabilityMeasure (α : ℝ) (hα : 0 < α) :
    IsProbabilityMeasure (reverseWeibullMeasure α hα) :=
  (reverseWeibullStieltjes α hα).isProbabilityMeasure (reverseWeibullCDF_tendsto_atBot hα)
    reverseWeibullCDF_tendsto_atTop

theorem cdf_reverseWeibullMeasure (hα : 0 < α) :
    cdf (reverseWeibullMeasure α hα) = reverseWeibullStieltjes α hα :=
  cdf_measure_stieltjesFunction _ (reverseWeibullCDF_tendsto_atBot hα) reverseWeibullCDF_tendsto_atTop

theorem cdf_reverseWeibullMeasure_apply (hα : 0 < α) (x : ℝ) :
    cdf (reverseWeibullMeasure α hα) x = reverseWeibullCDF α x := by
  rw [cdf_reverseWeibullMeasure]
  rfl

/-- Analytic max-stability of the reverse-Weibull formula: `W_α(x)^n = W_α(n^{1/α} x)`.
No sample-size hypothesis is needed: for `n = 0` both sides are `1` (`0^{1/α} = 0`, `W_α 0 = 1`). -/
theorem reverseWeibullCDF_maxstable (hα : 0 < α) (x : ℝ) (n : ℕ) :
    (reverseWeibullCDF α x) ^ n = reverseWeibullCDF α ((n : ℝ) ^ (1 / α) * x) := by
  rcases Nat.eq_zero_or_pos n with hn | hn
  · subst hn
    rw [Nat.cast_zero, Real.zero_rpow (one_div_ne_zero hα.ne'), zero_mul,
      reverseWeibullCDF_of_nonneg le_rfl, pow_zero]
  have hnR : (0 : ℝ) < n := Nat.cast_pos.mpr hn
  have hc : 0 < (n : ℝ) ^ (1 / α) := Real.rpow_pos_of_pos hnR _
  by_cases hx : x < 0
  · have hy : (n : ℝ) ^ (1 / α) * x < 0 := mul_neg_of_pos_of_neg hc hx
    rw [reverseWeibullCDF_of_neg hx, reverseWeibullCDF_of_neg hy, ← Real.exp_nat_mul]
    congr 1
    have e : (-((n : ℝ) ^ (1 / α) * x)) ^ α = n * (-x) ^ α := by
      rw [show -((n : ℝ) ^ (1 / α) * x) = (n : ℝ) ^ (1 / α) * (-x) by ring,
        Real.mul_rpow hc.le (neg_nonneg.mpr hx.le), ← Real.rpow_mul hnR.le,
        show (1 / α) * α = 1 by field_simp, Real.rpow_one]
    rw [e]
    ring
  · have hx' : 0 ≤ x := not_lt.mp hx
    rw [reverseWeibullCDF_of_nonneg hx', reverseWeibullCDF_of_nonneg (mul_nonneg hc.le hx'), one_pow]

/-- Max-stability instantiated for the constructed reverse-Weibull law: the maximum of `n`
independent coordinates with law `reverseWeibullMeasure α hα` has distribution function
`reverseWeibullCDF α (n^{1/α} x)` (scale `n^{−1/α}`, approaching the endpoint from below). -/
theorem cdf_map_maxRV_reverseWeibull {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    [IsProbabilityMeasure P] {ι : Type*} [Fintype ι] [Nonempty ι] (hα : 0 < α)
    (X : ι → Ω → ℝ) (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i))
    (hν : ∀ i, P.map (X i) = reverseWeibullMeasure α hα) (x : ℝ) :
    cdf (P.map (AuditExtremes.maxRV X)) x =
      reverseWeibullCDF α ((Fintype.card ι : ℝ) ^ (1 / α) * x) := by
  rw [AuditExtremes.cdf_map_maxRV X hX hm hν x, cdf_reverseWeibullMeasure_apply,
    reverseWeibullCDF_maxstable hα]

/-- Product-space iid realization for the reverse-Weibull law. -/
theorem cdf_map_maxRV_pi_reverseWeibull {ι : Type*} [Fintype ι] [Nonempty ι] (hα : 0 < α) (x : ℝ) :
    cdf ((Measure.pi fun _ : ι => reverseWeibullMeasure α hα).map
        (AuditExtremes.maxRV fun i (ω : ι → ℝ) => ω i)) x =
      reverseWeibullCDF α ((Fintype.card ι : ℝ) ^ (1 / α) * x) :=
  cdf_map_maxRV_reverseWeibull hα _ (iIndepFun_pi fun _ => aemeasurable_id)
    (fun i => measurable_pi_apply i) (fun i => (measurePreserving_eval _ i).map_eq) x

end ReverseWeibull

end AuditEVTLaws

#print axioms AuditEVTLaws.gumbelMeasure_isProbabilityMeasure
#print axioms AuditEVTLaws.cdf_gumbelMeasure_apply
#print axioms AuditEVTLaws.cdf_map_maxRV_gumbel
#print axioms AuditEVTLaws.cdf_map_maxRV_pi_gumbel
#print axioms AuditEVTLaws.frechetMeasure_isProbabilityMeasure
#print axioms AuditEVTLaws.cdf_frechetMeasure_apply
#print axioms AuditEVTLaws.cdf_map_maxRV_frechet
#print axioms AuditEVTLaws.cdf_map_maxRV_pi_frechet
#print axioms AuditEVTLaws.reverseWeibullMeasure_isProbabilityMeasure
#print axioms AuditEVTLaws.cdf_reverseWeibullMeasure_apply
#print axioms AuditEVTLaws.reverseWeibullCDF_maxstable
#print axioms AuditEVTLaws.cdf_map_maxRV_reverseWeibull
#print axioms AuditEVTLaws.cdf_map_maxRV_pi_reverseWeibull
