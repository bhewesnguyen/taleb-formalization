import AuditRepairs.Stable

/-!
# Replacement entry point for original Proof14

Source anchor: 7.2.1.
Correct location/scale; nonnegative scale; zero scale is degenerate.
The proof is centralized in AuditRepairs to prevent duplicate declarations.
-/

set_option autoImplicit false
namespace Taleb.Proof14
alias repaired := StableAudit.stableS1Expr_cauchy
end Taleb.Proof14
