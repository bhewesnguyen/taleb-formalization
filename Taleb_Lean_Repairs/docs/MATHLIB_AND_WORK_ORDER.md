# Mathlib reuse and implementation order

The checked baseline is Mathlib v4.24.0 at commit f897ebcf72cd16f89ab4577d0c826cd14afaafc7. Exact module/declaration evidence below comes from its local source. A broad filename/text search is not a proof that no equivalent theorem exists. Recheck current upstream before proposing a contribution; do not migrate the working baseline during the first reproduction.

| Dependency group | Existing infrastructure in the pinned snapshot | Work that remains |
|---|---|---|
| RV | `Analysis/Asymptotics/AsymptoticEquivalent`, real-power continuity, filter limits | A coherent positive/measurable regular-variation API; uniform convergence, Potter bounds and Karamata. No dedicated named RV module was found in the scoped search. |
| TAIL, MOM | `MeasureTheory/Integral/Layercake`: `lintegral_eq_lintegral_meas_lt`, `Integrable.integral_eq_integral_meas_lt`; `Analysis/SpecialFunctions/Pow/Integral` | Threshold excess corollaries; exact Pareto moment integrals; index boundary cases. Reuse layer cake. |
| CF | `MeasureTheory/Measure/CharacteristicFunction`: `charFun_conv`, `Measure.ext_of_charFun`; `Probability/Independence/Basic`: `IndepFun.map_add_eq_map_conv_map₀` | Stable law existence and admissible parameter families. The new bridge already reuses the convolution and uniqueness results; since v0.2.3 its premises are shown satisfiable at alpha = 2 (`AuditGaussian.convolutionPower_gaussianReal_scale`). Existence for alpha < 2 remains open. |
| Gaussian | `Probability/Distributions/Gaussian/Real`: `charFun_gaussianReal`, `gaussianReal_conv_gaussianReal` | Specialize or wrap these; do not submit another proof of Gaussian convolution closure as new infrastructure. Done in `AuditRepairs/GaussianBridge.lean` (v0.2.3): `charFun_gaussianReal_eq_stableS1Expr` (variance `2 sigma^2`, zero scale included) and `convolutionPower_gaussianReal`. |
| CDF, QUANT | `Probability/CDF`: `cdf_eq_real`, `Measure.eq_of_cdf`; Stieltjes measures and independence | Maximum/minimum laws, support-correct EVT measures, quantile conventions and atom handling. The independent-maximum law `P(max <= x) = prod P(X_i <= x)` and its Frechet/Gumbel max-stability consequences are done in `AuditRepairs/ExtremeValueBridge.lean` (v0.2.3); the minimum survival law and the law-level `cdf(max) = F^n`, `P(min > x) = S^n` theorems are done in v0.2.4 (T060 discharged). Gumbel, Fréchet and reverse-Weibull measures are constructed via `StieltjesFunction` (v0.2.5–v0.2.6, `AuditRepairs/ExtremeValueLaws.lean`), and the positive location/scale pushforward `affineLaw` with the three families and their iid-maximum laws is in `AuditRepairs/ExtremeValueAffine.lean` (v0.2.6; T061 discharged). Quantile conventions and atom handling remain open. |
| Pareto | `Probability/Distributions/Pareto`: `paretoMeasure`, `isProbabilityMeasure_paretoMeasure`, density/CDF integral bridge | Integrate against this law; do not create a duplicate distribution. Done in v0.2.8 (`AuditRepairs/ParetoLaw.lean`, Stage A): closed-form survival/cdf with endpoint values, moments finite iff `p < α` with value `αL^p/(α−p)`, extended-integral divergence for `p ≥ α`, tail exponent of the actual law. Stage B done in v0.2.9 (`AuditRepairs/ParetoConditional.lean`): threshold law via the pinned `ProbabilityTheory.cond`, excess law, conditional mean and mean excess, positive-power pushforward as an equality of laws. Centered Pareto ratios done in v0.2.10 (`AuditRepairs/ParetoMoments.lean`: mean, centered MAD through the threshold law, variance via Mathlib's `variance`, STD/MAD ratio (4.14)). Open: the general tail-integral identity (2.10) via layer-cake (T005), Property 5.2 for arbitrary laws (T032), Gaussian/Student moments (T021). |
| CALC | `Analysis/Convex/Integral`: `ConvexOn.map_integral_le`; `Analysis/Convex/Jensen` | Prove parameter-domain convexity, then supply integrability and support for Jensen. |
| LLN | `Probability/StrongLaw`: `strong_law_ae_real`, `strong_law_ae`, `strong_law_Lp` | Instantiate for powers, ratios and estimators; add maximum/sum facts rather than reprove SLLN. |
| GAMMA, DENS | `Probability/Distributions/Gamma`, `Beta`; gamma/beta special functions | Inverse moments, lognormal/gamma mixture identities and change-of-variable bridges. |
| CLT, EVT, SUBEXP | General measure/limit/Fourier foundations and convergence notions | Large theorem families; exact completeness in current upstream is unverified. Generalized CLT, domains of attraction and subexponential closure are substantial projects. |
| EST, GINI, KAPPA | Integration, laws of large numbers, elementary limits | Estimator definitions; joint asymptotics; regular MLE assumptions; delta/Slutsky steps. |
| MULTI, ENT | Inner product spaces, matrices, convexity, measure products | Elliptical distributions, differential entropy optimization, tail dependence; existence hypotheses matter. |
| RUIN, SDE, FIN | Martingale/optional-stopping modules; stochastic-process foundations | Check exact Brownian/Ito/Girsanov coverage before sizing; pricing assumptions and admissible strategies first. |
| APP | No theorem prover substitutes for data and a testable model | Reproducible calculations, model validation and software evidence. |

## Suggested contribution slices

1. Reproduce the handoff without edits. The verification JSON must say PASS and identify the pinned dependency commits.
2. Review the ratio-only predicate design before building on it. Consider aligning with a more general asymptotic/filter interface upstream, then propose a small reviewable family of closure and example lemmas. The eleven new foundation results are building material, not evidence of upstream acceptance.
3. Build exact Pareto survival, moment and threshold-excess results against `paretoMeasure`. Include both finite-moment results and divergence statements. This supplies many book applications without requiring generalized CLT.
4. Prove iid maximum/minimum distribution identities using existing independence (done: v0.2.3 maximum, v0.2.4 minimum and the law-level `cdf_map_maxRV` / `measureReal_map_minRV_Ioi`; T060 discharged). Construct valid Gumbel/Frechet/reverse-Weibull laws through CDF/Stieltjes infrastructure and connect them to the maximum law (done: Gumbel and Fréchet in v0.2.5, reverse-Weibull and the location/scale families with `map_maxRV_gumbelLaw`/`_frechetLaw`/`_reverseWeibullLaw` in v0.2.6; T061 discharged).
5. Add the genuine subexponential API and basic consequences. Do not confuse it with exponential-concentration classes. Proving regularly varying laws are subexponential is a larger step than declaring the predicate.
6. Add positive/measurable RV, uniform convergence, Potter bounds and Karamata, after agreement on definitions. These unlock moment tests, asymptotic shortfalls, options and EVT.
7. Treat stable-law existence, stable domains of attraction and generalized CLT as a substantial workstream. The new conditional bridge prevents algebraic formula manipulation from masquerading as existence.
8. Only then formalize kappa, Gini/quantile estimation, mixtures and application-specific chapters. Resolve source-gate rows before choosing a proposition.

## Priority and completion rules

P0 means repair the mathematical statement before coding. P1 means a comparatively contained reusable lemma family, assuming prerequisites. P2 means a substantial theorem or dependency family. P3 means advanced application, empirical work, or a model that is not yet specified. These are dependency priorities, not promises measured in days. A source-check status is a blocking mathematical review regardless of its priority.

A completed task needs: edition/page/anchor; exact quantified statement; all domain, integrability and independence assumptions; imports and dependency version; proof without placeholders; axiom closure; and a note identifying any difference from the book. A theorem that simply assumes the desired distributional conclusion as a hypothesis does not complete an existence task.

## Weekend and Monday split

A sensible near-term target is to reproduce this repaired package and select one small Pareto/tail API contribution. Formalizing the remaining book and obtaining upstream acceptance should not be a dependency of a Monday software demo. For the separate quantum/classical application, obtain the actual repository, runnable baseline, input schema, expected output examples and the particular paper claim being demonstrated. Then connect only the implemented, relevant mathematical contract to that software; keep simulation, classical computation and hardware execution explicitly identified. This handoff neither runs nor modifies that unseen application.

## Primary references

- [Versioned book](https://arxiv.org/abs/2001.10488v4)
- [Pinned Mathlib source](https://github.com/leanprover-community/mathlib4/tree/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib)
- [Mathlib contribution guide](https://leanprover-community.github.io/contribute/index.html)

The first two are provenance anchors for this work. Consult the current contribution guide and upstream source before proposing a PR; no current-acceptance claim is made here.
