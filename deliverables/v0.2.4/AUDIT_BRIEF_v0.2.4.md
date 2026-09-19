# Audit brief: Taleb Lean handoff v0.2.4

Prepared 19 September 2026 for the next independent audit. Everything below is a claim to
verify from the archive, the patches and the git bundle.

## What to audit

| Archive | `deliverables/v0.2.4/Taleb_Lean_Implementation_Handoff_v0.2.4_fable.zip` |
|---|---|
| SHA-256 | `60f6bf6989d5c15f2f8c4afe0ce3444c347acde0589083b25aec495f32af98fa` |
| Contents | 169 files, `SHA256SUMS` 168/168; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `aa48417`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.3, `36155f3a2172d862a57c7a1d9bd4927f42c7b4b9da04c9332b52c1a094a23bf1` (audited by `Taleb_Fable_v0.2.3_Independent_Audit.pdf`, `c5674a7b…91dfa70`, kept in `audits/04_astra_on_v0.2.3/`). |
| Patches | `fable_changes_v0.2.4.patch` (v0.2.0 → v0.2.4, 117 files; applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree); `fable_changes_v0.2.3_to_v0.2.4.patch` (39 files, from the v0.2.3 packaged tree `a5fe300`). |
| Repository history | `taleb-formalization_v0.2.4.bundle` (`git bundle`, `refs/heads/main` at `aa48417`, `git bundle verify` ok). This answers the previous audit's remark that commit hashes and clean-tree claims were only reported: clone the bundle and check `git ls-files`/`git diff` yourself. The bundle necessarily predates the commit that adds these deliverables. |
| Validation | `archive_validation_v0.2.4.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2741 jobs, 26 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree. |

## Changes since the v0.2.3 audit

### Verifier and regression suite (audit V1, R1)

- **V1 fixed.** `scripts/verify.py` walks `AuditRepairs/` and `Proofs/` recursively for both the
  public-API regex and the module-coverage check, deriving module names from relative paths. A
  nested un-imported module now fails the verifier (`nested_orphan_module` fixture: FAIL naming
  `AuditRepairs.Nested.Orphan`); an imported nested module with a public theorem passes and is
  scanned (`nested_imported_module` fixture: PASS, positive control).
- **R1 addressed by construction.** `scripts/harness_regression.py` restores, before every
  fixture, the sources from the pristine tarball *and* the project's `.lake/build` from a pristine
  snapshot, then asserts the restored source-tree SHA-256 equals the pristine hash and records it
  per fixture. A fresh scratch directory is used per run. The root cause observed in the auditor's
  environment was not reproduced here (two prior clean 10/10 runs); the new design does not depend
  on Lake's rebuild logic across fixtures.
- **New gate.** Every Lean declaration that `docs/FORMALIZATION_BACKLOG.json` credits to a family
  must exist in the scanned environment (71 cited).
- Twelve fixtures, all as expected: `evidence/fable/v0.2.4/current_after_verify/harness_regression.{json,log}`.

### Documentation and ledger (audit M1, L1, ledger recommendations)

- `GaussianBridge.lean`: "exactly when"/"iff" → "when"; one direction only, with the reason a
  pointwise converse would fail.
- T007 `missing → partial` (Gaussian slice); T060 `→ discharged` (below).
- Backlog rows carry delivery `states` ⊆ {formula_proved, conditional_law_theorem,
  actual_law_constructed, source_reviewed, discharged} and the credited `declarations`;
  `discharged` is a new status. Eleven families have states.
- Received third-party artifacts now live in the repository's `audits/<round>/` (strict manifest),
  outgoing packages in `deliverables/vX.Y.Z/`; the package carries `docs/AUDIT_HISTORY.md`.

### Mathematics (`AuditRepairs/ExtremeValueBridge.lean`, 19 theorems + 5 defs; nothing pre-existing modified)

| Declarations | Claim | Source |
|---|---|---|
| `measure_iInter_preimage` | `iIndepFun X P → MeasurableSet B → P(∀ i, Xᵢ ∈ B) = ∏ P(Xᵢ ∈ B)` | — (Mathlib `iIndepFun.meas_iInter`) |
| `minGtEvent`, `minGeEvent`, `maxLtEvent` + `_eq_iInter`, `measure_*`, `measure_minGtEvent_of_forall_eq`, `measureReal_minGtEvent_of_forall_eq` | strict/non-strict minimum and strict maximum events; product and `pⁿ` forms | §9.1 p. 173 / PDF 187 |
| `maxRV`, `minRV`, `measurable_maxRV`, `measurable_minRV`, `maxRV_preimage_Iic`, `minRV_preimage_Ioi` | extrema as random variables (`Finset.sup'`/`inf'`), measurable when coordinates are | — |
| `measure_preimage_of_map_eq`, `measure_maxLeEvent_of_map_eq`, `measure_minGtEvent_of_map_eq` | common law `ν` via `P.map (Xᵢ) = ν` | — |
| `cdf_map_maxRV` | `cdf (P.map (maxRV X)) x = (cdf ν x) ^ card ι` | §9.1: `F(x)^n` |
| `measureReal_map_minRV_Ioi`, `_eq_one_sub_cdf` | `P(min > x) = (ν(x,∞))^n = (1 − cdf ν x)^n` | §9.1: survival analogue |

**T060 is recorded as discharged** (first family): its stated targets — `CDF(max)(x) = F(x)^n`
and the minima survival analogue for independent measurable variables with a common law,
`n > 0`, atoms permitted — are met, with threshold conventions stated explicitly. Please check
that reading; the scope note says constructing specific EVT laws is T061, not T060. Counts:
83 theorems, 1 instance, 16 aliases (100 checked); trust scan 189 constants (48 internal), all
within the allowlist; backlog 1 discharged / 10 partial / 4 reuse / 91 missing / 34 source-check /
15 model-needed / 3 empirical.

## Suggested audit focus

1. Re-run `lake exe cache get`, `lake build`, `python3 scripts/verify.py`,
   `python3 scripts/harness_regression.py` (≈ 25 min). Confirm the per-fixture
   `restored_tree_sha256` values equal the run's `pristine_tree_sha256` and that the two nested
   fixtures behave as recorded. Fixtures we did not think of remain the most valuable finding.
2. Check the T060 discharge against the family's stated targets and the cited pages; check that
   the identical-law hypothesis (`∀ i, P.map (X i) = ν`) and the measurability hypotheses are the
   ones you would want, and that atoms are indeed handled by the `Iic`/`Ioi`/`Ici`/`Iio`
   conventions.
3. Check the delivery `states` recorded for the eleven families with Lean support for over- or
   under-statement (`docs/FORMALIZATION_BACKLOG.md`, "Delivered (…)" lines).
4. Review `FABLE_REVIEW.md` §14 and the v0.2.4 section of `CHANGELOG_FABLE.md` for over-claims.

## Known limits (unchanged unless stated)

No Fréchet, Gumbel or reverse-Weibull measure is constructed (T061); stable-law existence for
α < 2 (T007) and the Cauchy identification (T046) are open; the probabilistic Property 5.1 for
nonnegative sums (T029), domains of attraction (T011/T093), subexponentiality of concrete laws,
positive/measurable regular variation and Karamata, and the Pareto moment integrals are open. The
companion PDF `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` is the received v0.2.0
artifact; its figures refer to v0.2.0.
