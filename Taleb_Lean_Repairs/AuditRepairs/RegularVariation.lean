import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.Convex.SpecificFunctions.Basic
import Mathlib.Data.Real.Sign
import Mathlib.Topology.Algebra.Order.Field
import Mathlib.Analysis.SpecialFunctions.Pow.Continuity


set_option autoImplicit false

/-
Repairs/simplifications for Proof01-Proof06.
Checked with Lean 4.24.0 and the audit's pinned Mathlib v4.24.0 environment.
The definitions retain the uploaded pack's ratio-only convention.
-/

open Filter Topology

namespace AuditRV

def IsSlowlyVarying (L : ℝ → ℝ) : Prop :=
  ∀ b : ℝ, 0 < b → Tendsto (fun x => L (b * x) / L x) atTop (𝓝 1)

def IsRegularlyVarying (L : ℝ → ℝ) (α : ℝ) : Prop :=
  ∀ b : ℝ, 0 < b → Tendsto (fun x => L (b * x) / L x) atTop (𝓝 (b ^ α))

theorem isSlowlyVarying_log : IsSlowlyVarying Real.log := by
  intro b hb
  have e : (fun x => Real.log (b * x) / Real.log x) =ᶠ[atTop]
      (fun x => 1 + Real.log b / Real.log x) := by
    filter_upwards [eventually_gt_atTop 1] with x hx
    have hx0 : (0 : ℝ) < x := lt_trans zero_lt_one hx
    have hlogx : Real.log x ≠ 0 := ne_of_gt (Real.log_pos hx)
    rw [Real.log_mul (ne_of_gt hb) (ne_of_gt hx0),
      add_div, div_self hlogx, add_comm]
  have hdiv : Tendsto (fun x => Real.log b / Real.log x) atTop (𝓝 0) :=
    tendsto_const_nhds.div_atTop Real.tendsto_log_atTop
  have hadd : Tendsto (fun x => (1 : ℝ) + Real.log b / Real.log x)
      atTop (𝓝 (1 + 0)) := tendsto_const_nhds.add hdiv
  rw [add_zero] at hadd
  exact Tendsto.congr' e.symm hadd

theorem isSlowlyVarying_const {c : ℝ} (hc : c ≠ 0) :
    IsSlowlyVarying (fun _ => c) := by
  intro b hb
  simpa only [div_self hc] using
    (tendsto_const_nhds : Tendsto (fun _ : ℝ => (1 : ℝ)) atTop (𝓝 1))

/-- Diagnostic for the ratio-only convention. The book defines a slowly varying
function with codomain `(0, +∞)` (§2.2.1 printed p. 9, §E.1 printed p. 190,
Definition 21.1 printed p. 380; PDF pages +14). `IsSlowlyVarying` only constrains
ratios, so a negative constant satisfies it although it can never be the
slowly varying factor of a survival function. Results proved from these
predicates therefore need an explicit positivity hypothesis before they are
read as statements about the book's class. -/
theorem isSlowlyVarying_neg_one : IsSlowlyVarying (fun _ : ℝ => (-1 : ℝ)) :=
  isSlowlyVarying_const (by norm_num)

theorem IsSlowlyVarying.of_tendsto_const {L : ℝ → ℝ} {c : ℝ}
    (hc : c ≠ 0) (hL : Tendsto L atTop (𝓝 c)) : IsSlowlyVarying L := by
  intro b hb
  have hmul : Tendsto (fun x => b * x) atTop atTop :=
    Filter.Tendsto.const_mul_atTop hb tendsto_id
  simpa only [div_self hc] using (hL.comp hmul).div hL hc

theorem IsRegularlyVarying.mul {L₁ L₂ : ℝ → ℝ} {α₁ α₂ : ℝ}
    (h₁ : IsRegularlyVarying L₁ α₁) (h₂ : IsRegularlyVarying L₂ α₂) :
    IsRegularlyVarying (fun x => L₁ x * L₂ x) (α₁ + α₂) := by
  intro b hb
  simpa only [div_mul_div_comm, Real.rpow_add hb] using
    (h₁ b hb).mul (h₂ b hb)

theorem IsRegularlyVarying.rpow {L : ℝ → ℝ} {α p : ℝ}
    (hL : IsRegularlyVarying L α) (hpos : ∀ᶠ x in atTop, 0 < L x) :
    IsRegularlyVarying (fun x => (L x) ^ p) (p * α) := by
  intro b hb
  have hmul : Tendsto (fun x => b * x) atTop atTop :=
    Filter.Tendsto.const_mul_atTop hb tendsto_id
  have hpos' : ∀ᶠ x in atTop, 0 < L (b * x) := hmul.eventually hpos
  have e : (fun x => (L (b * x)) ^ p / (L x) ^ p) =ᶠ[atTop]
      (fun x => (L (b * x) / L x) ^ p) := by
    filter_upwards [hpos, hpos'] with x hx1 hx2
    rw [Real.div_rpow (le_of_lt hx2) (le_of_lt hx1)]
  have hlim : Tendsto (fun x => (L (b * x) / L x) ^ p)
      atTop (𝓝 ((b ^ α) ^ p)) :=
    (hL b hb).rpow_const
      (Or.inl (ne_of_gt (Real.rpow_pos_of_pos hb α)))
  have hlim' : Tendsto (fun x => (L (b * x) / L x) ^ p)
      atTop (𝓝 (b ^ (p * α))) := by
    simpa only [← Real.rpow_mul (le_of_lt hb), mul_comm α p] using hlim
  exact Tendsto.congr' e.symm hlim'

/-- Stronger than Proof06: no sign hypothesis on L is needed for this ratio-only predicate. -/
theorem isRegularlyVarying_iff_slowlyVarying {L : ℝ → ℝ} {α : ℝ} :
    IsRegularlyVarying L α ↔ IsSlowlyVarying (fun x => L x / x ^ α) := by
  have hnorm (b : ℝ) (hb : 0 < b) :
      (fun x => (L (b * x) / (b * x) ^ α) / (L x / x ^ α)) =ᶠ[atTop]
      (fun x => (L (b * x) / L x) / b ^ α) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
    have hbα : b ^ α ≠ 0 := ne_of_gt (Real.rpow_pos_of_pos hb α)
    have hxα : x ^ α ≠ 0 := ne_of_gt (Real.rpow_pos_of_pos hx α)
    rw [Real.mul_rpow (le_of_lt hb) (le_of_lt hx)]
    by_cases hLx : L x = 0
    · simp [hLx]
    · field_simp
  constructor
  · intro h b hb
    have hbα : b ^ α ≠ 0 := ne_of_gt (Real.rpow_pos_of_pos hb α)
    have hlim := (h b hb).div_const (b ^ α)
    rw [div_self hbα] at hlim
    exact Tendsto.congr' (hnorm b hb).symm hlim
  · intro h b hb
    have hbα : b ^ α ≠ 0 := ne_of_gt (Real.rpow_pos_of_pos hb α)
    have hratio : Tendsto (fun x => (L (b * x) / L x) / b ^ α)
        atTop (𝓝 1) := Tendsto.congr' (hnorm b hb) (h b hb)
    have hlim := hratio.mul_const (b ^ α)
    simpa only [div_mul_cancel₀ _ hbα, one_mul] using hlim

end AuditRV

#print axioms AuditRV.isSlowlyVarying_log
#print axioms AuditRV.isSlowlyVarying_const
#print axioms AuditRV.isSlowlyVarying_neg_one
#print axioms AuditRV.IsSlowlyVarying.of_tendsto_const
#print axioms AuditRV.IsRegularlyVarying.mul
#print axioms AuditRV.IsRegularlyVarying.rpow
#print axioms AuditRV.isRegularlyVarying_iff_slowlyVarying
