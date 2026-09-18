import AuditRepairs.RegularVariation

/-!
# Replacement entry point for original Proof05

Source anchor: 5.1; 21.2.
Eventually positive base function.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof05
alias repaired := AuditRV.IsRegularlyVarying.rpow
end Taleb.Proof05
