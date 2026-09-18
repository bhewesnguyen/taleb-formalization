import AuditRepairs.Stable

/-!
# Replacement entry point for original Proof15

Source anchor: 7.2.1-7.2.2.
Exponential scaling identity.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof15
alias repaired := StableAudit.cauchy_stable_short
end Taleb.Proof15
