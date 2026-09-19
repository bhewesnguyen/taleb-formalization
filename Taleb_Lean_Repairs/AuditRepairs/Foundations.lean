import AuditRepairs.RegularVariation
import AuditRepairs.Tails

/-!
# Small extensions beyond the original sixteen files

Ratio predicates keep their deliberately weak analytic meaning. They do not
silently acquire measurability, probability, or uniform-convergence assumptions.
-/

set_option autoImplicit false
open Filter Topology

namespace AuditRV

/-- The zero-index ratio predicate is precisely slow variation. -/
theorem regularlyVarying_zero_iff {L : ℝ → ℝ} :
    IsRegularlyVarying L 0 ↔ IsSlowlyVarying L := by
  simp only [IsRegularlyVarying, IsSlowlyVarying, Real.rpow_zero]

/-- Every real power has its indicated regular-variation index. -/
theorem regularlyVarying_power (α : ℝ) :
    IsRegularlyVarying (fun x : ℝ => x ^ α) α := by
  intro b hb
  have e : (fun x : ℝ => (b * x) ^ α / x ^ α) =ᶠ[atTop]
      (fun _ => b ^ α) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
    rw [Real.mul_rpow hb.le hx.le,
      mul_div_cancel_right₀ _ (ne_of_gt (Real.rpow_pos_of_pos hx α))]
  exact Tendsto.congr' e.symm tendsto_const_nhds

/-- Changing a function on a bounded initial region preserves its ratio limits. -/
theorem IsRegularlyVarying.congr {L M : ℝ → ℝ} {α : ℝ}
    (hL : IsRegularlyVarying L α) (h : L =ᶠ[atTop] M) :
    IsRegularlyVarying M α := by
  intro b hb
  have hbtop : Tendsto (fun x : ℝ => b * x) atTop atTop :=
    Filter.Tendsto.const_mul_atTop hb tendsto_id
  have e : (fun x => L (b * x) / L x) =ᶠ[atTop]
      (fun x => M (b * x) / M x) := by
    filter_upwards [h, hbtop.eventually h] with x hx hbx
    rw [hx, hbx]
  exact Tendsto.congr' e (hL b hb)

/-- A nonzero multiplicative constant does not change the index. -/
theorem IsRegularlyVarying.const_mul {L : ℝ → ℝ} {α c : ℝ}
    (hL : IsRegularlyVarying L α) (hc : c ≠ 0) :
    IsRegularlyVarying (fun x => c * L x) α := by
  have hconst : IsRegularlyVarying (fun _ : ℝ => c) 0 :=
    regularlyVarying_zero_iff.mpr (isSlowlyVarying_const hc)
  simpa only [zero_add] using hconst.mul hL

/-- Products of slowly varying functions are slowly varying. -/
theorem IsSlowlyVarying.mul {L M : ℝ → ℝ}
    (hL : IsSlowlyVarying L) (hM : IsSlowlyVarying M) :
    IsSlowlyVarying (fun x => L x * M x) := by
  apply regularlyVarying_zero_iff.mp
  simpa only [zero_add] using
    (regularlyVarying_zero_iff.mpr hL).mul (regularlyVarying_zero_iff.mpr hM)

/-- Real powers of an eventually positive slowly varying function are slowly varying. -/
theorem IsSlowlyVarying.rpow {L : ℝ → ℝ} (hL : IsSlowlyVarying L)
    (hp : ∀ᶠ x in atTop, 0 < L x) (p : ℝ) :
    IsSlowlyVarying (fun x => L x ^ p) := by
  apply regularlyVarying_zero_iff.mp
  simpa only [mul_zero] using
    (IsRegularlyVarying.rpow (p := p) (regularlyVarying_zero_iff.mpr hL) hp)

end AuditRV

namespace AuditTails

/-- A finite tail exponent, when it exists, is unique. -/
theorem HasFiniteTailExponent.unique {S : ℝ → ℝ} {α β : ℝ}
    (hα : HasFiniteTailExponent S α) (hβ : HasFiniteTailExponent S β) : α = β :=
  tendsto_nhds_unique hα.2 hβ.2

/-- The finite interface agrees with the legacy real-valued liminf on its valid domain. -/
theorem HasFiniteTailExponent.liminf_eq {S : ℝ → ℝ} {α : ℝ}
    (h : HasFiniteTailExponent S α) : tailExponentReal S = α := h.2.liminf_eq

/-- Exact scaling of a Pareto tail exponent under a positive power transformation.
This is the analytic tail expression; identifying the pushforward law is separate. -/
theorem pareto_power_tail {C α p : ℝ} (hC : 0 < C) (_hp : 0 < p) :
    HasFiniteTailExponent (fun y : ℝ => C * (y ^ (1 / p)) ^ (-α)) (α / p) := by
  have e : (fun y : ℝ => C * (y ^ (1 / p)) ^ (-α)) =ᶠ[atTop]
      (fun y => C * y ^ (-(α / p))) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with y hy
    rw [← Real.rpow_mul hy.le]
    congr 2
    ring
  have elog : (fun y => -Real.log (C * y ^ (-(α / p))) / Real.log y) =ᶠ[atTop]
      (fun y => -Real.log (C * (y ^ (1 / p)) ^ (-α)) / Real.log y) := by
    filter_upwards [e] with y hy
    rw [hy]
  refine ⟨?_, Tendsto.congr' elog (pareto_log_ratio_tendsto hC)⟩
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with y hy
  exact mul_pos hC (Real.rpow_pos_of_pos (Real.rpow_pos_of_pos hy _) _)

/-! ### Two-term power tails (book Property 5.1, printed p. 99; docs/SOURCE_GATES.md G18)

The display under Property 5.1 reads `lim log(w₁ z^(-α₁) + w₂ z^(-α₂)) / log z = α₂`
for `α₂ ≤ α₁`; the left side actually tends to `-α₂`. The lemmas below state the
corrected content in the project's finite-exponent interface (`-log S / log z`): the
two-term survival *formula* has tail exponent `min α₁ α₂` when both weights are
positive (and still `α₂` when the weight of the lighter term is only nonnegative).
These are statements about formulas, not about sums of random variables; for the
probabilistic statement and its cancellation counterexample see G18 and backlog T029. -/

/-- Ordered form: the heavier term (smaller exponent `α₂`) decides the exponent. -/
theorem two_power_tail {w₁ w₂ α₁ α₂ : ℝ} (hw₁ : 0 ≤ w₁) (hw₂ : 0 < w₂) (h : α₂ ≤ α₁) :
    HasFiniteTailExponent (fun z : ℝ => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) α₂ := by
  have hpos : ∀ᶠ z in atTop, 0 < w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with z hz
    exact add_pos_of_nonneg_of_pos (mul_nonneg hw₁ (Real.rpow_nonneg hz.le _))
      (mul_pos hw₂ (Real.rpow_pos_of_pos hz _))
  refine ⟨hpos, ?_⟩
  rcases lt_or_eq_of_le h with hlt | heq
  · -- Strictly lighter first term: the ratio to the dominant Pareto term tends to `1`.
    have hratio : Tendsto
        (fun z : ℝ => (w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) / (w₂ * z ^ (-α₂))) atTop (𝓝 1) := by
      have e : (fun z : ℝ => (w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) / (w₂ * z ^ (-α₂))) =ᶠ[atTop]
          (fun z : ℝ => (w₁ / w₂) * z ^ (-(α₁ - α₂)) + 1) := by
        filter_upwards [eventually_gt_atTop (0 : ℝ)] with z hz
        have h1 : z ^ (-α₂) ≠ 0 := ne_of_gt (Real.rpow_pos_of_pos hz _)
        have h2 : z ^ (-(α₁ - α₂)) = z ^ (-α₁) / z ^ (-α₂) := by
          rw [← Real.rpow_sub hz]; congr 1; ring
        rw [h2]
        field_simp
      have hlim : Tendsto (fun z : ℝ => (w₁ / w₂) * z ^ (-(α₁ - α₂)) + 1) atTop (𝓝 ((w₁ / w₂) * 0 + 1)) :=
        ((tendsto_rpow_neg_atTop (sub_pos.mpr hlt)).const_mul _).add tendsto_const_nhds
      rw [mul_zero, zero_add] at hlim
      exact Tendsto.congr' e.symm hlim
    exact tail_log_ratio_of_ratio_tendsto one_ne_zero hratio (pareto_log_ratio_tendsto hw₂)
      (hpos.mono fun _ hz => ne_of_gt hz)
      ((eventually_gt_atTop (0 : ℝ)).mono fun z hz =>
        ne_of_gt (mul_pos hw₂ (Real.rpow_pos_of_pos hz _)))
  · -- Equal exponents: the formula is a single Pareto term with weight `w₁ + w₂`.
    subst heq
    have e : (fun z : ℝ => w₁ * z ^ (-α₂) + w₂ * z ^ (-α₂)) = fun z : ℝ => (w₁ + w₂) * z ^ (-α₂) := by
      funext z; ring
    rw [e]
    exact pareto_log_ratio_tendsto (add_pos_of_nonneg_of_pos hw₁ hw₂)

/-- Symmetric form, as the book states Property 5.1 ("all weights strictly positive"):
the two-term power-tail formula has tail exponent `min α₁ α₂`. -/
theorem two_power_tail_min {w₁ w₂ α₁ α₂ : ℝ} (hw₁ : 0 < w₁) (hw₂ : 0 < w₂) :
    HasFiniteTailExponent (fun z : ℝ => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) (min α₁ α₂) := by
  rcases le_total α₂ α₁ with h | h
  · rw [min_eq_right h]
    exact two_power_tail hw₁.le hw₂ h
  · rw [min_eq_left h]
    have e : (fun z : ℝ => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) =
        fun z : ℝ => w₂ * z ^ (-α₂) + w₁ * z ^ (-α₁) := by
      funext z; ring
    rw [e]
    exact two_power_tail hw₂.le hw₁ h

end AuditTails

namespace AuditMoments

/-- Algebraic excess for the corrected shifted-gamma mixture mean.
The gamma inverse-moment integral is an outstanding probability theorem. -/
theorem gamma_mixture_excess (scale m s : ℝ)
    (hm : m ≠ 0) (hd : m ^ 2 - s ^ 2 ≠ 0) :
    scale * (1 + m / (m ^ 2 - s ^ 2)) - scale * (1 + 1 / m) =
      scale * s ^ 2 / (m * (m ^ 2 - s ^ 2)) := by
  field_simp
  ring

/-- Positive scale and a nonzero spread yield a strictly positive gamma excess
inside the finite-inverse-moment parameter region. -/
theorem gamma_mixture_excess_pos {scale m s : ℝ}
    (hscale : 0 < scale) (hm : 0 < m) (hs : s ≠ 0)
    (hd : 0 < m ^ 2 - s ^ 2) :
    0 < scale * s ^ 2 / (m * (m ^ 2 - s ^ 2)) :=
  div_pos (mul_pos hscale (sq_pos_of_ne_zero hs)) (mul_pos hm hd)

end AuditMoments
