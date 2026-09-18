import AuditRepairs.ProbabilityBridge

/-!
# Replacement entry point for original Proof08

Source anchor: 5, equation 5.1.
Now connects a probability law to its self-convolution.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof08
alias repaired := AuditProbability.IsSubexponential.finiteTailExponent
end Taleb.Proof08
