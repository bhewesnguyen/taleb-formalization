import AuditRepairs.ProbabilityBridge

/-!
# Tails of nonnegative weighted sums (backlog family T029, probabilistic half)

Book: Property 5.1, §5.2.1, printed pp. 98–99 (PDF pp. 112–113): the heavier tail dominates a
weighted sum. The unrestricted printed statement is false for signed dependent summands
(`X = Z, Y = −2Z` gives `2X + Y = 0`; SOURCE_GATES G18), and the displayed limit is printed
without its minus sign. v0.2.3 delivered the corrected *formula-level* two-term identity
(`AuditTails.two_power_tail`, `two_power_tail_min`). This module delivers the statement about
**random variables**, in the project's finite log-tail-exponent interface:

for nonnegative `X, Y : Ω → ℝ`, positive weights `a, b`, and survival functions with finite
exponents `α, β`, the survival function of `a X + b Y` has exponent `min α β`.

Route (no independence, no measurability needed for the inequalities): for every `t`,

* `{X > t/a} ⊆ {aX + bY > t}` and `{Y > t/b} ⊆ {aX + bY > t}` (nonnegativity of the other term),
* `{aX + bY > t} ⊆ {X > t/(2a)} ∪ {Y > t/(2b)}`,

so `max(S_X(t/a), S_Y(t/b)) ≤ S_Z(t) ≤ S_X(t/2a) + S_Y(t/2b)`. Three reusable analytic rules for
`HasFiniteTailExponent` — positive argument rescaling keeps the exponent, a maximum of two tails
has exponent `min`, a sum of two tails has exponent `min` — and a squeeze lemma finish the proof.
The log-denominator sign is handled once: all ratio inequalities are stated for `1 < t`, where
`log t > 0` and `s ↦ −log s / log t` is antitone on positive arguments.

What is *not* claimed: no survival-ratio asymptotics `S_Z(t) ~ c S_X(t)`, no regular variation of
the sum, no convolution asymptotics (those belong to the subexponential workstream, T008), and no
finite-family extension yet. Exponent equality is a statement about `−log S(t)/log t` only.
-/

set_option autoImplicit false

open MeasureTheory Filter Topology

namespace AuditTails

/-! ### Analytic rules for the finite log-tail exponent -/

/-- For `1 < x`, `s ↦ −log s / log x` is antitone on positive arguments. -/
theorem neg_log_div_log_antitone {s t x : ℝ} (hs : 0 < s) (hst : s ≤ t) (hx : 1 < x) :
    -Real.log t / Real.log x ≤ -Real.log s / Real.log x :=
  div_le_div_of_nonneg_right (neg_le_neg (Real.log_le_log hs hst)) (Real.log_pos hx).le

/-- Positive rescaling of the argument does not change the exponent:
`−log S(ct)/log t = (−log S(ct)/log(ct)) · (log(ct)/log t)` and the second factor tends to `1`. -/
theorem HasFiniteTailExponent.comp_const_mul {S : ℝ → ℝ} {α c : ℝ}
    (h : HasFiniteTailExponent S α) (hc : 0 < c) :
    HasFiniteTailExponent (fun t => S (c * t)) α := by
  have hct : Tendsto (fun t : ℝ => c * t) atTop atTop := Tendsto.const_mul_atTop hc tendsto_id
  refine ⟨hct.eventually h.1, ?_⟩
  have h1 : Tendsto (fun t : ℝ => -Real.log (S (c * t)) / Real.log (c * t)) atTop (𝓝 α) :=
    h.2.comp hct
  have h2 : Tendsto (fun t : ℝ => Real.log (c * t) / Real.log t) atTop (𝓝 1) := by
    have h0 : Tendsto (fun t : ℝ => Real.log c / Real.log t + 1) atTop (𝓝 (0 + 1)) :=
      (tendsto_const_nhds.div_atTop Real.tendsto_log_atTop).add tendsto_const_nhds
    rw [zero_add] at h0
    refine h0.congr' ?_
    filter_upwards [eventually_gt_atTop (1 : ℝ)] with t ht
    rw [Real.log_mul hc.ne' (by linarith : t ≠ 0), add_div, div_self (Real.log_pos ht).ne']
  have h3 := h1.mul h2
  rw [mul_one] at h3
  refine h3.congr' ?_
  filter_upwards [eventually_gt_atTop (max 1 (1 / c))] with t ht
  have hct1 : 1 < c * t := by
    have h' : 1 / c < t := lt_of_le_of_lt (le_max_right _ _) ht
    calc (1 : ℝ) < t * c := (div_lt_iff₀ hc).mp h'
      _ = c * t := mul_comm t c
  have hne : Real.log (c * t) ≠ 0 := (Real.log_pos hct1).ne'
  rw [div_mul_div_comm, mul_comm (Real.log (c * t)) (Real.log t), mul_div_mul_right _ _ hne]

/-- For positive `s₁ s₂`: `log (s₁ + s₂) ≤ log 2 + max (log s₁) (log s₂)`. -/
theorem log_add_le_log_two_add_max {s₁ s₂ : ℝ} (h₁ : 0 < s₁) (h₂ : 0 < s₂) :
    Real.log (s₁ + s₂) ≤ Real.log 2 + max (Real.log s₁) (Real.log s₂) := by
  rcases le_total s₁ s₂ with h | h
  · calc Real.log (s₁ + s₂) ≤ Real.log (2 * s₂) := Real.log_le_log (by linarith) (by linarith)
      _ = Real.log 2 + Real.log s₂ := Real.log_mul two_ne_zero h₂.ne'
      _ ≤ Real.log 2 + max (Real.log s₁) (Real.log s₂) := add_le_add_left (le_max_right _ _) _
  · calc Real.log (s₁ + s₂) ≤ Real.log (2 * s₁) := Real.log_le_log (by linarith) (by linarith)
      _ = Real.log 2 + Real.log s₁ := Real.log_mul two_ne_zero h₁.ne'
      _ ≤ Real.log 2 + max (Real.log s₁) (Real.log s₂) := add_le_add_left (le_max_left _ _) _

/-- For positive `s₁ s₂`, `log` commutes with `max`. -/
theorem log_max_of_pos {s₁ s₂ : ℝ} (h₁ : 0 < s₁) (h₂ : 0 < s₂) :
    Real.log (max s₁ s₂) = max (Real.log s₁) (Real.log s₂) := by
  rcases le_total s₁ s₂ with h | h
  · rw [max_eq_right h, max_eq_right (Real.log_le_log h₁ h)]
  · rw [max_eq_left h, max_eq_left (Real.log_le_log h₂ h)]

/-- A maximum of two tails has the smaller exponent (exactly: the ratio is the minimum of the
two ratios). -/
theorem HasFiniteTailExponent.max {S₁ S₂ : ℝ → ℝ} {α β : ℝ}
    (h₁ : HasFiniteTailExponent S₁ α) (h₂ : HasFiniteTailExponent S₂ β) :
    HasFiniteTailExponent (fun t => max (S₁ t) (S₂ t)) (min α β) := by
  refine ⟨?_, ?_⟩
  · filter_upwards [h₁.1] with t a
    exact lt_max_of_lt_left a
  · refine (h₁.2.min h₂.2).congr' ?_
    filter_upwards [h₁.1, h₂.1, eventually_gt_atTop (1 : ℝ)] with t a b ht
    rw [min_div_div_right (Real.log_pos ht).le, min_neg_neg, log_max_of_pos a b]

/-- A sum of two tails has the smaller exponent: `max ≤ S₁ + S₂ ≤ 2 max`, and the constant `2`
disappears in the log ratio. -/
theorem HasFiniteTailExponent.add {S₁ S₂ : ℝ → ℝ} {α β : ℝ}
    (h₁ : HasFiniteTailExponent S₁ α) (h₂ : HasFiniteTailExponent S₂ β) :
    HasFiniteTailExponent (fun t => S₁ t + S₂ t) (min α β) := by
  refine ⟨?_, ?_⟩
  · filter_upwards [h₁.1, h₂.1] with t a b
    exact add_pos a b
  · have hmin : Tendsto (fun t => min (-Real.log (S₁ t) / Real.log t) (-Real.log (S₂ t) / Real.log t))
        atTop (𝓝 (min α β)) := h₁.2.min h₂.2
    have hlow : Tendsto (fun t => -Real.log 2 / Real.log t +
        min (-Real.log (S₁ t) / Real.log t) (-Real.log (S₂ t) / Real.log t)) atTop (𝓝 (min α β)) := by
      have h0 : Tendsto (fun t : ℝ => -Real.log 2 / Real.log t) atTop (𝓝 0) :=
        tendsto_const_nhds.div_atTop Real.tendsto_log_atTop
      have h0' := h0.add hmin
      rwa [zero_add] at h0'
    refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlow hmin ?_ ?_
    · filter_upwards [h₁.1, h₂.1, eventually_gt_atTop (1 : ℝ)] with t a b ht
      have hl : 0 < Real.log t := Real.log_pos ht
      rw [min_div_div_right hl.le, ← add_div, min_neg_neg]
      refine div_le_div_of_nonneg_right ?_ hl.le
      have := log_add_le_log_two_add_max a b
      linarith
    · filter_upwards [h₁.1, h₂.1, eventually_gt_atTop (1 : ℝ)] with t a b ht
      have hl : 0 < Real.log t := Real.log_pos ht
      rw [min_div_div_right hl.le]
      refine div_le_div_of_nonneg_right (le_min ?_ ?_) hl.le
      · exact neg_le_neg (Real.log_le_log a (by linarith))
      · exact neg_le_neg (Real.log_le_log b (by linarith))

/-- Squeeze: a tail eventually between two tails with the same exponent has that exponent. -/
theorem HasFiniteTailExponent.of_le_of_le {L S U : ℝ → ℝ} {γ : ℝ}
    (hL : HasFiniteTailExponent L γ) (hU : HasFiniteTailExponent U γ)
    (hLS : ∀ᶠ t in atTop, L t ≤ S t) (hSU : ∀ᶠ t in atTop, S t ≤ U t) :
    HasFiniteTailExponent S γ := by
  refine ⟨?_, ?_⟩
  · filter_upwards [hL.1, hLS] with t a b
    exact lt_of_lt_of_le a b
  · refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hU.2 hL.2 ?_ ?_
    · filter_upwards [hL.1, hLS, hSU, eventually_gt_atTop (1 : ℝ)] with t a b c ht
      exact neg_log_div_log_antitone (lt_of_lt_of_le a b) c ht
    · filter_upwards [hL.1, hLS, eventually_gt_atTop (1 : ℝ)] with t a b ht
      exact neg_log_div_log_antitone a b ht

end AuditTails

namespace AuditProbability

open AuditTails

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}

/-- Survival function of a real random variable, `t ↦ P{X > t}` as a real number. Defined for
every function `Ω → ℝ`; it agrees with the law-level `survival (P.map X)` when `X` is measurable. -/
noncomputable def survivalRV (P : Measure Ω) (X : Ω → ℝ) (t : ℝ) : ℝ := P.real {ω | t < X ω}

theorem survivalRV_eq_survival_map {X : Ω → ℝ} (hX : Measurable X) :
    survivalRV P X = survival (P.map X) := by
  ext t
  simp only [survivalRV, survival, measureReal_def, Measure.map_apply hX measurableSet_Ioi]
  rfl

/-! ### Event inclusions (pure set statements, no measurability) -/

omit [MeasurableSpace Ω] in
theorem weightedSum_event_lower_left {X Y : Ω → ℝ} {a b t : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hY : ∀ ω, 0 ≤ Y ω) :
    {ω | a⁻¹ * t < X ω} ⊆ {ω | t < a * X ω + b * Y ω} := by
  intro ω h
  simp only [Set.mem_setOf_eq] at h ⊢
  have h1 : t < a * X ω := (inv_mul_lt_iff₀ ha).mp h
  have h2 : 0 ≤ b * Y ω := mul_nonneg hb.le (hY ω)
  linarith

omit [MeasurableSpace Ω] in
theorem weightedSum_event_lower_right {X Y : Ω → ℝ} {a b t : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hX : ∀ ω, 0 ≤ X ω) :
    {ω | b⁻¹ * t < Y ω} ⊆ {ω | t < a * X ω + b * Y ω} := by
  intro ω h
  simp only [Set.mem_setOf_eq] at h ⊢
  have h1 : t < b * Y ω := (inv_mul_lt_iff₀ hb).mp h
  have h2 : 0 ≤ a * X ω := mul_nonneg ha.le (hX ω)
  linarith

omit [MeasurableSpace Ω] in
theorem weightedSum_event_upper {X Y : Ω → ℝ} {a b t : ℝ} (ha : 0 < a) (hb : 0 < b) :
    {ω | t < a * X ω + b * Y ω} ⊆ {ω | (2 * a)⁻¹ * t < X ω} ∪ {ω | (2 * b)⁻¹ * t < Y ω} := by
  intro ω h
  simp only [Set.mem_setOf_eq, Set.mem_union] at h ⊢
  by_contra hcon
  push_neg at hcon
  obtain ⟨h1, h2⟩ := hcon
  have e1 : a * X ω ≤ t / 2 := by
    calc a * X ω ≤ a * ((2 * a)⁻¹ * t) := mul_le_mul_of_nonneg_left h1 ha.le
      _ = t / 2 := by field_simp
  have e2 : b * Y ω ≤ t / 2 := by
    calc b * Y ω ≤ b * ((2 * b)⁻¹ * t) := mul_le_mul_of_nonneg_left h2 hb.le
      _ = t / 2 := by field_simp
  linarith

/-! ### The probabilistic Property 5.1 -/

/-- **Property 5.1, corrected and proved for random variables.** For nonnegative `X, Y` on a
probability space and positive weights `a, b`, if the survival functions of `X` and `Y` have
finite log-tail exponents `α` and `β`, the survival function of `a X + b Y` has exponent
`min α β`. No independence is assumed; nonnegativity is pointwise (the signed case is false,
SOURCE_GATES G18). -/
theorem hasFiniteTailExponent_weightedSum [IsProbabilityMeasure P] {X Y : Ω → ℝ} {a b α β : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hX0 : ∀ ω, 0 ≤ X ω) (hY0 : ∀ ω, 0 ≤ Y ω)
    (hX : HasFiniteTailExponent (survivalRV P X) α) (hY : HasFiniteTailExponent (survivalRV P Y) β) :
    HasFiniteTailExponent (survivalRV P (fun ω => a * X ω + b * Y ω)) (min α β) := by
  have hL : HasFiniteTailExponent
      (fun t => max (survivalRV P X (a⁻¹ * t)) (survivalRV P Y (b⁻¹ * t))) (min α β) :=
    (hX.comp_const_mul (inv_pos.mpr ha)).max (hY.comp_const_mul (inv_pos.mpr hb))
  have hU : HasFiniteTailExponent
      (fun t => survivalRV P X ((2 * a)⁻¹ * t) + survivalRV P Y ((2 * b)⁻¹ * t)) (min α β) :=
    (hX.comp_const_mul (inv_pos.mpr (by positivity))).add
      (hY.comp_const_mul (inv_pos.mpr (by positivity)))
  refine hL.of_le_of_le hU (Eventually.of_forall fun t => ?_) (Eventually.of_forall fun t => ?_)
  · exact max_le
      (measureReal_mono (weightedSum_event_lower_left ha hb hY0) (measure_ne_top _ _))
      (measureReal_mono (weightedSum_event_lower_right ha hb hX0) (measure_ne_top _ _))
  · exact (measureReal_mono (weightedSum_event_upper ha hb) (measure_ne_top _ _)).trans
      (measureReal_union_le _ _)

/-- The same statement for the pushforward laws: with measurable coordinates, the law of the
weighted sum has survival exponent `min α β` whenever the coordinate laws have exponents `α, β`. -/
theorem hasFiniteTailExponent_survival_map_weightedSum [IsProbabilityMeasure P] {X Y : Ω → ℝ}
    {a b α β : ℝ} (ha : 0 < a) (hb : 0 < b) (hX0 : ∀ ω, 0 ≤ X ω) (hY0 : ∀ ω, 0 ≤ Y ω)
    (hXm : Measurable X) (hYm : Measurable Y)
    (hX : HasFiniteTailExponent (survival (P.map X)) α)
    (hY : HasFiniteTailExponent (survival (P.map Y)) β) :
    HasFiniteTailExponent (survival (P.map fun ω => a * X ω + b * Y ω)) (min α β) := by
  rw [← survivalRV_eq_survival_map ((hXm.const_mul a).add (hYm.const_mul b))]
  rw [← survivalRV_eq_survival_map hXm] at hX
  rw [← survivalRV_eq_survival_map hYm] at hY
  exact hasFiniteTailExponent_weightedSum ha hb hX0 hY0 hX hY

end AuditProbability

#print axioms AuditTails.HasFiniteTailExponent.comp_const_mul
#print axioms AuditTails.HasFiniteTailExponent.max
#print axioms AuditTails.HasFiniteTailExponent.add
#print axioms AuditTails.HasFiniteTailExponent.of_le_of_le
#print axioms AuditProbability.survivalRV_eq_survival_map
#print axioms AuditProbability.hasFiniteTailExponent_weightedSum
#print axioms AuditProbability.hasFiniteTailExponent_survival_map_weightedSum
