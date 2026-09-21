# Audit brief: Taleb Lean handoff v0.2.10

Prepared 21 September 2026 for the next independent audit. Everything below is a claim to
verify from the archive, the patches and the git bundle. This release applies the v0.2.9 audit's
one wording finding and optional refinement, and delivers the centered Pareto moments and the
STD/MAD ratio as specified in its handoff. It also includes, for the first time and at the project
owner's request, the repository's generated scope memo for review (§ "The scope memo" below).

## What to audit

| Archive | `deliverables/v0.2.10/Taleb_Lean_Implementation_Handoff_v0.2.10_fable.zip` |
|---|---|
| SHA-256 | `64a241c8433dbbe20171d7dd88cf5cbed27a51a14e357ce23b34c5daaa0c747c` |
| Contents | 273 files, `SHA256SUMS` 272/272; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `03b7764`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.9, `abbea690e34bfde5799b8384b727e834d6a319f25cdda52c851c61eca602b77e` (audited by `Taleb_Fable_v0.2.9_Independent_Audit.pdf`, `3a6ee12d…5b530507`; kept in `audits/10_astra_on_v0.2.9/`). |
| Patches | `fable_changes_v0.2.10.patch` (v0.2.0 → v0.2.10, 221 files; applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree, tree hash `0a70943e…`); `fable_changes_v0.2.9_to_v0.2.10.patch` (39 files, from the v0.2.9 packaged tree `382faa0`; same tree hash). |
| Repository history | `taleb-formalization_v0.2.10.bundle` (`git bundle`, `refs/heads/main` at `03b7764`, `git bundle verify` ok). It proves the committed history and archive equality; it does not prove worktree cleanliness or anything about a remote, and it predates the commit that adds these deliverables. |
| Validation | `archive_validation_v0.2.10.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2748 jobs, 32 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree → probes 18/18 (count from the JSON record). |
| In-package copies | `evidence/fable/v0.2.10/deliverables_index_at_packaging.md` (the deliverables index) and `evidence/fable/v0.2.10/scope_memo_at_packaging.md` (the generated scope memo), both as of packaging time. |

## Changes since the v0.2.9 audit

### Responses to the audit (all confirmed before repair)

- **D029-1** The grouped summaries and T005's `delivery_scope` now say: for `0 < α ≤ 1`, the
  **conditional raw first moment** diverges as an extended nonnegative integral
  (`lintegral_id_cond_paretoMeasure_eq_top`); no divergence theorem for `excessLaw` is exported or
  claimed. Both finite mean formulas kept. No count or status change.
- **G20 wording** (optional): "agrees only at `p = 1`" → "as an identity in `α`, only for `p = 1`", with
  your accidental-equality example recorded (`L = 1, p = −1/8, α = 1/4` gives `−128/27` for both;
  checked). T118's text matches.
- Your remark on the scope memo (forecasts and infrastructure-absence claims not adopted as facts):
  agreed, and adopted as the way the memo now describes itself — see below.

### Mathematics — `AuditRepairs/ParetoMoments.lean` (T021 centered slice; 20 theorems, 4 defs; nothing pre-existing modified)

Against Mathlib's pinned `paretoMeasure L α` (`L > 0`), reusing Stage A and Stage B:

| Declarations | Claim | Route |
|---|---|---|
| `paretoMean`, `integral_id_paretoMeasure`, `integrable_id_paretoMeasure`, `lt_paretoMean`, `paretoMean_pos` | `m = αL/(α−1)` is the mean for `α > 1`; `L < m` | Stage A at `p = 1` |
| `integral_sub_const_cond_paretoMeasure` | `∫ (x − K) d(ν[|Ioi K]) = K/(α−1)` for `L ≤ K` | threshold law + `integral_sub` |
| `setIntegral_eq_measureReal_mul_integral_cond` | `∫_A f dν = ν.real A · ∫ f d(ν[|A])` for a finite `ν` with `ν A ≠ 0` | `cond = (ν A)⁻¹ • ν.restrict A`, `integral_smul_measure` |
| `integral_posPart_paretoMeasure` | `∫ max (x−m) 0 dν = (L/m)^α · m/(α−1)` | indicator of `Ioi m`, the two lines above, Stage A survival at `m ≥ L` |
| **`integral_abs_sub_mean_paretoMeasure`**, `paretoMAD`, `paretoMAD_algebra`, `abs_eq_two_mul_max_sub`, `paretoMAD_pos` | **centered MAD** `∫ |x − m| dν = 2L(α−1)^{α−2}/α^{α−1}` for `α > 1`; `> 0` | `|t| = 2 max t 0 − t`, `∫ (x−m) = 0`, exponent algebra |
| `integrable_sq_paretoMeasure`, `memLp_two_id_paretoMeasure`, `integral_sq_paretoMeasure` | `MemLp id 2 ν`, `∫ x² = αL²/(α−2)` for `α > 2` | Stage A at `p = 2`, `memLp_two_iff_integrable_sq` |
| **`variance_id_paretoMeasure`**, `paretoVariance` | `Var[id; ν] = αL²/((α−1)²(α−2))` | Mathlib `variance_eq_sub` |
| `paretoStd`, `paretoStd_eq` | `√Var = L/(α−1)·√(α/(α−2))` (the book's display, p. 86) | `Real.sqrt_mul`, `sqrt_sq` |
| **`paretoStd_div_paretoMAD`** | `STD/MAD = α^{α−1/2}/(2√(α−2)(α−1)^{α−1})` for `α > 2` — eq. (4.14) in inverted form | `rpow_add`, `sqrt_eq_rpow`, `MAD > 0` before dividing |
| `paretoMean_one_three`, `paretoVariance_one_three`, `paretoMAD_one_three` | `3/2`, `3/4`, `4/9` at `L = 1, α = 3` | `norm_num` |

The MAD is obtained through the Stage B threshold law at `K = m` (legitimate because `m > L`), not
by a new density integral — your proposed route. Credited to **T021**, which stays `partial`
(Gaussian and Student moments and the general MAD/STD comparisons of §4.4 remain). Not claimed: any
divergent-variance statement (Mathlib's `variance` is `evariance.toReal`; nothing is asserted outside
`α > 2`), the median absolute deviation, other families.

Counts: 201 theorems, 8 instances, 16 aliases (225 checked); trust scan 390 constants (106 internal),
all within the allowlist. Backlog: 2 discharged / 12 partial / 4 reuse / 89 missing / 33 source-check /
15 model-needed / 3 empirical (unchanged); 191 citations over 186 declarations; S001, S002 open;
gates G01–G20.

## The scope memo (new; for review, not for acceptance)

`evidence/fable/v0.2.10/scope_memo_at_packaging.md` is a copy of the repository's `SCOPE_MEMO.md`,
rendered by `tools/scope_memo.py` (repository root, outside the package). It answers "how far is the
formalism from complete?" for the project owner and is **a judgment document with computed data**:

- Computed from the ledger, the committed evidence layers and ledger snapshots at each release commit,
  and a pattern scan of the pinned Mathlib: the three-denominator headline, status × priority, the
  release history, the supported-family table, the dependency-group table, and the P0/modelling lists.
- Hand-maintained and labelled as judgment: the effort tiers for the untouched P1 families (§5), the
  projection (§6), the completion definitions (§7), next steps (§8). The generator flags an untiered
  family, a tiered family that has since gained support, or a release without a substance line.
- The Mathlib scan (§4a) states its method and limits: "0 files" for a pattern is strong evidence of
  absence, not proof; a positive count is only evidence that something with that name exists.

What a review would help with: whether the tier assignments are sound, whether the infrastructure
attributions (which families each missing theory blocks) are right, and whether the "completion needs a
definition" framing and the recommended reporting rule (progress against the P1 core, full 158-family
denominator retained) are acceptable to you as the auditor of record. The memo is not part of the audited
mathematics, and nothing in the package depends on it.

## Suggested audit focus

1. Reproduce `lake build`, `verify.py`, `backlog_schema_probes.py` (18), `harness_regression.py` (14 —
   note the suite now takes ~55 min as each fixture is a full verifier run over 225 declarations).
2. Check `integral_abs_sub_mean_paretoMeasure`: the pointwise identity, the zero mean, the indicator
   step, and especially `setIntegral_eq_measureReal_mul_integral_cond` (the `cond` definition read
   backwards) and that Stage B is applied at `K = m` with `L ≤ m` discharged by `lt_paretoMean`.
3. Check `variance_id_paretoMeasure` uses Mathlib's `variance` with `MemLp id 2 ν` supplied, and that
   `paretoStd_div_paretoMAD` divides only after `paretoMAD_pos`; compare with (4.14) on p. 86.
4. Review the scope memo as described above.

## Known limits (unchanged unless stated)

T021 Gaussian/Student moments and general MAD/STD comparisons; T005 general (2.10) via layer-cake;
T032 general Property 5.2; T029 stronger regular-variation child, finite-family and a.s. variants; T118
convexity and Jensen; S001, S002; domains of attraction (T011/T062/T093); stable-law existence for
α < 2 (T007) and Cauchy identification (T046); subexponentiality of concrete laws; positive/measurable
regular variation and Karamata. The companion PDF `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf`
is the received v0.2.0 artifact; its figures refer to v0.2.0.
