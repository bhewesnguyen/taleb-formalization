import AuditRepairs.RegularVariation

/-!
# Replacement entry point for original Proof01

Source anchor: 2.2.1; 21.2.
Elementary analytic identity.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof01
alias repaired := AuditRV.isSlowlyVarying_log
end Taleb.Proof01
