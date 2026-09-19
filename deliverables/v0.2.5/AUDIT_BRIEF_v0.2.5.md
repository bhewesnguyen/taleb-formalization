# Audit brief: Taleb Lean handoff v0.2.5

Prepared 19 September 2026 for the next independent audit. Everything below is a claim to
verify from the archive, the patches and the git bundle.

## What to audit

| Archive | `deliverables/v0.2.5/Taleb_Lean_Implementation_Handoff_v0.2.5_fable.zip` |
|---|---|
| SHA-256 | `9e214be3eb53b37721d9bcbc17da5e3aec8ea39dca38760abc4bd20caff56727` |
| Contents | 186 files, `SHA256SUMS` 185/185; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `579f0d6`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.4, `60f6bf6989d5c15f2f8c4afe0ce3444c347acde0589083b25aec495f32af98fa` (audited by `Taleb_Fable_v0.2.4_Independent_Audit.pdf`, `5407c895…9b31f7`; kept in `audits/05_astra_on_v0.2.4/`). |
| Patches | `fable_changes_v0.2.5.patch` (v0.2.0 → v0.2.5, 134 files; applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree); `fable_changes_v0.2.4_to_v0.2.5.patch` (43 files, from the v0.2.4 packaged tree `aa48417`). |
| Repository history | `taleb-formalization_v0.2.5.bundle` (`git bundle`, `refs/heads/main` at `579f0d6`, `git bundle verify` ok). It lets you check the committed history and its equality with the archive; it does not prove the author's worktree was clean or anything about a remote. The bundle necessarily predates the commit that adds these deliverables. |
| Validation | `archive_validation_v0.2.5.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2742 jobs, 27 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree. |

## Changes since the v0.2.4 audit

### Responses to the audit's findings (all confirmed before repair)

- **H1** `--only` validated (unknown/empty IDs exit 2 before any filesystem action); an empty result set is no longer a pass. Probe record: `evidence/fable/v0.2.5/cli_probes/h1_only_validation.log`.
- **H2** `--scratch`/`--out` resolved to absolute paths; probe: `--only valid --scratch rel_scratch` PASS with the build snapshot restored (`cli_probes/h2_relative_scratch_valid_fixture.{json,log}`).
- Source anchor: the maximum law is eq. (9.1), printed p. 172 / PDF 186 (the EVT forms are p. 173); the minimum survival law is described as a proved companion, not a displayed equation. Corrected in the module docstrings and `FABLE_REVIEW.md` §14.
- Wording: boundary events / boundary mass instead of "atoms"; reproduced vs preventive repairs in `docs/AUDIT_HISTORY.md`; what a git bundle proves; the backlog intro now says only discharged rows claim completion.
- Ledger: new `law_theorem` facet (T060 carries it); every supported family has `delivery_scope` and `remaining_obligations` (T118 and T047 say "prerequisite only"); `verify.py` validates the ledger schema in its normal run. 83 citations over 82 distinct declarations (the Gaussian identification credited to T007 and T046).
- README: Lake locates the ProofWidgets release by tag when dependencies are fetched by hand.

### Mathematics — new `AuditRepairs/ExtremeValueLaws.lean` (T061 children 1–2; 20 theorems, 2 instances, 4 defs; nothing pre-existing modified)

| Declarations | Claim | Source / route |
|---|---|---|
| `gumbelCDF_monotone`, `continuous_gumbelCDF`, `gumbelCDF_tendsto_atBot`, `gumbelCDF_tendsto_atTop`, `gumbelStieltjes`, `gumbelMeasure`, `gumbelMeasure_isProbabilityMeasure`, `cdf_gumbelMeasure(_apply)` | the Gumbel distribution function is a Stieltjes function with limits 0 and 1; its measure is a probability measure with `cdf gumbelMeasure x = gumbelCDF x` | §9.1 p. 173; `StieltjesFunction.isProbabilityMeasure`, `cdf_measure_stieltjesFunction` |
| `frechetCDF_of_pos/_of_nonpos/_nonneg`, `frechetCDF_monotone`, `frechetCDF_continuousWithinAt_Ici`, `frechetCDF_tendsto_atBot/_atTop`, `frechetStieltjes ξ hξ`, `frechetMeasure ξ hξ`, `frechetMeasure_isProbabilityMeasure`, `cdf_frechetMeasure(_apply)` | same for Fréchet with `0 < ξ`; right-continuity at the support boundary 0 via `x^{−1/ξ} = exp((−1/ξ) log x) → +∞` as `x → 0⁺` | §9.1 p. 173 |
| `cdf_map_maxRV_gumbel`, `cdf_map_maxRV_frechet` | maximum of independent measurable coordinates with the constructed law has cdf `gumbelCDF (x − log n)` resp. `frechetCDF ξ (n^{−ξ} x)` — the CDF-realization premise of the v0.2.3 results is discharged; independence, measurability, common law, `n > 0` remain | `AuditExtremes.cdf_map_maxRV` + the v0.2.1 max-stability identities |
| `cdf_map_maxRV_pi_gumbel`, `cdf_map_maxRV_pi_frechet` | iid realizations exist for every finite nonempty `ι`: coordinate projections under `Measure.pi` | `iIndepFun_pi`, `measurePreserving_eval` |

**T061 remains partial** (states now include `actual_law_constructed` and `source_reviewed`):
reverse-Weibull and the location/scale wrappers for all three families are the remaining children.
Counts: 103 theorems, 3 instances, 16 aliases (122 checked); trust scan 216 constants (49
internal), all within the allowlist. Backlog statuses unchanged: 1 discharged / 10 partial / 4
reuse / 91 missing / 34 source-check / 15 model-needed / 3 empirical.

## Suggested audit focus

1. Reproduce `lake build`, `verify.py`, `harness_regression.py` (≈ 20–30 min); try the H1/H2 probes.
2. Check the two constructions against the family's acceptance boundaries you set: global
   support-correct CDF, monotonicity, right continuity (Fréchet at 0), endpoint limits, concrete
   measure, `IsProbabilityMeasure`, everywhere-CDF identity, max-stability instantiated; and that
   nothing is claimed for reverse-Weibull or location/scale.
3. Check the `delivery_scope`/`remaining_obligations` texts and the `law_theorem` facet for over- or
   under-statement (`docs/FORMALIZATION_BACKLOG.md`).
4. Review `FABLE_REVIEW.md` §15 and the v0.2.5 section of `CHANGELOG_FABLE.md` for over-claims.

## Known limits (unchanged unless stated)

Reverse-Weibull measure and location/scale wrappers (T061); stable-law existence for α < 2 (T007)
and the Cauchy identification (T046); probabilistic Property 5.1 for nonnegative sums (T029);
domains of attraction (T011/T062/T093); subexponentiality of concrete laws; positive/measurable
regular variation and Karamata; Pareto moment integrals. The companion PDF
`Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` is the received v0.2.0 artifact; its figures
refer to v0.2.0.
