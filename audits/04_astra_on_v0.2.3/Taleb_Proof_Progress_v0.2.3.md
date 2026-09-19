# Taleb proof implementation ledger: v0.2.3 audit companion

19 September 2026. Preserves all 158 family IDs and the supplied status values. The JSON companion contains the full source targets, hypotheses, provenance and proof-support mappings. No received project file was changed.

## What the totals mean

**0 families fully discharged; 10 marked partial; 148 in other open categories.** The original 16 replacement entry points are checked Lean aliases, not 16 completed book families. The 64 theorem declarations include helpers, variants and diagnostics. The 158 scanned Lean constants and the 158 ledger families are unrelated counts.

| Shipped status | Families | Meaning |
|---|---:|---|
| partial | 10 | Some useful project proof or definition exists; the entire family is open. No fractional completion weight is assigned. |
| reuse | 4 | Mathlib infrastructure is identified; application-specific instantiation and possibly additional lemmas are open. |
| missing | 92 | The family remains unimplemented as a whole. Dependencies may already exist. |
| source-check | 34 | The precise mathematical statement must be reviewed or repaired before coding; this does not mean every flagged statement is false. |
| model-needed | 15 | A precise model or decision problem must be supplied before a formal proposition can be fixed. |
| empirical | 3 | Data provenance, reproduction and uncertainty work are required alongside any formal mathematics. |

**Bookkeeping recommendation:** T007 should record its new Gaussian existence slice as partial. If adopted, the tally becomes 11 partial and 91 missing; every other count stays unchanged and no family becomes fully complete. The tables below retain the supplied counts so this recommendation is not silently applied.

10/158 = 6.3% is the share of families labelled partial, not the fraction of the book proved. The proof-oriented working set has 140 families; 18 others are model/data tasks. No defensible effort-weighted completion percentage is available.

## Change since the previous milestone

| Release | Partial | Reuse | Missing | Source check | Model | Empirical |
|---|---:|---:|---:|---:|---:|---:|
| v0.2.0 | 8 | 4 | 95 | 33 | 15 | 3 |
| v0.2.1 | 8 | 4 | 94 | 34 | 15 | 3 |
| v0.2.2 | 8 | 4 | 93 | 35 | 15 | 3 |
| v0.2.3 | 10 | 4 | 92 | 34 | 15 | 3 |

v0.2.3 adds 12 theorem declarations and 3 definitions. T029 moves source-check -> partial; T060 moves missing -> partial; T046 remains partial but gains its actual Gaussian-law half. T093 was moved missing -> source-check in v0.2.2. Source-check counts measure outstanding statement review, not a count of certified book errors.

## What each partially supported family still needs

| ID | Delivered support | Boundary still to cross |
|---|---|---|
| T001 | Ratio-limit definitions, examples and closure lemmas exist. The negative-one example establishes that these predicates alone do not imply positivity. | Add the positive measurable convention and its precise relationship to the ratio-only predicates; preserve the weak interface explicitly. |
| T007 (status correction proposed) | Actual Gaussian measures realize the S1 expression at alpha=2, including zero scale and arbitrary beta in the characteristic-function identity. The general family remains open. | Record the Gaussian existence slice, then construct admissible non-Gaussian S1 laws and prove their characteristic functions, including the alpha=1 branch and degenerate cases. |
| T008 | A nonnegative-law self-convolution predicate and preservation of a finite exponent are proved under that predicate. | Supply concrete subexponential laws and the standard fixed-n equivalent tail characterizations; a definition plus an assumed asymptotic does not discharge these. |
| T029 | The corrected two-power formula has the smaller finite logarithmic exponent. This is not yet a theorem about the law of a weighted sum. | Prove the finite logarithmic tail index of finite positive-weight sums of nonnegative random variables by event inclusions and a limit squeeze. Do not replace this target with asymptotic tail equivalence, which requires stronger assumptions. |
| T032 | The explicit transformed Pareto tail formula has index alpha/p. | Prove the measurable pushforward and the event identity for X^p, with X nonnegative and p>0, then connect the actual law to its transformed tail. |
| T046 | The Gaussian law and convolution specialization are complete slices. The Cauchy side is still an expression specialization without a constructed Cauchy probability law. | Construct or reuse a Cauchy law with its characteristic-function theorem, handle nonnegative scale including the Dirac case, and instantiate the existing bridge. |
| T047 | Convolution powers and conditional stable sums are available; the Gaussian convolution is concrete. The full sample-average law and finite-mean convergence have not been delivered. | Prove the pushforward under division by positive n, the scale n^(1/alpha-1), the alpha=1 skew location correction under rescaling, and the finite-mean convergence statement. |
| T060 | Independent maximum-threshold events have the product and common-CDF power formulas. Frechet/Gumbel specializations assume the coordinate CDFs. | Add the independent-minimum strict-survival product and common-tail power identities. State the finite nonempty index and strict/non-strict conventions so atoms are handled. Generic max/min identities do not depend on constructing specific EVT measures. |
| T061 | Global Frechet/Gumbel formulas and max-stability identities are present. No Frechet, Gumbel or reverse-Weibull probability measure has been constructed in this project. | Construct all three named families using Stieltjes measures, with monotonicity, right continuity, endpoint limits, mass one, support and CDF identification; specify location/positive-scale transformations. Instantiate independent coordinate laws. Frechet/Gumbel alone leave reverse-Weibull open. |
| T118 | The available lemma proves convexity of alpha -> c^(-alpha). It is related infrastructure, not the rational moment formula or its Jensen inequality. | Identify the actual Pareto pth moment for alpha>p, prove convexity of scale^p*alpha/(alpha-p), and justify Jensen with the mixing support and integrability assumptions. |
| T124 | The corrected rational excess formula and its positivity are proved algebraically. | Prove the inverse moment of the specified gamma law, its finite-moment condition, and the mixture expectation identity that supplies the algebraic formula. |

## Dependency-group coverage

Every group has zero fully discharged families. These are counts of primary family assignments; a theorem can support more than one family.

| Group | Total | Partial | Reuse | Missing | Review | Model/data |
|---|---:|---:|---:|---:|---:|---:|
| APP: Applications and data | 8 | 0 | 0 | 0 | 0 | 8 |
| CALC: Calculus and convexity | 4 | 1 | 0 | 3 | 0 | 0 |
| CDF: Distribution functions | 5 | 1 | 0 | 3 | 1 | 0 |
| CF: Characteristic functions and stable laws | 5 | 2 | 0 | 2 | 1 | 0 |
| CLT: Central and stable limit theory | 8 | 0 | 0 | 6 | 2 | 0 |
| DENS: Distribution densities | 8 | 0 | 0 | 7 | 1 | 0 |
| ENT: Entropy | 10 | 0 | 0 | 8 | 2 | 0 |
| EST: Statistical estimation | 13 | 0 | 0 | 6 | 3 | 4 |
| EVT: Extreme-value theory | 4 | 1 | 0 | 2 | 1 | 0 |
| FIN: Pricing and finance | 14 | 0 | 0 | 5 | 4 | 5 |
| GAMMA: Gamma and beta integrals | 2 | 1 | 0 | 0 | 1 | 0 |
| GINI: Gini and concentration | 10 | 0 | 0 | 6 | 4 | 0 |
| KAPPA: Kappa and sample-size metrics | 8 | 0 | 0 | 6 | 2 | 0 |
| LLN: Laws of large numbers | 3 | 0 | 2 | 1 | 0 | 0 |
| MOM: Moments and mixtures | 19 | 0 | 2 | 14 | 3 | 0 |
| MULTI: Multivariate laws and dependence | 4 | 0 | 0 | 3 | 0 | 1 |
| QUANT: Quantiles | 1 | 0 | 0 | 1 | 0 | 0 |
| RUIN: Survival and ruin | 3 | 0 | 0 | 3 | 0 | 0 |
| RV: Regular variation | 8 | 1 | 0 | 5 | 2 | 0 |
| SDE: Stochastic processes | 5 | 0 | 0 | 4 | 1 | 0 |
| SUBEXP: Subexponential tails | 5 | 2 | 0 | 2 | 1 | 0 |
| TAIL: Tail integrals and transformations | 11 | 1 | 0 | 5 | 5 | 0 |

## Chapter and lettered-unit coverage

All 39 units are indexed. Chapter 1 has no obligation row; indexing a unit does not certify its mathematics.

| Unit | Families | Partial | Reuse | Missing | Review | Model/data |
|---|---:|---:|---:|---:|---:|---:|
| 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 2 | 12 | 2 | 1 | 7 | 2 | 0 |
| 3 | 2 | 0 | 0 | 1 | 0 | 1 |
| 4 | 9 | 0 | 1 | 7 | 1 | 0 |
| 5 | 11 | 2 | 0 | 5 | 3 | 1 |
| 6 | 5 | 0 | 0 | 3 | 0 | 2 |
| A | 2 | 0 | 0 | 2 | 0 | 0 |
| B | 4 | 0 | 0 | 4 | 0 | 0 |
| 7 | 7 | 2 | 1 | 3 | 1 | 0 |
| 8 | 7 | 0 | 0 | 5 | 2 | 0 |
| 9 | 6 | 2 | 0 | 3 | 1 | 0 |
| C | 1 | 0 | 0 | 0 | 1 | 0 |
| D | 1 | 0 | 0 | 1 | 0 | 0 |
| E | 2 | 0 | 0 | 2 | 0 | 0 |
| 10 | 4 | 0 | 0 | 2 | 1 | 1 |
| F | 1 | 0 | 0 | 0 | 0 | 1 |
| G | 1 | 0 | 0 | 0 | 0 | 1 |
| 11 | 8 | 0 | 0 | 7 | 1 | 0 |
| 12 | 1 | 0 | 0 | 0 | 0 | 1 |
| 13 | 2 | 0 | 0 | 2 | 0 | 0 |
| 14 | 4 | 0 | 0 | 3 | 1 | 0 |
| 15 | 8 | 0 | 0 | 4 | 4 | 0 |
| 16 | 4 | 0 | 0 | 2 | 2 | 0 |
| 17 | 3 | 0 | 0 | 3 | 0 | 0 |
| 18 | 3 | 0 | 0 | 1 | 0 | 2 |
| H | 1 | 0 | 0 | 0 | 0 | 1 |
| 19 | 1 | 0 | 0 | 0 | 0 | 1 |
| 20 | 6 | 0 | 0 | 4 | 2 | 0 |
| 21 | 9 | 2 | 0 | 4 | 3 | 0 |
| 22 | 4 | 0 | 0 | 1 | 3 | 0 |
| I | 1 | 0 | 0 | 0 | 0 | 1 |
| 23 | 3 | 0 | 0 | 3 | 0 | 0 |
| 24 | 1 | 0 | 0 | 0 | 0 | 1 |
| 25 | 4 | 0 | 0 | 1 | 2 | 1 |
| 26 | 2 | 0 | 0 | 1 | 0 | 1 |
| 27 | 5 | 0 | 0 | 3 | 2 | 0 |
| 28 | 3 | 0 | 1 | 1 | 0 | 1 |
| 29 | 2 | 0 | 0 | 1 | 0 | 1 |
| 30 | 8 | 0 | 0 | 6 | 2 | 0 |

## Full 158-family register

Status below means supplied status. See the JSON for each complete target, assumptions and recommended acceptance boundary.

Priority: P0 = repair the statement first (12 families); P1 = a contained reusable family once prerequisites are available (58); P2 = substantial theory/dependency work (57); P3 = advanced application, model or empirical work (31). These labels are not time estimates. Every source-check row needs statement review regardless of priority.

| ID | Unit | Group | Priority | Status | Family |
|---|---|---|---|---|---|
| T001 | 2 | RV | P1 | partial | Regular variation API |
| T002 | 2 | RV | P2 | missing | Karamata representation |
| T003 | 2 | LLN | P1 | reuse | Weak and strong laws |
| T004 | 2 | CLT | P2 | missing | Central limit theorem |
| T005 | 2 | TAIL | P1 | missing | Tail integral and excess identities |
| T006 | 2 | KAPPA | P1 | missing | Kappa metric domain |
| T007 | 2 | CF | P2 | missing | Stable law existence |
| T008 | 2 | SUBEXP | P2 | partial | Subexponential law API |
| T009 | 2 | QUANT | P1 | missing | Quantiles and expected shortfall |
| T010 | 2 | LLN | P2 | missing | Maximum divided by sum |
| T011 | 2 | EVT | P1 | source-check | Maximum domain of attraction |
| T012 | 2 | TAIL | P1 | source-check | Payoff versus indicator |
| T013 | 3 | APP | P3 | model-needed | Overview and illustrative calculations |
| T014 | 3 | RUIN | P1 | missing | Multiplicative survival and ruin |
| T015 | 4 | MOM | P1 | missing | Gaussian scale mixture normalization |
| T016 | 4 | MOM | P1 | missing | Variance-preserving fattening |
| T017 | 4 | DENS | P3 | missing | Gamma mixture density |
| T018 | 4 | DENS | P2 | missing | Precision mixture and Student law |
| T019 | 4 | CALC | P1 | missing | Crossovers of perturbed Gaussian densities |
| T020 | 4 | MOM | P1 | reuse | Moment and norm comparisons |
| T021 | 4 | MOM | P1 | missing | Distribution-specific absolute moments |
| T022 | 4 | EST | P3 | missing | Estimator efficiency comparison |
| T023 | 4 | GAMMA | P2 | source-check | Lp-ball volumes |
| T024 | 5 | SUBEXP | P2 | missing | One large jump and absent exponential moments |
| T025 | 5 | SUBEXP | P1 | source-check | Exponential boundary |
| T026 | 5 | RV | P2 | missing | Regular-variation uniform convergence |
| T027 | 5 | RV | P2 | missing | Potter bounds |
| T028 | 5 | MOM | P1 | source-check | Tail moment threshold |
| T029 | 5 | SUBEXP | P2 | partial | Tail of sums with unequal indices |
| T030 | 5 | DENS | P1 | missing | Product of exact Pareto laws |
| T031 | 5 | RV | P2 | source-check | Breiman product theorem |
| T032 | 5 | TAIL | P1 | partial | Power transformation of a law |
| T033 | 5 | DENS | P2 | missing | Bell shape, interpolation, and log-Pareto |
| T034 | 5 | APP | P3 | model-needed | Stochastic-volatility interpretations |
| T035 | 6 | MULTI | P2 | missing | Elliptical and multivariate Student laws |
| T036 | 6 | MULTI | P1 | missing | Uncorrelated versus independent |
| T037 | 6 | ENT | P3 | missing | Student mutual information |
| T038 | 6 | MULTI | P3 | model-needed | Random matrices and undefined correlation |
| T039 | 6 | EST | P3 | model-needed | Regression with fat-tailed residuals |
| T040 | A | DENS | P1 | missing | Mixture multimodality |
| T041 | A | RUIN | P2 | missing | Eventual transition or failure |
| T042 | B | ENT | P2 | missing | Gaussian maximum entropy |
| T043 | B | ENT | P2 | missing | Pareto maximum entropy |
| T044 | B | CDF | P1 | missing | Uniform maximum entropy and probability integral transform |
| T045 | B | ENT | P3 | missing | Tsallis entropy |
| T046 | 7 | CF | P1 | partial | Stable characteristic function specializations |
| T047 | 7 | CF | P2 | partial | Stable sample averages |
| T048 | 7 | DENS | P2 | missing | Explicit finite-sum laws |
| T049 | 7 | MOM | P1 | missing | Cumulant scaling |
| T050 | 7 | CLT | P2 | missing | Lyapunov implies Lindeberg |
| T051 | 7 | LLN | P1 | reuse | LLN for powers and MS plots |
| T052 | 7 | CF | P2 | source-check | Stable mean absolute deviation |
| T053 | 8 | KAPPA | P1 | source-check | Kappa algebra and telescoping |
| T054 | 8 | KAPPA | P1 | missing | Stable kappa and sample equivalence |
| T055 | 8 | KAPPA | P1 | source-check | Kappa bounds and non-universality |
| T056 | 8 | KAPPA | P2 | missing | Cubic Student summed MAD |
| T057 | 8 | KAPPA | P2 | missing | Lognormal sum bounds |
| T058 | 8 | KAPPA | P1 | missing | Exponential summed MAD |
| T059 | 8 | KAPPA | P1 | missing | Negative kappa examples |
| T060 | 9 | CDF | P1 | partial | Distribution of iid maxima |
| T061 | 9 | EVT | P1 | partial | GEV families as probability measures |
| T062 | 9 | EVT | P2 | missing | Frechet and Gaussian maximum domains |
| T063 | 9 | EVT | P2 | missing | Pickands-Balkema-de Haan |
| T064 | 9 | TAIL | P1 | source-check | Hidden moment law |
| T065 | 9 | CLT | P2 | missing | Empirical CDF versus tail payoff |
| T066 | C | DENS | P1 | source-check | Log of a Pareto variable |
| T067 | D | CLT | P2 | missing | Large deviation principle |
| T068 | E | EST | P1 | missing | Pareto MLE and log transform |
| T069 | E | EST | P2 | missing | Tail-exponent sampling law |
| T070 | 10 | APP | P3 | empirical | SP500 empirical claims |
| T071 | 10 | MOM | P2 | missing | Aggregation and drawdown statistics |
| T072 | 10 | TAIL | P1 | source-check | Relative excess normalization |
| T073 | 10 | CDF | P1 | missing | Record counts and asymmetric tails |
| T074 | F | EST | P3 | model-needed | Risk estimator performance |
| T075 | G | EST | P3 | model-needed | Learning losses and angular calibration |
| T076 | 11 | TAIL | P1 | missing | Binary and unbounded payoff interfaces |
| T077 | 11 | RV | P2 | missing | Payoff-to-binary tail ratios |
| T078 | 11 | TAIL | P1 | missing | Gaussian tail integral and Mills ratio |
| T079 | 11 | TAIL | P1 | source-check | Adjusted payoff-equivalent probability |
| T080 | 11 | EST | P2 | missing | Calibration versus payoff calibration |
| T081 | 11 | MOM | P1 | missing | Bounded Brier score moments |
| T082 | 11 | EST | P3 | missing | Score distribution transforms |
| T083 | 11 | TAIL | P1 | missing | Nonlinear loss moments |
| T084 | 12 | APP | P3 | model-needed | Single forecasts and asymmetric decisions |
| T085 | 13 | MOM | P1 | missing | Beta uncertainty in quantiles |
| T086 | 13 | CALC | P1 | missing | Quantile sensitivity |
| T087 | 14 | SDE | P3 | missing | Gaussian digital payoff valuation |
| T088 | 14 | SDE | P0 | source-check | Sigmoid of a martingale |
| T089 | 14 | SDE | P3 | missing | Bounded dual diffusion |
| T090 | 14 | CDF | P2 | missing | Probability assessor and uniform forecast |
| T091 | 15 | GINI | P2 | missing | Population and sample Gini |
| T092 | 15 | GINI | P2 | missing | Order-statistic remainder |
| T093 | 15 | CLT | P2 | source-check | Stable domain of attraction |
| T094 | 15 | GINI | P3 | missing | Gini mean-deviation stable limit |
| T095 | 15 | GINI | P0 | source-check | Gini ratio stable limit |
| T096 | 15 | EST | P2 | source-check | Parametric Gini MLE limit |
| T097 | 15 | GINI | P2 | source-check | Pareto Gini estimator laws |
| T098 | 15 | GINI | P3 | missing | Finite-sample Gini correction |
| T099 | 16 | GINI | P1 | missing | Quantile-contribution estimator |
| T100 | 16 | GINI | P0 | source-check | Aggregation of concentration |
| T101 | 16 | GINI | P0 | source-check | Bias and consistency of threshold share |
| T102 | 16 | GINI | P3 | missing | Mixtures and concentration |
| T103 | 17 | CALC | P1 | missing | Dual bounded-to-unbounded transform |
| T104 | 17 | MOM | P2 | missing | Shadow density and moments |
| T105 | 17 | DENS | P2 | missing | Truncation versus transformation |
| T106 | 18 | APP | P3 | empirical | Conflict-data inference |
| T107 | 18 | TAIL | P2 | missing | Rescaling and conditional expectations |
| T108 | 18 | EST | P3 | model-needed | GPD inference and bootstrap |
| T109 | H | APP | P3 | model-needed | War-probability discussion |
| T110 | 19 | APP | P3 | empirical | Pandemic tail and shadow moments |
| T111 | 20 | MOM | P1 | missing | Recursive mixtures |
| T112 | 20 | MOM | P1 | missing | Constant-error moment products |
| T113 | 20 | MOM | P1 | missing | Absolute-moment invariance |
| T114 | 20 | CLT | P0 | source-check | Exploding moments versus limiting law |
| T115 | 20 | MOM | P2 | missing | Decaying-error infinite products |
| T116 | 20 | MOM | P1 | source-check | Additive error recursion |
| T117 | 21 | MOM | P1 | missing | Random-index mixture foundations |
| T118 | 21 | CALC | P1 | partial | Moment convexity in Pareto exponent |
| T119 | 21 | TAIL | P0 | source-check | Mixed expected shortfall |
| T120 | 21 | RV | P0 | source-check | Density and boundary normalization |
| T121 | 21 | SUBEXP | P2 | missing | Sums and stochastic indices |
| T122 | 21 | CF | P2 | missing | Asymmetric stable mixture |
| T123 | 21 | MOM | P0 | source-check | Shifted-lognormal index mean |
| T124 | 21 | GAMMA | P1 | partial | Shifted-gamma index mean |
| T125 | 21 | MOM | P2 | missing | Mixed bounded power law |
| T126 | 22 | EST | P0 | source-check | Finite-sample p-value density |
| T127 | 22 | EST | P2 | missing | Gaussian-limit p-value law |
| T128 | 22 | CDF | P1 | source-check | Minimum p-value law and expectation |
| T129 | 22 | EST | P3 | source-check | Power-of-test distribution |
| T130 | I | APP | P3 | model-needed | Loss-aversion examples |
| T131 | 23 | RUIN | P1 | missing | Survival, hazard and residual lifetime |
| T132 | 23 | SDE | P3 | missing | Brownian absorbing barrier |
| T133 | 23 | SDE | P3 | missing | Drifted barrier and Lindy interpretation |
| T134 | 24 | FIN | P3 | model-needed | Hedging-error decomposition |
| T135 | 25 | FIN | P2 | source-check | Call-price curve determines a marginal law |
| T136 | 25 | FIN | P2 | missing | Put/call law uniqueness |
| T137 | 25 | FIN | P0 | source-check | Forward mean is not measure uniqueness |
| T138 | 25 | FIN | P3 | model-needed | Physical versus pricing measure |
| T139 | 26 | FIN | P2 | missing | Static payoff formulas and hedging |
| T140 | 26 | FIN | P3 | model-needed | Limits of dynamic replication |
| T141 | 27 | FIN | P1 | source-check | Pareto call-price tail |
| T142 | 27 | RV | P1 | missing | Log return transforms |
| T143 | 27 | FIN | P1 | missing | Shifted Pareto relative calls |
| T144 | 27 | FIN | P0 | source-check | Put-price power law |
| T145 | 27 | FIN | P2 | missing | Splice no-arbitrage boundaries |
| T146 | 28 | MOM | P1 | reuse | Second versus fourth moment |
| T147 | 28 | FIN | P2 | missing | Jensen, insurance and numeraire |
| T148 | 28 | FIN | P3 | model-needed | Tail betting examples |
| T149 | 29 | MULTI | P2 | missing | Dependence beyond correlation |
| T150 | 29 | FIN | P3 | model-needed | Portfolio expected shortfall |
| T151 | 30 | ENT | P1 | missing | Tail constraint feasibility |
| T152 | 30 | ENT | P2 | missing | Gaussian tail constraint solution |
| T153 | 30 | CLT | P2 | missing | Two-normal small-variance limit |
| T154 | 30 | ENT | P2 | source-check | Entropy optimizer existence |
| T155 | 30 | ENT | P2 | missing | Piecewise-exponential maximum entropy |
| T156 | 30 | ENT | P0 | source-check | Absolute-moment entropy optimizer |
| T157 | 30 | ENT | P2 | missing | Power-tail maximum entropy |
| T158 | 30 | CLT | P2 | missing | Multi-period averages and stable/Gaussian limits |

## Rules for future milestones

- Retain stable family IDs. Add child obligations with an exact quantified statement, source anchor, dependencies, proof declaration, build/axiom evidence, and an explicit definition of done.
- Record separate states for formula proved, conditional law theorem, actual law constructed, source correspondence reviewed, and full family discharged. Use only the states that apply to a given task.
- Close a parent family only when all of its stated targets are satisfied. Adding helper lemmas or assuming the desired law does not close an existence task.
- Track Mathlib upstream review/merge separately from local Lean verification. No upstream acceptance is evidenced by this package.
- Track numerical software and the paper claim separately. This package contains no executable quantum/classical application or end-to-end software evidence.
- Reconcile all three counts each release: declarations, child obligations, and closed parent families. They answer different questions.

Inventory limit: the source catalog has 39 units, 353 bookmarks, 315 equation-locator occurrences and 71 heading candidates. These are locators, not a complete atomic list of all mathematics. New obligations may be discovered as each family is formalized.
