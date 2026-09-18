import AuditRepairs.Tails

/-!
# Replacement entry point for original Proof09

Source anchor: 21.2.
Correct domain Set.univ; Jensen integration remains separate.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof09
alias repaired := AuditTails.convexOn_rpow_neg_right
end Taleb.Proof09
