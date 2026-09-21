# Changelog: Fable review

## v0.2.7 → v0.2.8 (sixth corrective pass; exact Pareto law, Stage A)

Trigger: the independent audit of v0.2.7 (`Taleb_Fable_v0.2.7_Independent_Audit.pdf`, SHA-256
`6180c5ca…90b0c5c8`; ledger `Taleb_Proof_Progress_v0.2.7.md`, `e7e7cbdf…9c255160`; handoff
`Taleb_Fable_v0.2.7_Review_Handoff.md`, `56b58e16…6a151c17`; evidence ZIP `279619cc…8263ac93`).
Details: `FABLE_REVIEW.md` §18.

### Mathematical statement changes

No pre-existing theorem, definition, instance, alias or proof was modified. **Added** in the new module
`AuditRepairs/ParetoLaw.lean` (all with closure `{propext, Classical.choice, Quot.sound}`), against
Mathlib's pinned `ProbabilityTheory.paretoMeasure L α` (no parallel Pareto measure):

| Declaration | Kind | Content (`L > 0`, `α > 0` unless stated) |
|---|---|---|
| `AuditPareto.paretoMeasure_Iic_of_lt`, `paretoMeasure_Iio_endpoint`, `paretoMeasure_singleton_endpoint`, `measurable_paretoPDF` | theorems | no mass below the endpoint, no atom at `L` (no positivity hypotheses needed), measurability of the `ℝ≥0∞` density. |
| `AuditPareto.pareto_tail_algebra` | theorem | `α L^α · (−x^{−α}/(−α)) = (L/x)^α` for `x > 0`. |
| `AuditPareto.survival_paretoMeasure`, `survival_paretoMeasure_of_le`, `survival_paretoMeasure_endpoint` | theorems | strict survival `1` below `L`, `(L/x)^α` from `L` on; value `1` at `x = L`. |
| `AuditPareto.cdf_paretoMeasure`, `cdf_paretoMeasure_endpoint` | theorems | cdf `0` below `L`, `1 − (L/x)^α` from `L` on; value `0` at `x = L`. |
| `AuditPareto.momentLintegral L α p` | def | `∫⁻ x, ENNReal.ofReal (x^p) ∂(paretoMeasure L α)`. |
| `AuditPareto.momentLintegral_eq`, `momentLintegral_of_lt`, `momentLintegral_eq_top` | theorems | reduction to `∫⁻ x in Ioi L, ofReal (α L^α x^{p−α−1})`; `= ofReal (α L^p/(α−p))` for `p < α`; `= ⊤` for `α ≤ p` (boundary included). |
| `AuditPareto.ae_nonneg_rpow_paretoMeasure`, `integrable_rpow_paretoMeasure_iff`, `integral_rpow_paretoMeasure`, `integral_rpow_zero_paretoMeasure`, `integral_abs_rpow_paretoMeasure` | theorems | `x^p ≥ 0` a.e.; `Integrable (x^p) ↔ p < α`; `∫ x^p = α L^p/(α−p)` for `p < α`; `= 1` at `p = 0`; absolute moments equal raw moments. |
| `AuditPareto.hasFiniteTailExponent_survival_paretoMeasure` | theorem | the actual survival function has finite log-tail exponent `α`. |
| `AuditPareto.hasFiniteTailExponent_weightedSum_pareto` | theorem | Property 5.1 instantiated: Pareto-distributed nonnegative coordinates, positive weights ⟹ the law of the weighted sum has survival exponent `min α₁ α₂`; no independence. |

Counts: 140 → **160 theorems**, 8 instances, 16 aliases (**184** checked); trust scan 296 → **321**
constants (83 internal). Backlog: **T021** `missing → partial`
and **T028** `source-check → partial` (exact-Pareto slices; the general targets and T028's statement-review
gate for the regularly varying `q = α` boundary stay open); **T029** gains `actual_law_constructed` (the
Pareto instance) and the corrected texts of D027-1; 146 citations over 142 declarations.

### Changed files

| File | Change |
|---|---|
| `AuditRepairs/ParetoLaw.lean` | **New** (imports `AuditRepairs.WeightedSums`, `Mathlib.Probability.Distributions.Pareto`, `Mathlib.Analysis.SpecialFunctions.ImproperIntegrals`). |
| `AuditRepairs.lean` | Imports `AuditRepairs.ParetoLaw`. |
| `AuditVerification.lean` | Regenerated: 184 `#print axioms` lines. |
| `scripts/rebuild_curated_inventory.py` | T029 row: stale "remains open" sentence replaced (audit D027-1), facets `conditional_law_theorem` + `law_theorem` (credited to `survivalRV_eq_survival_map`) + `actual_law_constructed` (Pareto instance), the stronger regular-variation child named precisely. T021, T028 rows: exact-Pareto slices, status `partial`. |
| `scripts/verify.py`, `scripts/backlog_schema_probes.py` | Rendering gate compares raw bytes (`read_bytes()`), not newline-normalised text. |
| `docs/FORMALIZATION_BACKLOG.json`, `.md` | Regenerated together (checked). |
| `docs/SUPPLEMENTAL_OBLIGATIONS.md` | S001 (audit D027-2): explicit `G_0 = gumbelCDF` branch, off-support conventions, source pp. 172–173 / PDF 186–187 (checked against the book), coordinate table and endpoint `e = m − s/ξ`. |
| `docs/SOURCE_GATES.md` | G18 resolution note extended: concrete Pareto instance. |
| `docs/MATHLIB_AND_WORK_ORDER.md` | Pareto row updated. |
| `docs/AUDIT_HISTORY.md` | Round 7 (audit of v0.2.7) added. |
| `README.md` | Version, counts (160/8/16, 184), module list, "What is still open". |
| `FABLE_REVIEW.md` | + §18. |
| `lakefile.toml` | `version = "0.2.8"`. |
| `SHA256SUMS`, `evidence/current/*`, `evidence/fable/v0.2.8/` | Regenerated / new evidence layer. |

Repository (outside the package): `audits/08_astra_on_v0.2.7/` holds the received audit; `deliverables/README.md`
annotates the v0.2.7 validation log's probe count (17 → 18, audit D027-3) without rewriting the shipped log; a
`git bundle` accompanies the v0.2.8 ZIP.

Pins unchanged: `lean-toolchain`, `lake-manifest.json`, Mathlib `rev`.

### Compatibility implications

- Client code: none for existing declarations. New namespace `AuditPareto`. `import AuditRepairs` now also
  brings in `Mathlib.Probability.Distributions.Pareto` and `Mathlib.Analysis.SpecialFunctions.ImproperIntegrals`.
- Verification: a CRLF-converted `docs/FORMALIZATION_BACKLOG.md` now fails the rendering gate (previously
  accepted after newline normalisation). Runtime unchanged (≈ 2–4 min).

### Validation performed (v0.2.8)

- `rm -rf .lake/build; lake build`: exit 0, no warnings.
- `python3 scripts/verify.py`: exit 0, `PASS: 160 theorems, 8 instance, 16 aliases; no extra axioms; trust scan:
  321 project constants (incl. 83 internal) all within allowlist; 184 public theorem/instance constants match the
  regex inventory`; ledger valid, Markdown equals rendering (bytes), all cited declarations present.
- `python3 scripts/backlog_schema_probes.py`: exit 0, 18/18 (count read from the JSON record).
- `python3 scripts/harness_regression.py`: exit 0, 14/14 fixtures as expected.
- Final ZIP validated from a fresh extraction (`deliverables/v0.2.8/archive_validation_v0.2.8.log`).

---

## v0.2.6 → v0.2.7 (fifth corrective pass; probabilistic Property 5.1)

Trigger: the independent audit of v0.2.6 (`Taleb_Fable_v0.2.6_Independent_Audit.pdf`, SHA-256
`c9b5a23df58b0948…418e0f57`; ledger `Taleb_Proof_Progress_v0.2.6.md`, `a1f30b1cb099d5dd…876db7bb`;
evidence ZIP `753f97098dd99a89…cf8a8dbd`). Details and a **correction history** of the false v0.2.6
statements: `FABLE_REVIEW.md` §17.

**Correction to this changelog.** The v0.2.6 section below says
"`docs/FORMALIZATION_BACKLOG.json`, `.md` — Regenerated / synced (158/158)". The Markdown was *not*
regenerated in v0.2.6; it shipped byte-identical to v0.2.5 (audit D026-1). The line is left in place
and annotated rather than rewritten.

### Mathematical statement changes

No pre-existing theorem, definition, instance, alias or proof was modified. **Added** (all with closure
`{propext, Classical.choice, Quot.sound}`):

| Declaration | Kind | Content |
|---|---|---|
| `AuditEVTLaws.continuous_frechetCDF`, `continuous_reverseWeibullCDF` | theorems | global continuity of the guarded distribution functions for positive shape (`ExtremeValueLaws.lean`; audit D026-2 asked only for corrected prose — these make the corrected prose checkable). |
| `AuditTails.neg_log_div_log_antitone` | theorem | for `1 < x`, `s ↦ −log s / log x` is antitone on positive arguments (the single place the log-denominator sign is handled). |
| `AuditTails.HasFiniteTailExponent.comp_const_mul` | theorem | positive argument rescaling keeps the exponent. |
| `AuditTails.log_add_le_log_two_add_max`, `log_max_of_pos` | theorems | pointwise log inequalities for positive arguments. |
| `AuditTails.HasFiniteTailExponent.max`, `.add` | theorems | a maximum / a sum of two tails has exponent `min α β`. |
| `AuditTails.HasFiniteTailExponent.of_le_of_le` | theorem | squeeze between two tails with the same exponent. |
| `AuditProbability.survivalRV P X` | def | `t ↦ P.real {X > t}`, the survival function of a random variable. |
| `AuditProbability.survivalRV_eq_survival_map` | theorem | equals the law-level `survival (P.map X)` for measurable `X`. |
| `AuditProbability.weightedSum_event_lower_left`, `_lower_right`, `_upper` | theorems | the event inclusions `{X > t/a} ⊆ {aX+bY > t}`, `{Y > t/b} ⊆ …`, `{aX+bY > t} ⊆ {X > t/2a} ∪ {Y > t/2b}` (pure set statements). |
| `AuditProbability.hasFiniteTailExponent_weightedSum` | theorem | **Property 5.1 for random variables**: nonnegative `X, Y`, `a, b > 0`, exponents `α, β` ⟹ the survival function of `aX + bY` has exponent `min α β`; no independence. |
| `AuditProbability.hasFiniteTailExponent_survival_map_weightedSum` | theorem | the same for the pushforward laws with measurable coordinates. |

Counts: 125 → **140 theorems**, 8 instances, 16 aliases (**164** checked); trust scan 270 → **296**
constants (79 internal). Backlog: T029 gains
`law_theorem` and 14 declarations (status stays `partial`: the family's target reads "regularly
varying tail dominates", the stronger ratio statement); T060/T061 remaining texts corrected (D026-3);
T061 hypotheses text corrected (D026-2); all other rows unchanged.

### Changed files

| File | Change |
|---|---|
| `AuditRepairs/WeightedSums.lean` | **New** (imports `AuditRepairs.ProbabilityBridge`). |
| `AuditRepairs/ExtremeValueLaws.lean` | Module header rewritten (audit D026-1: it still called reverse-Weibull and location/scale "not done"; now children 1–3, pointing to `ExtremeValueAffine.lean` for child 4, with the continuity paragraph); two continuity theorems and their `#print axioms` lines added. Existing proofs untouched. |
| `AuditRepairs.lean` | Imports `AuditRepairs.WeightedSums`. |
| `AuditVerification.lean` | Regenerated: 164 `#print axioms` lines. |
| `scripts/backlog_schema.py` | `render_markdown(rows)` and `MARKDOWN_PREAMBLE`: the single rendering of `docs/FORMALIZATION_BACKLOG.md` (reproduces the v0.2.5 file byte for byte from the v0.2.5 JSON). |
| `scripts/rebuild_curated_inventory.py` | Writes **both** renderings from the validated rows. T029 row: `law_theorem`, declarations, target/scope/remaining. T061 hypotheses (D026-2), T060/T061 remaining (D026-3) corrected. |
| `scripts/verify.py` | New check: the shipped Markdown ledger equals `render_markdown(JSON)` byte for byte (audit D026-1). |
| `scripts/backlog_schema_probes.py` | +5 probes: Markdown equals rendering; stale Markdown status, stale Markdown scope, stale JSON scope, dropped JSON declaration are each detected. 18 probes. |
| `scripts/harness_regression.py` | Docstring: three positive controls. |
| `docs/FORMALIZATION_BACKLOG.json`, `.md` | Regenerated **together** (checked by `verify.py`): T029, T060, T061 texts. |
| `docs/SUPPLEMENTAL_OBLIGATIONS.md` | **New** (audit D026-3): S001 unified GEV parametrisation and `ξ → 0` Gumbel limit; S002 densities/`withDensity` of the three EVT laws; routing reminders (T011/T062 targets; `frechetMeasure (1/α)` for Pareto tail `α`). |
| `docs/AUDIT_HISTORY.md` | Round 6 (audit of v0.2.6) added. |
| `README.md` | Version, counts (140/8/16, 164), module list, verifier/probe descriptions, routing in "What is still open". |
| `FABLE_REVIEW.md` | §16.3 and §16.6 corrected with visible markers (D026-3); + §17 with the correction history. |
| `lakefile.toml` | `version = "0.2.7"`. |
| `SHA256SUMS`, `evidence/current/*`, `evidence/fable/v0.2.7/` | Regenerated / new evidence layer. |

Repository (outside the package): `audits/07_astra_on_v0.2.6/` holds the received audit; a `git bundle`
accompanies the v0.2.7 ZIP.

Pins unchanged: `lean-toolchain`, `lake-manifest.json`, Mathlib `rev`.

### Compatibility implications

- Client code: none for existing declarations. New namespace members under `AuditTails`,
  `AuditProbability`, `AuditEVTLaws` only.
- Verification: `verify.py` now fails on a hand-edited `docs/FORMALIZATION_BACKLOG.md`; regenerate
  with `python3 scripts/rebuild_curated_inventory.py`. Runtime unchanged (≈ 2–4 min).
- Backlog JSON: schema unchanged.

### Validation performed (v0.2.7)

- `rm -rf .lake/build; lake build`: exit 0, no warnings.
- `python3 scripts/verify.py`: exit 0, `PASS: 140 theorems, 8 instance, 16 aliases; no extra axioms; trust
  scan: 296 project constants (incl. 79 internal) all within allowlist; 164 public theorem/instance
  constants match the regex inventory`; ledger valid, Markdown equals rendering, all cited declarations present.
- `python3 scripts/backlog_schema_probes.py`: exit 0, 18/18.
- `python3 scripts/harness_regression.py`: exit 0, 14/14 fixtures as expected.
- Documentation consistency: replacement map 16/16; backlog Markdown/JSON consistency is now a
  verifier check, not a claim.
- Final ZIP validated from a fresh extraction (`deliverables/v0.2.7/archive_validation_v0.2.7.log`).

---

## v0.2.5 → v0.2.6 (fourth corrective pass; reverse-Weibull and location/scale laws; T061 discharged)

Trigger: the independent audit of v0.2.5 (`Taleb_Fable_v0.2.5_Independent_Audit.pdf`, SHA-256
`011567eaec47a98dd994b21fdac45b282ff00a8eb10c9b48946548fb6d29bae4`; ledger `Taleb_Proof_Progress_v0.2.5.md`,
`305c86a77b474eb81e80adc1a987363ca4228c1fffa292f59b551a308cd2e70a`; evidence ZIP
`8f604b672f43071e6e29338443441a7ae091d021c2e7451f49eaad2c6a3d8cc5`). Details: `FABLE_REVIEW.md` §16.

### Mathematical statement changes

No pre-existing theorem, definition, instance, alias or proof was modified. **Added** (all with closure
`{propext, Classical.choice, Quot.sound}`):

| Declaration | Kind | Content |
|---|---|---|
| `AuditEVTLaws.reverseWeibullCDF α x` | def | `exp(−(−x)^α)` for `x < 0`, `1` for `x ≥ 0` (Type III, upper endpoint `0`; `ExtremeValueLaws.lean`). |
| `AuditEVTLaws.reverseWeibullCDF_of_neg`, `_of_nonneg`, `_le_one`, `_monotone`, `_continuousWithinAt_Ici`, `_tendsto_atBot`, `_tendsto_atTop` | theorems | analytic properties for `0 < α` (right-continuity needs no hypothesis on `α`). |
| `AuditEVTLaws.reverseWeibullStieltjes α hα`, `reverseWeibullMeasure α hα` | defs | Stieltjes function and measure. |
| `AuditEVTLaws.reverseWeibullMeasure_isProbabilityMeasure` | instance | total mass one. |
| `AuditEVTLaws.cdf_reverseWeibullMeasure`, `cdf_reverseWeibullMeasure_apply` | theorems | cdf identities. |
| `AuditEVTLaws.reverseWeibullCDF_maxstable` | theorem | `W_α(x)^n = W_α(n^{1/α} x)` for every `n : ℕ`. |
| `AuditEVTLaws.cdf_map_maxRV_reverseWeibull`, `cdf_map_maxRV_pi_reverseWeibull` | theorems | maximum of independent `reverseWeibullMeasure` coordinates has cdf `W_α(n^{1/α} x)`; product-space realization. |
| `AuditEVTLaws.affineLaw ν μ σ` | def | `ν.map (fun z => μ + σ z)` (new module `ExtremeValueAffine.lean`). |
| `AuditEVTLaws.measurable_affine`, `affineLaw_zero_one`, `affine_preimage_Iic`, `cdf_affineLaw` | theorems | measurability; `affineLaw ν 0 1 = ν`; for `σ > 0`, preimage of `Iic x` is `Iic ((x − μ)/σ)` and `cdf (affineLaw ν μ σ) x = cdf ν ((x − μ)/σ)`. |
| `AuditEVTLaws.affineLaw_isProbabilityMeasure`, `gumbelLaw_isProbabilityMeasure`, `frechetLaw_isProbabilityMeasure`, `reverseWeibullLaw_isProbabilityMeasure` | instances | probability measures. |
| `AuditEVTLaws.gumbelLaw μ σ`, `frechetLaw ξ hξ μ σ`, `reverseWeibullLaw α hα μ σ` | defs | the location/scale families. |
| `AuditEVTLaws.cdf_gumbelLaw`, `cdf_frechetLaw`, `cdf_reverseWeibullLaw` | theorems | `G((x − μ)/σ)` distribution functions for `σ > 0`. |
| `AuditEVTLaws.map_maxRV_gumbelLaw`, `map_maxRV_frechetLaw`, `map_maxRV_reverseWeibullLaw` | theorems | **equalities of laws**: the maximum of `n` independent location/scale coordinates is `gumbelLaw (μ + σ log n) σ`, `frechetLaw ξ μ (σ n^ξ)`, `reverseWeibullLaw α μ (σ n^{−1/α})`. |

Counts: 103 → **125 theorems**, 3 → **8 instances**, 16 aliases (**149** checked); trust scan 216 → **270**
constants (69 internal). Backlog: **T061
discharged** (second closed family; states gain `law_theorem` and `discharged`, 45 credited
declarations, scope and remaining rewritten); all other rows unchanged.

### Changed files

| File | Change |
|---|---|
| `AuditRepairs/ExtremeValueLaws.lean` | New section "Reverse-Weibull" appended after the Fréchet section; five `#print axioms` lines added. Existing content untouched. |
| `AuditRepairs/ExtremeValueAffine.lean` | **New** (imports `AuditRepairs.ExtremeValueLaws`). |
| `AuditRepairs/ExtremeValueBridge.lean` | Docstrings only (audit D025-1): strict and non-strict threshold events differ exactly on `{minRV X = x}` resp. `{maxRV X = x}`, not on `{∃ i, Xᵢ = x}`. |
| `AuditRepairs.lean` | Imports `AuditRepairs.ExtremeValueAffine`. |
| `AuditVerification.lean` | Regenerated: 149 `#print axioms` lines. |
| `scripts/backlog_schema.py` | **New** (audit V025-L1): the single ledger validator — exact ID sequence `T001…T158`, typed fields, no unknown fields, nonblank text, fixed vocabularies, no duplicate states/declarations, status ⇔ state ⇔ Boolean agreement, delivery fields present together, PDF anchor offset. |
| `scripts/backlog_schema_probes.py` | **New**: 12 malformed-ledger probes (the auditor's three and nine more) plus the clean ledger; writes `evidence/current/backlog_schema_probes.json`. |
| `scripts/rebuild_curated_inventory.py` | Imports the shared validator and refuses to write a malformed ledger; local vocabularies removed. T061 row: status `discharged`, states, 24 new declarations, target/hypotheses "Delivered" text, scope and remaining. |
| `scripts/verify.py` | Imports the shared validator in place of its private schema loop; docstring updated. **Discovery fix (self-found, H026-1):** the regex inventory kept a namespace-only stack and popped it at every `end`, including `end <Section>`; every declaration after a section end lost its namespace. Masked in v0.2.5 (nothing followed `end Frechet`), it surfaced immediately in v0.2.6 as a failed `AuditVerification` build — the intended fail-closed behaviour. Now one stack for namespaces and sections. Report fields unchanged. |
| `scripts/harness_regression.py` | New fixtures `backlog_duplicate_id` (expected FAIL on `schema violations`) and `namespace_section_theorem` (positive control: a theorem after `end <Section>` inside a namespace must be discovered with its namespace); 14 fixtures. |
| `docs/FORMALIZATION_BACKLOG.json`, `.md` | Regenerated / synced (158/158): T061 discharged. **Incorrect (audit of v0.2.6, D026-1): only the JSON was regenerated; the Markdown shipped byte-identical to v0.2.5. Repaired in v0.2.7.** |
| `docs/REPLACEMENT_MAP.md`, `docs/replacement_map.json` | Rows 10, 11 (audit D025-2): "remains open" clauses rewritten as history; v0.2.6 location/scale laws noted. |
| `docs/MATHLIB_AND_WORK_ORDER.md` | CDF row and slice 4: T061 done. |
| `docs/AUDIT_HISTORY.md` | Round 5 (audit of v0.2.5) added; round-4 response names Gumbel **and** Fréchet (audit D025-2). |
| `README.md` | Version, counts (125/8/16, 149), module list, verifier/regression/probe descriptions, "What is still open". |
| `FABLE_REVIEW.md` | §14.2 boundary-event wording corrected; + §16. |
| `lakefile.toml` | `version = "0.2.6"`. |
| `SHA256SUMS`, `evidence/current/*`, `evidence/fable/v0.2.6/` | Regenerated / new evidence layer. |

Repository (outside the package): `audits/06_astra_on_v0.2.5/` holds the received audit; a `git bundle`
accompanies the v0.2.6 ZIP.

Pins unchanged: `lean-toolchain`, `lake-manifest.json`, Mathlib `rev`.

### Compatibility implications

- Client code: none for existing declarations. New namespace members under `AuditEVTLaws` only.
- Verification: `verify.py` now imports `scripts/backlog_schema.py` (same directory; no new
  third-party dependency). `harness_regression.py` runs 14 fixtures (≈ 25–35 min).
- Backlog JSON: schema unchanged; enforcement stricter (a hand-edited ledger with duplicate IDs,
  contradictory flags or non-string text now fails both the generator and the verifier).

### Validation performed (v0.2.6)

- `rm -rf .lake/build; lake build`: exit 0, no warnings.
- `python3 scripts/verify.py`: exit 0, `PASS: 125 theorems, 8 instance, 16 aliases; no extra axioms; trust
  scan: 270 project constants (incl. 69 internal) all within allowlist; 149 public theorem/instance
  constants match the regex inventory`; ledger valid; all cited declarations present.
- `python3 scripts/backlog_schema_probes.py`: exit 0, 13/13 (clean ledger + 12 probes).
- `python3 scripts/harness_regression.py`: exit 0, 14/14 fixtures as expected.
- Documentation consistency: replacement map 16/16, backlog 158/158.
- Final ZIP validated from a fresh extraction (`deliverables/v0.2.6/archive_validation_v0.2.6.log`).

---

## v0.2.4 → v0.2.5 (third corrective pass; Gumbel and Fréchet laws constructed)

Trigger: the independent audit of v0.2.4 (`Taleb_Fable_v0.2.4_Independent_Audit.pdf`, SHA-256
`5407c895a153229f861f8a078831c877c5b73041bbc95963142f9eedca9b31f7`; ledger `Taleb_Proof_Progress_v0.2.4.md`,
`c4a29b2636a9198afa56db3af32971fd74bc69706a3e453b4eac5b3ce4b12332`; evidence ZIP
`b5117d9f2aef8846c758da613e91380d96b2ba35c85c247e0c4ec86e00f9efe7`). Details: `FABLE_REVIEW.md` §15.

### Mathematical statement changes

No pre-existing theorem, definition, instance, alias or proof was modified. **Added** in the new
module `AuditRepairs/ExtremeValueLaws.lean` (all with closure `{propext, Classical.choice, Quot.sound}`):

| Declaration | Kind | Content |
|---|---|---|
| `AuditEVTLaws.gumbelCDF_monotone`, `continuous_gumbelCDF`, `gumbelCDF_tendsto_atBot`, `gumbelCDF_tendsto_atTop` | theorems | analytic properties of `AuditTails.gumbelCDF`. |
| `AuditEVTLaws.gumbelStieltjes`, `gumbelMeasure` | defs | the Gumbel distribution function as a `StieltjesFunction` and its measure. |
| `AuditEVTLaws.gumbelMeasure_isProbabilityMeasure` | instance | total mass one from the endpoint limits. |
| `AuditEVTLaws.cdf_gumbelMeasure`, `cdf_gumbelMeasure_apply` | theorems | `cdf gumbelMeasure = gumbelStieltjes`; pointwise `cdf gumbelMeasure x = gumbelCDF x`. |
| `AuditEVTLaws.cdf_map_maxRV_gumbel`, `cdf_map_maxRV_pi_gumbel` | theorems | maximum of independent `gumbelMeasure` coordinates has cdf `gumbelCDF (x − log n)`; product-space realization. |
| `AuditEVTLaws.frechetCDF_of_pos`, `frechetCDF_of_nonpos`, `frechetCDF_nonneg`, `neg_one_div_nonpos`, `frechetCDF_monotone`, `frechetCDF_continuousWithinAt_Ici`, `frechetCDF_tendsto_atBot`, `frechetCDF_tendsto_atTop` | theorems | analytic properties of `AuditTails.frechetCDF ξ` for `0 < ξ`, including right-continuity at the support boundary. |
| `AuditEVTLaws.frechetStieltjes ξ hξ`, `frechetMeasure ξ hξ` | defs | Stieltjes function and measure. |
| `AuditEVTLaws.frechetMeasure_isProbabilityMeasure` | instance | total mass one. |
| `AuditEVTLaws.cdf_frechetMeasure`, `cdf_frechetMeasure_apply` | theorems | cdf identities. |
| `AuditEVTLaws.cdf_map_maxRV_frechet`, `cdf_map_maxRV_pi_frechet` | theorems | maximum of independent `frechetMeasure` coordinates has cdf `frechetCDF ξ (n^{−ξ} x)`; product-space realization. |

Counts: 83 → **103 theorems**, 1 → **3 instances**, 16 aliases (**122** checked); trust scan 189 → **216**
constants (49 internal). Backlog statuses unchanged (T061 stays partial: reverse-Weibull and
location/scale open); T061 gains `actual_law_constructed` and `source_reviewed`, T060 gains `law_theorem`.

### Changed files

| File | Change |
|---|---|
| `AuditRepairs/ExtremeValueLaws.lean` | **New** (imports `AuditRepairs.ExtremeValueBridge`, `Mathlib.MeasureTheory.Measure.Stieltjes`, `Mathlib.Probability.CDF`). |
| `AuditRepairs/ExtremeValueBridge.lean` | Docstrings only: module heading no longer says "part"; the maximum-law anchor is eq. (9.1) printed p. 172 / PDF 186 (the EVT forms are p. 173); strict/non-strict events differ on the boundary event and their probabilities by the boundary mass (not "on atoms"). |
| `AuditRepairs.lean` | Imports `AuditRepairs.ExtremeValueLaws`. |
| `AuditVerification.lean` | Regenerated: 122 `#print axioms` lines. |
| `scripts/harness_regression.py` | Audit H1: `--only` IDs validated (unknown or empty IDs rejected with exit 2 before any filesystem action), `all_ok` requires a nonempty result set. Audit H2: `--scratch` and `--out` resolved to absolute paths. |
| `scripts/verify.py` | Stale "67/69" docstring reworded. Ledger schema validation added to the normal path (statuses and states from the fixed vocabularies incl. `law_theorem`; discharged ⇔ state; states, declarations, `delivery_scope`, `remaining_obligations` present together; 158 rows); report gains `backlog_schema_valid`, `backlog_families`, `backlog_discharged`, `backlog_cited_distinct_declarations`. |
| `scripts/rebuild_curated_inventory.py` | Delivery field gains `scope=` and `remaining=` sub-fields and the `law_theorem` state; validation that states, declarations, scope and remaining occur together. All eleven supported rows annotated (T118, T047 "prerequisite only"); T060 `law_theorem`; T061 new declarations and states. |
| `docs/FORMALIZATION_BACKLOG.json`, `.md` | Regenerated / synced (158/158): rows gain `delivery_scope`, `remaining_obligations`; legend explains the facets (nonexclusive, not a ladder), `law_theorem`, and that state counts overlap; intro sentence corrected ("only discharged rows claim completion"). |
| `docs/REPLACEMENT_MAP.md`, `docs/replacement_map.json` | Rows 10, 11: measure constructed, max-stability instantiated. |
| `docs/MATHLIB_AND_WORK_ORDER.md` | CDF row and slice 4 updated. |
| `docs/AUDIT_HISTORY.md` | Round 4 (audit of v0.2.4) added; the "rules" paragraph distinguishes reproduced failures from preventive repairs. |
| `README.md` | Version, counts (103/3/16, 122; 216 constants), module list, verifier/regression description, ProofWidgets tag note, "What is still open". |
| `FABLE_REVIEW.md` | §14: source anchor, boundary-mass wording and bundle wording corrected; + §15. |
| `lakefile.toml` | `version = "0.2.5"`. |
| `SHA256SUMS`, `evidence/current/*`, `evidence/fable/v0.2.5/` | Regenerated / new evidence layer (includes the H1/H2 CLI probe records). |

Repository (outside the package): `audits/05_astra_on_v0.2.4/` holds the received audit; a `git bundle`
accompanies the v0.2.5 ZIP.

Pins unchanged: `lean-toolchain`, `lake-manifest.json`, Mathlib `rev`.

### Compatibility implications

- Client code: none for existing declarations. `import AuditRepairs` now also brings in
  `Mathlib.MeasureTheory.Measure.Stieltjes`.
- Verification: `verify.py` ≈ 2 min; `harness_regression.py` ≈ 20–30 min. `--only` now rejects
  unknown IDs (previously silently ignored).
- Backlog JSON schema: rows gain `delivery_scope`, `remaining_obligations`; state vocabulary gains
  `law_theorem`.

### Validation performed (v0.2.5)

- `rm -rf .lake/build; lake build`: exit 0, no warnings.
- `python3 scripts/verify.py`: exit 0, `PASS: 103 theorems, 3 instance, 16 aliases; … trust scan:
  216 project constants (incl. 49 internal) all within allowlist; 122 public theorem/instance
  constants match the regex inventory`; ledger schema valid; 83 cited declarations present.
- `python3 scripts/harness_regression.py`: exit 0, 12/12 fixtures as expected.
- CLI probes: unknown / mixed / empty `--only` → exit 2 with no scratch directory created;
  `--only valid --scratch rel_scratch` → PASS with the build snapshot restored from an absolute path.
- Documentation consistency: replacement map 16/16, backlog 158/158 including scope/remaining lines.
- Final ZIP validated from a fresh extraction (`deliverables/v0.2.5/archive_validation_v0.2.5.log`).

---

## v0.2.3 → v0.2.4 (second corrective pass; first discharged family)

Trigger: the independent audit of v0.2.3 (`Taleb_Fable_v0.2.3_Independent_Audit.pdf`, SHA-256
`c5674a7b6ba7300d414d2de5fd2a21d7f792533b1b1f1f27c4d65628391dfa70`; ledger
`Taleb_Proof_Progress_v0.2.3.md`, `532c3c8a427997fc43bd37620d13c0ccecbb96cdb6613fed498d1dd4b583bd45`).
Details: `FABLE_REVIEW.md` §14.

### Mathematical statement changes

No pre-existing theorem, definition, instance, alias or proof was modified. **Added** in
`AuditRepairs/ExtremeValueBridge.lean` (all with closure `{propext, Classical.choice, Quot.sound}`):

| Declaration | Kind | Content |
|---|---|---|
| `AuditExtremes.minGtEvent`, `minGeEvent`, `maxLtEvent` | defs | `∀ i, x < Xᵢ`, `∀ i, x ≤ Xᵢ`, `∀ i, Xᵢ < x`. |
| `minGtEvent_eq_iInter`, `minGeEvent_eq_iInter`, `maxLtEvent_eq_iInter` | theorems | `⋂`-forms. |
| `AuditExtremes.maxRV`, `minRV` | defs | `Finset.univ.sup' _ X`, `Finset.univ.inf' _ X` (nonempty finite index). |
| `maxRV_preimage_Iic`, `minRV_preimage_Ioi` | theorems | preimages are the threshold events. |
| `measure_iInter_preimage` | theorem | `iIndepFun X P → MeasurableSet B → P (⋂ i, Xᵢ ⁻¹' B) = ∏ P (Xᵢ ⁻¹' B)`. |
| `measure_minGtEvent`, `measure_minGeEvent`, `measure_maxLtEvent` | theorems | product forms. |
| `measure_minGtEvent_of_forall_eq`, `measureReal_minGtEvent_of_forall_eq` | theorems | `p ^ card ι` forms for the minimum (`ℝ≥0∞` and `ℝ`). |
| `measure_preimage_of_map_eq`, `measure_maxLeEvent_of_map_eq`, `measure_minGtEvent_of_map_eq` | theorems | common law `ν` via `P.map (Xᵢ) = ν`. |
| `measurable_maxRV`, `measurable_minRV` | theorems | measurability of the extrema. |
| `cdf_map_maxRV` | theorem | `cdf (P.map (maxRV X)) x = (cdf ν x) ^ card ι`. |
| `measureReal_map_minRV_Ioi`, `measureReal_map_minRV_Ioi_eq_one_sub_cdf` | theorems | `P(min > x) = (ν(x,∞))^n = (1 − cdf ν x)^n`. |

Counts: 64 → **83 theorems**, 1 instance, 16 aliases (**100** checked); trust scan 158 → **189**
constants (48 internal). Backlog: **T060 discharged** (first), T007 `missing → partial`.

### Changed files

| File | Change |
|---|---|
| `AuditRepairs/ExtremeValueBridge.lean` | + section "General product formula, minima, and the laws of `max` and `min`"; + `import Mathlib.Probability.CDF`; event definitions and set identities placed in the first (measure-free) block. Existing declarations untouched. |
| `AuditRepairs/GaussianBridge.lean` | Wording only (audit M1): "exactly when"/"iff" → "when"; docstring notes the one-directional statement and why a pointwise converse would be false. |
| `AuditRepairs.lean` | unchanged (both bridge modules already imported). |
| `AuditVerification.lean` | Regenerated: 100 `#print axioms` lines. |
| `scripts/verify.py` | Audit V1: `declarations()` and `modules_on_disk()` walk subdirectories; module names derived from relative paths (`module_name`). New gate: every declaration cited in `docs/FORMALIZATION_BACKLOG.json` (`declarations` field) must exist in the scanned environment; reported as `backlog_cited_declarations_exist` / `backlog_cited_declaration_count`. Docstring updated. |
| `scripts/harness_regression.py` | Audit R1: per fixture, sources re-extracted **and** `.lake/build` restored from a pristine snapshot; restored source-tree SHA-256 asserted equal to the pristine hash before mutation and recorded (`restored_tree_sha256`, `restored_tree_matches_pristine`, `build_dir_reset_from_snapshot`); fresh scratch directory per run. Two fixtures added: `nested_orphan_module` (un-imported `AuditRepairs/Nested/Orphan.lean` with a `sorry`, must FAIL) and `nested_imported_module` (imported nested module with a public theorem, `AuditVerification.lean` regenerated inside the fixture, must PASS and appear in the inventory). Twelve fixtures total. |
| `scripts/rebuild_curated_inventory.py` | Optional 10th column `states=…;decls=…` per row; new status `discharged`; row validation (`STATES`, `STATUSES`, discharged ⇔ state); JSON rows gain `states`, `declarations`, `discharged`; `completion` text for discharged rows. Rows annotated: T001, T007 (→ partial, Gaussian slice), T008, T029, T032, T046, T047, T060 (→ discharged, target/hypotheses rewritten to what was delivered), T061, T118, T124. |
| `docs/FORMALIZATION_BACKLOG.json`, `.md` | Regenerated / synced (158/158): legend extended with `discharged` and the delivery states; "Delivered (…): …" lines for the eleven families with Lean support. |
| `docs/REPLACEMENT_MAP.md`, `docs/replacement_map.json` | Rows 10, 11: law-level pointers (`cdf_map_maxRV`, `measureReal_map_minRV_Ioi_eq_one_sub_cdf`). |
| `docs/MATHLIB_AND_WORK_ORDER.md` | CDF row and slice 4 updated (T060 discharged; T061 open). |
| `docs/AUDIT_HISTORY.md` | **New**: the audit rounds, hashes and responses (the third-party documents themselves live in the repository's `audits/`, outside this package). |
| `README.md` | Version, counts (83/1/16, 100; 189 constants), module description, verifier/regression description, "What is still open". |
| `FABLE_REVIEW.md` | + §14; §13.5 marked superseded; deliverable paths updated to `deliverables/vX.Y.Z/`. |
| `lakefile.toml` | `version = "0.2.4"`. |
| `SHA256SUMS`, `evidence/current/*`, `evidence/fable/v0.2.4/` | Regenerated / new evidence layer. |

Repository (outside the package): received artifacts moved to `audits/<round>/` with a strict
manifest and README; deliverables to `deliverables/vX.Y.Z/`; a `git bundle` accompanies the
v0.2.4 ZIP.

Pins unchanged: `lean-toolchain`, `lake-manifest.json`, Mathlib `rev`.

### Compatibility implications

- Client code: none for existing declarations.
- Verification: `verify.py` ≈ 2 min (189 constants); `harness_regression.py` ≈ 25 min (twelve
  fixtures, each with a full project rebuild from the pristine build snapshot).
- Backlog JSON schema: rows gain `states`, `declarations`, `discharged`; status vocabulary gains
  `discharged`.

### Validation performed (v0.2.4)

- `rm -rf .lake/build; lake build`: exit 0, no warnings.
- `python3 scripts/verify.py`: exit 0, `PASS: 83 theorems, 1 instance, 16 aliases; … trust scan:
  189 project constants (incl. 48 internal) all within allowlist; 100 public theorem/instance
  constants match the regex inventory`; 71 backlog-cited declarations present.
- `python3 scripts/harness_regression.py`: exit 0, 12/12 fixtures as expected, per-fixture
  pristine-hash checks recorded.
- Documentation consistency: replacement map 16/16, backlog 158/158 (including the Delivered lines).
- Final ZIP validated from a fresh extraction (`deliverables/v0.2.4/archive_validation_v0.2.4.log`).

---

## v0.2.2 → v0.2.3 (first mathematics increment)

Delivers the three contained tasks recommended by the v0.2.1 review (§11) and by the
independent audit ("Recommended next pass", item 3). Details and exact statements:
`FABLE_REVIEW.md` §13.

### Mathematical statement changes

No pre-existing theorem, definition, instance, alias or proof was modified. **Added**
(all with axiom closure `{propext, Classical.choice, Quot.sound}`):

| Declaration | Kind | Content |
|---|---|---|
| `AuditTails.two_power_tail` (`AuditRepairs/Foundations.lean`) | theorem | `0 ≤ w₁ → 0 < w₂ → α₂ ≤ α₁ → HasFiniteTailExponent (fun z => w₁ z^{−α₁} + w₂ z^{−α₂}) α₂` — corrected content of the display under book Property 5.1 (G18). |
| `AuditTails.two_power_tail_min` | theorem | positive weights → exponent `min α₁ α₂`. |
| `AuditGaussian.varianceOfScale`, `coe_varianceOfScale` (`AuditRepairs/GaussianBridge.lean`, new) | def, theorem | `v = 2σ²` as an `ℝ≥0`. |
| `AuditGaussian.charFun_gaussianReal_eq_stableS1Expr` | theorem | `(v : ℝ) = 2σ² → charFun (gaussianReal μ v) t = stableS1Expr 2 β μ σ t` (zero scale included). |
| `AuditGaussian.gaussianParameters` | def | the admissible S1 tuple `(2, 0, μ, σ)`. |
| `AuditGaussian.convolutionPower_gaussianReal_scale` | theorem | `convolutionPower (gaussianReal m (2σ²)) n = gaussianReal (n m) (2 (n^{1/2} σ)²)`, proved **through** `stableS1_convolutionPower_eq` (non-vacuity of Proof16's premises at α = 2). |
| `AuditGaussian.convolutionPower_gaussianReal` | theorem | `convolutionPower (gaussianReal m v) n = gaussianReal (n m) (n v)`. |
| `AuditExtremes.maxLeEvent`, `maxLeEvent_eq_iInter` (`AuditRepairs/ExtremeValueBridge.lean`, new) | def, theorem | the event `∀ i, Xᵢ ≤ x` and its `⋂` form. |
| `AuditExtremes.measure_maxLeEvent` | theorem | `iIndepFun X P → P (maxLeEvent X x) = ∏ i, P (Xᵢ ⁻¹' Iic x)`. |
| `AuditExtremes.measure_maxLeEvent_of_forall_eq`, `measureReal_maxLeEvent_of_forall_eq` | theorems | the `p ^ card ι` forms in `ℝ≥0∞` and `ℝ`. |
| `AuditExtremes.measureReal_maxLeEvent_frechet`, `measureReal_maxLeEvent_gumbel` | theorems | max-stability for independent maxima whose coordinates have the Fréchet(ξ) resp. Gumbel distribution function. |

Counts: 52 → **64 theorems**, 1 instance, 16 aliases (**81** checked); trust scan 137 → **158**
constants (41 internal).

### Changed files

| File | Change |
|---|---|
| `AuditRepairs/Foundations.lean` | + section "Two-term power tails" with the two theorems above. |
| `AuditRepairs/GaussianBridge.lean` | **New** module (imports `AuditRepairs.ProbabilityBridge`, `Mathlib.Probability.Distributions.Gaussian.Real`). |
| `AuditRepairs/ExtremeValueBridge.lean` | **New** module (imports `AuditRepairs.Tails`, `Mathlib.MeasureTheory.Measure.Real`, `Mathlib.Probability.Independence.Basic`). |
| `AuditRepairs.lean` | Imports the two new modules. |
| `AuditVerification.lean` | Regenerated (+12 `#print axioms` lines, 81 total). |
| `docs/FORMALIZATION_BACKLOG.{json,md}`, `scripts/rebuild_curated_inventory.py` | T029 `source-check → partial`, T046 text (Gaussian half delivered; Cauchy open), T060 `missing → partial`; regenerated and synced (158/158). Statuses now 92 missing / 34 source-check / 10 partial. |
| `docs/REPLACEMENT_MAP.md`, `docs/replacement_map.json` | Rows 10, 11, 16: pointers to the new iid-maximum and Gaussian-instantiation theorems. |
| `docs/SOURCE_GATES.md` | G18: names the delivered lemmas. |
| `docs/MATHLIB_AND_WORK_ORDER.md` | CF, Gaussian, CDF rows and slice 4 updated with what is now done and what remains. |
| `README.md` | Version, counts (64/1/16, 81; 158 constants), module list, "What is still open". |
| `FABLE_REVIEW.md` | + §13 (statements, sources, scope, verification, next tasks). |
| `lakefile.toml` | `version = "0.2.3"`. |
| `SHA256SUMS`, `evidence/current/*`, `evidence/fable/v0.2.3/` | Regenerated / new evidence layer. |

Pins unchanged: `lean-toolchain`, `lake-manifest.json`, Mathlib `rev`.

### Compatibility implications

- Client code: none for existing declarations. `import AuditRepairs` now also brings in
  `Mathlib.Probability.Distributions.Gaussian.Real` and `Mathlib.Probability.Independence.Basic`
  (both were already transitively available through Mathlib; build time is unchanged in
  practice, +2 project modules).
- Verification: `verify.py` runtime ≈ 100 s (the trust scan now covers 158 constants).

### Validation performed (v0.2.3)

- `rm -rf .lake/build; lake build`: exit 0, no warnings.
- `python3 scripts/verify.py`: exit 0, `PASS: 64 theorems, 1 instance, 16 aliases; … trust scan:
  158 project constants (incl. 41 internal) all within allowlist; 81 public theorem/instance
  constants match the regex inventory`.
- `python3 scripts/harness_regression.py`: exit 0, 10/10 fixtures as expected.
- Documentation consistency: replacement map 16/16, backlog 158/158.
- Final ZIP validated from a fresh extraction (`deliverables/v0.2.3/archive_validation_v0.2.3.log`).

---

## v0.2.1 → v0.2.2 (corrective pass after the independent audit of v0.2.1)

Trigger: `Taleb_Fable_v0.2.1_Independent_Audit.md` (SHA-256 `3f71049c08fdcaf6b4c73b8b91ab63447de2164b2a89787169683b8a7461f809`)
with evidence `Taleb_Fable_v0.2.1_Audit_Evidence.zip` (`a5553019a8693135356717831455385e0b9a89ce73c50ad9ee86fd8613e90f04`).
Every finding was reproduced before being repaired; see `FABLE_REVIEW.md` §12.

### Mathematical statement changes

**None.** No theorem, definition, instance, alias, proof body, `lean-toolchain`,
`lake-manifest.json` or Mathlib `rev` was touched. Counts are unchanged: 52 theorems,
1 instance, 16 aliases, 69 checked declarations.

### Changed files

| File | Change |
|---|---|
| `scripts/FableInventory.lean` | Rewritten. Lists **every** constant of the project modules (137: 102 public/generated + 35 internal) and collects each axiom closure **before** any visibility or provenance filtering (audit A1). Provenance is decided from Lean's bookkeeping — constructor/recursor kind, `Environment.isProjectionFn`, `isAuxRecursor`, `isNoConfusion`, or absence of a declaration range — never from a namespace prefix (audit A2); the rule that fired is recorded per row (`generatedBy`). Also emits `imported_project_modules` and `axiom_kind_constants`. Field names changed: `isInternal`, `generated`, `generatedBy`, `hasDeclarationRange`; top-level `constants` replaces `declarations`. |
| `scripts/verify.py` | Rewritten around explicit `check(cond, message)` calls raising `VerificationError` instead of `assert`, so `python3 -O` / `PYTHONOPTIMIZE` cannot disable acceptance (audit A3); report booleans are the validated conditions and `python_optimize` is recorded. New gates: the Lake build log must contain no `warning:`/`error:` line, `sorryAx` or `declaration uses 'sorry'`; every scanned constant must be within the allowlist and no project constant may be an `axiom` (trust scan, audit A1); every dependency checkout must have a clean working tree (`git status --porcelain`); every project module on disk (`AuditRepairs.lean`, `AuditRepairs/*.lean`, `Proofs/*.lean`) must be imported into the scanned environment. Public reconciliation now uses the provenance flag. Output line and `environment_inventory` fields extended. |
| `scripts/harness_regression.py` | **New.** Ten-fixture regression suite run in a disposable copy (sources + copied `.lake/packages` and `.lake/build`): valid package (must PASS), private `sorry` theorem, private `sorry` def, private axiom without compiler warning, user theorem inside the `StableParameters` namespace, `protected` theorem, wrong alias target (ordinary and `PYTHONOPTIMIZE=1`), orphan un-imported module, dirty dependency (all must FAIL with exit 1 and the expected message). Records exact command, verifier subprocess exit code, output tail and resulting `verification.json` per fixture into `evidence/current/harness_regression.{json,log}` (audit A4). For the two `sorry` fixtures it also runs the trust scan alone and checks the private constant is listed with `sorryAx`. |
| `docs/SOURCE_GATES.md` | G18 qualified with the cancellation counterexample (`X = EZ`, `Y = −2EZ`, `2X + Y = 0`) and the valid nonnegative-summand target (audit M1); new **G19** (p. 282 identifies regularly varying with α-stable; false, only the domain-of-attraction statement holds) (audit M2); intro sentence updated. |
| `scripts/rebuild_curated_inventory.py`, `docs/FORMALIZATION_BACKLOG.json`, `docs/FORMALIZATION_BACKLOG.md` | T029: target restricted to nonnegative variables with positive weights; gap text carries the counterexample. T093: `missing → source-check` with the G19 note. Regenerated JSON, hand-synced Markdown, 158/158 consistency re-verified. Status distribution now 93 missing / 35 source-check. |
| `FABLE_REVIEW.md` | Proof01 row: `x_min ≥ 1` → `x_min > 1`; §6.2 G18 sentence qualified; new §12 addendum (audit findings, reproduction, repairs, fixtures). |
| `evidence/fable/final/harness_negative_tests.NOTE.md` | **New.** Explains the stale-`PIPESTATUS` `exit=0` line in the preserved v0.2.1 log (audit A4). The log itself is unchanged. |
| `evidence/fable/v0.2.2/` | **New** evidence layer for this pass: clean build log, verify log, `current_after_verify/` (incl. `harness_regression.{json,log}`), `environment.md`, `declaration_inventory.md`, `RECEIVED_AUDIT_ARTIFACTS.sha256`. |
| `evidence/current/*` | Regenerated by the final v0.2.2 `verify.py` and `harness_regression.py` runs. |
| `README.md` | Version `v0.2.2`; verification description updated (trust scan of all constants, build-diagnostic gate, dependency cleanliness, import coverage, regression suite, no `assert`s). |
| `lakefile.toml` | `version = "0.2.1"` → `"0.2.2"`. |
| `SHA256SUMS` | Regenerated for the final tree. |

### Compatibility implications

- Client code: none.
- Verification workflow: `python3 scripts/verify.py` is stricter — any compiler warning in the
  build, any `private`/internal `sorry` or axiom, any un-imported project module, and any
  modified dependency checkout now fail it. Runtime ≈ 60 s. `python3 scripts/harness_regression.py`
  (≈ 11 min, needs ~6 GB scratch space under `/tmp` by default) is optional but is the
  intended acceptance test for changes to the harness itself.
- `evidence/current/inventory_environment.json` schema changed (see `FableInventory.lean` row).

### Validation performed (v0.2.2)

- `rm -rf .lake/build; lake build`: exit 0, 2643 jobs, 24 modules built, no warnings.
- `python3 scripts/verify.py`: exit 0 — `PASS: 52 theorems, 1 instance, 16 aliases; no extra
  axioms; trust scan: 137 project constants (incl. 35 internal) all within allowlist; 69 public
  theorem/instance constants match the regex inventory`.
- `python3 scripts/harness_regression.py`: exit 0; all 10 fixtures behaved as expected
  (`evidence/fable/v0.2.2/current_after_verify/harness_regression.log`).
- Documentation consistency (replacement map 16/16, backlog 158/158) re-checked.
- Final ZIP validated from a fresh extraction (`deliverables/v0.2.1/archive_validation.log`).

---

## v0.2.0 (received) → v0.2.1

All changes relative to the received `Taleb_Lean_Implementation_Handoff.zip`
(SHA-256 `8a8fb28af0b492c34edd02275ace60b213eedac1f41ec2514505588157cab406`). The complete
unified diff, including new files, is `deliverables/v0.2.1/fable_changes.patch` next to the final
ZIP (generated with `git diff` between the pristine-extraction commit and the final commit).
Toolchain and dependency pins are **unchanged**: `lean-toolchain`, `lake-manifest.json` and
the Mathlib `rev` in `lakefile.toml` are byte-identical to the received files.

## Mathematical statement changes

**None.** No theorem, definition, instance or alias of v0.2.0 was modified, removed,
renamed or weakened. No hypothesis was added to or removed from any existing declaration.
No proof body was edited.

Two theorems were **added** (both diagnostics, no new mathematical content):

| Declaration | Statement | Purpose |
|---|---|---|
| `AuditRV.isSlowlyVarying_neg_one` (`AuditRepairs/RegularVariation.lean`) | `IsSlowlyVarying (fun _ : ℝ => (-1 : ℝ))` | Pins the gap between the ratio-only predicate and the book's definition, whose `L` has codomain `(0, +∞)` (§2.2.1 p. 9, §E.1 p. 190, Def. 21.1 p. 380). |
| `AuditTails.frechetFormula_zero` (`AuditRepairs/Tails.lean`) | `ξ ≠ 0 → frechetFormula ξ 0 = 1` | Pins the boundary value that makes the raw formula unusable as a CDF at `x = 0` (Lean: `0 ^ (-1/ξ) = 0`), i.e. why `frechetCDF` is piecewise. |

Both depend only on `propext`, `Classical.choice`, `Quot.sound`.

## Changed files

| File | Change |
|---|---|
| `AuditRepairs/RegularVariation.lean` | + `isSlowlyVarying_neg_one` with docstring; + its `#print axioms` line. |
| `AuditRepairs/Tails.lean` | + `frechetFormula_zero` with docstring (placed between `frechetFormula` and `frechetCDF`); + its `#print axioms` line. |
| `AuditRepairs/Stable.lean` | Comment only: the remark above `submitted_alpha_one_ignores_skew` now states that the identity holds because Lean's `Real.tan (π/2) = 0` (`Real.tan_pi_div_two`), that `tan(π/2)` is mathematically undefined, that (7.2) is stated only for `α ≠ 1`, and points to `stableS1Expr` and G17. |
| `AuditVerification.lean` | Regenerated by the discovery function of `scripts/verify.py`: two `#print axioms` lines added (69 total). |
| `scripts/verify.py` | Docstring extended. After the axiom run it now executes `lake env lean scripts/FableInventory.lean`, stores `evidence/current/inventory_environment.json` and `.log`, and asserts: user-written theorem/instance constants in the environment == regex-discovered set; every project constant within the axiom allowlist; alias targets == `docs/replacement_map.json`. Report gains `environment_inventory`; PASS line extended. Failure modes are reported through the existing `FAIL` path. |
| `scripts/FableInventory.lean` | **New.** Enumerates every constant whose defining module is `AuditRepairs*`, `Proofs*` or `AuditVerification`; records kind, module, instance flag, Batteries alias target, structure-generated flag, axiom closure (`collectAxioms`) and pretty-printed type; prints one JSON document. `autoImplicit false`. Not a Lake target; run through `lake env lean`. |
| `scripts/rebuild_curated_inventory.py` | Raw rows for T007 and T029 edited (see backlog below). |
| `docs/FORMALIZATION_BACKLOG.json` | Regenerated by the script above: T007 pages `12-13;139-140;282`, anchor `2.2.9;7.2.1;15.2.1`, gap note on the 15.2.1 misprint; T029 pages `98-99`, status `missing → source-check`, target extended with the corrected formula-level statement, gap note on the sign error. Still 158 rows. |
| `docs/FORMALIZATION_BACKLOG.md` | The same two entries edited by hand to match the JSON (no shipped script generates the Markdown; JSON↔Markdown consistency of all 158 rows verified before and after). |
| `docs/SOURCE_GATES.md` | Intro sentence attributes G01–G16 to the handoff and G17–G18 to this review; + **G17** (15.2.1 S1 characteristic function printed with misplaced parentheses; α-range inconsistency) and **G18** (sign error in the displayed limit under Property 5.1). |
| `docs/REPLACEMENT_MAP.md`, `docs/replacement_map.json` | Rows 14 and 16: scope text extended ((7.2) excludes α = 1; α = 1 branch is standard S1, printed in the book only in misprinted 15.2.1). Declarations and source columns unchanged. |
| `README.md` | Title/version `v0.2.1 (Fable-reviewed)`; pointer paragraph to `FABLE_REVIEW.md`, `CHANGELOG_FABLE.md`, `evidence/fable/`; expected counts `52 theorems, 1 instance, 16 aliases (69)` with the v0.2.0 comparison; description of the environment cross-check; module list gains `scripts/FableInventory.lean`; provenance paragraph notes the reproduced 8/8 legacy result. |
| `lakefile.toml` | `version = "0.2.0"` → `"0.2.1"`. Nothing else. |
| `SHA256SUMS` | Regenerated for the final tree (all files except itself, excluding `.lake/`). The received manifest is preserved verbatim in the git history (commit `f6b1007`) and as `evidence/fable/received_current/SHA256SUMS_check_on_extracted_tree.log` records its verification. |
| `FABLE_REVIEW.md`, `CHANGELOG_FABLE.md` | **New.** |
| `evidence/current/*` | Regenerated by the final `scripts/verify.py` run (`axioms.log`, `build.log`, `declarations.json`, `verification.json`, new `inventory_environment.json`, `inventory_environment.log`). The received versions are preserved under `evidence/fable/received_current/`. |
| `evidence/fable/**` | **New** evidence tree: `README.md`; `received_current/` (received evidence + manifest checks + artifact hashes); `baseline/` (cache-get log, clean build log, verify log, `current_after_verify/`, `environment.md`, `originals_recheck/` with the 16 per-file logs and `summary.csv`); `final/` (clean build log, verify log, `current_after_verify/`, `environment.md`, `declaration_inventory.md`, `harness_negative_tests.log`). The archive-validation log cannot be inside the archive it validates; it is delivered alongside the ZIP as `deliverables/v0.2.1/archive_validation.log`. |

Unchanged: `AuditRepairs.lean`, `AuditRepairs/Foundations.lean`, `AuditRepairs/ImplicitSetDiagnostic.lean`,
`AuditRepairs/ProbabilityBridge.lean`, all sixteen `Proofs/*.lean`, `lean-toolchain`,
`lake-manifest.json`, `docs/MATHLIB_AND_WORK_ORDER.md`, `docs/source_inventory/*`,
`scripts/build_handoff_pdf.py`, `scripts/index_book.py`, all legacy `evidence/Proof*.log`,
`evidence/aggregate.log`, `evidence/summary.json`, `evidence/build_environment.md`,
`evidence/proof09_probe.log`, `evidence/source/mathlib-proofs-16.zip`.

## Compatibility implications

- **Client code:** none. Every v0.2.0 declaration keeps its name, statement and namespace;
  `import AuditRepairs` and `Taleb.ProofNN.repaired` behave identically.
- **Verification workflow:** `python3 scripts/verify.py` takes about 40 s longer (the
  environment inventory) and now fails on three additional conditions (see `scripts/verify.py`
  docstring). Anyone adding a declaration must, as before, regenerate `AuditVerification.lean`;
  in addition, declarations written in a form the regex does not see (`protected`, attributes
  on the same line, `section`s) now cause a hard failure instead of silent omission.
- **Counts:** documents that quote "50 theorems / 67 checked" describe v0.2.0; the companion
  PDF `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` was not regenerated (it is a received
  artifact and would require `reportlab`), so its figures refer to v0.2.0.
- **Backlog:** status distribution changes from 95 missing / 33 source-check to
  94 missing / 34 source-check (T029). Total families unchanged at 158.

## Validation performed

- Baseline (received source, unmodified): clean `lake build` exit 0; `scripts/verify.py`
  exit 0, `PASS: 50 theorems, 1 instance, 16 aliases`; regenerated `verification.json`
  identical to the received one except `elapsed_seconds`; 16 original files re-checked with
  identical per-file results to `evidence/summary.json` (8 pass / 8 fail).
- Final (repaired source): `rm -rf .lake/build; lake build` exit 0 (26 s, 2643 jobs, 24
  modules built, no warnings/errors); `scripts/verify.py` exit 0,
  `PASS: 52 theorems, 1 instance, 16 aliases; … environment cross-check: 102 project
  constants, 69 user theorem/instance, all within allowlist`.
- Axioms: 69/69 exported declarations and 102/102 environment constants have exactly
  `{propext, Classical.choice, Quot.sound}`; no `sorryAx`.
- Harness negative tests: an appended `protected theorem` → `FAIL: Environment/regex
  inventory mismatch: ['AuditRV.regex_blind_spot']`; a wrong alias target in
  `docs/replacement_map.json` → `FAIL: Alias targets differ …`. Both reverted byte-identically.
- Documentation consistency: `docs/REPLACEMENT_MAP.md` ↔ `docs/replacement_map.json`
  (16/16) and `docs/FORMALIZATION_BACKLOG.md` ↔ `.json` (158/158) checked programmatically.
- Archive: the final ZIP was extracted into a fresh directory with no project build outputs,
  the pinned dependency checkouts and cache were copied in, `SHA256SUMS` verified, `lake build`
  and `scripts/verify.py` re-run there, and the resulting Lean source hashes compared with
  those of the working tree (`deliverables/v0.2.1/archive_validation.log`, alongside the ZIP).
