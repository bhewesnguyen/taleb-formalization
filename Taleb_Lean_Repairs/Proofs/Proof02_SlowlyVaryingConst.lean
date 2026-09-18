import AuditRepairs.RegularVariation

/-!
# Replacement entry point for original Proof02

Source anchor: 2.2.1; 21.2.
Constant must be nonzero.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof02
alias repaired := AuditRV.isSlowlyVarying_const
end Taleb.Proof02
