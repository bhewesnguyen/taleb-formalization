# Audit brief: Taleb Lean handoff v0.2.3 (covers the v0.2.2 corrective pass and the v0.2.3 mathematics increment)

Prepared 19 September 2026 for the next independent audit. Everything below is reproducible
from the archive and the patches; treat the statements here as claims to verify.

## What to audit

| Archive | `deliverables/Taleb_Lean_Implementation_Handoff_v0.2.3_fable.zip` |
|---|---|
| SHA-256 | `36155f3a2172d862a57c7a1d9bd4927f42c7b4b9da04c9332b52c1a094a23bf1` |
| Contents | 155 files, `SHA256SUMS` 154/154; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `a5fe300`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.1, `c492cc14c470f8cd3d237f884a4c3157195a11c1d5e56e62c52a818f9053008a` (audited by `Taleb_Fable_v0.2.1_Independent_Audit.md`, `3f71049c…7461f809`). |
| Patches | `fable_changes_v0.2.3.patch` (v0.2.0 → v0.2.3, 103 files, applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree); `fable_changes_v0.2.1_to_v0.2.2.patch` (34 files, the corrective pass); `fable_changes_v0.2.2_to_v0.2.3.patch` (39 files, the mathematics increment). |
| Validation | `archive_validation_v0.2.3.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2736 jobs, 26 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree. |

## Two changes since the last audit

### 1. v0.2.2 — corrective pass requested by the v0.2.1 audit (harness and documentation only)

All six findings were reproduced before repair; none changed a theorem, proof, definition or pin.

- **A1** (private `sorry` escaped the verifier): `scripts/FableInventory.lean` now collects the axiom closure of **every** constant in the project modules, including `_private`/internal names, before any filtering; `scripts/verify.py` fails on any constant outside `{propext, Classical.choice, Quot.sound}`, on any project `axiom`, and on any `warning:`/`error:`/`sorry` line in the Lake build log.
- **A2** (namespace prefix mistaken for provenance): provenance now comes from Lean's bookkeeping — constructor/recursor kinds, `Environment.isProjectionFn`, `isAuxRecursor`, `isNoConfusion`, or absence of a declaration range — never from a namespace.
- **A3** (`python3 -O` disabled `assert`-based checks): all acceptance conditions are explicit `check(...)` calls raising `VerificationError`; report booleans are the validated values; `python_optimize` is recorded.
- **A4** (a negative-test log recorded `exit=0`): the v0.2.1 log is preserved with `harness_negative_tests.NOTE.md`; `scripts/harness_regression.py` records, per fixture, the exact command, the verifier's own subprocess exit code and the resulting `verification.json`.
- Hardening: dependency working trees must be clean; every project module on disk must be imported into the scanned environment.
- **M1/M2/nit**: G18 qualified with the cancellation counterexample (Property 5.1 as printed is false for signed dependent summands); new **G19** (p. 282 identifies regularly varying with α-stable; false); T029/T093 → source-check; Proof01 row `x_min > 1`.

Regression suite (`scripts/harness_regression.py`, ~12 min): 10 fixtures — valid package (PASS), private `sorry` theorem, private `sorry` def, private axiom with no compiler warning, user theorem inside the `StableParameters` namespace, `protected` theorem, wrong alias target in ordinary and `PYTHONOPTIMIZE=1` mode, orphan un-imported module, dirty dependency (all FAIL, exit 1). Record: `evidence/fable/v0.2.3/current_after_verify/harness_regression.{json,log}`.

### 2. v0.2.3 — first mathematics increment (12 theorems, 3 defs added; nothing pre-existing modified)

| Module | Declarations | Claim | Source anchor |
|---|---|---|---|
| `AuditRepairs/Foundations.lean` | `AuditTails.two_power_tail`, `two_power_tail_min` | `HasFiniteTailExponent (fun z => w₁ z^{−α₁} + w₂ z^{−α₂}) (min α₁ α₂)` for positive weights (ordered form with `w₁ ≥ 0`). Formula-level only. | Property 5.1 display, printed p. 99 / PDF 113 (G18: printed `α₂` should be `−α₂`). |
| `AuditRepairs/GaussianBridge.lean` (new) | `AuditGaussian.varianceOfScale`, `coe_varianceOfScale`, `charFun_gaussianReal_eq_stableS1Expr`, `gaussianParameters`, `convolutionPower_gaussianReal_scale`, `convolutionPower_gaussianReal` | Mathlib's `gaussianReal μ v` has characteristic function `stableS1Expr 2 β μ σ` iff `v = 2σ²` (zero scale included); the conditional Proof16 theorem `stableS1_convolutionPower_eq` is instantiated with real Gaussian measures, giving `N(m,v)^{*n} = N(nm, nv)`. | §7.2.1 printed p. 140 / PDF 154; scale convention G05. |
| `AuditRepairs/ExtremeValueBridge.lean` (new) | `AuditExtremes.maxLeEvent`, `maxLeEvent_eq_iInter`, `measure_maxLeEvent`, `measure_maxLeEvent_of_forall_eq`, `measureReal_maxLeEvent_of_forall_eq`, `measureReal_maxLeEvent_frechet`, `measureReal_maxLeEvent_gumbel` | For `iIndepFun X P`: `P(∀ i, Xᵢ ≤ x) = ∏ P(Xᵢ ≤ x)`, hence `pⁿ`; if every coordinate has the Fréchet(ξ)/Gumbel distribution function the maximum has the rescaled one. Conditional on the coordinates' distribution function; no Fréchet/Gumbel measure is constructed. | §9.1 printed p. 173 / PDF 187. |

Backlog effects: T029 → partial, T046 → partial (Gaussian half done; Cauchy open, no Cauchy law with a charFun lemma in the pinned Mathlib), T060 → partial (maximum done; minimum and T061 measures open). Counts: 64 theorems, 1 instance, 16 aliases (81 checked); trust scan 158 constants (41 internal), all within the allowlist.

## Suggested audit focus

1. Re-run `lake exe cache get`, `lake build`, `python3 scripts/verify.py`, `python3 scripts/harness_regression.py`; confirm the recorded outputs and that the suite's fixtures are rejected with the recorded messages.
2. Check the three new modules' statements against the cited pages (the exact pretty-printed types are in `evidence/fable/v0.2.3/declaration_inventory.md`), in particular: that `two_power_tail_min` is a statement about formulas and is labelled as such; that `convolutionPower_gaussianReal_scale` genuinely goes through `stableS1_convolutionPower_eq` (not through Mathlib's direct closure lemma); that the EVT results assume the distribution-function hypothesis and claim no measure construction.
3. Try to break the verifier again: fixtures we did not think of are the most valuable finding.
4. Review §12–§13 of `FABLE_REVIEW.md` and the v0.2.2/v0.2.3 sections of `CHANGELOG_FABLE.md` for over-claims.

## Known limits (unchanged unless stated)

Stable-law existence for `α < 2` (T007); Cauchy identification (T046 half); Fréchet/Gumbel measures and minima (T061, T060 half); domains of attraction (T011, T093); subexponentiality of any concrete law (T008/T024/T025); positive/measurable regular variation and Karamata (T001/T002); Pareto moment integrals (T005/T021); the probabilistic Property 5.1 for nonnegative sums (T029 half). The companion PDF report `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` is the received v0.2.0 artifact and its figures refer to v0.2.0.
