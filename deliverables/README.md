# Fable review deliverables

Outgoing packages for the independent audit loop of the Taleb Lean formalization handoff, one
folder per version. The current deliverable is **v0.2.5**; start with
`v0.2.5/AUDIT_BRIEF_v0.2.5.md`. Received third-party inputs (the handoff, the prior audit, the
Astra audits) are kept unchanged under `../audits/`.

| Version | Folder | ZIP SHA-256 | What it is |
|---|---|---|---|
| **v0.2.5** (current) | `v0.2.5/` | `9e214be3eb53b37721d9bcbc17da5e3aec8ea39dca38760abc4bd20caff56727` | Third corrective pass (audit of v0.2.4: H1/H2 runner CLI, source anchor, wording, ledger scope and `law_theorem`) and T061 children 1–2: Gumbel and Fréchet probability measures constructed from their distribution functions, `cdf` identities, max-stability instantiated for the constructed laws, product-space iid realizations. Contains `taleb-formalization_v0.2.5.bundle` (history to the packaged tree `579f0d6`), patches v0.2.0→v0.2.5 (134 files) and v0.2.4→v0.2.5 (43 files), `archive_validation_v0.2.5.log`, `AUDIT_BRIEF_v0.2.5.md`. |
| v0.2.4 | `v0.2.4/` | `60f6bf6989d5c15f2f8c4afe0ce3444c347acde0589083b25aec495f32af98fa` | Second corrective pass (audit of v0.2.3: V1, R1, M1, L1, ledger states) and the first discharged backlog family (T060: independent minima and law-level `cdf(max) = F^n`, `P(min > x) = S^n`). Also contains `taleb-formalization_v0.2.4.bundle` (git history to the packaged tree `aa48417`), patches v0.2.0→v0.2.4 (117 files) and v0.2.3→v0.2.4 (39 files), `archive_validation_v0.2.4.log`, `AUDIT_BRIEF_v0.2.4.md`. Audited by Astra → `../audits/05_astra_on_v0.2.4/`. |
| v0.2.3 | `v0.2.3/` | `36155f3a2172d862a57c7a1d9bd4927f42c7b4b9da04c9332b52c1a094a23bf1` | First mathematics increment: two-term power tails (G18), Gaussian instantiation of the stable bridge (T046), independent maxima (T060 part). Audited by Astra → `../audits/04_astra_on_v0.2.3/`. |
| v0.2.2 | `v0.2.2/` | `dbee243fcc98fc927e1eb12b4db52f9d2cfa74905261435264015fd2e45af62d` | Corrective pass after the Astra audit of v0.2.1 (trust scan of all constants, explicit checks, Lean-derived provenance, regression suite, G18 qualified, G19). |
| v0.2.1 | `v0.2.1/` | `c492cc14c470f8cd3d237f884a4c3157195a11c1d5e56e62c52a818f9053008a` | Fable review of the received v0.2.0 handoff (baseline reproduction, harness hardening, G17/G18, two boundary diagnostics). Audited by Astra → `../audits/03_astra_on_v0.2.1/`. |

Each folder holds the ZIP, its `.sha256`, the full patch against the pristine v0.2.0 extraction
(commit `f6b1007`), an incremental patch from the previous version, and the fresh-extraction
validation log. The review report (`FABLE_REVIEW.md`), changelog (`CHANGELOG_FABLE.md`), audit
history (`docs/AUDIT_HISTORY.md`) and all evidence are inside each ZIP under `Taleb_Lean_Repairs/`.

## Final statuses (v0.2.5)

- Final build: **passes** — clean `lake build` exit 0 (27 modules, 2742 jobs, no warnings); `verify.py` PASS 103/3/16 (122 checked); also from a fresh extraction.
- Axiom checks: **all 216 project constants** (122 public theorem/instance, 25 defs, structure type, 19 Lean-generated, 49 internal) depend only on `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`; no project `axiom`; ledger schema valid; all 83 cited declarations exist.
- Verifier regression: **12/12 fixtures** as expected from re-extracted sources and a pristine `.lake/build`; H1/H2 CLI probes recorded.
- Mathematics added (v0.2.5): Gumbel and Fréchet (ξ > 0) probability measures with exact cdf identities and max-stability instantiated for them (T061 children 1–2). Backlog: 1 discharged (T060), 10 partial, 4 reuse, 91 missing, 34 source-check, 15 model-needed, 3 empirical; per-family delivery scope and remaining obligations recorded.
- Unresolved: reverse-Weibull and location/scale (T061), stable-law existence for α < 2 (T007) and Cauchy identification (T046), probabilistic Property 5.1 for nonnegative sums (T029), domains of attraction (T011/T062/T093), subexponentiality of concrete laws, positive/measurable RV and Karamata, Pareto moment integrals.

Git history: `f6b1007` pristine extraction → … → `cf322a8` v0.2.3 deliverables → `3ddcead` repository
reorganization (`audits/`, `deliverables/vX/`) → `1231b56` v0.2.4 corrective pass and T060 →
`aa48417` v0.2.4 final evidence and manifest → `aea4b85` v0.2.4 deliverables → `af80e53` round-5 audit received →
`5ec630a` v0.2.5 corrective pass and Gumbel/Fréchet laws → `579f0d6` v0.2.5 final evidence and manifest (the packaged
tree) → this commit (v0.2.5 deliverables).
