import AuditRepairs.ExtremeValueLaws

/-!
# Location/scale families of the extreme-value laws (backlog family T061, child 4)

One reusable positive affine pushforward: for a probability law `ν` on `ℝ`, `μ : ℝ` and
`σ > 0`, `affineLaw ν μ σ := ν.map (fun z => μ + σ z)` is a probability measure with
`cdf (affineLaw ν μ σ) x = cdf ν ((x − μ)/σ)`. Applied to the three standardised laws of
`AuditRepairs/ExtremeValueLaws.lean` this gives `gumbelLaw μ σ`, `frechetLaw ξ hξ μ σ` and
`reverseWeibullLaw α hα μ σ` with their distribution functions, i.e. the book's
`G((x − b_n)/a_n)` forms of §9.1 (printed p. 173, PDF p. 187) with `b_n = μ`, `a_n = σ`.

Combined with the generic maximum law `AuditExtremes.cdf_map_maxRV` and the analytic
max-stability identities, the maximum of `n` independent coordinates with a location/scale
law is again a law of the same family with the parameters of the table below; the results are
stated as **equalities of probability measures** (through `Measure.eq_of_cdf`):

| coordinates' law | law of the maximum |
|---|---|
| `gumbelLaw μ σ` | `gumbelLaw (μ + σ log n) σ` |
| `frechetLaw ξ μ σ` (`ξ > 0`) | `frechetLaw ξ μ (σ n^ξ)` |
| `reverseWeibullLaw α μ σ` (`α > 0`) | `reverseWeibullLaw α μ (σ n^{−1/α})` |

`μ` is the lower endpoint for Fréchet and the upper endpoint for reverse-Weibull. Positive
scale is essential: a negative scale reverses the inequalities and is not covered.
-/

set_option autoImplicit false

open MeasureTheory ProbabilityTheory

namespace AuditEVTLaws

section Affine

variable {ν : Measure ℝ} {μ σ : ℝ}

/-- The law of `μ + σ Z` when `Z ∼ ν`. -/
noncomputable def affineLaw (ν : Measure ℝ) (μ σ : ℝ) : Measure ℝ := ν.map (fun z => μ + σ * z)

theorem measurable_affine (μ σ : ℝ) : Measurable (fun z : ℝ => μ + σ * z) := by fun_prop

instance affineLaw_isProbabilityMeasure (ν : Measure ℝ) [IsProbabilityMeasure ν] (μ σ : ℝ) :
    IsProbabilityMeasure (affineLaw ν μ σ) :=
  Measure.isProbabilityMeasure_map (measurable_affine μ σ).aemeasurable

/-- The identity transformation returns the law itself. -/
theorem affineLaw_zero_one (ν : Measure ℝ) : affineLaw ν 0 1 = ν := by
  simp [affineLaw]

theorem affine_preimage_Iic (hσ : 0 < σ) (x : ℝ) :
    (fun z : ℝ => μ + σ * z) ⁻¹' Set.Iic x = Set.Iic ((x - μ) / σ) := by
  ext z
  simp only [Set.mem_preimage, Set.mem_Iic]
  rw [le_div_iff₀ hσ]
  constructor <;> intro h <;> linarith

/-- The distribution function of a positive location/scale transform. -/
theorem cdf_affineLaw [IsProbabilityMeasure ν] (hσ : 0 < σ) (x : ℝ) :
    cdf (affineLaw ν μ σ) x = cdf ν ((x - μ) / σ) := by
  rw [cdf_eq_real, cdf_eq_real, affineLaw, Measure.real, Measure.real,
    Measure.map_apply (measurable_affine μ σ) measurableSet_Iic, affine_preimage_Iic hσ]

end Affine

/-! ### The three location/scale families -/

/-- Gumbel with location `μ` and scale `σ`. -/
noncomputable def gumbelLaw (μ σ : ℝ) : Measure ℝ := affineLaw gumbelMeasure μ σ

/-- Fréchet with shape `ξ > 0`, lower endpoint `μ` and scale `σ`. -/
noncomputable def frechetLaw (ξ : ℝ) (hξ : 0 < ξ) (μ σ : ℝ) : Measure ℝ :=
  affineLaw (frechetMeasure ξ hξ) μ σ

/-- Reverse-Weibull with shape `α > 0`, upper endpoint `μ` and scale `σ`. -/
noncomputable def reverseWeibullLaw (α : ℝ) (hα : 0 < α) (μ σ : ℝ) : Measure ℝ :=
  affineLaw (reverseWeibullMeasure α hα) μ σ

instance gumbelLaw_isProbabilityMeasure (μ σ : ℝ) : IsProbabilityMeasure (gumbelLaw μ σ) :=
  affineLaw_isProbabilityMeasure _ μ σ

instance frechetLaw_isProbabilityMeasure (ξ : ℝ) (hξ : 0 < ξ) (μ σ : ℝ) :
    IsProbabilityMeasure (frechetLaw ξ hξ μ σ) :=
  affineLaw_isProbabilityMeasure _ μ σ

instance reverseWeibullLaw_isProbabilityMeasure (α : ℝ) (hα : 0 < α) (μ σ : ℝ) :
    IsProbabilityMeasure (reverseWeibullLaw α hα μ σ) :=
  affineLaw_isProbabilityMeasure _ μ σ

theorem cdf_gumbelLaw {μ σ : ℝ} (hσ : 0 < σ) (x : ℝ) :
    cdf (gumbelLaw μ σ) x = AuditTails.gumbelCDF ((x - μ) / σ) := by
  rw [gumbelLaw, cdf_affineLaw hσ, cdf_gumbelMeasure_apply]

theorem cdf_frechetLaw {ξ : ℝ} (hξ : 0 < ξ) {μ σ : ℝ} (hσ : 0 < σ) (x : ℝ) :
    cdf (frechetLaw ξ hξ μ σ) x = AuditTails.frechetCDF ξ ((x - μ) / σ) := by
  rw [frechetLaw, cdf_affineLaw hσ, cdf_frechetMeasure_apply]

theorem cdf_reverseWeibullLaw {α : ℝ} (hα : 0 < α) {μ σ : ℝ} (hσ : 0 < σ) (x : ℝ) :
    cdf (reverseWeibullLaw α hα μ σ) x = reverseWeibullCDF α ((x - μ) / σ) := by
  rw [reverseWeibullLaw, cdf_affineLaw hσ, cdf_reverseWeibullMeasure_apply]

/-! ### Maxima of iid location/scale coordinates, as equalities of laws -/

section Maxima

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} [IsProbabilityMeasure P]
  {ι : Type*} [Fintype ι] [Nonempty ι]

/-- Gumbel: the maximum of `n` independent `gumbelLaw μ σ` coordinates has law
`gumbelLaw (μ + σ log n) σ` (location shifts by `σ log n`, scale unchanged). -/
theorem map_maxRV_gumbelLaw {μ σ : ℝ} (hσ : 0 < σ) (X : ι → Ω → ℝ) (hX : iIndepFun X P)
    (hm : ∀ i, Measurable (X i)) (hν : ∀ i, P.map (X i) = gumbelLaw μ σ) :
    P.map (AuditExtremes.maxRV X) = gumbelLaw (μ + σ * Real.log (Fintype.card ι)) σ := by
  haveI : IsProbabilityMeasure (P.map (AuditExtremes.maxRV X)) :=
    Measure.isProbabilityMeasure_map (AuditExtremes.measurable_maxRV hm).aemeasurable
  refine Measure.eq_of_cdf _ _ (StieltjesFunction.ext fun x => ?_)
  rw [AuditExtremes.cdf_map_maxRV X hX hm hν x, cdf_gumbelLaw hσ, cdf_gumbelLaw hσ,
    AuditTails.gumbel_maxstable _ Fintype.card_pos]
  congr 1
  field_simp
  ring

/-- Fréchet: the maximum of `n` independent `frechetLaw ξ μ σ` coordinates has law
`frechetLaw ξ μ (σ n^ξ)` (endpoint unchanged, scale multiplied by `n^ξ`). -/
theorem map_maxRV_frechetLaw {ξ : ℝ} (hξ : 0 < ξ) {μ σ : ℝ} (hσ : 0 < σ) (X : ι → Ω → ℝ)
    (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i)) (hν : ∀ i, P.map (X i) = frechetLaw ξ hξ μ σ) :
    P.map (AuditExtremes.maxRV X) = frechetLaw ξ hξ μ (σ * (Fintype.card ι : ℝ) ^ ξ) := by
  haveI : IsProbabilityMeasure (P.map (AuditExtremes.maxRV X)) :=
    Measure.isProbabilityMeasure_map (AuditExtremes.measurable_maxRV hm).aemeasurable
  have hn : (0 : ℝ) < Fintype.card ι := Nat.cast_pos.mpr Fintype.card_pos
  have hσ' : 0 < σ * (Fintype.card ι : ℝ) ^ ξ := mul_pos hσ (Real.rpow_pos_of_pos hn _)
  refine Measure.eq_of_cdf _ _ (StieltjesFunction.ext fun x => ?_)
  rw [AuditExtremes.cdf_map_maxRV X hX hm hν x, cdf_frechetLaw hξ hσ, cdf_frechetLaw hξ hσ',
    AuditTails.frechet_cdf_maxstable hξ _ _ Fintype.card_pos]
  congr 1
  rw [Real.rpow_neg hn.le]
  field_simp

/-- Reverse-Weibull: the maximum of `n` independent `reverseWeibullLaw α μ σ` coordinates has law
`reverseWeibullLaw α μ (σ n^{−1/α})` (endpoint unchanged, scale shrinks towards it). -/
theorem map_maxRV_reverseWeibullLaw {α : ℝ} (hα : 0 < α) {μ σ : ℝ} (hσ : 0 < σ) (X : ι → Ω → ℝ)
    (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i))
    (hν : ∀ i, P.map (X i) = reverseWeibullLaw α hα μ σ) :
    P.map (AuditExtremes.maxRV X) =
      reverseWeibullLaw α hα μ (σ * (Fintype.card ι : ℝ) ^ (-(1 / α))) := by
  haveI : IsProbabilityMeasure (P.map (AuditExtremes.maxRV X)) :=
    Measure.isProbabilityMeasure_map (AuditExtremes.measurable_maxRV hm).aemeasurable
  have hn : (0 : ℝ) < Fintype.card ι := Nat.cast_pos.mpr Fintype.card_pos
  have hσ' : 0 < σ * (Fintype.card ι : ℝ) ^ (-(1 / α)) := mul_pos hσ (Real.rpow_pos_of_pos hn _)
  refine Measure.eq_of_cdf _ _ (StieltjesFunction.ext fun x => ?_)
  rw [AuditExtremes.cdf_map_maxRV X hX hm hν x, cdf_reverseWeibullLaw hα hσ,
    cdf_reverseWeibullLaw hα hσ', reverseWeibullCDF_maxstable hα]
  congr 1
  rw [Real.rpow_neg hn.le]
  field_simp

end Maxima

end AuditEVTLaws

#print axioms AuditEVTLaws.cdf_affineLaw
#print axioms AuditEVTLaws.cdf_gumbelLaw
#print axioms AuditEVTLaws.cdf_frechetLaw
#print axioms AuditEVTLaws.cdf_reverseWeibullLaw
#print axioms AuditEVTLaws.map_maxRV_gumbelLaw
#print axioms AuditEVTLaws.map_maxRV_frechetLaw
#print axioms AuditEVTLaws.map_maxRV_reverseWeibullLaw
