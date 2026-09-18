import AuditRepairs.Stable

/-!
# Replacement entry point for original Proof13

Source anchor: 7.2.1-7.2.2.
Exponential scaling identity; use Mathlib Gaussian law theorem for distributions.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof13
alias repaired := StableAudit.gaussian_stable_real_short
end Taleb.Proof13
