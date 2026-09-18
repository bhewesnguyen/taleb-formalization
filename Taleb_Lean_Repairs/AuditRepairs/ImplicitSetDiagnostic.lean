import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.Convex.SpecificFunctions.Basic
import Mathlib.Data.Real.Sign
import Mathlib.Topology.Algebra.Order.Field

open Filter Topology

namespace Proof09Probe

-- Copy of the submitted theorem's proposition in a declaration TYPE, under
-- its exact imports and open declarations. The implication is reflexive so
-- the probe proves only elaboration, never assumes the submitted claim.
-- autoImplicit acts in declaration types, not a def's value body.
theorem signature_probe {c : ℝ} (_hc : 0 < c) :
    ConvexOn ℝ univ (fun α : ℝ => c ^ (-α)) →
      ConvexOn ℝ univ (fun α : ℝ => c ^ (-α)) := fun h => h

#check @signature_probe
#print signature_probe

-- The resulting proposition with the captured binder stated explicitly.
def statement {univ : Set ℝ} {c : ℝ} (_hc : 0 < c) : Prop :=
  ConvexOn ℝ univ (fun α : ℝ => c ^ (-α))

#check @statement
#print statement

-- The implicit set can be a nonconvex two-point set. ConvexOn includes
-- convexity of the domain, so no function can be ConvexOn on this set.
theorem pair_not_convex : ¬ Convex ℝ ({(0 : ℝ), 2} : Set ℝ) := by
  intro h
  have hm := h (by simp : (0 : ℝ) ∈ ({(0 : ℝ), 2} : Set ℝ))
    (by simp : (2 : ℝ) ∈ ({(0 : ℝ), 2} : Set ℝ))
    (by norm_num : 0 ≤ (1 / 2 : ℝ))
    (by norm_num : 0 ≤ (1 / 2 : ℝ))
    (by norm_num : (1 / 2 : ℝ) + 1 / 2 = 1)
  norm_num at hm

theorem submitted_statement_counterexample :
    ¬ statement (univ := ({(0 : ℝ), 2} : Set ℝ)) (c := 1) (by norm_num) := by
  intro h
  exact pair_not_convex h.1

#print axioms submitted_statement_counterexample

end Proof09Probe
