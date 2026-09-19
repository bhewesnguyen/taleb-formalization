# Taleb proof progress, v0.2.4

Independent assessment, 19 September 2026. The full original rows and credited declaration lists are preserved in the companion JSON. This document adds audited scope for the eleven supported families and a readable index of all 158 families.

## Current position

Independent clean build and verifier passed. The unchanged sequential regression suite passed all 12 fixtures with the intended outcomes. All 189 scanned project constants satisfy the standard three-axiom allowlist.

| Status | Families |
|---|---:|
| discharged | 1 |
| partial | 10 |
| reuse | 4 |
| missing | 91 |
| source-check | 34 |
| model-needed | 15 |
| empirical | 3 |

There is one closed family, T060, and ten additional partially supported families. T007 receives retrospective credit for its v0.2.3 Gaussian slice; T060 is the new v0.2.4 completion. The formal-proof working set is 140 families, alongside 15 model-needed and 3 empirical families.

These are unequal, curated obligation families, not an exhaustive atomic theorem census or a percentage of implementation effort. The 100 public checks, 189 scanned constants, 71 family/declaration citations and 70 distinct cited declarations describe different things. Delivery tags apply to scoped components and are not a completion ladder.

## Audited scope of the eleven supported families

### T001: Regular variation API

**Status: partial.** Recorded states: formula_proved, source_reviewed.

**Assessment:** accurate

**Delivered scope:** Ratio-limit analytic API, examples, closure, regular/slow equivalence and eventual-equality transport.

**Recommended clarification:** Retain partial; positivity/measurability are explicitly separate, as shown by the negative-constant diagnostic.

**Remaining target:** Build the positive measurable convention and bridge it to the ratio predicates.

### T007: Stable law existence

**Status: partial.** Recorded states: actual_law_constructed, source_reviewed.

**Assessment:** accurate with named slice

**Delivered scope:** The Gaussian alpha=2 slice is realized by gaussianReal at variance 2*sigma^2, including scale zero.

**Recommended clarification:** Retain partial and concrete-law credit for the Gaussian slice; realization may reuse Mathlib.

**Remaining target:** Construct and identify stable measures for alpha<2, including Cauchy and the alpha=1 skew branch; export general zero-scale identification if desired.

### T008: Subexponential law API

**Status: partial.** Recorded states: conditional_law_theorem.

**Assessment:** accurate scoped credit

**Delivered scope:** Measure-level subexponential definition and preservation of an assumed finite log-tail exponent under self-convolution.

**Recommended clarification:** Retain partial; make clear that subexponentiality and a finite exponent are premises, and broaden the state definition to cover property hypotheses.

**Remaining target:** Prove concrete subexponential examples and equivalent n-fold tail characterizations; no finite-exponent existence theorem is delivered.

### T029: Tail of sums with unequal indices

**Status: partial.** Recorded states: formula_proved, source_reviewed.

**Assessment:** accurate

**Delivered scope:** The analytic sum of two positive power-tail formulas has the minimum finite log-tail exponent.

**Recommended clarification:** Retain partial/formula-only; explicitly distinguish formula coefficients from survival of a weighted random-variable sum.

**Remaining target:** Nonnegative weighted-sum survival/event-inclusion squeeze and finite log-tail exponent; exact asymptotic tail dominance is a separate stronger target.

### T032: Power transformation of a law

**Status: partial.** Recorded states: formula_proved.

**Assessment:** accurate

**Delivered scope:** Analytic composition of a Pareto power tail has exponent alpha/p.

**Recommended clarification:** Retain partial/formula-only.

**Remaining target:** Measurability and monotone inverse/event identity for the positive-power pushforward, and probability-law survival identification.

### T046: Stable characteristic function specializations

**Status: partial.** Recorded states: formula_proved, actual_law_constructed, source_reviewed.

**Assessment:** accurate with named slice

**Delivered scope:** Gaussian and Cauchy formula specializations; actual Gaussian CF identification and convolution closure through the stable bridge.

**Recommended clarification:** Retain partial; actual-law credit is Gaussian-only, with variance 2*sigma^2 and zero scale included.

**Remaining target:** Cauchy measure and characteristic-function identification.

### T047: Stable sample averages

**Status: partial.** Recorded states: conditional_law_theorem.

**Assessment:** accurate prerequisite only

**Delivered scope:** Conditional stable sum/convolution bridge, probability convolution powers, CF power identity and binary independent-sum map law.

**Recommended clarification:** Retain partial; add delivery_scope saying sum bridge only, not a proved sample-average law.

**Remaining target:** N-sample average pushforward, scale n^(1/alpha-1), location rules including alpha=1 skew correction, and finite-mean convergence.

### T060: Distribution of iid maxima

**Status: discharged.** Recorded states: formula_proved, source_reviewed, discharged.

**Assessment:** discharge accepted tag understates

**Delivered scope:** Actual finite maximum/minimum random variables, measurability, independent product laws, common-law max CDF F^n and minimum strict survival (1-F)^n, with atoms permitted.

**Recommended clarification:** Accept discharged against unchanged stated target; add generic law_theorem facet or clearly define a law-level tag for common-law hypotheses.

**Remaining target:** None within stated family. Specific EVT measures remain T061; empty real-valued extrema are outside the n>0 scope.

### T061: GEV families as probability measures

**Status: partial.** Recorded states: formula_proved, conditional_law_theorem.

**Assessment:** accurate

**Delivered scope:** Support-correct Frechet and Gumbel formulas, formula max-stability, and independent-maxima consequences conditional on CDF premises.

**Recommended clarification:** Retain partial, formula and conditional-law credit; no concrete EVT-law realization credit.

**Remaining target:** Gumbel, Frechet and reverse-Weibull validity and measure construction, location/scale wrappers and realized max-stability.

### T118: Moment convexity in Pareto exponent

**Status: partial.** Recorded states: formula_proved.

**Assessment:** accurate prerequisite only needs scope

**Delivered scope:** Only convexity of alpha -> c^(-alpha) is proved, a tail-kernel prerequisite for the moment/Jensen target.

**Recommended clarification:** Retain partial; qualify formula_proved with prerequisite-only delivery_scope. No mathematical blocker or missing-status downgrade.

**Remaining target:** Convexity of m_p(alpha)=scale^p*alpha/(alpha-p), moment identification and integrated Jensen.

### T124: Shifted-gamma index mean

**Status: partial.** Recorded states: formula_proved, source_reviewed.

**Assessment:** accurate

**Delivered scope:** Corrected shifted-gamma rational excess identity and positivity within m^2>s^2.

**Recommended clarification:** Retain partial/formula-only; source text already separates the probability integral.

**Remaining target:** Gamma inverse-moment evaluation, mixture expectation and divergence at m^2<=s^2.

## Dependency-group position

Groups are the original ledger categories. CDF contains the newly closed generic extrema-law family; EVT contains the still-partial named-measure family. Remaining formal means reuse, missing and source-check rows together. Counts are not weighted by effort.

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
| EVT | 4 | 0 | 1 | 1 | 3 | 0 |
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

The source-check column is a subset of remaining formal, not an additional category.

## Full 158-family index

Rows outside the eleven supported families are tallied here without a new full-family mathematical audit. Source locators are the release's recorded anchors. T060's exact maximum identity is Eq. (9.1), printed p.172 / PDF186; p.173 / PDF187 contains the EVT formulas.

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
| T061 | 9 | partial | EVT | P1 | GEV families as probability measures | 172-173 |
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

1. Apply/review the small runner CLI patch and clarify the ledger delivery scopes. Preserve the existing status counts.
2. T061: complete Gumbel, Fréchet and reverse-Weibull construction children, including probability normalization and global CDF identities, then the recorded location/scale wrappers and concrete max-stability instantiations.
3. T029: prove the finite log-tail exponent of nonnegative weighted sums by event inclusions. Exact convolution asymptotics remain separate.
4. Exact Pareto survival, moments, divergence, excess and power pushforwards, using the existing Mathlib distribution. Credit the appropriate child slices without automatically closing broader parents.

See the independent audit for the T060 discharge reasoning, verifier findings, provenance and source limits. The evidence package includes the pinned T061 API note and optional runner repair.
