import AuditRepairs.Tails
import Mathlib.MeasureTheory.Measure.Real
import Mathlib.Probability.CDF
import Mathlib.Probability.Independence.Basic

/-!
# Independent maxima and the EVT formulas at the probability level (backlog family T060, part)

The Proof10/Proof11 replacements (`AuditTails.frechet_cdf_maxstable`,
`AuditTails.gumbel_maxstable`) are identities between real-valued *formulas*:
`F(x)^n = F(a_n x)` resp. `G(x)^n = G(x − log n)`. Here they are connected to
random variables. For a finite family `X : ι → Ω → ℝ` of independent random
variables (`iIndepFun`), the event "every coordinate is at most `x`" — i.e. the
maximum is at most `x` — has probability `∏ᵢ P(Xᵢ ≤ x)` (Mathlib's
`iIndepFun.meas_iInter`), hence `p^n` when the coordinates share the value
`p = P(Xᵢ ≤ x)`. Specialising to coordinates whose distribution function is the
Fréchet resp. Gumbel formula gives the max-stability statements of book Section
9.1 (printed p. 173, PDF p. 187) as statements about independent maxima.

What is *not* done here: constructing a probability measure whose distribution
function is `frechetCDF ξ` or `gumbelCDF` (backlog T061), and the maximum
domain of attraction (T011). The hypotheses below assume the coordinates already
have those distribution functions at every point.
-/

set_option autoImplicit false

open MeasureTheory ProbabilityTheory
open scoped ENNReal

namespace AuditExtremes

variable {Ω : Type*} {ι : Type*}

/-- The event that every coordinate is at most `x`; equivalently the maximum is at most `x`
(for nonempty `ι`). -/
def maxLeEvent (X : ι → Ω → ℝ) (x : ℝ) : Set Ω := {ω | ∀ i, X i ω ≤ x}

theorem maxLeEvent_eq_iInter (X : ι → Ω → ℝ) (x : ℝ) :
    maxLeEvent X x = ⋂ i, X i ⁻¹' Set.Iic x := by
  ext ω
  simp [maxLeEvent]

/-- Every coordinate exceeds `x` strictly: the minimum is `> x` (survival convention
`P(X > x)`, matching `AuditProbability.survival`). -/
def minGtEvent (X : ι → Ω → ℝ) (x : ℝ) : Set Ω := {ω | ∀ i, x < X i ω}

/-- Every coordinate is at least `x`: the minimum is `≥ x` (non-strict variant; the two
differ exactly on atoms). -/
def minGeEvent (X : ι → Ω → ℝ) (x : ℝ) : Set Ω := {ω | ∀ i, x ≤ X i ω}

/-- Every coordinate is below `x` strictly: the maximum is `< x`. -/
def maxLtEvent (X : ι → Ω → ℝ) (x : ℝ) : Set Ω := {ω | ∀ i, X i ω < x}

theorem minGtEvent_eq_iInter (X : ι → Ω → ℝ) (x : ℝ) :
    minGtEvent X x = ⋂ i, X i ⁻¹' Set.Ioi x := by
  ext ω
  simp [minGtEvent]

theorem minGeEvent_eq_iInter (X : ι → Ω → ℝ) (x : ℝ) :
    minGeEvent X x = ⋂ i, X i ⁻¹' Set.Ici x := by
  ext ω
  simp [minGeEvent]

theorem maxLtEvent_eq_iInter (X : ι → Ω → ℝ) (x : ℝ) :
    maxLtEvent X x = ⋂ i, X i ⁻¹' Set.Iio x := by
  ext ω
  simp [maxLtEvent]

/-- The maximum of finitely many (nonempty index) real random variables, as a random variable. -/
noncomputable def maxRV [Fintype ι] [Nonempty ι] (X : ι → Ω → ℝ) : Ω → ℝ :=
  Finset.univ.sup' Finset.univ_nonempty X

/-- The minimum of finitely many (nonempty index) real random variables, as a random variable. -/
noncomputable def minRV [Fintype ι] [Nonempty ι] (X : ι → Ω → ℝ) : Ω → ℝ :=
  Finset.univ.inf' Finset.univ_nonempty X

theorem maxRV_preimage_Iic [Fintype ι] [Nonempty ι] (X : ι → Ω → ℝ) (x : ℝ) :
    maxRV X ⁻¹' Set.Iic x = maxLeEvent X x := by
  ext ω
  simp [maxRV, maxLeEvent, Finset.sup'_apply, Finset.sup'_le_iff]

theorem minRV_preimage_Ioi [Fintype ι] [Nonempty ι] (X : ι → Ω → ℝ) (x : ℝ) :
    minRV X ⁻¹' Set.Ioi x = minGtEvent X x := by
  ext ω
  simp [minRV, minGtEvent, Finset.inf'_apply, Finset.lt_inf'_iff]

variable [MeasurableSpace Ω] {P : Measure Ω} [Fintype ι]

/-- Independent coordinates: the distribution function of the maximum is the product of the
coordinate distribution functions. No identical-distribution assumption. -/
theorem measure_maxLeEvent (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ) :
    P (maxLeEvent X x) = ∏ i, P (X i ⁻¹' Set.Iic x) := by
  rw [maxLeEvent_eq_iInter]
  exact hX.meas_iInter fun _ => ⟨Set.Iic x, measurableSet_Iic, rfl⟩

/-- Independent coordinates with a common value `p = P(Xᵢ ≤ x)`: `P(max ≤ x) = p ^ n`. -/
theorem measure_maxLeEvent_of_forall_eq (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ)
    {p : ℝ≥0∞} (hp : ∀ i, P (X i ⁻¹' Set.Iic x) = p) :
    P (maxLeEvent X x) = p ^ Fintype.card ι := by
  rw [measure_maxLeEvent X hX x]
  simp [hp, Finset.prod_const, Finset.card_univ]

/-- Real-valued version for a finite measure and a nonempty index type. -/
theorem measureReal_maxLeEvent_of_forall_eq [IsFiniteMeasure P] [Nonempty ι]
    (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ) {q : ℝ}
    (hq : ∀ i, P.real (X i ⁻¹' Set.Iic x) = q) :
    P.real (maxLeEvent X x) = q ^ Fintype.card ι := by
  have hq0 : 0 ≤ q := (hq (Classical.arbitrary ι)) ▸ measureReal_nonneg
  have hp : ∀ i, P (X i ⁻¹' Set.Iic x) = ENNReal.ofReal q := fun i => by
    rw [← hq i, Measure.real, ENNReal.ofReal_toReal (measure_ne_top _ _)]
  rw [Measure.real, measure_maxLeEvent_of_forall_eq X hX x hp, ENNReal.toReal_pow,
    ENNReal.toReal_ofReal hq0]

/-- Fréchet max-stability for independent maxima: if each coordinate has the Fréchet(ξ)
distribution function at every point, the maximum of `n = |ι|` of them has distribution
function `frechetCDF ξ (n^(-ξ) x)`. Upgrades `AuditTails.frechet_cdf_maxstable` from a
formula identity to a statement about random variables, conditional on the coordinates'
distribution-function hypothesis. -/
theorem measureReal_maxLeEvent_frechet [IsFiniteMeasure P] [Nonempty ι]
    (X : ι → Ω → ℝ) (hX : iIndepFun X P) {ξ : ℝ} (hξ : 0 < ξ)
    (hF : ∀ i x, P.real (X i ⁻¹' Set.Iic x) = AuditTails.frechetCDF ξ x) (x : ℝ) :
    P.real (maxLeEvent X x) = AuditTails.frechetCDF ξ ((Fintype.card ι : ℝ) ^ (-ξ) * x) := by
  rw [measureReal_maxLeEvent_of_forall_eq X hX x (fun i => hF i x),
    AuditTails.frechet_cdf_maxstable hξ x _ Fintype.card_pos]

/-- Gumbel max-stability for independent maxima, likewise conditional on the coordinates'
distribution-function hypothesis. -/
theorem measureReal_maxLeEvent_gumbel [IsFiniteMeasure P] [Nonempty ι]
    (X : ι → Ω → ℝ) (hX : iIndepFun X P)
    (hG : ∀ i x, P.real (X i ⁻¹' Set.Iic x) = AuditTails.gumbelCDF x) (x : ℝ) :
    P.real (maxLeEvent X x) = AuditTails.gumbelCDF (x - Real.log (Fintype.card ι)) := by
  rw [measureReal_maxLeEvent_of_forall_eq X hX x (fun i => hG i x),
    AuditTails.gumbel_maxstable _ Fintype.card_pos]

/-! ### General product formula, minima, and the laws of `max` and `min` (v0.2.4)

Book §9.1, printed p. 173 (PDF p. 187): the maximum of `n` iid variables with distribution
function `F` has distribution function `F^n`; the survival analogue for the minimum is
`P(min > x) = S(x)^n` with `S = 1 − F`. Threshold conventions are stated explicitly
(`Iic`/`Iio` for maxima, `Ioi`/`Ici` for minima) so that atoms are handled exactly. -/

/-- Independent coordinates and any measurable `B ⊆ ℝ`: the probability that every
coordinate lies in `B` is the product of the coordinate probabilities. Every threshold
event in this file is an instance. -/
theorem measure_iInter_preimage (X : ι → Ω → ℝ) (hX : iIndepFun X P) {B : Set ℝ}
    (hB : MeasurableSet B) : P (⋂ i, X i ⁻¹' B) = ∏ i, P (X i ⁻¹' B) :=
  hX.meas_iInter fun _ => ⟨B, hB, rfl⟩

theorem measure_minGtEvent (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ) :
    P (minGtEvent X x) = ∏ i, P (X i ⁻¹' Set.Ioi x) := by
  rw [minGtEvent_eq_iInter]
  exact measure_iInter_preimage X hX measurableSet_Ioi

theorem measure_minGeEvent (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ) :
    P (minGeEvent X x) = ∏ i, P (X i ⁻¹' Set.Ici x) := by
  rw [minGeEvent_eq_iInter]
  exact measure_iInter_preimage X hX measurableSet_Ici

theorem measure_maxLtEvent (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ) :
    P (maxLtEvent X x) = ∏ i, P (X i ⁻¹' Set.Iio x) := by
  rw [maxLtEvent_eq_iInter]
  exact measure_iInter_preimage X hX measurableSet_Iio

/-- Independent coordinates with a common strict survival value `p = P(Xᵢ > x)`:
`P(min > x) = p ^ n`. -/
theorem measure_minGtEvent_of_forall_eq (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ)
    {p : ℝ≥0∞} (hp : ∀ i, P (X i ⁻¹' Set.Ioi x) = p) :
    P (minGtEvent X x) = p ^ Fintype.card ι := by
  rw [measure_minGtEvent X hX x]
  simp [hp, Finset.prod_const, Finset.card_univ]

/-- Real-valued version of the minimum survival power law. -/
theorem measureReal_minGtEvent_of_forall_eq [IsFiniteMeasure P] [Nonempty ι]
    (X : ι → Ω → ℝ) (hX : iIndepFun X P) (x : ℝ) {q : ℝ}
    (hq : ∀ i, P.real (X i ⁻¹' Set.Ioi x) = q) :
    P.real (minGtEvent X x) = q ^ Fintype.card ι := by
  have hq0 : 0 ≤ q := (hq (Classical.arbitrary ι)) ▸ measureReal_nonneg
  have hp : ∀ i, P (X i ⁻¹' Set.Ioi x) = ENNReal.ofReal q := fun i => by
    rw [← hq i, Measure.real, ENNReal.ofReal_toReal (measure_ne_top _ _)]
  rw [Measure.real, measure_minGtEvent_of_forall_eq X hX x hp, ENNReal.toReal_pow,
    ENNReal.toReal_ofReal hq0]

section CommonLaw

variable {ν : Measure ℝ}

omit [Fintype ι] in
/-- With measurable coordinates of common law `ν`, each coordinate probability is `ν B`. -/
theorem measure_preimage_of_map_eq {X : ι → Ω → ℝ} (hm : ∀ i, Measurable (X i))
    (hν : ∀ i, P.map (X i) = ν) {B : Set ℝ} (hB : MeasurableSet B) (i : ι) :
    P (X i ⁻¹' B) = ν B := by
  rw [← hν i, Measure.map_apply (hm i) hB]

theorem measure_maxLeEvent_of_map_eq (X : ι → Ω → ℝ) (hX : iIndepFun X P)
    (hm : ∀ i, Measurable (X i)) (hν : ∀ i, P.map (X i) = ν) (x : ℝ) :
    P (maxLeEvent X x) = (ν (Set.Iic x)) ^ Fintype.card ι :=
  measure_maxLeEvent_of_forall_eq X hX x fun i =>
    measure_preimage_of_map_eq hm hν measurableSet_Iic i

theorem measure_minGtEvent_of_map_eq (X : ι → Ω → ℝ) (hX : iIndepFun X P)
    (hm : ∀ i, Measurable (X i)) (hν : ∀ i, P.map (X i) = ν) (x : ℝ) :
    P (minGtEvent X x) = (ν (Set.Ioi x)) ^ Fintype.card ι :=
  measure_minGtEvent_of_forall_eq X hX x fun i =>
    measure_preimage_of_map_eq hm hν measurableSet_Ioi i

theorem measurable_maxRV [Nonempty ι] {X : ι → Ω → ℝ} (hm : ∀ i, Measurable (X i)) :
    Measurable (maxRV X) :=
  Finset.measurable_sup' _ fun i _ => hm i

theorem measurable_minRV [Nonempty ι] {X : ι → Ω → ℝ} (hm : ∀ i, Measurable (X i)) :
    Measurable (minRV X) :=
  -- Mathlib has `Finset.measurable_sup'` but no `inf'` twin in the pinned snapshot;
  -- this is the same induction.
  Finset.inf'_induction Finset.univ_nonempty X (fun _f hf _g hg => hf.inf hg) fun i _ => hm i

/-- **Distribution function of the maximum** (book §9.1): for independent measurable
coordinates with common law `ν`, the law of `max_i Xᵢ` has distribution function
`(cdf ν x) ^ n`. Atoms are permitted; `n = |ι| > 0`. -/
theorem cdf_map_maxRV [Nonempty ι] [IsProbabilityMeasure P] (X : ι → Ω → ℝ)
    (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i)) (hν : ∀ i, P.map (X i) = ν) (x : ℝ) :
    cdf (P.map (maxRV X)) x = (cdf ν x) ^ Fintype.card ι := by
  haveI : IsProbabilityMeasure ν := by
    rw [← hν (Classical.arbitrary ι)]
    exact Measure.isProbabilityMeasure_map (hm _).aemeasurable
  haveI : IsProbabilityMeasure (P.map (maxRV X)) :=
    Measure.isProbabilityMeasure_map (measurable_maxRV hm).aemeasurable
  rw [cdf_eq_real, cdf_eq_real, Measure.real, Measure.real,
    Measure.map_apply (measurable_maxRV hm) measurableSet_Iic, maxRV_preimage_Iic,
    measure_maxLeEvent_of_map_eq X hX hm hν x, ENNReal.toReal_pow]

/-- **Survival function of the minimum**: `P(min_i Xᵢ > x) = (ν(x, ∞)) ^ n`. -/
theorem measureReal_map_minRV_Ioi [Nonempty ι] [IsProbabilityMeasure P] (X : ι → Ω → ℝ)
    (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i)) (hν : ∀ i, P.map (X i) = ν) (x : ℝ) :
    (P.map (minRV X)).real (Set.Ioi x) = (ν.real (Set.Ioi x)) ^ Fintype.card ι := by
  rw [Measure.real, Measure.real, Measure.map_apply (measurable_minRV hm) measurableSet_Ioi,
    minRV_preimage_Ioi, measure_minGtEvent_of_map_eq X hX hm hν x, ENNReal.toReal_pow]

/-- The same in terms of the common distribution function: `P(min > x) = (1 − F(x)) ^ n`. -/
theorem measureReal_map_minRV_Ioi_eq_one_sub_cdf [Nonempty ι] [IsProbabilityMeasure P]
    (X : ι → Ω → ℝ) (hX : iIndepFun X P) (hm : ∀ i, Measurable (X i))
    (hν : ∀ i, P.map (X i) = ν) (x : ℝ) :
    (P.map (minRV X)).real (Set.Ioi x) = (1 - cdf ν x) ^ Fintype.card ι := by
  haveI : IsProbabilityMeasure ν := by
    rw [← hν (Classical.arbitrary ι)]
    exact Measure.isProbabilityMeasure_map (hm _).aemeasurable
  rw [measureReal_map_minRV_Ioi X hX hm hν x, cdf_eq_real]
  congr 1
  have hc : Set.Ioi x = (Set.Iic x)ᶜ := by
    ext y
    simp
  rw [hc, measureReal_compl measurableSet_Iic, measureReal_univ_eq_one]

end CommonLaw

end AuditExtremes

#print axioms AuditExtremes.measure_maxLeEvent
#print axioms AuditExtremes.measure_maxLeEvent_of_forall_eq
#print axioms AuditExtremes.measureReal_maxLeEvent_of_forall_eq
#print axioms AuditExtremes.measureReal_maxLeEvent_frechet
#print axioms AuditExtremes.measureReal_maxLeEvent_gumbel
#print axioms AuditExtremes.measure_iInter_preimage
#print axioms AuditExtremes.measure_minGtEvent_of_forall_eq
#print axioms AuditExtremes.cdf_map_maxRV
#print axioms AuditExtremes.measureReal_map_minRV_Ioi
#print axioms AuditExtremes.measureReal_map_minRV_Ioi_eq_one_sub_cdf
