# Fable review deliverables

Outgoing packages for the independent audit loop of the Taleb Lean formalization handoff, one
folder per version. The current deliverable is **v0.2.7**; start with
`v0.2.7/AUDIT_BRIEF_v0.2.7.md`. Received third-party inputs (the handoff, the prior audit, the
Astra audits) are kept unchanged under `../audits/`.

| Version | Folder | ZIP SHA-256 | What it is |
|---|---|---|---|
| **v0.2.7** (current) | `v0.2.7/` | `88ebaa078a18dc0e16bb46057969c5fec186c1fc958df1422b6d434e323d157b` | Fifth corrective pass (audit of v0.2.6: D026-1 Markdown ledger now rendered by the generator and checked byte for byte by the verifier, with a correction history for the false v0.2.6 "synced" claim; D026-2 false continuity prose withdrawn and global continuity proved; D026-3 densities/unified GEV moved to `docs/SUPPLEMENTAL_OBLIGATIONS.md`, Pareto limit `frechetMeasure (1/α)`) and T029's probabilistic half: Property 5.1 for random variables — the survival function of a nonnegative positively weighted sum has log-tail exponent `min α β`, no independence. Contains `taleb-formalization_v0.2.7.bundle` (history to the packaged tree `fe14519`), patches v0.2.0→v0.2.7 (170 files) and v0.2.6→v0.2.7 (43 files), `archive_validation_v0.2.7.log`, `AUDIT_BRIEF_v0.2.7.md`. |
| v0.2.6 | `v0.2.6/` | `d684d0ef3c3d17f9ceb5cd456969559674c1ac86e21bbd6a27505cf22d4fb3f3` | Fourth corrective pass (audit of v0.2.5: V025-L1 shared ledger validator with probes, D025-1/D025-2 wording, T061 `law_theorem`; self-found discovery defect H026-1 fixed) and T061 children 3–4: reverse-Weibull probability measure with max-stability, the positive affine pushforward `affineLaw`, the three location/scale families and the law of iid maxima as equalities of measures — **T061 discharged** (second closed family). Contains `taleb-formalization_v0.2.6.bundle` (history to the packaged tree `83ef501`), patches v0.2.0→v0.2.6 (153 files) and v0.2.5→v0.2.6 (44 files), `archive_validation_v0.2.6.log`, `AUDIT_BRIEF_v0.2.6.md`. Audited by Astra → `../audits/07_astra_on_v0.2.6/` (its brief's density→T062 routing is corrected in v0.2.7; the folder is left as shipped). |
| v0.2.5 | `v0.2.5/` | `9e214be3eb53b37721d9bcbc17da5e3aec8ea39dca38760abc4bd20caff56727` | Third corrective pass (audit of v0.2.4: H1/H2 runner CLI, source anchor, wording, ledger scope and `law_theorem`) and T061 children 1–2: Gumbel and Fréchet probability measures constructed from their distribution functions, `cdf` identities, max-stability instantiated for the constructed laws, product-space iid realizations. Contains `taleb-formalization_v0.2.5.bundle` (history to the packaged tree `579f0d6`), patches v0.2.0→v0.2.5 (134 files) and v0.2.4→v0.2.5 (43 files), `archive_validation_v0.2.5.log`, `AUDIT_BRIEF_v0.2.5.md`. Audited by Astra → `../audits/06_astra_on_v0.2.5/`. |
| v0.2.4 | `v0.2.4/` | `60f6bf6989d5c15f2f8c4afe0ce3444c347acde0589083b25aec495f32af98fa` | Second corrective pass (audit of v0.2.3: V1, R1, M1, L1, ledger states) and the first discharged backlog family (T060: independent minima and law-level `cdf(max) = F^n`, `P(min > x) = S^n`). Also contains `taleb-formalization_v0.2.4.bundle` (git history to the packaged tree `aa48417`), patches v0.2.0→v0.2.4 (117 files) and v0.2.3→v0.2.4 (39 files), `archive_validation_v0.2.4.log`, `AUDIT_BRIEF_v0.2.4.md`. Audited by Astra → `../audits/05_astra_on_v0.2.4/`. |
| v0.2.3 | `v0.2.3/` | `36155f3a2172d862a57c7a1d9bd4927f42c7b4b9da04c9332b52c1a094a23bf1` | First mathematics increment: two-term power tails (G18), Gaussian instantiation of the stable bridge (T046), independent maxima (T060 part). Audited by Astra → `../audits/04_astra_on_v0.2.3/`. |
| v0.2.2 | `v0.2.2/` | `dbee243fcc98fc927e1eb12b4db52f9d2cfa74905261435264015fd2e45af62d` | Corrective pass after the Astra audit of v0.2.1 (trust scan of all constants, explicit checks, Lean-derived provenance, regression suite, G18 qualified, G19). |
| v0.2.1 | `v0.2.1/` | `c492cc14c470f8cd3d237f884a4c3157195a11c1d5e56e62c52a818f9053008a` | Fable review of the received v0.2.0 handoff (baseline reproduction, harness hardening, G17/G18, two boundary diagnostics). Audited by Astra → `../audits/03_astra_on_v0.2.1/`. |

Each folder holds the ZIP, its `.sha256`, the full patch against the pristine v0.2.0 extraction
(commit `f6b1007`), an incremental patch from the previous version, and the fresh-extraction
validation log. The review report (`FABLE_REVIEW.md`), changelog (`CHANGELOG_FABLE.md`), audit
history (`docs/AUDIT_HISTORY.md`) and all evidence are inside each ZIP under `Taleb_Lean_Repairs/`.

## Final statuses (v0.2.7)

- Final build: **passes** — clean `lake build` exit 0 (29 modules, 2744 jobs, no warnings); `verify.py` PASS 140/8/16 (164 checked); also from a fresh extraction.
- Axiom checks: **all 296 project constants** (164 public theorem/instance, 33 defs, structure type, 19 Lean-generated, 79 internal) depend only on `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`; no project `axiom`; ledger valid and the Markdown ledger equal to its rendering; all 123 citations (122 distinct declarations) exist.
- Verifier regression: **14/14 fixtures** as expected from re-extracted sources and a pristine `.lake/build`; ledger/rendering probes 18/18.
- Mathematics added (v0.2.7): Property 5.1 for random variables (T029 probabilistic half, no independence) with reusable rescaling/max/sum/squeeze rules for `HasFiniteTailExponent`; global continuity of the Fréchet and reverse-Weibull distribution functions. Backlog: 2 discharged (T060, T061), 9 partial, 4 reuse, 91 missing, 34 source-check, 15 model-needed, 3 empirical; supplemental S001/S002 open.
- Unresolved: finite-family and a.s. variants of Property 5.1 (T029), unified GEV parametrisation (S001) and EVT densities (S002), domains of attraction (T011/T062/T093), stable-law existence for α < 2 (T007) and Cauchy identification (T046), subexponentiality of concrete laws, positive/measurable RV and Karamata, Pareto moment integrals.

Git history: `f6b1007` pristine extraction → … → `cf322a8` v0.2.3 deliverables → `3ddcead` repository
reorganization (`audits/`, `deliverables/vX/`) → `1231b56` v0.2.4 corrective pass and T060 →
`aa48417` v0.2.4 final evidence and manifest → `aea4b85` v0.2.4 deliverables → `af80e53` round-5 audit received →
`5ec630a` v0.2.5 corrective pass and Gumbel/Fréchet laws → `579f0d6` v0.2.5 final evidence and manifest →
`014ae32` v0.2.5 deliverables → `8dc0e2d` round-6 audit received → `a626e34` v0.2.6 corrective pass, reverse-Weibull and
location/scale laws, T061 discharged → `83ef501` v0.2.6 final evidence and manifest → `ea1286d` v0.2.6 deliverables → `3f72f14` round-7 audit received →
`7b48ebd` v0.2.7 corrective pass and probabilistic Property 5.1 → `fe14519` v0.2.7 final evidence and manifest (the
packaged tree) → this commit (v0.2.7 deliverables).
