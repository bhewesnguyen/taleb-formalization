# Taleb proof progress, v0.2.8

Independent assessment, 21 September 2026. The companion JSON preserves every received field of all 158 families and adds audited scopes, source corrections, child obligations, and independent-execution evidence.

## Current position

Independent reproduction passed: clean build, 184 public checks, all 321 project constants within the allowed axioms, 18 schema/rendering probes and all 14 shipped regression fixtures. An additional real CRLF-only Markdown mutation was correctly rejected.

**Exact Pareto Stage A is accepted.** The pinned Mathlib law now has exact support, CDF/survival, integrability and moment results, including infinite extended moments at and above the shape threshold. T021 and T028 move to partial. T060 and T061 remain discharged.

| Status | Received families | Recommended families |
| --- | --- | --- |
| discharged | 2 | 2 |
| partial | 11 | 11 |
| reuse | 4 | 4 |
| missing | 90 | 90 |
| source-check | 33 | 33 |
| model-needed | 15 | 15 |
| empirical | 3 | 3 |

Thirteen families have credited Lean work, up from eleven. The received ledger has **146 family/declaration pairs over 142 distinct names**, up from 123/122. Cross-crediting the already proved Pareto moment identification to T118 would make that 147/142 without a new theorem, supported family or closure. Of 140 formal-proof families, two are closed and 138 remain open; the other 18 need models or empirical work. These are scope counts, not an effort-completion percentage or a census of independent book theorems.

Only T021, T028 and T029 changed in the JSON. The other 155 rows are identical to v0.2.7. The exact original rows are preserved in `ledger_rows`; recommendations are stored separately.

## Pareto milestone and the two scope decisions

Allowing every real moment order p below alpha is correct. With L > 0, the support is bounded away from zero, so negative powers introduce no singularity on the support. The finite moment is alpha*L^p/(alpha-p); p=0 gives one. For p >= alpha, the extended nonnegative integral is infinite. No totalized real-integral value is used to demonstrate finiteness.

T028 may accurately move from source-check to partial because a concrete exact-law child is now proved. The general regularly varying moment theorem and its source-review gate remain open. For positive alpha, the critical moment of a general tail t^(-alpha)*L(t) depends on the integral of L(t)/t: a constant L diverges, while L(t)=(log t)^(-2) sufficiently far into the tail gives convergence. Exact-Pareto boundary divergence is not a theorem about every regularly varying law. These are explanatory examples, not additional formalized results.

| Child | State | Scope |
| --- | --- | --- |
| Exact Pareto Stage A | complete | Pinned law, support and endpoint, global CDF/survival, all-real-order finite/divergent extended moments, integrability iff p < alpha, real/absolute moment formula in the integrable range, actual tail exponent. |
| Conditional threshold and excess law | open | For K >= L > 0 and alpha > 0, normalized restricted law above K equals Pareto(K,alpha), with global excess survival. Conditional-moment corollaries are optional follow-ons to the core law identities. This credits an exact-Pareto slice only. |
| Positive-power pushforward law | open | For q > 0, paretoMeasure L alpha mapped by x -> x^q equals paretoMeasure (L^q) (alpha/q). Include measurability, support and inverse-event identities; do not infer law equality from an exponent formula. |

T021 remains a broad multi-distribution family. Raw absolute moments E[|X|^p] are not the centered mean absolute deviation E[|X-E X|]. The Pareto MD/STD ratio needs the centered absolute-deviation integration as well as mean/variance and ratio algebra. Gaussian and Student moments also remain open.

## T029 scope and child obligations

The completed binary finite-log-exponent result retains its accepted scope: pointwise nonnegative coordinates, positive weights, finite real exponents, and no independence. The new theorem specializes its exponent premises to concrete Pareto marginal laws. It still assumes a common probability space and measurable pointwise nonnegative coordinates with those marginals; it does not export a joint realization theorem. That extra construction is not a retrospective acceptance condition for Stage A.

| Child | State | Scope and acceptance boundary |
| --- | --- | --- |
| Two-power-tail formula exponent | complete | Corrected negative-log convention; symmetric minimum of two finite exponents.  |
| Binary nonnegative weighted-sum finite exponent | complete | Pointwise nonnegative coordinates, positive weights, assumed finite real exponents, no independence, plus measurable pushforward version. Matches the preceding audit mathematical milestone. |
| Finite nonempty family exponent extension | open | Positive weights, finite real exponents, finite minimum; no independence. Source-level extension; prior v0.2.6 next-milestone guidance allowed it to follow the binary result. |
| Unequal-index regularly varying tail equivalence | open | For 0 <= alpha < beta (a positive-alpha first slice is acceptable), nonnegative measurable coordinates with regularly varying tails and a,b > 0, prove S_(aX+bY)(t)/S_X(t/a) -> 1, equivalently S_(aX+bY)(t)/S_X(t) -> a^alpha; no independence. Equal-index dependent tails require a different statement. Stronger than printed Property 5.1 exponent display and the agreed binary milestone. Inherited from original family wording, clarified explicitly rather than imposed as a new defect. |
| Almost-sure nonnegativity variant | open | Replace pointwise nonnegativity by almost-sure hypotheses and handle null-set event inclusions. Useful API extension, not a new prerequisite for accepting the delivered theorem. |
| Concrete Pareto marginal specialization | complete | Specified Pareto marginal laws discharge the finite-exponent premises; pointwise nonnegative measurable coordinates on a common probability space are still hypotheses. No independence. A joint sample-space realization is not claimed or imposed as a new acceptance gate. |
| Extended-real exponent API | open | Account for the source's informal infinite-exponent convention. Recorded future interface extension; not a missing premise of the finite-exponent theorem. |

The stronger unequal-index RV target remains `S_(aX+bY)(t)/S_X(t/a) -> 1`, equivalently `S_(aX+bY)(t)/S_X(t) -> a^alpha`. The weight belongs in the denominator or the limiting coefficient. Exponent equality alone does not imply this ratio or regular variation. Equal-index dependent tails require a different statement.

## Delivery facets

Facets describe scoped components and overlap. Their counts must not be added as completed work.

| Facet | Received count | Recommended count |
| --- | --- | --- |
| actual_law_constructed | 6 | 7 |
| conditional_law_theorem | 4 | 4 |
| discharged | 2 | 2 |
| formula_proved | 8 | 8 |
| law_theorem | 5 | 6 |
| source_reviewed | 9 | 9 |

The only recommended facet-count change is for T118: its existing formula-level tail-kernel convexity can now be accompanied by law_theorem and actual_law_constructed for the exact Pareto moment identification. This reuses the existing Mathlib probability law. T029 retains its conditional-law facet for the general exponent theorem and realization credit scoped to its concrete Pareto marginals.

## Completed EVT work and supplemental obligations

| T061 child | State |
| --- | --- |
| Standard Gumbel measure, exact CDF and instantiated/product-space maximum laws | complete |
| Standard Frechet measure for xi > 0, exact CDF and instantiated/product-space maximum laws | complete |
| Reverse-Weibull measure for alpha > 0 with upper endpoint 0, exact CDF and instantiated/product-space maximum laws | complete |
| Positive affine pushforwards, CDF transformation and all three location/scale maximum laws as equalities of measures | complete |

T060 covers independent maximum/minimum law identities. T061 covers the three separate EVT families and their location/scale maximum laws, not convergence to those laws. Global continuity of the guarded Frechet and reverse-Weibull CDFs is proved. The affine law definition allows any real scale; its CDF and maximum rules require positive scale.

| ID | State | Scope | Source |
| --- | --- | --- | --- |
| S001 | open | Unified GEV with explicit zero-shape Gumbel branch, probability CDFs, shape-to-zero limit and endpoint-coordinate reparameterization. | printed172-173/PDF186-187 |
| S002 | open | EVT density derivatives on open supports and withDensity identifications. | CDF forms printed173/PDF187; densities are derived work. |

S001 now has the explicit zero-shape Gumbel branch, correct off-support values and correct source pages. The unified endpoint is m-s/xi, with positive separate-family scales s/xi for positive xi and -s/xi for negative xi. S001 and S002 remain outside the fixed 158 families and do not reopen T061. Normalized-maxima convergence remains T011/T062; for Pareto shape alpha the proposed limit is frechetMeasure (1/alpha) under normalization M_n/(L*n^(1/alpha)).

## Documentation corrections

| Finding | Priority | Correction |
| --- | --- | --- |
| D028-1 | low | Cross-credit AuditPareto.integral_rpow_paretoMeasure to T118 and describe the exact Pareto moment identification as complete. Add law_theorem and actual_law_constructed for that scoped prerequisite, keeping formula_proved for the earlier tail-kernel convexity. Update the source range to printed pp. 381-382 / PDF pp. 395-396, citing Proposition 21.1 and Eq. (21.7). Leave moment-function convexity and integrated Jensen open and keep T118 partial. Regenerate both ledger files. |
| D028-2 | low | Cite printed p. 95 / PDF p. 109 for the constant-factor Pareto tail, printed pp. 96-97 / PDF pp. 110-111 for the slowly varying formulation and Definition 5.1, and printed p. 86 / PDF p. 100 for the exact Pareto density. The parent range 95-98 already contains the correct source page. |

For T118, Eq. (21.7) on printed p. 382 / PDF p. 396 is the exact moment formula now proved. Keep the future general-p convexity derivative as 2*p*L^p/(alpha-p)^3; the printed expression omits the factor p and replaces (alpha-p)^3 with (alpha-1)^3 while retaining L^p in the numerator. It coincides with the correct derivative at p=1. Jensen and mixing integrability remain open.

The v0.2.8 validation log now reports 18 probe results from its machine-readable record. The claimed annotation to the historical v0.2.7 deliverables index lies outside the supplied pre-deliverables bundle and remains unconfirmed from these files. This is a bounded provenance caveat, not a defect in the mathematics or the corrected new count.

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

### T021: Distribution-specific absolute moments

**Received status: partial. Recommended status: partial.**

**Received facets:** law_theorem, actual_law_constructed, source_reviewed.

**Recommended facets:** law_theorem, actual_law_constructed, source_reviewed.

**Delivered scope:** Exact pinned Pareto raw and absolute moments: extended integral finite with the closed formula for every real p < alpha, infinite for p >= alpha, integrability iff p < alpha, and zeroth moment one. L > 0 and alpha > 0. Negative orders are included correctly because the support is bounded away from zero.

**Recommendation:** Accept missing to partial. Retain the general Gaussian/Student and centered Pareto MD/STD work as open. Raw absolute moments are not centered mean absolute deviations.

**Remaining target:** Gaussian and Student absolute moments; Pareto mean/variance and the centered mean absolute deviation E[|X-E X|], then the MD/STD ratio; correct scale conventions. Raw E[|X|^p] does not itself compute centered MD.

### T028: Tail moment threshold

**Received status: partial. Recommended status: partial.**

**Received facets:** law_theorem, actual_law_constructed, source_reviewed.

**Recommended facets:** law_theorem, actual_law_constructed, source_reviewed.

**Delivered scope:** The actual pinned Pareto law has support at and above L, no endpoint atom, exact global CDF and strict survival, finite log-tail exponent alpha, and the finite/infinite moment threshold including divergence at p = alpha for this exact law.

**Recommendation:** Accept source-check to partial because a genuine reviewed exact-law child is proved; explicitly retain the general regularly varying statement-review gate. Correct the exact-tail source anchor from printed p. 97 to p. 95 (D028-2).

**Remaining target:** The general statement for nonnegative laws with regularly varying tails of index -alpha (finite for q < alpha, infinite for q > alpha) and its q = alpha boundary, which requires an integral test on the slowly varying factor (the statement-review gate is unchanged for that general case). Regular variation infrastructure (positive measurable convention, Karamata) is T001/T002.

### T029: Tail of sums with unequal indices

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved, conditional_law_theorem, law_theorem, actual_law_constructed, source_reviewed.

**Recommended facets:** formula_proved, conditional_law_theorem, law_theorem, actual_law_constructed, source_reviewed.

**Delivered scope:** Previously completed binary weighted-sum finite-exponent theorem and measurable pushforward version, now specialized to concrete pinned Pareto marginal laws. No independence. The general theorem assumes finite-exponent properties; the Pareto corollary discharges those properties from the actual marginal laws but assumes the joint P and pointwise nonnegative measurable X and Y with those marginals.

**Recommendation:** Retain partial. Accept the repaired conditional_law_theorem allocation and actual_law_constructed scoped to concrete Pareto marginal laws. Say specialization to concrete Pareto marginals when describing the new corollary; no explicit joint realization is proved. That extra realization is not a retrospective acceptance gate. The stronger unequal-index regularly varying ratio theorem remains open.

**Remaining target:** Stronger regular-variation child (the original target's reading, kept open deliberately): for measurable nonnegative X, Y on one probability space, a, b > 0, and eventually positive survival functions regularly varying with indices -alpha, -beta where 0 <= alpha < beta (a first version with 0 < alpha is acceptable), prove S_Z(t)/S_X(t/a) -> 1 and S_Z(t)/S_X(t) -> a^alpha for Z = aX + bY, via S_X(t/a) <= S_Z(t) <= S_X((1 - delta) t/a) + S_Y(delta t/b) and delta -> 0, no independence. Do not extend to equal-index dependent tails without new hypotheses (Y = X with Pareto index 2 gives S_(X+Y) = 4 t^(-2) against S_X + S_Y = 2 t^(-2)). Recorded follow-ups, not acceptance conditions of the delivered child: finite-family extension (nonempty index, positive weights), almost-sure-nonnegativity variant, extended-real exponent API for the source's informal infinite exponent. Exact convolution asymptotics belong to the subexponential workstream (T008).

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

**Recommended facets:** formula_proved, law_theorem, actual_law_constructed.

**Delivered scope:** The earlier tail-kernel convexity remains. In v0.2.8, AuditPareto.integral_rpow_paretoMeasure also supplies the exact moment identification needed here, even though T118 does not yet credit it. Convexity of alpha -> L^p alpha/(alpha-p) and the integrated Jensen step are not delivered.

**Recommendation:** Apply D028-1: cross-credit the existing exact Pareto moment theorem, update delivered/remaining text and facets, and retain partial. Do not reimplement the moment calculation.

**Remaining target:** For fixed p > 0 and L > 0, prove convexity of alpha -> L^p alpha/(alpha-p) on alpha > p, then justify Jensen under the stated random-index support and integrability or extended-expectation hypotheses. The general second derivative is 2*p*L^p/(alpha-p)^3; the printed expression omits the factor p and replaces (alpha-p)^3 with (alpha-1)^3 while retaining L^p in the numerator. It coincides with the correct derivative at p=1.

### T124: Shifted-gamma index mean

**Received status: partial. Recommended status: partial.**

**Received facets:** formula_proved, source_reviewed.

**Recommended facets:** formula_proved, source_reviewed.

**Delivered scope:** Corrected rational gamma-mixture excess expression and positivity, purely algebraic.

**Recommendation:** Retain partial. The gamma inverse moment, finiteness threshold and mixture expectation identity remain.

**Remaining target:** The inverse moment of the gamma law, its finiteness threshold, and the mixture expectation identity that produces the formula.

## Dependency-group position

Other open formal combines reuse, missing and source-check. The source-check column is a subset of that total. Partial families also retain work.

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
| MOM | 19 | 0 | 2 | 2 | 17 | 0 |
| MULTI | 4 | 0 | 0 | 0 | 3 | 1 |
| QUANT | 1 | 0 | 0 | 0 | 1 | 0 |
| RUIN | 3 | 0 | 0 | 0 | 3 | 0 |
| RV | 8 | 0 | 1 | 2 | 7 | 0 |
| SDE | 5 | 0 | 0 | 1 | 5 | 0 |
| SUBEXP | 5 | 0 | 2 | 1 | 3 | 0 |
| TAIL | 11 | 0 | 1 | 5 | 10 | 0 |

## Recommended next mathematics

Proceed to Pareto Stage B. For K >= L > 0, prove positivity of the tail mass and the normalized restricted-law equality with Pareto(K,alpha). The excess survival equals one below zero and (K/(K+y))^alpha for y >= 0. For alpha > 1, the conditional mean is alpha*K/(alpha-1) and mean excess K/(alpha-1); divergent cases require extended nonnegative integrals. Credit the exact-Pareto T005 slice only.

For positive q, prove the equality of pushforward measures Pareto(L,alpha).map(x -> x^q) = Pareto(L^q,alpha/q). Include measurability and the inverse-event argument on the positive support. This is the exact-Pareto T032 slice; a general power-law transformation target may remain. Centered T021 ratios, the stronger T029 RV child and later EVT convergence remain separately scoped.

## Full 158-family index

Unsupported rows are tallied without a new full-family mathematical audit. Source locators below are the received release anchors. All original row fields remain unchanged in the companion JSON; the two recommended corrections are recorded separately.

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
| T021 | 4 | partial | MOM | P1 | Distribution-specific absolute moments | 80-86 |
| T022 | 4 | missing | EST | P3 | Estimator efficiency comparison | 83 |
| T023 | 4 | source-check | GAMMA | P2 | Lp-ball volumes | 88-89 |
| T024 | 5 | missing | SUBEXP | P2 | One large jump and absent exponential moments | 91-93 |
| T025 | 5 | source-check | SUBEXP | P1 | Exponential boundary | 91-94 |
| T026 | 5 | missing | RV | P2 | Regular-variation uniform convergence | 95-98 |
| T027 | 5 | missing | RV | P2 | Potter bounds | 95-98 |
| T028 | 5 | partial | MOM | P1 | Tail moment threshold | 95-98 |
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

This records formalization scope. It does not establish upstream Mathlib acceptance, an exhaustive census of every source statement, or operational readiness of the separate quantum/classical application. A family with no credited declaration may have reusable dependencies; a partial family may contain a substantial completed child.
