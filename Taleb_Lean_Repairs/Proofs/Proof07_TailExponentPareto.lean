import AuditRepairs.Tails

/-!
# Replacement entry point for original Proof07

Source anchor: 5.1; E.1.
Explicit finite exponent, not a general extended-real index.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof07
alias repaired := AuditTails.pareto_hasFiniteTailExponent
end Taleb.Proof07
