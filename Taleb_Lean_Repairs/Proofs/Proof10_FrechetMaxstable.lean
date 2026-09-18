import AuditRepairs.Tails

/-!
# Replacement entry point for original Proof10

Source anchor: 9.1.
Global piecewise formula and positive sample size; CDF realization remains open.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof10
alias repaired := AuditTails.frechet_cdf_maxstable
end Taleb.Proof10
