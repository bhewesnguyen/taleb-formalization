# Audit brief: Taleb Lean handoff v0.2.8

Prepared 20 September 2026 for the next independent audit. Everything below is a claim to
verify from the archive, the patches and the git bundle. This release adopts the v0.2.7 audit's
T029 scope ruling, applies its three low documentation corrections at their sources, and adds
the exact Pareto law (Stage A of the milestone the audit specified).

## What to audit

| Archive | `deliverables/v0.2.8/Taleb_Lean_Implementation_Handoff_v0.2.8_fable.zip` |
|---|---|
| SHA-256 | `696c5187ed87bb0ad428bbbdd78185758de5b437fb14a9e2411c07b32a8ccbb0` |
| Contents | 238 files, `SHA256SUMS` 237/237; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `d086ce0`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.7, `88ebaa078a18dc0e16bb46057969c5fec186c1fc958df1422b6d434e323d157b` (audited by `Taleb_Fable_v0.2.7_Independent_Audit.pdf`, `6180c5ca…90b0c5c8`; kept in `audits/08_astra_on_v0.2.7/`). |
| Patches | `fable_changes_v0.2.8.patch` (v0.2.0 → v0.2.8, 186 files; applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree, tree hash `ebfa0c52…`); `fable_changes_v0.2.7_to_v0.2.8.patch` (42 files, from the v0.2.7 packaged tree `fe14519`; same tree hash). |
| Repository history | `taleb-formalization_v0.2.8.bundle` (`git bundle`, `refs/heads/main` at `d086ce0`, `git bundle verify` ok). It lets you check the committed history and its equality with the archive; it does not prove worktree cleanliness or anything about a remote, and it predates the commit that adds these deliverables. |
| Validation | `archive_validation_v0.2.8.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2746 jobs, 30 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree → probes 18/18 with the count read from the JSON record. |

## Changes since the v0.2.7 audit

### Responses to the audit (all confirmed before repair)

- **T029 scope ruling** adopted verbatim: `partial`; the binary finite-exponent child is
  complete; the stronger regular-variation child is named precisely in the ledger (the `δ`-split
  route and the equal-index warning included). The auditor's counterexample
  `S(t) = t^{−α} e^{ε sin log t}` is recorded as the reason the two readings differ.
- **D027-1** The stale sentence "The probabilistic statement about sums of random variables
  remains open" is gone from the generator row and both renderings. Facets:
  `conditional_law_theorem` for the two exponent theorems (assumed finite-exponent premises),
  `law_theorem` credited to `survivalRV_eq_survival_map` alone, `actual_law_constructed` newly
  earned by the concrete Pareto instance (not by quantifying over arbitrary laws); the scope text
  says which declaration supports which facet.
- **D027-2** S001 now has an explicit `G_0 = gumbelCDF` branch, off-support conventions, the
  corrected source pp. 172–173 / PDF 186–187 (checked against the book: the kernel follows eq. (9.2)
  on p. 172, the limit and named forms are on p. 173), the coordinate table
  `ξ > 0 ↦ frechetLaw ξ (−1/ξ) (1/ξ)`, `ξ < 0 ↦ reverseWeibullLaw (−1/ξ) (−1/ξ) (−1/ξ)`,
  `ξ = 0 ↦ gumbelLaw 0 1`, and the general endpoint `e = m − s/ξ`.
- **D027-3** The v0.2.7 validation log is left as shipped; `deliverables/README.md` annotates its
  "17 probes" as a text-grep miscount (18 results). The v0.2.8 log reads the count from
  `backlog_schema_probes.json`.
- Your remark that the rendering gate compared newline-normalised text: it now compares raw bytes
  (`read_bytes()`), so a CRLF conversion also fails it.

### Mathematics — `AuditRepairs/ParetoLaw.lean` (Stage A; 20 theorems, 1 def; nothing pre-existing modified)

Against **Mathlib's pinned** `paretoMeasure L α = volume.withDensity (paretoPDF L α)` — no parallel
Pareto measure — for `L > 0`, `α > 0`:

| Declarations | Claim | Route |
|---|---|---|
| `paretoMeasure_Iic_of_lt`, `paretoMeasure_Iio_endpoint`, `paretoMeasure_singleton_endpoint` | no mass below `L`; no atom at `L` (absolute continuity) | `withDensity_apply`, `withDensity_absolutelyContinuous` |
| `survival_paretoMeasure`, `_of_le`, `_endpoint` | strict survival `1` for `x < L`, `(L/x)^α` for `x ≥ L`, value `1` at `x = L` | `integral_Ioi_rpow_of_lt`, `ofReal_integral_eq_lintegral_ofReal` |
| `cdf_paretoMeasure`, `_endpoint` | cdf `0` for `x < L`, `1 − (L/x)^α` for `x ≥ L`, value `0` at `x = L` | `1 − S` via `measureReal_compl` |
| `momentLintegral`, `momentLintegral_eq` | `∫⁻ x, ofReal (x^p) dPareto = ∫⁻ x in Ioi L, ofReal (α L^α x^{p−α−1})` | `lintegral_withDensity_eq_lintegral_mul`, endpoint null |
| `momentLintegral_of_lt` | `= ofReal (α L^p/(α − p))` for `p < α` | `integral_Ioi_rpow_of_lt` |
| `momentLintegral_eq_top` | `= ⊤` for `α ≤ p`, **boundary `p = α` included** | `integrableOn_Ioi_rpow_iff` (exponent `≥ −1`), `hasFiniteIntegral_iff_ofReal` |
| `integrable_rpow_paretoMeasure_iff` | `Integrable (x^p) (paretoMeasure L α) ↔ p < α` | from the two extended-integral results |
| `integral_rpow_paretoMeasure`, `integral_rpow_zero_paretoMeasure`, `integral_abs_rpow_paretoMeasure` | `∫ x^p = α L^p/(α − p)` for `p < α` (all real `p`, negative orders included); `= 1` at `p = 0`; absolute moments agree | derived **only** inside the integrable range |
| `hasFiniteTailExponent_survival_paretoMeasure` | the actual survival function has exponent `α` | eventual equality with `L^α x^{−α}` |
| `hasFiniteTailExponent_weightedSum_pareto` | **Property 5.1 instantiated**: Pareto-distributed nonnegative coordinates ⟹ the law of `aX + bY` has exponent `min α₁ α₂`; no independence | T029 theorem + the line above |

A totalized real integral is never used as evidence of finiteness. Credited as the exact-Pareto
*slices* of **T021** (`missing → partial`) and **T028** (`source-check → partial`; the
statement-review gate for the general regularly varying `q = α` boundary is kept in its remaining
text). Stage B — conditional/excess law `𝓛(X | X > K) = Pareto(K, α)` and the positive-power
pushforward `Pareto(L, α).map (· ^ q) = Pareto(L^q, α/q)` — is not claimed.

Counts: 160 theorems, 8 instances, 16 aliases (184 checked); trust scan 321 constants (83
internal), all within the allowlist. Backlog: 2 discharged / 11 partial / 4 reuse / 90 missing /
33 source-check / 15 model-needed / 3 empirical; 146 citations over 142 declarations; S001, S002
open.

## Suggested audit focus

1. Reproduce `lake build`, `verify.py`, `backlog_schema_probes.py` (18) and `harness_regression.py`
   (14); try a CRLF conversion of the shipped Markdown ledger against the byte-literal gate.
2. Check `momentLintegral_eq_top` at the boundary `p = α` and that no real-integral statement is
   made outside `p < α`; check the endpoint conventions (`survival = 1`, `cdf = 0` at `x = L`) against
   Mathlib's density (`t ≤ x` branch) — the law has no atom, so the strict/non-strict conventions
   agree at `L`.
3. Decide whether T028's move from `source-check` to `partial` is right: the exact-Pareto slice
   settles the boundary for the exact law, while the general regularly varying statement keeps
   its statement-review gate in the remaining text.
4. Check the T029 facet allocation and the named stronger child against your ruling.

## Known limits (unchanged unless stated)

Pareto Stage B (conditional/excess, positive-power pushforward); T021 ratios and the Gaussian/
Student moments; T029 stronger regular-variation child, finite-family and a.s. variants; S001,
S002; domains of attraction (T011/T062/T093); stable-law existence for α < 2 (T007) and the
Cauchy identification (T046); subexponentiality of concrete laws; positive/measurable regular
variation and Karamata. The companion PDF `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` is
the received v0.2.0 artifact; its figures refer to v0.2.0.
