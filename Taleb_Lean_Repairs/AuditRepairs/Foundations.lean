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
