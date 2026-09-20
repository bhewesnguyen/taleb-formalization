# Audit brief: Taleb Lean handoff v0.2.6

Prepared 20 September 2026 for the next independent audit. Everything below is a claim to
verify from the archive, the patches and the git bundle.

## What to audit

| Archive | `deliverables/v0.2.6/Taleb_Lean_Implementation_Handoff_v0.2.6_fable.zip` |
|---|---|
| SHA-256 | `d684d0ef3c3d17f9ceb5cd456969559674c1ac86e21bbd6a27505cf22d4fb3f3` |
| Contents | 205 files, `SHA256SUMS` 204/204; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `83ef501`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.5, `9e214be3eb53b37721d9bcbc17da5e3aec8ea39dca38760abc4bd20caff56727` (audited by `Taleb_Fable_v0.2.5_Independent_Audit.pdf`, `011567ea…29bae4`; kept in `audits/06_astra_on_v0.2.5/`). |
| Patches | `fable_changes_v0.2.6.patch` (v0.2.0 → v0.2.6, 153 files; applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree, tree hash `bc7e8604…`); `fable_changes_v0.2.5_to_v0.2.6.patch` (44 files, from the v0.2.5 packaged tree `579f0d6`; same tree hash). |
| Repository history | `taleb-formalization_v0.2.6.bundle` (`git bundle`, `refs/heads/main` at `83ef501`, `git bundle verify` ok). It lets you check the committed history and its equality with the archive; it does not prove the author's worktree was clean or anything about a remote. The bundle necessarily predates the commit that adds these deliverables. |
| Validation | `archive_validation_v0.2.6.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2743 jobs, 28 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree. |

## Changes since the v0.2.5 audit

### Responses to the audit's findings (all confirmed before repair)

- **V025-L1** One validator, `scripts/backlog_schema.py`, is imported by both the ledger generator
  (which now refuses to write a malformed ledger) and `verify.py`. It requires the exact ID sequence
  `T001…T158`, typed fields (`bool` ≠ `int`), no unknown fields, nonblank text, fixed vocabularies,
  no duplicate states/declarations, `status = discharged ⇔ discharged ∈ states ⇔ discharged = true`,
  the four delivery fields present together, and the PDF-anchor offset. Your three mutations and
  nine more are replayed by `python3 scripts/backlog_schema_probes.py` (seconds; record in
  `evidence/fable/v0.2.6/04_backlog_schema_probes.log` and `current_after_verify/backlog_schema_probes.json`);
  the regression suite gained the end-to-end fixture `backlog_duplicate_id`.
- **D025-1** Strict and non-strict threshold events differ exactly on `{minRV X = x}` resp.
  `{maxRV X = x}`; `{∃ i, Xᵢ = x}` only contains the difference. Corrected in `ExtremeValueBridge.lean`
  (module and definition docstrings) and `FABLE_REVIEW.md` §14.2.
- **D025-2** Replacement-map rows 10/11 rewritten as history ("was open until v0.2.5", "constructed in
  v0.2.5", extended for v0.2.6); `docs/AUDIT_HISTORY.md` round-4 response names Gumbel **and** Fréchet.
- T061 carries the `law_theorem` facet.

### Self-found harness defect (H026-1) — please check the fix and the fixture

The regex public-API discovery in `verify.py` kept a namespace-only stack and popped it at every
`end`, including `end <Section>`; every declaration after a section end inside a namespace was
recorded unqualified. Latent in v0.2.5 (nothing followed `end Frechet`), it surfaced in the first
clean build of v0.2.6 as 22 `Unknown constant` errors in `AuditVerification.lean` — the designed
fail-closed path, but one that would have blocked a release rather than passed a wrong one. Fix:
one stack for namespaces and sections (`noncomputable section` handled). New positive-control
fixture `namespace_section_theorem` (14 fixtures). Recorded in `FABLE_REVIEW.md` §16.1 and the
v0.2.6 environment record.

### Mathematics — T061 children 3–4 (22 theorems, 5 instances, 7 defs; nothing pre-existing modified)

| Declarations | Claim | Source / route |
|---|---|---|
| `AuditEVTLaws.reverseWeibullCDF α`, `_of_neg/_of_nonneg/_le_one`, `_monotone`, `_continuousWithinAt_Ici`, `_tendsto_atBot/_atTop`, `reverseWeibullStieltjes`, `reverseWeibullMeasure`, `reverseWeibullMeasure_isProbabilityMeasure`, `cdf_reverseWeibullMeasure(_apply)` (`ExtremeValueLaws.lean`) | `exp(−(−x)^α)` for `x < 0`, `1` for `x ≥ 0`, `α > 0`: monotone, right-continuous everywhere (no hypothesis on `α` needed for this part), limits 0/1; Stieltjes probability measure with `cdf = reverseWeibullCDF α` | §9.1 p. 173 (Type III, `ξ = −1/α`; upper endpoint 0 — not the lifetime Weibull) |
| `reverseWeibullCDF_maxstable` | `W_α(x)^n = W_α(n^{1/α} x)` for **every** `n : ℕ` (both sides `1` at `n = 0`) | `Real.mul_rpow`, `Real.rpow_mul` |
| `cdf_map_maxRV_reverseWeibull`, `cdf_map_maxRV_pi_reverseWeibull` | maximum of independent `reverseWeibullMeasure` coordinates has cdf `W_α(n^{1/α} x)`; product-space realization | `AuditExtremes.cdf_map_maxRV`, `iIndepFun_pi` |
| `affineLaw ν μ σ`, `affineLaw_isProbabilityMeasure`, `affineLaw_zero_one`, `measurable_affine`, `affine_preimage_Iic`, `cdf_affineLaw` (`ExtremeValueAffine.lean`, new) | `ν.map (fun z => μ + σ z)` is a probability measure; for `σ > 0`, `cdf (affineLaw ν μ σ) x = cdf ν ((x − μ)/σ)` | `Measure.map_apply`, `le_div_iff₀` |
| `gumbelLaw μ σ`, `frechetLaw ξ hξ μ σ`, `reverseWeibullLaw α hα μ σ`, their `IsProbabilityMeasure` instances, `cdf_gumbelLaw`, `cdf_frechetLaw`, `cdf_reverseWeibullLaw` | the book's `G((x − b_n)/a_n)` forms with `b_n = μ`, `a_n = σ > 0` | §9.1 p. 173 |
| `map_maxRV_gumbelLaw`, `map_maxRV_frechetLaw`, `map_maxRV_reverseWeibullLaw` | **equalities of probability measures**: the maximum of `n` independent location/scale coordinates is `gumbelLaw (μ + σ log n) σ`, `frechetLaw ξ μ (σ n^ξ)`, `reverseWeibullLaw α μ (σ n^{−1/α})` | `Measure.eq_of_cdf` + the analytic max-stability identities |

**T061 is proposed as discharged** (second closed family, after T060). Target: "construct global
Gumbel, Fréchet and reverse-Weibull CDFs and prove validity"; hypotheses: "correct piecewise
support; scale > 0; shape domains; right continuity and endpoint limits". Documented non-claims:
the unified GEV form in `ξ` with the `ξ → 0` Gumbel limit is not stated (the three families are
separate laws); densities are T062; domains of attraction are T011. Negative scale is out of scope
and explicit in every statement. Ledger: states `formula_proved, conditional_law_theorem,
law_theorem, actual_law_constructed, source_reviewed, discharged`; 45 credited declarations;
scope and remaining texts rewritten (`docs/FORMALIZATION_BACKLOG.md`, T061).

Counts: 125 theorems, 8 instances, 16 aliases (149 checked); trust scan 270 constants (69
internal), all within the allowlist. Backlog: 2 discharged / 9 partial / 4 reuse / 91 missing /
34 source-check / 15 model-needed / 3 empirical.

## Suggested audit focus

1. Reproduce `lake build`, `verify.py`, `harness_regression.py` (14 fixtures, ≈ 30 min) and
   `backlog_schema_probes.py`; re-run your three V025-L1 mutations against the shipped verifier.
2. Decide whether T061 meets the acceptance boundaries you would set for "GEV families as
   probability measures": support conventions (reverse-Weibull endpoint from below, Fréchet from
   above), shape domains, positive scale only, right-continuity at the endpoints, the parameter
   rules for maxima, and whether the absence of the unified `ξ`-parametrisation should keep the
   family open or is correctly recorded as a documented difference.
3. Check `reverseWeibullCDF_maxstable` at `n = 0` and `reverseWeibullCDF_continuousWithinAt_Ici`
   without an `α` hypothesis — both are stronger than the sibling Fréchet statements, deliberately.
4. Check H026-1: that `verify.py`'s discovery now agrees with the environment on a file whose
   namespace contains several sections (the shipped `ExtremeValueLaws.lean`, `ExtremeValueAffine.lean`
   and the `namespace_section_theorem` fixture).
5. Review `FABLE_REVIEW.md` §16 and the v0.2.6 section of `CHANGELOG_FABLE.md` for over-claims.

## Known limits (unchanged unless stated)

Unified GEV parametrisation and densities of the EVT laws (T062); domains of attraction
(T011/T093); stable-law existence for α < 2 (T007) and the Cauchy identification (T046);
probabilistic Property 5.1 for nonnegative sums (T029); subexponentiality of concrete laws;
positive/measurable regular variation and Karamata; Pareto moment integrals. The companion PDF
`Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` is the received v0.2.0 artifact; its figures
refer to v0.2.0.
