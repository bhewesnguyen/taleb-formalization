# Taleb proof progress, v0.2.6

Independent assessment, 20 September 2026. The companion JSON preserves all 158 received family rows and adds audited scopes, findings and supplemental obligations.

## Current position

Independent reproduction passed: clean build, 149 public checks, all 270 project constants within the allowed axioms, all schema probes, and all 14 regression fixtures. The regression coverage used three isolated, disjoint invocations of the unchanged harness.

**T061 closure is accepted.** The three named EVT probability laws and their positive location/scale scope are complete. T060 remains discharged. The release Markdown ledger is stale; the tally below uses the reviewed JSON and the accepted mathematical scope.

| Status | Families |
|---|---:|
| discharged | 2 |
| partial | 9 |
| reuse | 4 |
| missing | 91 |
| source-check | 34 |
| model-needed | 15 |
| empirical | 3 |

The change from v0.2.5 is one closure: 1 to 2 discharged, 10 to 9 partial. Eleven families have credited Lean work, with 107 family/declaration pairs over 106 distinct names. There are 140 formal-proof families: 2 closed and 138 open. The other 18 require models or empirical work. Counts do not measure effort completed, and the inventory is not an exhaustive atomic census of every book claim.

## Completed T061 children

| Child | Audit state | Delivered |
|---|---|---|
| Standard Gumbel | complete | Concrete probability measure, exact CDF, maximum law and finite product iid model. |
| Standard Frechet, xi > 0 | complete | Support-correct probability measure, exact CDF, maximum law and finite product iid model. |
| Standard reverse-Weibull, alpha > 0 | complete | Upper-endpoint probability measure, exact CDF, max-stability and finite product iid model. |
| Positive location/scale, all three laws | complete | Generic affine probability law and CDF rule; three named families and exact maximum-law measure equalities. |

The unified GEV parametrization and its xi -> 0 Gumbel limit were not part of the original three-family construction target. They remain explicit source obligations. No new global-continuity theorem is required to close this Stieltjes construction.

## Documentation repairs before the next handoff

1. Generate Markdown and JSON from the same validated records; update T061 in the stale Markdown and the module header. Add a fast consistency check.
2. Correct the claim that the support-correct Frechet and reverse-Weibull CDFs are not globally continuous. Under positive shapes they are continuous; only right continuity needed to be proved for construction.
3. Correct the carried-forward density-to-T062 mapping, including prior audit guidance. T062 is a convergence family. Correct the Pareto-to-Frechet shape to xi = 1/alpha.

## Supplemental open EVT obligations

These are visible work items, not extra rows in the fixed 158-family count and not reasons to reopen T061.

- Unified GEV-in-xi parametrization and xi-to-zero Gumbel limit
- Density/withDensity identifications for the three EVT laws, currently without a dedicated family ID
- Normalized-maxima convergence: setup under T011; regular-variation/Frechet and Gaussian/Gumbel cases under T062

## Audited supported families

### T001: Regular variation API

**Status: partial.** Recorded states: formula_proved, source_reviewed.

**Assessment:** accurate

**Delivered scope:** Ratio-only regular/slow variation API, examples and closure rules. The negative-constant diagnostic explicitly separates this from the positive measurable convention.

**Recommended clarification:** Retain partial. Positivity/measurability remain; Karamata, uniform convergence and Potter bounds belong to other recorded families.

**Remaining target:** Positive measurable convention and its relationship to the ratio predicates. Uniform convergence, Potter bounds and Karamata are T026, T027 and T002.

### T007: Stable law existence

**Status: partial.** Recorded states: actual_law_constructed, source_reviewed.

**Assessment:** accurate

**Delivered scope:** Gaussian realization of the S1 expression at alpha = 2, including zero scale, by reusing Mathlib's actual Gaussian law.

**Recommended clarification:** Retain partial. No alpha < 2 existence theorem is delivered; reuse is correctly disclosed.

**Remaining target:** Existence of a probability law with the S1 characteristic function for every 0 < alpha < 2, including alpha = 1 with beta != 0, and the zero-scale Dirac case for those alpha.

### T008: Subexponential law API

**Status: partial.** Recorded states: conditional_law_theorem.

**Assessment:** accurate

**Delivered scope:** A probability-level subexponential predicate and preservation of an assumed finite log-tail exponent under self-convolution.

**Recommended clarification:** Retain partial. Concrete examples, the n-fold characterization and standard-definition equivalences remain. The revised conditional-law legend now covers these property premises.

**Remaining target:** Any concrete subexponential law, the equivalent n-fold tail characterizations, equivalence with the standard definition, and whether subexponential laws must have a finite exponent.

### T029: Tail of sums with unequal indices

**Status: partial.** Recorded states: formula_proved, source_reviewed.

**Assessment:** accurate

**Delivered scope:** Finite log-tail exponent of a sum of two positive power-tail formulas, with exponent equal to the minimum of the two exponents.

**Recommended clarification:** Retain partial. The random-variable nonnegative weighted-sum squeeze remains. Keep exact convolution asymptotics distinct.

**Remaining target:** Finite log tail exponent of nonnegative weighted sums via event inclusions and a squeeze lemma (no independence needed). Exact convolution asymptotics belong to the subexponential workstream.

### T032: Power transformation of a law

**Status: partial.** Recorded states: formula_proved.

**Assessment:** accurate

**Delivered scope:** Analytic power-composition tail exponent alpha/p, without a pushforward-law identification.

**Recommended clarification:** Retain partial. Measurability, the inverse event and actual transformed law remain.

**Remaining target:** Measurable pushforward under x -> x^p for nonnegative x and p > 0, the inverse-event identity and identification of the transformed law.

### T046: Stable characteristic function specializations

**Status: partial.** Recorded states: formula_proved, actual_law_constructed, source_reviewed.

**Assessment:** accurate

**Delivered scope:** Gaussian law and instantiated stable convolution bridge; Cauchy expression specialization remains formula-level.

**Recommended clarification:** Retain partial. A Cauchy law/characteristic-function identification is still required. Adding law_theorem for the proved Gaussian convolution equality would be optional conservative bookkeeping, not additional mathematics.

**Remaining target:** A Cauchy probability law with its characteristic function (none in the pinned Mathlib), nonnegative scale including Dirac, and its instantiation of the bridge.

### T047: Stable sample averages

**Status: partial.** Recorded states: conditional_law_theorem.

**Assessment:** accurate prerequisite only

**Delivered scope:** Conditional stable sum/convolution infrastructure only, now explicitly labeled prerequisite only.

**Recommended clarification:** Retain partial. Sample-average pushforwards, the n^(1/alpha-1) scale, alpha = 1 skew-location correction and finite-mean convergence remain.

**Remaining target:** Pushforward under division by n, the average scale n^(1/alpha - 1), the alpha = 1 skew-location correction under rescaling, and finite-mean convergence.

### T060: Distribution of iid maxima

**Status: discharged.** Recorded states: formula_proved, law_theorem, source_reviewed, discharged.

**Assessment:** discharge accepted

**Delivered scope:** Actual measurable maximum/minimum laws for independent coordinates with a common law on a finite nonempty index type, plus all four event threshold conventions.

**Recommended clarification:** Retain discharged. Scope and delivery are accurate; correct the carried-forward remaining-text cross-reference that assigns densities to T062.

**Remaining target:** None within T060. Named EVT measures are T061 (now discharged); domains-of-attraction setup is T011 and concrete Frechet/Gaussian cases are T062. Density identifications need their own recorded task.

### T061: GEV families as probability measures

**Status: discharged.** Recorded states: formula_proved, conditional_law_theorem, law_theorem, actual_law_constructed, source_reviewed, discharged.

**Assessment:** discharge accepted with documentation repairs

**Delivered scope:** All three support-correct standard EVT probability laws, exact CDF identities, law-instantiated maxima and finite-product iid realizations; positive affine CDF rule and all three location/scale maximum laws as equalities of measures.

**Recommended clarification:** Retain discharged against the original v0.2.0 target, whose opening statement and hypotheses have been preserved. Correct stale Markdown/current module header, false continuity prose, and T062 routing. The unified GEV parametrization and xi-to-zero limit are supplemental open work, not retrospective closure requirements.

**Remaining target:** None within the three-family construction and positive location/scale scope. Supplemental open EVT work: unified GEV coordinates and xi-to-zero Gumbel limit; density identifications; normalized-maxima convergence under T011/T062.

### T118: Moment convexity in Pareto exponent

**Status: partial.** Recorded states: formula_proved.

**Assessment:** accurate prerequisite only

**Delivered scope:** Convexity of alpha -> c^(-alpha) only, now explicitly separated from the Pareto moment formula, its convexity and Jensen.

**Recommended clarification:** Retain partial under the ledger's prerequisite-credit convention. The actual moment-convexity target is still open; p > 0 and positive scale are already recorded in the hypotheses.

**Remaining target:** Identify E[X^p] = scale^p alpha/(alpha - p) for alpha > p, prove its convexity in alpha, and justify Jensen with the mixing support and integrability assumptions.

### T124: Shifted-gamma index mean

**Status: partial.** Recorded states: formula_proved, source_reviewed.

**Assessment:** accurate

**Delivered scope:** Corrected rational gamma-mixture excess expression and positivity, purely algebraic.

**Recommended clarification:** Retain partial. The gamma inverse moment, finiteness threshold and mixture expectation identity remain.

**Remaining target:** The inverse moment of the gamma law, its finiteness threshold, and the mixture expectation identity that produces the formula.

## Dependency-group position

Remaining formal combines reuse, missing and source-check. The source-check column is a subset, not an additional category.

| Group | Families | Discharged | Partial | Source-check subset | Remaining formal | Model / empirical |
|---|---:|---:|---:|---:|---:|---:|
| APP | 8 | 0 | 0 | 0 | 0 | 8 |
| CALC | 4 | 0 | 1 | 0 | 3 | 0 |
| CDF | 5 | 1 | 0 | 1 | 4 | 0 |
| CF | 5 | 0 | 3 | 1 | 2 | 0 |
| CLT | 8 | 0 | 0 | 2 | 8 | 0 |
| DENS | 8 | 0 | 0 | 1 | 8 | 0 |
| ENT | 10 | 0 | 0 | 2 | 10 | 0 |
| EST | 13 | 0 | 0 | 3 | 9 | 4 |
| EVT | 4 | 1 | 0 | 1 | 3 | 0 |
| FIN | 14 | 0 | 0 | 4 | 9 | 5 |
| GAMMA | 2 | 0 | 1 | 1 | 1 | 0 |
| GINI | 10 | 0 | 0 | 4 | 10 | 0 |
| KAPPA | 8 | 0 | 0 | 2 | 8 | 0 |
| LLN | 3 | 0 | 0 | 0 | 3 | 0 |
| MOM | 19 | 0 | 0 | 3 | 19 | 0 |
| MULTI | 4 | 0 | 0 | 0 | 3 | 1 |
| QUANT | 1 | 0 | 0 | 0 | 1 | 0 |
| RUIN | 3 | 0 | 0 | 0 | 3 | 0 |
| RV | 8 | 0 | 1 | 2 | 7 | 0 |
| SDE | 5 | 0 | 0 | 1 | 5 | 0 |
| SUBEXP | 5 | 0 | 2 | 1 | 3 | 0 |
| TAIL | 11 | 0 | 1 | 5 | 10 | 0 |

## Full 158-family index

Unsupported rows are tallied here without a new full-family mathematical audit. Source locators are the release anchors.

| ID | Unit | Status | Group | Priority | Family | Printed pages |
|---|---|---|---|---|---|---|
| T001 | 2 | partial | RV | P1 | Regular variation API | 9-10 |
| T002 | 2 | missing | RV | P2 | Karamata representation | 9;379-382 |
| T003 | 2 | reuse | LLN | P1 | Weak and strong laws | 10;137-139 |
| T004 | 2 | missing | CLT | P2 | Central limit theorem | 10;147-148 |
| T005 | 2 | missing | TAIL | P1 | Tail integral and excess identities | 10;18;259 |
| T006 | 2 | missing | KAPPA | P1 | Kappa metric domain | 11;156-159 |
| T007 | 2 | partial | CF | P2 | Stable law existence | 12-13;139-140;282 |
| T008 | 2 | partial | SUBEXP | P2 | Subexponential law API | 13;91-93 |
| T009 | 2 | missing | QUANT | P1 | Quantiles and expected shortfall | 16 |
| T010 | 2 | missing | LLN | P2 | Maximum divided by sum | 16-17;200 |
| T011 | 2 | source-check | EVT | P1 | Maximum domain of attraction | 17;171-177 |
| T012 | 2 | source-check | TAIL | P1 | Payoff versus indicator | 18;225-227 |
| T013 | 3 | model-needed | APP | P3 | Overview and illustrative calculations | 25-67 |
| T014 | 3 | missing | RUIN | P1 | Multiplicative survival and ruin | 53;63-66 |
| T015 | 4 | missing | MOM | P1 | Gaussian scale mixture normalization | 69-74 |
| T016 | 4 | missing | MOM | P1 | Variance-preserving fattening | 71-72 |
| T017 | 4 | missing | DENS | P3 | Gamma mixture density | 72-74 |
| T018 | 4 | missing | DENS | P2 | Precision mixture and Student law | 74-75 |
| T019 | 4 | missing | CALC | P1 | Crossovers of perturbed Gaussian densities | 75-79 |
| T020 | 4 | reuse | MOM | P1 | Moment and norm comparisons | 79-86 |
| T021 | 4 | missing | MOM | P1 | Distribution-specific absolute moments | 80-86 |
| T022 | 4 | missing | EST | P3 | Estimator efficiency comparison | 83 |
| T023 | 4 | source-check | GAMMA | P2 | Lp-ball volumes | 88-89 |
| T024 | 5 | missing | SUBEXP | P2 | One large jump and absent exponential moments | 91-93 |
| T025 | 5 | source-check | SUBEXP | P1 | Exponential boundary | 91-94 |
| T026 | 5 | missing | RV | P2 | Regular-variation uniform convergence | 95-98 |
| T027 | 5 | missing | RV | P2 | Potter bounds | 95-98 |
| T028 | 5 | source-check | MOM | P1 | Tail moment threshold | 95-98 |
| T029 | 5 | partial | SUBEXP | P2 | Tail of sums with unequal indices | 98-99 |
| T030 | 5 | missing | DENS | P1 | Product of exact Pareto laws | 99-100 |
| T031 | 5 | source-check | RV | P2 | Breiman product theorem | 100 |
| T032 | 5 | partial | TAIL | P1 | Power transformation of a law | 100 |
| T033 | 5 | missing | DENS | P2 | Bell shape, interpolation, and log-Pareto | 101-103 |
| T034 | 5 | model-needed | APP | P3 | Stochastic-volatility interpretations | 103-105 |
| T035 | 6 | missing | MULTI | P2 | Elliptical and multivariate Student laws | 108-114 |
| T036 | 6 | missing | MULTI | P1 | Uncorrelated versus independent | 113-114 |
| T037 | 6 | missing | ENT | P3 | Student mutual information | 114-115 |
| T038 | 6 | model-needed | MULTI | P3 | Random matrices and undefined correlation | 115-117 |
| T039 | 6 | model-needed | EST | P3 | Regression with fat-tailed residuals | 117-119 |
| T040 | A | missing | DENS | P1 | Mixture multimodality | 122-124 |
| T041 | A | missing | RUIN | P2 | Eventual transition or failure | 124-125 |
| T042 | B | missing | ENT | P2 | Gaussian maximum entropy | 128-129 |
| T043 | B | missing | ENT | P2 | Pareto maximum entropy | 129 |
| T044 | B | missing | CDF | P1 | Uniform maximum entropy and probability integral transform | 129 |
| T045 | B | missing | ENT | P3 | Tsallis entropy | 129-132 |
| T046 | 7 | partial | CF | P1 | Stable characteristic function specializations | 139-140 |
| T047 | 7 | partial | CF | P2 | Stable sample averages | 140 |
| T048 | 7 | missing | DENS | P2 | Explicit finite-sum laws | 141-145 |
| T049 | 7 | missing | MOM | P1 | Cumulant scaling | 145-147 |
| T050 | 7 | missing | CLT | P2 | Lyapunov implies Lindeberg | 147-148 |
| T051 | 7 | reuse | LLN | P1 | LLN for powers and MS plots | 148-150 |
| T052 | 7 | source-check | CF | P2 | Stable mean absolute deviation | 151-152 |
| T053 | 8 | source-check | KAPPA | P1 | Kappa algebra and telescoping | 156-158 |
| T054 | 8 | missing | KAPPA | P1 | Stable kappa and sample equivalence | 158-160 |
| T055 | 8 | source-check | KAPPA | P1 | Kappa bounds and non-universality | 160-162 |
| T056 | 8 | missing | KAPPA | P2 | Cubic Student summed MAD | 164-166 |
| T057 | 8 | missing | KAPPA | P2 | Lognormal sum bounds | 166-168 |
| T058 | 8 | missing | KAPPA | P1 | Exponential summed MAD | 168-169 |
| T059 | 8 | missing | KAPPA | P1 | Negative kappa examples | 169-170 |
| T060 | 9 | discharged | CDF | P1 | Distribution of iid maxima | 171-173 |
| T061 | 9 | discharged | EVT | P1 | GEV families as probability measures | 172-173 |
| T062 | 9 | missing | EVT | P2 | Frechet and Gaussian maximum domains | 173-175 |
| T063 | 9 | missing | EVT | P2 | Pickands-Balkema-de Haan | 176-177 |
| T064 | 9 | source-check | TAIL | P1 | Hidden moment law | 177-179 |
| T065 | 9 | missing | CLT | P2 | Empirical CDF versus tail payoff | 179-181 |
| T066 | C | source-check | DENS | P1 | Log of a Pareto variable | 183-185 |
| T067 | D | missing | CLT | P2 | Large deviation principle | 187-188 |
| T068 | E | missing | EST | P1 | Pareto MLE and log transform | 189-191 |
| T069 | E | missing | EST | P2 | Tail-exponent sampling law | 191-192 |
| T070 | 10 | empirical | APP | P3 | SP500 empirical claims | 193-205 |
| T071 | 10 | missing | MOM | P2 | Aggregation and drawdown statistics | 195-198 |
| T072 | 10 | source-check | TAIL | P1 | Relative excess normalization | 200 |
| T073 | 10 | missing | CDF | P1 | Record counts and asymmetric tails | 201-205 |
| T074 | F | model-needed | EST | P3 | Risk estimator performance | 208-212 |
| T075 | G | model-needed | EST | P3 | Learning losses and angular calibration | 213-216 |
| T076 | 11 | missing | TAIL | P1 | Binary and unbounded payoff interfaces | 220-225 |
| T077 | 11 | missing | RV | P2 | Payoff-to-binary tail ratios | 225-227 |
| T078 | 11 | missing | TAIL | P1 | Gaussian tail integral and Mills ratio | 226 |
| T079 | 11 | source-check | TAIL | P1 | Adjusted payoff-equivalent probability | 228 |
| T080 | 11 | missing | EST | P2 | Calibration versus payoff calibration | 230-231 |
| T081 | 11 | missing | MOM | P1 | Bounded Brier score moments | 231-238 |
| T082 | 11 | missing | EST | P3 | Score distribution transforms | 233-240 |
| T083 | 11 | missing | TAIL | P1 | Nonlinear loss moments | 235-238 |
| T084 | 12 | model-needed | APP | P3 | Single forecasts and asymmetric decisions | 241-251 |
| T085 | 13 | missing | MOM | P1 | Beta uncertainty in quantiles | 253-257 |
| T086 | 13 | missing | CALC | P1 | Quantile sensitivity | 257-259 |
| T087 | 14 | missing | SDE | P3 | Gaussian digital payoff valuation | 263-268 |
| T088 | 14 | source-check | SDE | P0 | Sigmoid of a martingale | 268 |
| T089 | 14 | missing | SDE | P3 | Bounded dual diffusion | 268-271 |
| T090 | 14 | missing | CDF | P2 | Probability assessor and uniform forecast | 271-273 |
| T091 | 15 | missing | GINI | P2 | Population and sample Gini | 277-282 |
| T092 | 15 | missing | GINI | P2 | Order-statistic remainder | 281-282 |
| T093 | 15 | source-check | CLT | P2 | Stable domain of attraction | 282-283 |
| T094 | 15 | missing | GINI | P3 | Gini mean-deviation stable limit | 283 |
| T095 | 15 | source-check | GINI | P0 | Gini ratio stable limit | 283-284;295 |
| T096 | 15 | source-check | EST | P2 | Parametric Gini MLE limit | 284 |
| T097 | 15 | source-check | GINI | P2 | Pareto Gini estimator laws | 285-287 |
| T098 | 15 | missing | GINI | P3 | Finite-sample Gini correction | 287-295 |
| T099 | 16 | missing | GINI | P1 | Quantile-contribution estimator | 299-302 |
| T100 | 16 | source-check | GINI | P0 | Aggregation of concentration | 302-306 |
| T101 | 16 | source-check | GINI | P0 | Bias and consistency of threshold share | 305 |
| T102 | 16 | missing | GINI | P3 | Mixtures and concentration | 306-309 |
| T103 | 17 | missing | CALC | P1 | Dual bounded-to-unbounded transform | 314-316 |
| T104 | 17 | missing | MOM | P2 | Shadow density and moments | 316-319 |
| T105 | 17 | missing | DENS | P2 | Truncation versus transformation | 319-321 |
| T106 | 18 | empirical | APP | P3 | Conflict-data inference | 323-342 |
| T107 | 18 | missing | TAIL | P2 | Rescaling and conditional expectations | 328-329 |
| T108 | 18 | model-needed | EST | P3 | GPD inference and bootstrap | 333-339 |
| T109 | H | model-needed | APP | P3 | War-probability discussion | 343-345 |
| T110 | 19 | empirical | APP | P3 | Pandemic tail and shadow moments | 347-361 |
| T111 | 20 | missing | MOM | P1 | Recursive mixtures | 368-371 |
| T112 | 20 | missing | MOM | P1 | Constant-error moment products | 372-373 |
| T113 | 20 | missing | MOM | P1 | Absolute-moment invariance | 372-373 |
| T114 | 20 | source-check | CLT | P0 | Exploding moments versus limiting law | 373-377 |
| T115 | 20 | missing | MOM | P2 | Decaying-error infinite products | 375 |
| T116 | 20 | source-check | MOM | P1 | Additive error recursion | 376 |
| T117 | 21 | missing | MOM | P1 | Random-index mixture foundations | 379-382 |
| T118 | 21 | partial | CALC | P1 | Moment convexity in Pareto exponent | 381 |
| T119 | 21 | source-check | TAIL | P0 | Mixed expected shortfall | 381-383 |
| T120 | 21 | source-check | RV | P0 | Density and boundary normalization | 381-382 |
| T121 | 21 | missing | SUBEXP | P2 | Sums and stochastic indices | 383-384 |
| T122 | 21 | missing | CF | P2 | Asymmetric stable mixture | 384-385 |
| T123 | 21 | source-check | MOM | P0 | Shifted-lognormal index mean | 385 |
| T124 | 21 | partial | GAMMA | P1 | Shifted-gamma index mean | 386 |
| T125 | 21 | missing | MOM | P2 | Mixed bounded power law | 386-387 |
| T126 | 22 | source-check | EST | P0 | Finite-sample p-value density | 391-393 |
| T127 | 22 | missing | EST | P2 | Gaussian-limit p-value law | 392-394 |
| T128 | 22 | source-check | CDF | P1 | Minimum p-value law and expectation | 395 |
| T129 | 22 | source-check | EST | P3 | Power-of-test distribution | 396 |
| T130 | I | model-needed | APP | P3 | Loss-aversion examples | 399-403 |
| T131 | 23 | missing | RUIN | P1 | Survival, hazard and residual lifetime | 405-409 |
| T132 | 23 | missing | SDE | P3 | Brownian absorbing barrier | 409-411 |
| T133 | 23 | missing | SDE | P3 | Drifted barrier and Lindy interpretation | 411-413 |
| T134 | 24 | model-needed | FIN | P3 | Hedging-error decomposition | 417-420 |
| T135 | 25 | source-check | FIN | P2 | Call-price curve determines a marginal law | 423-426 |
| T136 | 25 | missing | FIN | P2 | Put/call law uniqueness | 426 |
| T137 | 25 | source-check | FIN | P0 | Forward mean is not measure uniqueness | 426 |
| T138 | 25 | model-needed | FIN | P3 | Physical versus pricing measure | 427 |
| T139 | 26 | missing | FIN | P2 | Static payoff formulas and hedging | 434-439 |
| T140 | 26 | model-needed | FIN | P3 | Limits of dynamic replication | 439-442 |
| T141 | 27 | source-check | FIN | P1 | Pareto call-price tail | 446-448 |
| T142 | 27 | missing | RV | P1 | Log return transforms | 448 |
| T143 | 27 | missing | FIN | P1 | Shifted Pareto relative calls | 448-449 |
| T144 | 27 | source-check | FIN | P0 | Put-price power law | 449-451 |
| T145 | 27 | missing | FIN | P2 | Splice no-arbitrage boundaries | 451 |
| T146 | 28 | reuse | MOM | P1 | Second versus fourth moment | 453-454 |
| T147 | 28 | missing | FIN | P2 | Jensen, insurance and numeraire | 454-456 |
| T148 | 28 | model-needed | FIN | P3 | Tail betting examples | 456-457 |
| T149 | 29 | missing | MULTI | P2 | Dependence beyond correlation | 459-467 |
| T150 | 29 | model-needed | FIN | P3 | Portfolio expected shortfall | 459-467 |
| T151 | 30 | missing | ENT | P1 | Tail constraint feasibility | 469-474 |
| T152 | 30 | missing | ENT | P2 | Gaussian tail constraint solution | 474;481 |
| T153 | 30 | missing | CLT | P2 | Two-normal small-variance limit | 475 |
| T154 | 30 | source-check | ENT | P2 | Entropy optimizer existence | 476-477 |
| T155 | 30 | missing | ENT | P2 | Piecewise-exponential maximum entropy | 477 |
| T156 | 30 | source-check | ENT | P0 | Absolute-moment entropy optimizer | 478 |
| T157 | 30 | missing | ENT | P2 | Power-tail maximum entropy | 479 |
| T158 | 30 | missing | CLT | P2 | Multi-period averages and stable/Gaussian limits | 480-481 |

## Next acceptance sequence

1. Correct the three documentation findings without altering the proved scope.
2. T029: actual nonnegative weighted sums and finite log-tail exponent min(alpha, beta), via event inclusions and a general exponent squeeze; no independence.
3. Exact Pareto probability-law slice: global survival, finite moments and divergence, conditioning/excess, positive-power pushforward. Credit only the relevant slices of larger families.
4. Pareto maxima convergence under T011/T062 with reciprocal shape; separately scoped EVT densities and unified GEV work.

Mathematical declarations do not establish a Mathlib upstream merge or readiness of the separate quantum/classical application. Those software outcomes need their own implementation evidence.
