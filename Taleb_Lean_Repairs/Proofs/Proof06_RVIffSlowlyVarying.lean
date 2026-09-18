import AuditRepairs.RegularVariation

/-!
# Replacement entry point for original Proof06

Source anchor: 2.2.1; 21.2.
Ratio-only representation; not Karamata integral representation.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof06
alias repaired := AuditRV.isRegularlyVarying_iff_slowlyVarying
end Taleb.Proof06
