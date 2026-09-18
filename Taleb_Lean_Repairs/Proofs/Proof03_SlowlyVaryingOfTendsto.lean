import AuditRepairs.RegularVariation

/-!
# Replacement entry point for original Proof03

Source anchor: 2.2.1; 21.2.
Nonzero finite limit implies the ratio property.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof03
alias repaired := AuditRV.IsSlowlyVarying.of_tendsto_const
end Taleb.Proof03
