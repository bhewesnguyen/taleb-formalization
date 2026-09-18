import AuditRepairs.Stable
import AuditRepairs.Tails
import Mathlib.MeasureTheory.Measure.CharacteristicFunction
import Mathlib.Probability.Independence.Basic

/-!
# Genuine measure interfaces

These theorems reuse Mathlib's convolution and characteristic-function uniqueness.
The stable-law theorem is conditional on existence of laws with the specified
characteristic functions. It does not prove that such a law exists for every
admissible parameter tuple. Subexponentiality below concerns a convolution of
the measure with itself, not two unrelated real functions.
-/

set_option autoImplicit false
open MeasureTheory ProbabilityTheory Filter Topology
open scoped ENNReal

namespace AuditProbability

/-- The strict right tail of a probability measure, represented as a real number. -/
noncomputable def survival (μ : Measure ℝ) (x : ℝ) : ℝ := μ.real (Set.Ioi x)

/-- A nonnegative probability law whose convolution tail is asymptotic to twice
its own tail. Eventual positivity makes the quotient nonvacuous. -/
def IsSubexponential (μ : Measure ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ μ (Set.Iio 0) = 0 ∧
  (∀ᶠ x in atTop, 0 < survival μ x) ∧
  Tendsto (fun x => survival (μ ∗ μ) x / survival μ x) atTop (𝓝 2)

/-- A finite tail exponent is preserved by self-convolution for a subexponential law. -/
theorem IsSubexponential.finiteTailExponent {μ : Measure ℝ} {α : ℝ}
    (h : IsSubexponential μ)
    (hα : AuditTails.HasFiniteTailExponent (survival μ) α) :
    AuditTails.HasFiniteTailExponent (survival (μ ∗ μ)) α := by
  have hrpos : ∀ᶠ x in atTop, 0 < survival (μ ∗ μ) x / survival μ x :=
    h.2.2.2.eventually (eventually_gt_nhds (by norm_num : (0 : ℝ) < 2))
  have hpos : ∀ᶠ x in atTop, 0 < survival (μ ∗ μ) x := by
    filter_upwards [hrpos, h.2.2.1] with x hr hs
    have hm := mul_pos hr hs
    simpa only [div_mul_cancel₀ _ (ne_of_gt hs)] using hm
  exact ⟨hpos, AuditTails.tail_log_ratio_of_ratio_tendsto
    (by norm_num : (2 : ℝ) ≠ 0) h.2.2.2 hα.2
    (hpos.mono fun _ hx => ne_of_gt hx)
    (hα.1.mono fun _ hx => ne_of_gt hx)⟩

/-- Zero-fold convolution is the point mass at zero. -/
noncomputable def convolutionPower (μ : Measure ℝ) : ℕ → Measure ℝ
  | 0 => Measure.dirac 0
  | n + 1 => convolutionPower μ n ∗ μ

instance convolutionPower_probability (μ : Measure ℝ) [IsProbabilityMeasure μ]
    (n : ℕ) : IsProbabilityMeasure (convolutionPower μ n) := by
  induction n with
  | zero => dsimp [convolutionPower]; infer_instance
  | succ n ih =>
    letI := ih
    dsimp [convolutionPower]
    infer_instance

/-- Characteristic functions turn convolution powers into ordinary powers. -/
theorem charFun_convolutionPower (μ : Measure ℝ) [IsProbabilityMeasure μ]
    (n : ℕ) (t : ℝ) :
    charFun (convolutionPower μ n) t = charFun μ t ^ n := by
  induction n with
  | zero => simp [convolutionPower, charFun_dirac]
  | succ n ih => rw [convolutionPower, charFun_conv, ih, pow_succ]

/-- Conditional law-of-sum identification, including the S1 alpha=1 branch.
Existence is explicitly represented by the two characteristic-function premises. -/
theorem stableS1_convolutionPower_eq {μ ν : Measure ℝ}
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν]
    (p : StableAudit.StableParameters) (n : ℕ)
    (hμ : ∀ t, charFun μ t =
      StableAudit.stableS1Expr p.alpha p.beta p.location p.scale t)
    (hν : ∀ t, charFun ν t =
      StableAudit.stableS1Expr p.alpha p.beta (n * p.location)
        ((n : ℝ) ^ (1 / p.alpha) * p.scale) t) :
    convolutionPower μ n = ν := by
  apply Measure.ext_of_charFun
  funext t
  rw [charFun_convolutionPower, hμ, hν]
  exact StableAudit.stableS1Expr_power n t p.alpha_pos

/-- Independent real random variables induce the convolution of their laws. -/
theorem law_independent_sum {Ω : Type*} [MeasurableSpace Ω]
    {P : Measure Ω} [IsProbabilityMeasure P] {X Y : Ω → ℝ}
    (hX : AEMeasurable X P) (hY : AEMeasurable Y P) (hXY : IndepFun X Y P) :
    P.map (fun ω => X ω + Y ω) = P.map X ∗ P.map Y :=
  hXY.map_add_eq_map_conv_map₀ hX hY

end AuditProbability
