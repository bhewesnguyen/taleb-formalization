import AuditRepairs.ProbabilityBridge

/-!
# Replacement entry point for original Proof16

Source anchor: 7.2.1-7.2.2; 15.2.1.
Conditional law theorem; existence of S1 laws remains open.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof16
alias repaired := AuditProbability.stableS1_convolutionPower_eq
end Taleb.Proof16
