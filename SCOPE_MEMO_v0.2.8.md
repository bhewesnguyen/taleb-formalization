# Scope memo: how far the Taleb formalization has come, and how far it has to go

Prepared 20 September 2026 against the v0.2.8 ledger (`Taleb_Lean_Repairs/docs/FORMALIZATION_BACKLOG.json`,
packaged tree `d086ce0`, ZIP SHA-256 `696c5187…8ccbb0`). Personal working reference; not part of any
audited deliverable. Every count below is read from the ledger or the pinned Mathlib checkout; the
effort tiers in §5 are my judgment and say so.

---

## 1. Headline numbers

The ledger has 158 obligation families. They are deliberately unequal (a family can be one lemma
or a research programme), so no single percentage is honest. Three denominators:

| Denominator | Closed (`discharged`) | Touched (any Lean support) | Untouched |
|---|---|---|---|
| All 158 families | **2** (1.3 %) | **13** (8 %) | 145 |
| 140 formal-proof families (158 minus 15 `model-needed` and 3 `empirical`, which are modelling/data tasks, not theorems) | 2 | 13 | 127 |
| 58 **P1** families — the "contained, reusable" mathematical core | **2** | **9** | 49 |

Declarations checked by the verifier: 184 (160 theorems, 8 instances, 16 aliases), up from 67 in
the received v0.2.0. Citations: 146 family/declaration pairs over 142 distinct names. These are
inventory counts, not progress percentages — the auditor has been right to insist on that.

Status distribution (v0.2.8): 2 discharged · 11 partial · 4 reuse · 90 missing · 33 source-check
· 15 model-needed · 3 empirical.

Status × priority:

| | P0 | P1 | P2 | P3 |
|---|---|---|---|---|
| discharged | – | 2 | – | – |
| partial | – | 7 | 4 | – |
| reuse | – | 4 | – | – |
| missing | – | 33 | 45 | 12 |
| source-check | **12** | 12 | 8 | 1 |
| model-needed / empirical | – | – | – | 15 / 3 |
| total | 12 | 58 | 57 | 31 |

---

## 2. Release history (what one release buys)

| Release | Date | Theorems | Discharged | Partial | Substance |
|---|---|---|---|---|---|
| v0.2.0 (received) | — | 50 | 0 | — | 16 replacement proofs, inventory |
| v0.2.1 | 18 Sep | 52 | 0 | — | reproduction, harness, G17/G18, two boundary diagnostics |
| v0.2.2 | 18 Sep | 52 | 0 | — | harness/documentation corrective pass |
| v0.2.3 | 18 Sep | 64 | 0 | — | two-term power tails (G18), Gaussian stable bridge, independent maxima |
| v0.2.4 | 18 Sep | 83 | **1** (T060) | 10 | independent minima, law-level `cdf(max) = F^n`; first closed family |
| v0.2.5 | 19 Sep | 103 | 1 | 10 | Gumbel and Fréchet measures via Stieltjes |
| v0.2.6 | 20 Sep | 125 | **2** (T061) | 9 | reverse-Weibull, location/scale API, laws of iid maxima as measure equalities |
| v0.2.7 | 20 Sep | 140 | 2 | 9 | Property 5.1 for random variables (T029 binary child), global continuity |
| v0.2.8 | 20 Sep | 160 | 2 | 11 | exact Pareto law: survival/cdf, moments, divergence, tail exponent (T021/T028 slices) |

Rule of thumb from this history: one release ≈ one substantive family child (20–25 theorems),
plus an audit-response cycle. Two families closed in eight releases; the closed ones were among
the most tractable in the ledger (see §4).

---

## 3. What has been done (the 13 supported families)

| Family | Status | Group | What is actually in Lean |
|---|---|---|---|
| T060 Distribution of iid maxima | **discharged** | CDF | `cdf(max) = F^n`, `P(min > x) = S^n`, all four threshold conventions, atoms permitted |
| T061 GEV families as probability measures | **discharged** | EVT | Gumbel, Fréchet, reverse-Weibull as Stieltjes probability measures; location/scale API; laws of iid maxima as equalities of measures |
| T001 Regular variation API | partial | RV | ratio-only RV/SV predicates, closure lemmas, examples; positive-measurable convention open |
| T007 Stable law existence | partial | CF | Gaussian slice only (`gaussianReal` realizes the S1 expression at α = 2); α < 2 open |
| T008 Subexponential law API | partial | SUBEXP | predicate and conditional self-convolution tail result; no concrete law shown subexponential |
| T021 Distribution-specific absolute moments | partial | MOM | exact-Pareto moments: finite iff `p < α`, value `αL^p/(α−p)`, divergence for `p ≥ α` |
| T028 Tail moment threshold | partial | MOM | exact-Pareto survival/cdf with endpoint values, tail exponent, threshold with boundary settled |
| T029 Tail of sums with unequal indices | partial | SUBEXP | Property 5.1 for random variables (binary, no independence) + Pareto instance; stronger RV child open |
| T032 Power transformation of a law | partial | TAIL | analytic exponent `α/p` only; law pushforward open |
| T046 Stable characteristic function specializations | partial | CF | Gaussian half; Cauchy identification open (no Cauchy law in Mathlib) |
| T047 Stable sample averages | partial | CF | prerequisite only: convolution powers and their characteristic functions |
| T118 Moment convexity in Pareto exponent | partial | CALC | prerequisite only: convexity of the tail kernel |
| T124 Shifted-gamma index mean | partial | GAMMA | corrected rational excess formula, as algebra |

Chapters touched: 2, 4, 5, 7, 9, 21 (of 30 numbered + 9 lettered). Supplemental register: S001
(unified GEV parametrisation), S002 (EVT densities) — open, outside the 158.

Common thread: everything done sits in the layer of **distribution facts where the pinned Mathlib
already had the machinery** — `StieltjesFunction`, `iIndepFun`, `withDensity` + improper `rpow`
integrals, `gaussianReal`, elementary real analysis. That front has been harvested deliberately.

---

## 4. What remains, by kind

### 4a. Infrastructure the pinned Mathlib (`f897ebcf…`) does **not** have

Checked by grep on 20 Sep 2026:

| Missing in Mathlib | Blocks |
|---|---|
| Central limit theorem (any form) | T004, T158, Gaussian normalisers in T062, most of CLT group (8 families) |
| Cauchy and Student distributions | T046 (Cauchy half), T021 (Student moments), Student-based rows |
| Karamata / slowly-varying theory | T002, T026, T027, general T011/T028 statements, RV group beyond ratios |
| Bochner's theorem / Lévy–Khintchine (existence of a law from a characteristic function) | T007 stable existence for α < 2, T093 stable domain of attraction, T047 sample averages |
| Gini, expected-shortfall, maximum-entropy APIs | GINI group (10), T009, ENT group (10) — definable from scratch, but nothing to reuse |
| Stochastic calculus for the SDE rows | SDE group (5) |

Present and reusable: Gaussian, Gamma, Pareto laws; `cdf`; Stieltjes measures; independence;
convolution and characteristic functions (uniqueness, not existence); strong/weak LLN (for the
`reuse` rows T003/T051); mgf/cgf.

### 4b. The 12 P0 source-check gates

T088, T095, T100, T101, T114, T119, T120, T123, T126, T137, T144, T156 — the book's statement must
be repaired or disambiguated before any proof (as with G17–G19). Some may end as "documented
defect, no theorem". A further 21 source-check rows sit at P1–P3.

### 4c. Modelling and data tasks (not theorems)

15 `model-needed` + 3 `empirical` (APP, EST, FIN, MULTI groups): T013, T034, T038, T039, T070,
T074, T075, T084, T106, T108, T109, T110, T130, T134, T138, T140, T148, T150. These complete only
by a modelling decision, then possibly a theorem about the model.

### 4d. Dependency groups

| Group | Families | Closed | Partial | Reuse | Missing | Source-check | Model/emp. |
|---|---|---|---|---|---|---|---|
| MOM | 19 | 0 | 2 | 2 | 13 | 2 | 0 |
| FIN | 14 | 0 | 0 | 0 | 5 | 4 | 5 |
| EST | 13 | 0 | 0 | 0 | 6 | 3 | 4 |
| TAIL | 11 | 0 | 1 | 0 | 5 | 5 | 0 |
| ENT | 10 | 0 | 0 | 0 | 8 | 2 | 0 |
| GINI | 10 | 0 | 0 | 0 | 6 | 4 | 0 |
| RV | 8 | 0 | 1 | 0 | 5 | 2 | 0 |
| CLT | 8 | 0 | 0 | 0 | 6 | 2 | 0 |
| KAPPA | 8 | 0 | 0 | 0 | 6 | 2 | 0 |
| APP | 8 | 0 | 0 | 0 | 0 | 0 | 8 |
| DENS | 8 | 0 | 0 | 0 | 7 | 1 | 0 |
| CF | 5 | 0 | 3 | 0 | 1 | 1 | 0 |
| SUBEXP | 5 | 0 | 2 | 0 | 2 | 1 | 0 |
| CDF | 5 | 1 | 0 | 0 | 3 | 1 | 0 |
| SDE | 5 | 0 | 0 | 0 | 4 | 1 | 0 |
| EVT | 4 | 1 | 0 | 0 | 2 | 1 | 0 |
| CALC | 4 | 0 | 1 | 0 | 3 | 0 | 0 |
| MULTI | 4 | 0 | 0 | 0 | 3 | 0 | 1 |
| LLN | 3 | 0 | 0 | 2 | 1 | 0 | 0 |
| RUIN | 3 | 0 | 0 | 0 | 3 | 0 | 0 |
| GAMMA | 2 | 0 | 1 | 0 | 0 | 1 | 0 |
| QUANT | 1 | 0 | 0 | 0 | 1 | 0 | 0 |

Groups with **zero** Lean support: FIN, EST, ENT, GINI, CLT, KAPPA, DENS, SDE, RUIN, MULTI, QUANT,
APP — the book's entire applied second half.

---

## 5. The 49 untouched P1 families, tiered (judgment, to be confirmed when each is opened)

Tier **A — contained, current infrastructure suffices** (one release each, some several per release):
T005 tail integral/excess (Pareto slice is Stage B), T014 multiplicative survival and ruin,
T015 Gaussian scale-mixture normalisation, T016 variance-preserving fattening, T019 perturbed
Gaussian crossovers, T030 product of exact Paretos, T036 uncorrelated vs independent, T040 mixture
multimodality, T044 probability integral transform, T049 cumulant scaling (Mathlib has `cgf`),
T058 exponential summed MAD, T059 negative-kappa examples, T076 payoff interfaces, T078 Gaussian
tail integral / Mills ratio, T081 Brier moments, T083 nonlinear loss moments, T086 quantile
sensitivity, T103 bounded-to-unbounded transform, T111/T112/T113/T117 mixture and error-moment
algebra, T131 survival/hazard/residual lifetime, T142 log-return transforms, T143 shifted-Pareto
relative calls, T151 tail-constraint feasibility; and the four `reuse` rows T003, T020, T051, T146
(Mathlib LLN / norm comparisons, cheap).

Tier **B — medium: contained but needs a definition layer first**: T006 kappa metric domain,
T009 quantiles and expected shortfall, T054 stable kappa (stable part is Tier C), T068 Pareto MLE,
T073 record counts, T085 Beta quantile uncertainty, T099 Gini quantile-contribution estimator.

Tier **C — statement gate first (P1 source-check)**: T011 maximum domain of attraction (general;
the Pareto→Fréchet case is reachable now), T012, T025 exponential boundary of the subexponential
class, T053/T055 kappa algebra and bounds, T064 hidden moment law, T066 log of a Pareto variable,
T072, T079, T116, T128 minimum p-value law, T141 Pareto call-price tail.

P1 families with support but blocked on §4a infrastructure: T007 (stable existence α < 2), T046
(Cauchy), T047 (sample-average law), T001 (Karamata-dependent parts).

---

## 6. Projection

- **Tier A + reuse (~33 P1 families)**: at one to two per release with the current audit cadence,
  roughly 20–30 releases. Infrastructure accumulates (e.g. `affineLaw`, the Pareto law, the
  weighted-sum rules), so the later ones are cheaper than the early ones were.
- **Tiers B and C (~18 P1 families)**: each needs a definition layer or a statement repair before
  the proof; budget a release each, some two.
- **Infrastructure-blocked (§4a)**: not reachable by cadence. Each of CLT, Bochner/Lévy–Khintchine,
  Karamata is a Mathlib-scale development effort — weeks to months of specialist work per item —
  and each unlocks a cluster of families (CLT ≈ 8, Karamata ≈ 6–8, Bochner ≈ 3–4).
- **P0 gates and model/empirical rows (~30 families)**: complete by decision and documentation,
  not by proof; some will remain "documented, not proved".

"Completing the formalism" as *all 140 proof families discharged* is therefore a many-months to
multi-year programme at this working style, and roughly a fifth of the 158 will only ever be
documented. The realistic near-term target is the P1 core.

---

## 7. Completion needs a definition — three candidates

| Target | Meaning | Current standing | Feasibility |
|---|---|---|---|
| **Core-P1 completion** | discharge the 58 P1 families | 2 closed, 9 touched | achievable with mostly existing infrastructure, minus T007/T011-general/T002 which hide §4a dependencies |
| **Proof-family completion** | discharge all 140 | 2 closed, 13 touched | requires building CLT / Bochner / Karamata theory first; long |
| **Book coverage** | all 158 incl. a modelling layer for the applied chapters | as above + 18 modelling decisions | a different kind of project |

Recommended reporting rule: report progress against the **P1 core** (closed / touched / 58), list
the infrastructure-blocked P1s separately, and keep the 158-family tally as the full denominator
the auditor already uses. Never derive a percentage from declaration counts.

---

## 8. Sensible next milestones (dependency-ordered)

1. Pareto **Stage B** — conditional/excess law `𝓛(X | X > K) = Pareto(K, α)`, excess survival
   `(K/(K+y))^α`, conditional mean for `α > 1` (T005 slice); positive-power pushforward
   `Pareto(L, α).map (·^q) = Pareto(L^q, α/q)` as an equality of laws (T032 slice).
2. **T021 ratios**: mean and variance from the delivered moments; the Pareto STD/MD ratio (4.14).
3. **T029 stronger child** (regular-variation dominance, δ-split route), first for `α > 0`.
4. **Pareto → Fréchet domain of attraction** (T011 formulation, T062 case): `M_n/(L n^{1/α}) →
   frechetMeasure (1/α)` — the first convergence theorem, using the exact survival now available.
5. Then the Tier A sweep in chapter order (2 → 4 → 5 → 8), which also fills the empty MOM/TAIL/DENS
   groups; T030 (product of Paretos) and T044 (probability integral transform) are natural early picks.
6. Decide, separately from cadence work, whether any §4a infrastructure item is worth building
   here (CLT is the highest-leverage; Bochner is the hardest).

---

## 9. Process notes worth keeping

- Every "synced" or "checked" claim must be backed by a machine check; the D026-1 episode (a
  hand-maintained Markdown ledger shipped a release stale while the changelog said "synced") is the
  cautionary case. The ledger is now generated and byte-checked.
- Scope rulings belong to the auditor when the ledger's inherited wording is ambiguous (T029: the
  binary exponent child is complete; the regular-variation reading stays open).
- Keep assumed-property theorems (`conditional_law_theorem`) distinct from concrete-law results
  (`actual_law_constructed`); the Pareto instance is what turned Property 5.1 from conditional into
  realized.
- Credit slices, not families: a Pareto example never closes a multi-distribution target.
