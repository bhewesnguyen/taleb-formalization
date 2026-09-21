# Scope memo: how far the Taleb formalization has come, and how far it has to go

Rendered 21 September 2026 by `tools/scope_memo.py` for **v0.2.10** (packaged tree `03b7764`, ZIP SHA-256 `64a241c8…0c747c`).
Every number below is computed from the ledger, the committed evidence layers and the pinned Mathlib checkout; the
judgment sections (§5 tiers, §6 projection, §8 next steps) are hand-maintained in the script and cross-checked against the
data. Personal working reference for the project owner; not part of any audited package. Refresh with `python3 tools/scope_memo.py`;
`python3 tools/scope_memo.py --check` reports whether this file is stale.

---

## 1. Headline numbers

The ledger has 158 obligation families of very unequal size, so no single percentage is honest. Three denominators:

| Denominator | Closed (`discharged`) | Touched (any Lean support) | Untouched |
|---|---|---|---|
| All 158 families | **2** (1.3 %) | **14** (9 %) | 144 |
| 140 formal-proof families (158 minus 15 `model-needed` and 3 `empirical`, which are modelling/data tasks, not theorems) | **2** (1.4 %) | **14** (10 %) | 126 |
| 58 **P1** families — the "contained, reusable" mathematical core | **2** (3.4 %) | **10** (17 %) | 48 |

Declarations checked by the verifier: 225 (201 theorems, 8 instances, 16 aliases); trust scan 390 project constants (106 internal), all within the allowlist. Citations: 191 family/declaration pairs over 186 distinct names. These are inventory counts, not progress percentages.

Status distribution: 2 discharged · 12 partial · 4 reuse · 89 missing · 33 source-check · 15 model-needed · 3 empirical.

Status × priority:

| | P0 | P1 | P2 | P3 | total |
|---|---|---|---|---|---|
| discharged | – | 2 | – | – | 2 |
| partial | – | 8 | 4 | – | 12 |
| reuse | – | 4 | – | – | 4 |
| missing | – | 32 | 45 | 12 | 89 |
| source-check | 12 | 12 | 8 | 1 | 33 |
| model-needed | – | – | – | 15 | 15 |
| empirical | – | – | – | 3 | 3 |
| **total** | 12 | 58 | 57 | 31 | 158 |

---

## 2. Release history (what one release buys)

| Release | Date | Theorems | Checked | Discharged | Partial | Supported | Substance |
|---|---|---|---|---|---|---|---|
| v0.2.0 (received) | — | 50 | 67 | 0 | — | — | received handoff: 16 replacement proofs, inventory (not a Fable release) |
| v0.2.1 | 2026-09-18 | 52 | 69 | 0 | 8 | — | reproduction, harness hardening, G17/G18, two boundary diagnostics |
| v0.2.2 | 2026-09-18 | 52 | 69 | 0 | 8 | — | harness/documentation corrective pass (trust scan of all constants, regression suite) |
| v0.2.3 | 2026-09-18 | 64 | 81 | 0 | 10 | — | two-term power tails (G18), Gaussian stable bridge, independent maxima |
| v0.2.4 | 2026-09-18 | 83 | 100 | 1 | 10 | 11 | independent minima, law-level `cdf(max) = F^n`; **first closed family (T060)** |
| v0.2.5 | 2026-09-19 | 103 | 122 | 1 | 10 | 11 | Gumbel and Fréchet measures via Stieltjes functions |
| v0.2.6 | 2026-09-20 | 125 | 149 | 2 | 9 | 11 | reverse-Weibull, location/scale API, laws of iid maxima as measure equalities; **second closed family (T061)** |
| v0.2.7 | 2026-09-20 | 140 | 164 | 2 | 9 | 11 | Property 5.1 for random variables (T029 binary child), global continuity of the EVT cdfs |
| v0.2.8 | 2026-09-20 | 160 | 184 | 2 | 11 | 13 | exact Pareto law, Stage A: survival/cdf, moments, extended-integral divergence, tail exponent (T021/T028 slices) |
| v0.2.9 | 2026-09-20 | 181 | 205 | 2 | 12 | 14 | exact Pareto law, Stage B: threshold law via `cond`, excess law, means, positive-power law (T005/T032 slices) |
| v0.2.10 | 2026-09-21 | 201 | 225 | 2 | 12 | 14 | centered Pareto moments: mean, centered MAD through the threshold law, variance via Mathlib `variance`, STD/MAD ratio (4.14) (T021 slice) |

Rule of thumb from this history: one release ≈ one substantive family child (15–25 theorems) plus an audit-response cycle. 2 families closed in 10 releases; the closed ones were among the most tractable (see §4).

---

## 3. What has been done (the 14 supported families)

| Family | Status | Group | Delivered (scope, first sentence) | Still open (first sentence) |
|---|---|---|---|---|
| T001 Regular variation API | partial | RV | Ratio-only slowly/regularly varying predicates with closure lemmas, examples (log, constants, real powers) and the RV-iff-normalised-SV equivalence. | Positive measurable convention and its relationship to the ratio predicates. |
| T005 Tail integral and excess identities | partial | TAIL | Exact-Pareto conditional and excess laws as equalities of probability measures (threshold law, excess law with global cdf and strict survival), conditional mean and mean excess for alpha > 1, and, for 0 < alpha <= 1, divergence of the conditional raw first moment as an extended nonnegative integral (AuditPareto.lintegral_id_cond_paretoMeasure_eq_top: no separate divergence theorem for the excess law is exported). | The general tail-integral identity (2.10), E[X 1_(X > K)] = K P(X > K) + integral_K^inf P(X > x) dx, for arbitrary nonnegative X via Tonelli on extended integrals, and the general conditional and excess mean formulas derived from it under a finite first moment. |
| T007 Stable law existence | partial | CF | Gaussian slice only: Mathlib's gaussianReal mu (2 sigma^2) realizes stableS1Expr 2 beta mu sigma, zero scale included. | Existence of a probability law with the S1 characteristic function for every 0 < alpha < 2, including alpha = 1 with beta != 0, and the zero-scale Dirac case for those alpha. |
| T008 Subexponential law API | partial | SUBEXP | Definition of the nonnegative self-convolution class and preservation of a finite tail exponent under that hypothesis. | Any concrete subexponential law, the equivalent n-fold tail characterizations, equivalence with the standard definition, and whether subexponential laws must have a finite exponent. |
| T021 Distribution-specific absolute moments | partial | MOM | Exact-Pareto raw and absolute moments against the pinned Mathlib law: finite exactly for p < alpha with value alpha L^p/(alpha - p), divergent (extended integral = top) for p >= alpha including the boundary, integrability equivalence, zeroth moment 1. | Gaussian and Student absolute moments and their MAD/STD ratios (4.4.2-4.4.3), the general MAD/STD comparison across families, and the scale conventions of each family. |
| T028 Tail moment threshold | partial | MOM | Exact-Pareto slice: global survival and distribution functions of the pinned law with the endpoint values explicit, absence of an atom at L, tail exponent alpha of the actual survival, and the moment threshold with the boundary settled (infinite) for the exact law. | The general statement for nonnegative laws with regularly varying tails of index -alpha (finite for q < alpha, infinite for q > alpha) and its q = alpha boundary, which requires an integral test on the slowly varying factor (the statement-review gate is unchanged for that general case). |
| T029 Tail of sums with unequal indices | partial | SUBEXP | Formula-level two-term power tails (v0.2.3) and, since v0.2.7, the binary probabilistic statement (completed child): for two pointwise nonnegative random variables with positive weights whose survival functions have finite log-tail exponents alpha, beta, the survival function of the weighted sum (and of its pushforward law, for measurable coordinates) has exponent min(alpha, beta), with no independence hypothesis, via event inclusions and reusable rescaling, max, sum and squeeze rules for HasFiniteTailExponent. | Stronger regular-variation child (the original target's reading, kept open deliberately): for measurable nonnegative X, Y on one probability space, a, b > 0, and eventually positive survival functions regularly varying with indices -alpha, -beta where 0 <= alpha < beta (a first version with 0 < alpha is acceptable), prove S_Z(t)/S_X(t/a) -> 1 and S_Z(t)/S_X(t) -> a^alpha for Z = aX + bY, via S_X(t/a) <= S_Z(t) <= S_X((1 - delta) t/a) + S_Y(delta t/b) and delta -> 0, no independence. |
| T032 Power transformation of a law | partial | TAIL | Analytic power-transform tail formula with exponent alpha/p. | The general statement of Property 5.2 for an arbitrary law with tail exponent alpha (finite log-tail exponent or regularly varying survival): the law of X^p has exponent alpha/p for p > 0, via the inverse-event argument on a positive support, and the density transformation (5.8) under the stated regularity. |
| T046 Stable characteristic function specializations | partial | CF | Gaussian half: gaussianReal realizes the S1 expression at alpha = 2 and the stable convolution bridge is instantiated with actual Gaussian laws. | A Cauchy probability law with its characteristic function (none in the pinned Mathlib), nonnegative scale including Dirac, and its instantiation of the bridge. |
| T047 Stable sample averages | partial | CF | Prerequisite only: convolution powers, their characteristic functions and the conditional stable sum/convolution bridge. | Pushforward under division by n, the average scale n^(1/alpha - 1), the alpha = 1 skew-location correction under rescaling, and finite-mean convergence. |
| T060 Distribution of iid maxima | **discharged** | CDF | Generic probability-law theorems: the cdf of the maximum equals (cdf nu)^n and the survival of the minimum equals (nu(x, inf))^n = (1 - cdf nu x)^n for independent measurable coordinates with common law nu, plus event-level product and power identities for all four threshold conventions. | None within the family. |
| T061 GEV families as probability measures | **discharged** | EVT | All three standardised EVT laws (Gumbel, Frechet xi > 0, reverse-Weibull alpha > 0 with upper endpoint 0) as probability measures with exact cdf identities and max-stability instantiated for the constructed laws including product-space iid realizations. | None within the family as scoped (the three named families with location/scale). |
| T118 Moment convexity in Pareto exponent | partial | CALC | Two delivered components: convexity of the tail kernel alpha -> c^(-alpha) (formula_proved), and the identification of the moment function m_p(alpha) = L^p alpha/(alpha - p) for the actual Pareto law with L > 0, alpha > 0, p < alpha (law_theorem, actual_law_constructed, credited from the T021 slice). | Convexity of alpha -> m_p(alpha) on alpha > p for p > 0 with a common positive scale (second derivative 2 p L^p/(alpha - p)^3, correcting the book's display), and the integrated Jensen inequality for a random exponent supported in alpha > p with the mixing integrability or extended-expectation conditions made explicit. |
| T124 Shifted-gamma index mean | partial | GAMMA | Corrected rational excess formula and its positivity in the finite-inverse-moment regime, as algebra. | The inverse moment of the gamma law, its finiteness threshold, and the mixture expectation identity that produces the formula. |

Chapters touched: 2, 4, 5, 7, 9, 21 (of 38 chapter units). Supplemental register (outside the 158): see `Taleb_Lean_Repairs/docs/SUPPLEMENTAL_OBLIGATIONS.md`.

Common thread: everything done sits in the layer of **distribution facts where the pinned Mathlib already had the machinery** — `StieltjesFunction`, `iIndepFun`, `withDensity` + improper `rpow` integrals, `gaussianReal`, `paretoMeasure`, `cond`, elementary real analysis. That front has been harvested deliberately.

---

## 4. What remains, by kind

### 4a. Infrastructure the pinned Mathlib does or does not have (scan of the checkout, 21 September 2026)

Method and limits: every `.lean` file under the pinned checkout's `Mathlib/` is searched for the case-sensitive patterns listed in
`GAPS`/`PRESENT` in `tools/scope_memo.py`. "0 files" means no file matches those patterns — a strong indication, not a proof, that
the theory is absent (a false negative is possible if Mathlib names it unexpectedly), and a positive count is only evidence that
*something* with that name exists, not that it has the form the family needs. Family attributions in the third column are judgment.

| Missing in Mathlib | Files matching | Blocks |
|---|---|---|
| Central limit theorem (any form) | 0 | T004, T158, Gaussian normalisers in T062, most of the CLT group |
| Cauchy distribution (as a defined law) | 0 | T046 (Cauchy half), Cauchy-based rows |
| Student t distribution | 0 | T021 (Student moments), Student-based rows |
| Karamata / slowly-varying theory | 0 | T002, T026, T027, general T011/T028, RV group beyond ratios |
| Bochner's theorem / Lévy–Khintchine (a law from a characteristic function) | 0 | T007 (α < 2), T093, T047 |
| Gini coefficient API | 0 | GINI group |
| Expected shortfall API | 0 | T009 |
| Maximum-entropy API | 0 | ENT group |
| Stochastic integration (Itô) | 0 | SDE group |

Present and reusable: Gaussian law (3 files), Pareto law (1 files), Gamma law (2 files), Stieltjes measures (10 files), independence (`iIndepFun`) (10 files), characteristic functions (uniqueness) (4 files), conditioning (`cond`) (1 files), strong law of large numbers (1 files), mgf / cgf (5 files).

### 4b. The 12 P0 source-check gates

T088, T095, T100, T101, T114, T119, T120, T123, T126, T137, T144, T156 — the book's statement must be repaired or disambiguated before any proof (as with the G-gates in `docs/SOURCE_GATES.md`). A further 21 source-check rows sit at P1–P3.

### 4c. Modelling and data tasks (not theorems): 18 families

T013 (APP), T034 (APP), T038 (MULTI), T039 (EST), T070 (APP), T074 (EST), T075 (EST), T084 (APP), T106 (APP), T108 (EST), T109 (APP), T110 (APP), T130 (APP), T134 (FIN), T138 (FIN), T140 (FIN), T148 (FIN), T150 (FIN). These complete only by a modelling decision, then possibly a theorem about the model.

### 4d. Dependency groups

| Group | Families | Closed | Partial | Reuse | Missing | Source-check | Model/emp. |
|---|---|---|---|---|---|---|---|
| MOM | 19 | 0 | 2 | 2 | 13 | 2 | 0 |
| FIN | 14 | 0 | 0 | 0 | 5 | 4 | 5 |
| EST | 13 | 0 | 0 | 0 | 6 | 3 | 4 |
| TAIL | 11 | 0 | 2 | 0 | 4 | 5 | 0 |
| ENT | 10 | 0 | 0 | 0 | 8 | 2 | 0 |
| GINI | 10 | 0 | 0 | 0 | 6 | 4 | 0 |
| APP | 8 | 0 | 0 | 0 | 0 | 0 | 8 |
| CLT | 8 | 0 | 0 | 0 | 6 | 2 | 0 |
| DENS | 8 | 0 | 0 | 0 | 7 | 1 | 0 |
| KAPPA | 8 | 0 | 0 | 0 | 6 | 2 | 0 |
| RV | 8 | 0 | 1 | 0 | 5 | 2 | 0 |
| CDF | 5 | 1 | 0 | 0 | 3 | 1 | 0 |
| CF | 5 | 0 | 3 | 0 | 1 | 1 | 0 |
| SDE | 5 | 0 | 0 | 0 | 4 | 1 | 0 |
| SUBEXP | 5 | 0 | 2 | 0 | 2 | 1 | 0 |
| CALC | 4 | 0 | 1 | 0 | 3 | 0 | 0 |
| EVT | 4 | 1 | 0 | 0 | 2 | 1 | 0 |
| MULTI | 4 | 0 | 0 | 0 | 3 | 0 | 1 |
| LLN | 3 | 0 | 0 | 2 | 1 | 0 | 0 |
| RUIN | 3 | 0 | 0 | 0 | 3 | 0 | 0 |
| GAMMA | 2 | 0 | 1 | 0 | 0 | 1 | 0 |
| QUANT | 1 | 0 | 0 | 0 | 1 | 0 | 0 |

Groups with **zero** Lean support (no discharged or partial family; `reuse` rows are not yet instantiated): APP, CLT, DENS, ENT, EST, FIN, GINI, KAPPA, LLN, MULTI, QUANT, RUIN, SDE.

---

## 5. The 48 untouched P1 families, tiered (judgment, to be confirmed when each is opened)

**Tier A — contained, current infrastructure suffices** (one release each, some several per release) — 29:

T003 Weak and strong laws; T014 Multiplicative survival and ruin; T015 Gaussian scale mixture normalization; T016 Variance-preserving fattening; T019 Crossovers of perturbed Gaussian densities; T020 Moment and norm comparisons; T030 Product of exact Pareto laws; T036 Uncorrelated versus independent; T040 Mixture multimodality; T044 Uniform maximum entropy and probability integral transform; T049 Cumulant scaling; T051 LLN for powers and MS plots; T058 Exponential summed MAD; T059 Negative kappa examples; T076 Binary and unbounded payoff interfaces; T078 Gaussian tail integral and Mills ratio; T081 Bounded Brier score moments; T083 Nonlinear loss moments; T086 Quantile sensitivity; T103 Dual bounded-to-unbounded transform; T111 Recursive mixtures; T112 Constant-error moment products; T113 Absolute-moment invariance; T117 Random-index mixture foundations; T131 Survival, hazard and residual lifetime; T142 Log return transforms; T143 Shifted Pareto relative calls; T146 Second versus fourth moment; T151 Tail constraint feasibility

**Tier B — medium: contained but needs a definition layer first** — 7:

T006 Kappa metric domain; T009 Quantiles and expected shortfall; T054 Stable kappa and sample equivalence; T068 Pareto MLE and log transform; T073 Record counts and asymmetric tails; T085 Beta uncertainty in quantiles; T099 Quantile-contribution estimator

**Tier C — statement gate first (P1 source-check)** — 12:

T011 Maximum domain of attraction; T012 Payoff versus indicator; T025 Exponential boundary; T053 Kappa algebra and telescoping; T055 Kappa bounds and non-universality; T064 Hidden moment law; T066 Log of a Pareto variable; T072 Relative excess normalization; T079 Adjusted payoff-equivalent probability; T116 Additive error recursion; T128 Minimum p-value law and expectation; T141 Pareto call-price tail

P1 families with support but blocked on §4a infrastructure: T007 (stable-law existence for α < 2 (Bochner / Lévy–Khintchine)); T046 (Cauchy law and its characteristic function); T047 (stable sample-average law); T001 (Karamata-dependent parts of regular variation).

---

## 6. Projection

- **Tier A (29 P1 families, incl. the `reuse` rows)**: at one to two per release with the current audit cadence, roughly 14–29 releases; infrastructure accumulates, so later ones are cheaper.
- **Tiers B and C (19 P1 families)**: each needs a definition layer or a statement repair before the proof; budget a release each, some two.
- **Infrastructure-blocked (§4a)**: not reachable by cadence. CLT, Bochner/Lévy–Khintchine and Karamata are each Mathlib-scale developments (weeks to months of specialist work) that unlock clusters of families (CLT ≈ 8, Karamata ≈ 6–8, Bochner ≈ 3–4).
- **P0 gates and model/empirical rows (30 families)**: complete by decision and documentation, not by proof; some will remain "documented, not proved".

"Completing the formalism" as *all 140 proof families discharged* is a many-months to multi-year programme at this working style, and roughly a fifth of the 158 will only ever be documented. The realistic near-term target is the P1 core.

---

## 7. Completion needs a definition — three candidates

| Target | Meaning | Current standing | Feasibility |
|---|---|---|---|
| **Core-P1 completion** | discharge the 58 P1 families | 2 closed, 10 touched | achievable with mostly existing infrastructure, minus the P1s in §5's blocked line |
| **Proof-family completion** | discharge all 140 | 2 closed, 14 touched | requires building CLT / Bochner / Karamata theory first; long |
| **Book coverage** | all 158 incl. a modelling layer for the applied chapters | as above + 18 modelling decisions | a different kind of project |

Reporting rule: report progress against the **P1 core** (closed / touched / 58), list the infrastructure-blocked P1s separately, keep the 158-family tally as the full denominator the auditor uses, and never derive a percentage from declaration counts.

---

## 8. Sensible next milestones (dependency-ordered)

1. **T005 general identity (2.10)**: `∫_K^∞ x f = K P(X > K) + ∫_K^∞ P(X > x) dx` for nonnegative `X` via Tonelli (layer-cake), with the Pareto case as the check.
2. **T029 stronger child** (regular-variation dominance, `δ`-split route), first for `α > 0`.
3. **T118 convexity**: `m_p` convex in `α` on `α > p` for `p > 0` with the corrected second derivative (G20), then the integrated Jensen statement of Proposition 21.1.
4. **Pareto → Fréchet domain of attraction** (T011 formulation, T062 case): `M_n/(L n^{1/α}) → frechetMeasure (1/α)` — the first convergence theorem.
5. Then the Tier A sweep in chapter order (2 → 4 → 5 → 8); T030 (products of Paretos) and T044 (probability integral transform) are natural early picks.
6. Separately from cadence work: decide whether any §4a infrastructure item is worth building here (CLT is the highest-leverage; Bochner the hardest).

---

## 9. Process notes worth keeping

- Every "synced" or "checked" claim must be backed by a machine check (the D026-1 episode: a hand-maintained Markdown ledger shipped a release stale while the changelog said "synced"). The ledger is now generated and byte-checked; this memo is generated for the same reason.
- Scope rulings belong to the auditor when the ledger's inherited wording is ambiguous (T029: the binary exponent child is complete; the regular-variation reading stays open as a named child).
- Keep assumed-property theorems (`conditional_law_theorem`) distinct from concrete-law results (`actual_law_constructed`); the Pareto instance is what turned Property 5.1 from conditional into realized.
- Credit slices, not families: a Pareto example never closes a multi-distribution target (T005, T021, T028, T032 all stay partial with their general targets named).
- Source locators are checked page by page against the PDF, never inferred from a multi-page text extraction (D028-2).

---

## 10. Revision history

| Release | Date | Change to this memo |
|---|---|---|
| v0.2.8 | 20 Sep 2026 | initial memo (`SCOPE_MEMO_v0.2.8.md`, hand-written from the ledger). |
| v0.2.9 | 21 Sep 2026 | memo made a generated document (`tools/scope_memo.py`, renamed to `SCOPE_MEMO.md`); Stage B added; T005 → partial; G20; release table now computed from the evidence layers. |
| v0.2.10 | 21 Sep 2026 | tracked in git and, from this release, copied into the package evidence for the auditor (`evidence/fable/vX/scope_memo_at_packaging.md`); §4a states the scan method and its limits after the v0.2.9 audit declined to adopt the memo's infrastructure-absence claims as facts; T021 centered slice added to §2/§3. |
