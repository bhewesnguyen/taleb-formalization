# Audit history

Independent reviews this package has been through, in order, with the response to each. The
review documents themselves are third-party artifacts and are not redistributed inside this
package; they are kept, unchanged and hashed, in the repository's `audits/` directory
(`audits/RECEIVED_ARTIFACTS.sha256`). Hashes below identify them.

| # | Reviewed | Reviewer artifact (SHA-256) | Findings | Response |
|---|---|---|---|---|
| 0 | original `mathlib-proofs-16.zip` (`b0132c09…5d05b47c`) | `Taleb_Fat_Tails_Lean_Audit.pdf` (`ac94f4df…64d3da5`) | 8/16 files fail on the pinned toolchain; Proof09/12/14 false as stated; definition gaps. | v0.1 repair bundle, then handoff v0.2.0 (`evidence/`, `evidence/source/`). |
| 1 | handoff v0.2.0 (`8a8fb28a…57cab406`) | Fable review (this package, `FABLE_REVIEW.md` §0–§11) | Baseline reproduced; harness discovery latent hole; source gates G17, G18; two boundary diagnostics. | v0.2.1. |
| 2 | v0.2.1 (`c492cc14…9053008a`) | `Taleb_Fable_v0.2.1_Independent_Audit.md` (`3f71049c…7461f809`), evidence ZIP (`a5553019…13e90f04`) | A1 private `sorry` escaped verifier; A2 namespace-based provenance; A3 `python -O` disabled asserts; A4 mis-recorded exit code; M1 Property 5.1 overstated; M2 RV≠stable (G19). | v0.2.2 (`FABLE_REVIEW.md` §12): trust scan of all constants, explicit checks, Lean-derived provenance, ten-fixture regression suite, G18 qualified, G19 added. |
| 3 | v0.2.3 (`36155f3a…4a23bf1`) | `Taleb_Fable_v0.2.3_Independent_Audit.pdf` (`c5674a7b…91dfa70`), ledger `Taleb_Proof_Progress_v0.2.3.md` (`532c3c8a…583bd45`) | Mathematics accepted within scope. V1 nested un-imported modules evade coverage; R1 regression fixtures not isolated in the auditor's environment; M1 "iff" wording; L1 T007 should be partial; recommends child-obligation states and closing T060 via minima. | v0.2.4 (`FABLE_REVIEW.md` §14): recursive module discovery, per-fixture build isolation with source-hash assertions, two nested-module fixtures, wording fix, T007 partial, per-family delivery states, independent minima and law-level max/min theorems (T060 discharged). |
| 4 | v0.2.4 (`60f6bf69…2af98fa`) | `Taleb_Fable_v0.2.4_Independent_Audit.pdf` (`5407c895…9b31f7`), ledger `Taleb_Proof_Progress_v0.2.4.md` (`c4a29b26…b12332`), evidence ZIP (`b5117d9f…f9efe7`) | T060 discharge accepted; no mathematical finding. H1 runner accepts unknown `--only` IDs (zero-fixture success); H2 relative `--scratch` breaks restoration; source anchor for the maximum law is Eq. (9.1) p. 172 not p. 173; ledger needs a `law_theorem` facet and per-family scope; wording (boundary events vs atoms, reproduced vs preventive repairs, what a git bundle proves). | v0.2.5 (`FABLE_REVIEW.md` §15): runner CLI fixes, anchor and wording corrections, `law_theorem` state plus `delivery_scope`/`remaining_obligations` per supported family, and the first T061 child: the Gumbel probability measure constructed from `gumbelCDF` via a Stieltjes function, with `cdf_map_maxRV` instantiated for it. |

Rules followed across rounds: received artifacts are never modified; every finding is either
reproduced before it is repaired or, where it could not be reproduced locally (v0.2.3 audit finding R1),
repaired preventively on the strength of the auditor's evidence and labelled as such; theorem statements
and toolchain pins are not changed to obtain a pass; each release ships a full patch against the pristine
v0.2.0 extraction and is re-validated from a fresh extraction of its ZIP.
