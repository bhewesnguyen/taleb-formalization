import AuditRepairs.Tails
import Mathlib.MeasureTheory.Measure.Real
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

end AuditExtremes

#print axioms AuditExtremes.measure_maxLeEvent
#print axioms AuditExtremes.measure_maxLeEvent_of_forall_eq
#print axioms AuditExtremes.measureReal_maxLeEvent_of_forall_eq
#print axioms AuditExtremes.measureReal_maxLeEvent_frechet
#print axioms AuditExtremes.measureReal_maxLeEvent_gumbel
