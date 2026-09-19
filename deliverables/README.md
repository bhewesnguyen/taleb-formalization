# Fable review deliverables

Review package for the independent audit of the Taleb Lean formalization handoff.
Two iterations are kept: **v0.2.1** (received v0.2.0 → reviewed) and **v0.2.2** (v0.2.1 →
corrective pass requested by the independent audit `Taleb_Fable_v0.2.1_Independent_Audit.md`).
The current deliverable is v0.2.2.

## v0.2.2 (current)

| Deliverable | Location | Notes |
|---|---|---|
| Review report | `Taleb_Lean_Repairs/FABLE_REVIEW.md` (also inside the ZIP) | §0–§11 review of v0.2.0→v0.2.1; **§12 addendum**: audit findings A1–A4/M1/M2, their reproduction, the repairs and the regression fixtures. |
| Changelog | `Taleb_Lean_Repairs/CHANGELOG_FABLE.md` (also inside the ZIP) | v0.2.1→v0.2.2 section first, then v0.2.0→v0.2.1. Statement changes: none in either. |
| Final source ZIP | `deliverables/Taleb_Lean_Implementation_Handoff_v0.2.2_fable.zip` | 140 files; equals the git-tracked project files; no `.lake/`, build outputs or bytecode caches. |
| ZIP checksum | `…_v0.2.2_fable.zip.sha256` | `dbee243fcc98fc927e1eb12b4db52f9d2cfa74905261435264015fd2e45af62d` |
| Complete patch v0.2.0 → v0.2.2 | `deliverables/fable_changes_v0.2.2.patch` | `git diff f6b1007 HEAD -- Taleb_Lean_Repairs/`, 85 files; verified to apply to the pristine extraction and reproduce the packaged tree. |
| Incremental patch v0.2.1 → v0.2.2 | `deliverables/fable_changes_v0.2.1_to_v0.2.2.patch` | `git diff f247b17 HEAD -- Taleb_Lean_Repairs/`, 34 files. |
| Archive validation log | `deliverables/archive_validation_v0.2.2.log` | Fresh extraction → manifest 139/139 → pinned dependency copy → clean `lake build` exit 0 → `verify.py` PASS (trust scan 137/137) → hashes identical to the working tree. |
| Verifier regression record | inside the ZIP: `Taleb_Lean_Repairs/evidence/fable/v0.2.2/current_after_verify/harness_regression.{json,log}` and `03_harness_regression.log` | 10 fixtures, exact commands and subprocess exit codes; all behaved as expected. |
| Raw logs, machine-readable results, inventory, environment | inside the ZIP: `evidence/fable/{received_current,baseline,final,v0.2.2}/`, `evidence/current/` | See `evidence/fable/README.md`. |
| Received artifacts (unchanged) | repo root; hashes in `received/RECEIVED_ARTIFACTS.sha256` | Handoff ZIP and reports, prior audit, prior repair bundle, and the independent audit of v0.2.1 (`Taleb_Fable_v0.2.1_*`). The source book `2001.10488v4.pdf` is used locally and not committed. |

### Final statuses (v0.2.2)

- Baseline reproduction (v0.2.0): **reproduced** (unchanged from v0.2.1 review).
- Final build: **passes** — clean `lake build` exit 0 (2643 jobs, no warnings); `verify.py` PASS 52/1/16 (69 checked); also from a fresh extraction of the ZIP.
- Axiom checks: **all 137 project constants** (69 public theorem/instance, 13 defs, structure type, 19 Lean-generated, 35 internal/private) depend only on `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`; no project `axiom`.
- Verifier regression: **10/10 fixtures** behave as expected (private `sorry` theorem/def, private axiom, structure-namespace theorem, `protected` theorem, wrong alias target in ordinary and `PYTHONOPTIMIZE=1` mode, orphan module, dirty dependency rejected; valid package accepted).
- Source correspondence: unchanged for the sixteen entries; gates now G17, G18 (qualified: Property 5.1's printed scope is false by cancellation; valid for nonnegative summands), **G19** (p. 282 identifies regular variation with stability; false).
- Unresolved mathematical obligations: unchanged in substance (stable-law existence T007, Gaussian/Cauchy identification T046, EVT measures/iid maxima T060/T011, subexponentiality of concrete laws T008/T024/T025, positive/measurable RV and Karamata T001/T002, Property 5.1 formula lemma and nonnegative-sum theorem T029, domain of attraction T093, moments/mixtures T005/T118/T124).

## v0.2.1 (superseded, kept for the audit trail)

| Deliverable | Location |
|---|---|
| ZIP | `deliverables/Taleb_Lean_Implementation_Handoff_v0.2.1_fable.zip`, checksum `c492cc14c470f8cd3d237f884a4c3157195a11c1d5e56e62c52a818f9053008a` (`.sha256` alongside) |
| Patch v0.2.0 → v0.2.1 | `deliverables/fable_changes.patch` |
| Archive validation | `deliverables/archive_validation.log` |

Git history: `f6b1007` pristine extraction → `eff6e82` preservation → `307c651` baseline evidence →
`a89acb0` v0.2.1 repairs → `b929536`/`d5e7f41`/`f247b17` v0.2.1 docs, manifest → `ca574fc`/`31b2644`
v0.2.1 deliverables → `2f1328e` v0.2.2 corrective pass → `16224ec` harness scratch fix → `70207f6`
v0.2.2 final evidence and manifest → this commit (v0.2.2 deliverables).
