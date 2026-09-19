# Fable review deliverables

Review package for the independent audit of the Taleb Lean formalization handoff
(received v0.2.0 → reviewed v0.2.1). Produced 18 September 2026.

| Deliverable | Location | Notes |
|---|---|---|
| Review report | `Taleb_Lean_Repairs/FABLE_REVIEW.md` (also inside the ZIP) | Baseline reproduction, harness audit, per-entry assessment Proof01–16, repairs, unresolved obligations, limits, next tasks. |
| Changelog | `Taleb_Lean_Repairs/CHANGELOG_FABLE.md` (also inside the ZIP) | Every changed file; statement changes (none); compatibility; validation. |
| Complete patch against the received source | `deliverables/fable_changes.patch` | `git diff f6b1007 HEAD -- Taleb_Lean_Repairs/`; 67 files incl. new ones. Verified to apply to the pristine extraction and to reproduce the final tree exactly. |
| Final source ZIP | `deliverables/Taleb_Lean_Implementation_Handoff_v0.2.1_fable.zip` | Project, docs, evidence; no `.lake/`, no build outputs, no bytecode caches. Contents equal the git-tracked files under `Taleb_Lean_Repairs/`. |
| ZIP checksum | `deliverables/Taleb_Lean_Implementation_Handoff_v0.2.1_fable.zip.sha256` | `c492cc14c470f8cd3d237f884a4c3157195a11c1d5e56e62c52a818f9053008a` |
| Archive validation log | `deliverables/archive_validation.log` | Fresh extraction → `SHA256SUMS` 121/121 → pinned dependency copy → clean `lake build` (exit 0) → `scripts/verify.py` (PASS 52/1/16) → hashes identical to working tree. |
| Raw execution logs, machine-readable results, inventory, environment | inside the ZIP: `Taleb_Lean_Repairs/evidence/fable/{received_current,baseline,final}/` and `evidence/current/` | See `evidence/fable/README.md`. |
| Received artifacts (unchanged) | repo root: `Taleb_Lean_Implementation_Handoff.zip`, `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf`, `Taleb_Fat_Tails_Lean_Audit.pdf`, `Taleb_Lean_Checked_Repairs.zip`; hashes in `received/RECEIVED_ARTIFACTS.sha256` | The source book `2001.10488v4.pdf` (SHA-256 `758e18b7…`) is used locally and deliberately not committed. |

Git history: `f6b1007` pristine extraction of the received ZIP → `eff6e82` preservation layer →
`307c651` baseline reproduction evidence → `a89acb0` repairs → `b929536` review documents and final
evidence → `d5e7f41` manifest regeneration → `ca574fc` first deliverables → `f247b17` review arithmetic
fix + manifest → this commit (regenerated deliverables for the packaged tree `f247b17`).

## Final statuses

- Baseline reproduction: **reproduced** (clean build exit 0; `verify.py` PASS 50/1/16 identical to the received evidence apart from timing; legacy 8/16 original-file result reproduced exactly).
- Final build: **passes** (clean build exit 0, 2643 jobs, no warnings; `verify.py` PASS 52/1/16, 69 checked; also passes from a fresh extraction of the ZIP).
- Axiom checks: **69/69 exported declarations and 102/102 project constants** depend exactly on `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`.
- Source correspondence: **checked for all sixteen entries** against arXiv:2001.10488v4; no encoded statement contradicts the book; two new source defects recorded (G17: misprinted S1 characteristic function in 15.2.1; G18: sign error under Property 5.1); several entries are analogues/special cases rather than displayed theorems (classified in `FABLE_REVIEW.md` §6.3).
- Unresolved mathematical obligations: **unchanged in substance** — stable-law existence (T007), Gaussian/Cauchy law identification (T046), EVT measures and iid maxima (T060/T011), subexponentiality of concrete laws (T008/T024/T025), positive/measurable RV and Karamata (T001/T002), Property 5.1 formula lemma (T029), moments/mixtures (T005/T118/T124).
