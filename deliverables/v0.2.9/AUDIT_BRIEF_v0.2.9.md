# Audit brief: Taleb Lean handoff v0.2.9

Prepared 21 September 2026 for the next independent audit. Everything below is a claim to
verify from the archive, the patches and the git bundle. This release applies the two low ledger
corrections of the v0.2.8 audit (plus the source defect it uncovered, G20), adopts its scoping
remarks verbatim, and completes Pareto Stage B as specified in its handoff.

## What to audit

| Archive | `deliverables/v0.2.9/Taleb_Lean_Implementation_Handoff_v0.2.9_fable.zip` |
|---|---|
| SHA-256 | `abbea690e34bfde5799b8384b727e834d6a319f25cdda52c851c61eca602b77e` |
| Contents | 255 files, `SHA256SUMS` 254/254; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `382faa0`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.8, `696c5187ed87bb0ad428bbbdd78185758de5b437fb14a9e2411c07b32a8ccbb0` (audited by `Taleb_Fable_v0.2.8_Independent_Audit.pdf`, `0d71cf28…712d0945`; kept in `audits/09_astra_on_v0.2.8/`). |
| Patches | `fable_changes_v0.2.9.patch` (v0.2.0 → v0.2.9, 203 files; applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree, tree hash `2931c3c6…`); `fable_changes_v0.2.8_to_v0.2.9.patch` (38 files, from the v0.2.8 packaged tree `d086ce0`; same tree hash). |
| Repository history | `taleb-formalization_v0.2.9.bundle` (`git bundle`, `refs/heads/main` at `382faa0`, `git bundle verify` ok). It proves the committed history and archive equality; it does not prove worktree cleanliness or anything about a remote, and it predates the commit that adds these deliverables. |
| Validation | `archive_validation_v0.2.9.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2747 jobs, 31 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree → probes 18/18 (count from the JSON record). |
| D027-3 inspectability | `evidence/fable/v0.2.9/deliverables_index_at_packaging.md` **inside the package** is a copy of `deliverables/README.md` as of packaging time, so the annotation of the v0.2.7 log's probe count is checkable from the archive and bundle (your evidence-boundary remark). The shipped v0.2.7 log is unchanged. |

## Changes since the v0.2.8 audit

### Responses to the audit (all confirmed before repair)

- **D028-1** T118 cross-credits `AuditPareto.integral_rpow_paretoMeasure` (= eq. (21.7), printed
  p. 382 / PDF 396, checked); facets `law_theorem`, `actual_law_constructed` scoped to the moment
  slice; status `partial`; remaining = convexity of `m_p` in `α` and the integrated Jensen inequality.
  147 citations before Stage B, as you predicted. The book's second-derivative display under (21.7)
  is recorded as **G20** in `docs/SOURCE_GATES.md` (`x₀^p · 2/(α−1)³` printed; `2p x₀^p/(α−p)³`
  correct; equal only at `p = 1`), and T118's specification carries the corrected derivative and the
  `p > 0` requirement.
- **D028-2** T028's locator: p. 95 (PDF 109) for `P(X > x) = Cx^{−α}`, p. 96 for `L(x)`, p. 97 for
  Definition 5.1; density p. 86 retained.
- Scoping remarks adopted verbatim in the ledger: T029's `actual_law_constructed` covers the
  realized Pareto marginal laws only (joint space with those marginals still assumed; pointwise
  nonnegativity a premise); T021's negative-order moments rely on `L > 0` and do not generalize to
  laws with mass near 0; `E(abs(X)^p)` is a raw moment, not the centered MAD.

### Mathematics — `AuditRepairs/ParetoConditional.lean` (Stage B; 21 theorems, 1 def; nothing pre-existing modified)

Against Mathlib's pinned `paretoMeasure L α` and `ProbabilityTheory.cond`, for `L > 0`, `α > 0`:

| Declarations | Claim | Route |
|---|---|---|
| `paretoMeasure_Ioi`, `paretoMeasure_Ioi_ne_zero`, `isProbabilityMeasure_cond_paretoMeasure` | the conditioning event `X > K` (`L ≤ K`) has mass `ofReal ((L/K)^α) ≠ 0`; the conditional law is a probability measure | Stage A survival, `cond_isProbabilityMeasure` |
| `cdf_cond_paretoMeasure`, **`cond_paretoMeasure_Ioi`**, `cond_paretoMeasure_Ioi_endpoint` | **threshold law** `(paretoMeasure L α)[|Ioi K] = paretoMeasure K α` for `L ≤ K`; `K = L` included (no atom at `L`) | `cond_apply`, `Ioi ∩ Iic = Ioc`, `measureReal_diff`, `Measure.eq_of_cdf` |
| `excessLaw`, `excessLaw_eq`, `isProbabilityMeasure_excessLaw`, `cdf_excessLaw`, `survival_excessLaw`, `survival_excessLaw_zero` | excess law `= affineLaw (paretoMeasure K α) (−K) 1`; cdf `1 − (K/(K+y))^α`, survival `(K/(K+y))^α` for `y ≥ 0`, `1` for `y < 0`, value `1` at `0` | v0.2.6 `cdf_affineLaw` |
| `integral_rpow_cond_paretoMeasure`, `integral_id_cond_paretoMeasure`, `integral_id_excessLaw`, `lintegral_id_cond_paretoMeasure_eq_top` | conditional moments are Stage A moments of `Pareto(K, α)`; `E[X | X > K] = αK/(α−1)`, mean excess `K/(α−1)` (`α > 1`, kept distinct); `⊤` for `α ≤ 1` as an extended integral | `integral_map`, `integral_add`, Stage A |
| `paretoMeasure_apply_inter_Ici`, `preimage_rpow_Iic_inter_Ici_eq_empty`, `preimage_rpow_Iic_inter_Ici`, `pareto_power_algebra`, **`map_rpow_paretoMeasure`** | **power law** `(paretoMeasure L α).map (· ^ q) = paretoMeasure (L^q) (α/q)` for `q > 0`, an equality of laws; the preimage is computed on the support (`{y ≥ L : y^q ≤ x} = [L, x^{1/q}]`), so the totalized power on negative bases never enters | `le_rpow_inv_iff_of_pos`, `rpow_rpow_inv`, `Measure.eq_of_cdf` |
| `integrable_rpow_map_rpow_paretoMeasure_iff` | `x^p` integrable under the law of `X^q` iff `p < α/q` (Property 5.2's threshold) | Stage A on the identified law |

Credited as exact-Pareto *slices* of **T005** (`missing → partial`; the general tail-integral
identity (2.10), printed p. 18, is not proved) and **T032** (law slice added; Property 5.2 for
arbitrary laws remains). Not claimed: (2.10) in general, other families' conditional laws, `q ≤ 0`,
the centered MAD/STD ratios.

Counts: 181 theorems, 8 instances, 16 aliases (205 checked); trust scan 361 constants (101
internal), all within the allowlist. Backlog: 2 discharged / 12 partial / 4 reuse / 89 missing /
33 source-check / 15 model-needed / 3 empirical; 169 citations over 164 declarations; S001, S002
open; gates G01–G20.

## Suggested audit focus

1. Reproduce `lake build`, `verify.py`, `backlog_schema_probes.py` (18), `harness_regression.py` (14).
2. Check `cond_paretoMeasure_Ioi` at `K = L` and the `L ≤ K` hypothesis (for `K < L` nothing is
   stated); check that `excessLaw` is the pushforward of the *conditional* law and that the mean
   excess and conditional mean are separate theorems.
3. Check `map_rpow_paretoMeasure`'s preimage argument: the support restriction
   (`paretoMeasure_apply_inter_Ici`) and the two set identities are where the totalized power
   is kept out; both sides carry probability instances before `eq_of_cdf`.
4. Check G20 against p. 382 and the corrected `m_p''`; check the T118 facet scoping.
5. Confirm the D027-3 annotation is now readable from `evidence/fable/v0.2.9/deliverables_index_at_packaging.md`.

## Known limits (unchanged unless stated)

T021 centered MAD/STD ratios and Gaussian/Student moments; T005 general (2.10); T032 general
Property 5.2; T029 stronger regular-variation child, finite-family and a.s. variants; T118 convexity
and Jensen; S001, S002; domains of attraction (T011/T062/T093); stable-law existence for α < 2
(T007) and Cauchy identification (T046); subexponentiality of concrete laws; positive/measurable
regular variation and Karamata. The companion PDF `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf`
is the received v0.2.0 artifact; its figures refer to v0.2.0.
