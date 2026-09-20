# Audit brief: Taleb Lean handoff v0.2.7

Prepared 20 September 2026 for the next independent audit. Everything below is a claim to
verify from the archive, the patches and the git bundle. This release corrects three
documentation findings of the v0.2.6 audit — two of them false statements in the v0.2.6
handoff, recorded as such in `FABLE_REVIEW.md` §17.1 — and adds the probabilistic Property 5.1.

## What to audit

| Archive | `deliverables/v0.2.7/Taleb_Lean_Implementation_Handoff_v0.2.7_fable.zip` |
|---|---|
| SHA-256 | `88ebaa078a18dc0e16bb46057969c5fec186c1fc958df1422b6d434e323d157b` |
| Contents | 222 files, `SHA256SUMS` 221/221; equals the git-tracked files of `Taleb_Lean_Repairs/` at commit `fe14519`; no `.lake/`, build outputs or bytecode. |
| Pins (unchanged since v0.2.0) | Lean `leanprover/lean4:v4.24.0`; Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; `lake-manifest.json` byte-identical. |
| Previous audited archive | v0.2.6, `d684d0ef3c3d17f9ceb5cd456969559674c1ac86e21bbd6a27505cf22d4fb3f3` (audited by `Taleb_Fable_v0.2.6_Independent_Audit.pdf`, `c9b5a23d…418e0f57`; kept in `audits/07_astra_on_v0.2.6/`). The v0.2.6 deliverables folder is left as shipped; its brief carries the routing error corrected here. |
| Patches | `fable_changes_v0.2.7.patch` (v0.2.0 → v0.2.7, 170 files; applies to the pristine extraction commit `f6b1007` and reproduces the packaged tree, tree hash `94c53167…`); `fable_changes_v0.2.6_to_v0.2.7.patch` (43 files, from the v0.2.6 packaged tree `83ef501`; same tree hash). |
| Repository history | `taleb-formalization_v0.2.7.bundle` (`git bundle`, `refs/heads/main` at `fe14519`, `git bundle verify` ok). It lets you check the committed history and its equality with the archive; it does not prove worktree cleanliness or anything about a remote, and it predates the commit that adds these deliverables. |
| Validation | `archive_validation_v0.2.7.log`: fresh extraction → manifest → pinned dependency copy → clean `lake build` exit 0 (2744 jobs, 29 modules, no warnings) → `verify.py` PASS → hashes identical to the working tree → schema/rendering probes 18/18. |

## Changes since the v0.2.6 audit

### Responses to the audit's findings (all confirmed before repair)

- **D026-1 (medium)** Confirmed, and worse than stale: the generator had only ever written the
  JSON, the Markdown was a hand step skipped in v0.2.6, and the v0.2.6 changelog nevertheless said
  "regenerated / synced". Repair: `backlog_schema.render_markdown` is the single rendering (it
  reproduces the v0.2.5 Markdown byte for byte from the v0.2.5 JSON); the generator writes both
  files from the same validated rows; `verify.py` fails unless the shipped Markdown equals the
  rendering byte for byte; `backlog_schema_probes.py` gained five rendering probes (Markdown
  equals rendering; stale Markdown status, stale Markdown scope, stale JSON scope, dropped JSON
  declaration each detected). No expensive Lean fixture was added, as you asked. The
  `ExtremeValueLaws.lean` module header now describes children 1–3 and points to
  `ExtremeValueAffine.lean`. The false changelog line is annotated, not rewritten.
- **D026-2 (low)** Confirmed: the claim that Fréchet/reverse-Weibull are "not globally continuous"
  was false. Prose corrected at the generator row (right-continuity and endpoint limits are what
  the Stieltjes construction uses; the totalized-power caveat belongs to `frechetFormula` only;
  `affineLaw` accepts any real `σ`, the cdf/maximum rules need `σ > 0`). Beyond the requested prose
  fix, global continuity is now proved (`continuous_frechetCDF`, `continuous_reverseWeibullCDF`),
  so the corrected sentence is a checked statement.
- **D026-3 (low)** Confirmed: densities were routed to T062, whose target is the Fréchet/Gaussian
  convergence cases, and §16.6 wrote `frechetMeasure α` for the Pareto limit. Repair: new
  `docs/SUPPLEMENTAL_OBLIGATIONS.md` with S001 (unified GEV parametrisation and the `ξ → 0` Gumbel
  limit, with the endpoint-coordinate reparametrisation flagged) and S002 (densities/`withDensity`);
  T060/T061 remaining texts and §16 corrected with visible markers; the Pareto limit is
  `frechetMeasure (1/α)` with normalisation `M_n/(L n^{1/α})`.
- Harness docstring: three positive controls.

### Mathematics — `AuditRepairs/WeightedSums.lean` (T029 probabilistic half; 13 theorems, 1 def) and two continuity theorems

| Declarations | Claim | Source / route |
|---|---|---|
| `AuditProbability.survivalRV P X`, `survivalRV_eq_survival_map` | `t ↦ P.real {X > t}`; equals `survival (P.map X)` for measurable `X` | definition |
| `weightedSum_event_lower_left/_right`, `weightedSum_event_upper` | `{X > t/a} ⊆ {aX+bY > t}`, `{Y > t/b} ⊆ {aX+bY > t}` (nonnegativity of the other summand), `{aX+bY > t} ⊆ {X > t/2a} ∪ {Y > t/2b}` — pure set statements, no measurability | §5.2.1 route proposed in the v0.2.6 audit |
| `AuditTails.neg_log_div_log_antitone`, `HasFiniteTailExponent.comp_const_mul`, `.max`, `.add`, `.of_le_of_le` (+ `log_add_le_log_two_add_max`, `log_max_of_pos`) | for `1 < t` the ratio is antitone in the tail; positive argument rescaling keeps the exponent (`log(ct)/log t → 1`); a max or a sum of two tails has exponent `min` (`max ≤ S₁+S₂ ≤ 2 max`, constant vanishes in the ratio); squeeze | general analytic bridge — `two_power_tail_min` was **not** used, as you asked |
| `AuditProbability.hasFiniteTailExponent_weightedSum` | **Property 5.1 for random variables**: pointwise nonnegative `X, Y`, `a, b > 0`, exponents `α, β` ⟹ the survival function of `aX + bY` has exponent `min α β`; **no independence** | Property 5.1, printed pp. 98–99 |
| `hasFiniteTailExponent_survival_map_weightedSum` | the same for the pushforward laws with measurable coordinates | via `survivalRV_eq_survival_map` |
| `AuditEVTLaws.continuous_frechetCDF`, `continuous_reverseWeibullCDF` | global continuity for positive shape | D026-2 |

Scope, stated exactly: exponent equality in the `−log S(t)/log t` interface. Not claimed:
survival-ratio asymptotics, regular variation of the sum, convolution asymptotics, a
finite-family version, or an almost-sure-nonnegativity variant. **T029 stays partial** (its target
reads "regularly varying tail dominates", the stronger ratio statement); states gain
`law_theorem`, 16 credited declarations. Nonnegativity is pointwise; the G18 signed
counterexample is the reason it is there.

Counts: 140 theorems, 8 instances, 16 aliases (164 checked); trust scan 296 constants (79
internal), all within the allowlist. Backlog: 2 discharged / 9 partial / 4 reuse / 91 missing /
34 source-check / 15 model-needed / 3 empirical; supplemental S001, S002 open.

## Suggested audit focus

1. Reproduce `lake build`, `verify.py` (now including the Markdown-rendering check),
   `backlog_schema_probes.py` (18) and `harness_regression.py` (14). Hand-edit the shipped
   `FORMALIZATION_BACKLOG.md` (e.g. T061 back to `partial`) and confirm `verify.py` fails.
2. Check `hasFiniteTailExponent_weightedSum` against Property 5.1: hypotheses (pointwise
   nonnegativity, positive weights, finite exponents of both survival functions), the absence of
   independence, and that the conclusion is exponent equality only. Check the three event
   inclusions and the sign handling in `neg_log_div_log_antitone` (stated for `1 < t`).
3. Decide whether T029's remaining target (the regular-variation reading) should stay open as
   written or be scoped to the exponent reading; the ledger currently keeps it open.
4. Review §17.1 (correction history) for completeness against your findings, and
   `docs/SUPPLEMENTAL_OBLIGATIONS.md` for the S001 reparametrisation statement.

## Known limits (unchanged unless stated)

Finite-family and a.s. variants of Property 5.1 (T029); unified GEV parametrisation (S001) and
EVT densities (S002); domains of attraction (T011/T062/T093); stable-law existence for α < 2
(T007) and the Cauchy identification (T046); subexponentiality of concrete laws; positive/
measurable regular variation and Karamata; Pareto moment integrals. The companion PDF
`Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` is the received v0.2.0 artifact; its figures
refer to v0.2.0.
