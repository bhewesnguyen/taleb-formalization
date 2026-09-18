import AuditRepairs.Stable

/-!
# Replacement entry point for original Proof12

Source anchor: 7.2.1.
Correct location/scale and repaired S1 expression; scale maps to variance 2*scale^2.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof12
alias repaired := StableAudit.stableS1Expr_gaussian
end Taleb.Proof12
