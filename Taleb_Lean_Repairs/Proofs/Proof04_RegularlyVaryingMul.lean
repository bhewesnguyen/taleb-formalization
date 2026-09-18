import AuditRepairs.RegularVariation

/-!
# Replacement entry point for original Proof04

Source anchor: 5.1; 21.2.
Product of functions, not of random variables.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof04
alias repaired := AuditRV.IsRegularlyVarying.mul
end Taleb.Proof04
