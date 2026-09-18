import AuditRepairs.Tails

/-!
# Replacement entry point for original Proof11

Source anchor: 9.1.
Correct original identity retained.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof11
alias repaired := AuditTails.gumbel_maxstable
end Taleb.Proof11
