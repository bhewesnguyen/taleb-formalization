# Taleb proof progress, v0.2.7

Independent assessment, 20 September 2026. The companion JSON preserves all 158 received family rows exactly and adds audited scopes, findings, child obligations and independent-execution evidence.

## Current position

Independent reproduction passed: clean build, 164 public checks, all 296 project constants within the allowed axioms, 18 schema/rendering probes and all 14 shipped regression fixtures. An additional real stale-Markdown mutation was correctly rejected.

**The binary weighted-sum milestone is accepted. T029 remains partial under its inherited broader target.** The new proof gives the minimum finite log-tail exponent of two nonnegative coordinates with positive weights, including the measurable pushforward version, without independence. It delivers the preceding audit's requested milestone. The stronger regular-variation tail equivalence remains separately open.

T060 and T061 remain discharged. The previous Markdown/JSON synchronization, continuity prose and EVT routing issues are repaired; the two support-correct EVT continuity statements are now proved too.

| Status | Received families | Recommended families |
| --- | --- | --- |
| discharged | 2 | 2 |
| partial | 9 | 9 |
| reuse | 4 | 4 |
| missing | 91 | 91 |
| source-check | 34 | 34 |
| model-needed | 15 | 15 |
| empirical | 3 | 3 |

Parent-family counts are unchanged from v0.2.6, while the delivered mathematical scope has increased. Eleven families have credited Lean work, with **123 family/declaration pairs over 122 distinct names**, up from 107/106. Of 140 formal-proof families, two are closed and 138 remain open. The other 18 require models or empirical work. These are scope counts, not percentages of effort completed or counts of independent book theorems.

Only T029, T060 and T061 changed in the JSON; the other 155 received rows are identical to v0.2.6. The JSON preserves received rows separately from audit recommendations. The sole shared declaration is `AuditGaussian.charFun_gaussianReal_eq_stableS1Expr`, credited to T007 and T046.

## T029 scope history and child obligations

The original v0.2.0 title was 'Tail of sums with unequal indices'; its target said the heavier regularly varying tail dominates a sum. The corrected source Property 5.1 on printed p. 99 / PDF p. 113 instead displays a finite-n exponent equality. The prior audit specifically requested the binary finite-exponent theorem and allowed the finite-family extension to follow. v0.2.7 meets that milestone. This historical scope ambiguity belongs to the shared audit and ledger history; it is not a new proof defect.

| Child | State | Scope and acceptance boundary |
| --- | --- | --- |
| Two-power-tail formula exponent | complete | Corrected negative-log convention; symmetric minimum of two finite exponents.  |
| Binary nonnegative weighted-sum finite exponent | complete | Pointwise nonnegative coordinates, positive weights, assumed finite real exponents, no independence, plus measurable pushforward version. Matches the preceding audit mathematical milestone. |
| Finite nonempty family exponent extension | open | Positive weights, finite real exponents, finite minimum; no independence. Source-level extension; prior v0.2.6 next-milestone guidance allowed it to follow the binary result. |
| Unequal-index regularly varying tail equivalence | open | For 0 < alpha < beta and nonnegative coordinates with regularly varying tails, prove S_(aX+bY)(t)/S_X(t/a) -> 1, hence regular variation of sum. No independence needed. Stronger than printed Property 5.1 exponent display and the agreed binary milestone. Inherited from original family wording, clarified explicitly rather than imposed as a new defect. |
| Almost-sure nonnegativity variant | open | Replace pointwise nonnegativity by almost-sure hypotheses and handle null-set event inclusions. Useful API extension, not a new prerequisite for accepting the delivered theorem. |

For strict unequal regularly varying tail indices `0 < alpha < beta`, the stronger target should explicitly say `P(aX + bY > t) / P(X > t/a) -> 1`. The heavier tail is weighted: relative to `P(X > t)`, the limiting factor is `a^alpha`. Exponent equality alone does not prove this ratio or regular variation. Keep the inherited stronger target open, or preserve it elsewhere through an explicit versioned scope decision before changing the parent status.

Finite-family and almost-sure variants are useful extensions, not newly failed release gates. The source's informal infinite-exponent convention is outside the delivered finite-real interface. No existing family explicitly owns an extended-real exponent API, so this is recorded as a scope limitation without invented routing or a retrospective acceptance requirement.

## Delivery facets

Facets describe scoped components and overlap; their counts must not be added as completed work.

| Facet | Received count | Recommended count |
| --- | --- | --- |
| actual_law_constructed | 3 | 3 |
| conditional_law_theorem | 3 | 4 |
| discharged | 2 | 2 |
| formula_proved | 8 | 8 |
| law_theorem | 3 | 3 |
| source_reviewed | 7 | 7 |

Add `conditional_law_theorem` to T029 for the weighted-sum theorem, whose marginal finite exponents are hypotheses. Its `law_theorem` facet may remain if explicitly assigned to the generic `survivalRV_eq_survival_map` identity, which has ordinary measurability hypotheses. This is bookkeeping under the existing glossary, not a reduction in mathematical credit or a demand for new realization proofs.

## Completed T061 children

| Child | State |
| --- | --- |
| Standard Gumbel measure, exact CDF and instantiated/product-space maximum laws | complete |
| Standard Frechet measure for xi > 0, exact CDF and instantiated/product-space maximum laws | complete |
| Reverse-Weibull measure for alpha > 0 with upper endpoint 0, exact CDF and instantiated/product-space maximum laws | complete |
| Positive affine pushforwards, CDF transformation and all three location/scale maximum laws as equalities of measures | complete |

Global continuity of the guarded Frechet and reverse-Weibull CDFs under positive shapes is separately exported in v0.2.7. The unguarded totalized-power formula's endpoint issue does not apply to those CDFs. The affine law definition and probability instance allow any real scale; the CDF and maximum rules require positive scale.

## Supplemental open EVT obligations

These are separate from the fixed 158-family count and do not reopen T061.

| ID | State | Scope | Source |
| --- | --- | --- | --- |
| S001 | open | Unified GEV with explicit zero-shape Gumbel branch, probability CDFs, shape-to-zero limit and endpoint-coordinate reparameterization. | printed172-173/PDF186-187 |
| S002 | open | EVT density derivatives on open supports and withDensity identifications. | CDF forms printed173/PDF187; densities are derived work. |

S001 must explicitly define the zero-shape branch as `gumbelCDF`; the power expression is for nonzero shape. Its source anchor is printed pp. 172-173 / PDF pp. 186-187. In unified location/scale coordinates, the support endpoint is `mu - sigma/xi`; the separate-family scale is `sigma/xi` for positive xi and `-sigma/xi` for negative xi. Preserve this reparameterization.

Normalized-maxima convergence remains under T011 for the general setup and T062 for the regular-variation/Frechet and Gaussian/Gumbel cases. For exact Pareto tail exponent alpha and lower endpoint L, the proposed limit is `frechetMeasure (1/alpha)` with normalization `M_n/(L*n^(1/alpha))`.

## Documentation corrections for the next handoff

| Finding | Priority | Correction |
| --- | --- | --- |
| D027-1 | low | Replace the stale sentence with exact delivered/remaining scopes and add conditional_law_theorem for the weighted-sum exponent theorem. law_theorem can remain explicitly for the generic survivalRV_eq_survival_map identity. Keep binary milestone complete and parent partial unless a documented versioned scope decision preserves the stronger target elsewhere. |
| D027-2 | low | Define G_0 as gumbelCDF, guard the power expression with xi != 0, specify lower/upper support branches by sign, and use printed pp.172-173 / PDF186-187. Retain endpoint-coordinate reparameterization. |
| D027-3 | low | Correct or visibly annotate the supplied archive-validation summary from 17 to 18 probes. Preserve historical evidence or mark its correction; no extra Lean fixture is required. |

## Audited supported families

### T001: Regular variation API

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved, source_reviewed.

**Recommended facets:** formula_proved, source_reviewed.

**Delivered scope:** Ratio-only regular/slow variation API, examples and closure rules. The negative-constant diagnostic explicitly separates this from the positive measurable convention.

**Recommendation:** Retain partial. Positivity/measurability remain; Karamata, uniform convergence and Potter bounds belong to other recorded families.

**Remaining target:** Positive measurable convention and its relationship to the ratio predicates. Uniform convergence, Potter bounds and Karamata are T026, T027 and T002.

### T007: Stable law existence

**Received status: partial. Recommended status: partial.**

**Received facets:** actual_law_constructed, source_reviewed.

**Recommended facets:** actual_law_constructed, source_reviewed.

**Delivered scope:** Gaussian realization of the S1 expression at alpha = 2, including zero scale, by reusing Mathlib's actual Gaussian law.

**Recommendation:** Retain partial. No alpha < 2 existence theorem is delivered; reuse is correctly disclosed.

**Remaining target:** Existence of a probability law with the S1 characteristic function for every 0 < alpha < 2, including alpha = 1 with beta != 0, and the zero-scale Dirac case for those alpha.

### T008: Subexponential law API

**Received status: partial. Recommended status: partial.**

**Received facets:** conditional_law_theorem.

**Recommended facets:** conditional_law_theorem.

**Delivered scope:** A probability-level subexponential predicate and preservation of an assumed finite log-tail exponent under self-convolution.

**Recommendation:** Retain partial. Concrete examples, the n-fold characterization and standard-definition equivalences remain. The revised conditional-law legend now covers these property premises.

**Remaining target:** Any concrete subexponential law, the equivalent n-fold tail characterizations, equivalence with the standard definition, and whether subexponential laws must have a finite exponent.

### T029: Tail of sums with unequal indices

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved, law_theorem, source_reviewed.

**Recommended facets:** formula_proved, conditional_law_theorem, law_theorem, source_reviewed.

**Delivered scope:** Formula-level two-power-tail minimum exponent plus general analytic rescaling, maximum, addition and squeeze rules. Actual binary weighted-sum survival exponent and measurable pushforward version for pointwise nonnegative coordinates, positive weights and assumed finite log-tail exponents, without independence.

**Recommendation:** Retain partial and mark the agreed binary exponent milestone complete. Fix the stale sentence; add conditional_law_theorem for the exponent theorem. law_theorem may remain only if explicitly assigned to survivalRV_eq_survival_map. Record stronger inherited RV tail equivalence separately. Finite-family and almost-sure variants are extensions, not newly failed release gates.

**Remaining target:** Finite-family finite-exponent extension; separately inherited and now clarified unequal-index regular-variation tail equivalence with the weighted heavier tail; optional almost-sure nonnegativity variant. The printed infinite-exponent convention is outside the delivered interface and not made a new release gate.

### T032: Power transformation of a law

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved.

**Recommended facets:** formula_proved.

**Delivered scope:** Analytic power-composition tail exponent alpha/p, without a pushforward-law identification.

**Recommendation:** Retain partial. Measurability, the inverse event and actual transformed law remain.

**Remaining target:** Measurable pushforward under x -> x^p for nonnegative x and p > 0, the inverse-event identity and identification of the transformed law.

### T046: Stable characteristic function specializations

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved, actual_law_constructed, source_reviewed.

**Recommended facets:** formula_proved, actual_law_constructed, source_reviewed.

**Delivered scope:** Gaussian law and instantiated stable convolution bridge; Cauchy expression specialization remains formula-level.

**Recommendation:** Retain partial. A Cauchy law/characteristic-function identification is still required. Adding law_theorem for the proved Gaussian convolution equality would be optional conservative bookkeeping, not additional mathematics.

**Remaining target:** A Cauchy probability law with its characteristic function (none in the pinned Mathlib), nonnegative scale including Dirac, and its instantiation of the bridge.

### T047: Stable sample averages

**Received status: partial. Recommended status: partial.**

**Received facets:** conditional_law_theorem.

**Recommended facets:** conditional_law_theorem.

**Delivered scope:** Conditional stable sum/convolution infrastructure only, now explicitly labeled prerequisite only.

**Recommendation:** Retain partial. Sample-average pushforwards, the n^(1/alpha-1) scale, alpha = 1 skew-location correction and finite-mean convergence remain.

**Remaining target:** Pushforward under division by n, the average scale n^(1/alpha - 1), the alpha = 1 skew-location correction under rescaling, and finite-mean convergence.

### T060: Distribution of iid maxima

**Received status: discharged. Recommended status: discharged.**

**Received facets:** formula_proved, law_theorem, source_reviewed, discharged.

**Recommended facets:** formula_proved, law_theorem, source_reviewed, discharged.

**Delivered scope:** Actual measurable maximum/minimum laws for independent coordinates with a common law on a finite nonempty index type, plus all four event threshold conventions. Future density work is now correctly routed to supplemental S002, not T062.

**Recommendation:** Retain discharged. The generic extrema scope is unchanged; future density work is now correctly routed to supplemental S002, and convergence to T011/T062.

**Remaining target:** None within the family. Named EVT laws are T061 (discharged in v0.2.6). Domains of attraction are T011 (general formulation) and T062 (Frechet via regular variation, Gaussian/Gumbel normalisers). Density identifications of the EVT laws are supplemental obligation S002 (docs/SUPPLEMENTAL_OBLIGATIONS.md), not T062 as earlier text said.

### T061: GEV families as probability measures

**Received status: discharged. Recommended status: discharged.**

**Received facets:** formula_proved, conditional_law_theorem, law_theorem, actual_law_constructed, source_reviewed, discharged.

**Recommended facets:** formula_proved, conditional_law_theorem, law_theorem, actual_law_constructed, source_reviewed, discharged.

**Delivered scope:** All three support-correct standard EVT probability laws, exact CDF identities, law-instantiated maxima and finite-product iid realizations; positive affine CDF rule and all three location/scale maximum laws as equalities of measures. Global continuity of the support-correct Frechet and reverse-Weibull CDFs for positive shapes is now separately proved.

**Recommendation:** Retain discharged. S001 unified GEV and S002 densities remain supplemental; fix the literal S001 zero-shape specification without reopening T061.

**Remaining target:** None within the three-family construction and positive location/scale scope. S001 unified GEV, S002 densities and normalized-maxima convergence under T011/T062 remain separate.

### T118: Moment convexity in Pareto exponent

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved.

**Recommended facets:** formula_proved.

**Delivered scope:** Convexity of alpha -> c^(-alpha) only, now explicitly separated from the Pareto moment formula, its convexity and Jensen.

**Recommendation:** Retain partial under the ledger's prerequisite-credit convention. The actual moment-convexity target is still open; p > 0 and positive scale are already recorded in the hypotheses.

**Remaining target:** Identify E[X^p] = scale^p alpha/(alpha - p) for alpha > p, prove its convexity in alpha, and justify Jensen with the mixing support and integrability assumptions.

### T124: Shifted-gamma index mean

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved, source_reviewed.

**Recommended facets:** formula_proved, source_reviewed.

**Delivered scope:** Corrected rational gamma-mixture excess expression and positivity, purely algebraic.

**Recommendation:** Retain partial. The gamma inverse moment, finiteness threshold and mixture expectation identity remain.

**Remaining target:** The inverse moment of the gamma law, its finiteness threshold, and the mixture expectation identity that produces the formula.

## Dependency-group position

Other open formal combines reuse, missing and source-check. The source-check column is a subset of that total, not an additional category. Partial families have remaining work too.

| Group | Families | Discharged | Partial | Source-check subset | Other open formal | Model / empirical |
| --- | --- | --- | --- | --- | --- | --- |
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

## Recommended next mathematics

Proceed to the exact Pareto slice against the pinned `paretoMeasure`: global CDF and survival, moments finite exactly below the shape threshold, divergence via extended nonnegative integrals, threshold excess and positive-power pushforward. Credit only the delivered portions of T005/T021/T028/T032. The generic affine layer supplies pushforward and positive-scale CDF infrastructure, not integration or conditioning proofs.

Finite-family and almost-sure versions of T029 can follow as contained extensions. The stronger unequal-index RV theorem needs an explicit weighted-tail statement. Later EVT work should keep S001/S002 separate from T011/T062 convergence.

## Full 158-family index

Unsupported rows are tallied without a new full-family mathematical audit. Source locators below are the received release anchors. All original row fields, including the stale T029 sentence, remain unchanged in the JSON's `ledger_rows`; recommendations are stored separately.

| ID | Unit | Received status | Group | Priority | Family | Printed pages |
| --- | --- | --- | --- | --- | --- | --- |
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

## Interpretation limits

This ledger measures recorded formalization scope. It does not establish upstream Mathlib acceptance, an exhaustive census of every source statement, or operational readiness of the separate quantum/classical application. A valid conditional theorem is useful progress; its hypotheses and the parent family's remaining targets still need to be read explicitly.
