# Replacement map

These are importable project entry points, not standalone pasted files. Import `AuditRepairs` for the complete repaired project. Original signatures deliberately change where the original was false or underspecified.

| Original | Checked declaration | Source | Scope |
|---|---|---|---|
| 01 SlowlyVaryingLog | `AuditRV.isSlowlyVarying_log` | 2.2.1; 21.2 | Elementary analytic identity. |
| 02 SlowlyVaryingConst | `AuditRV.isSlowlyVarying_const` | 2.2.1; 21.2 | Constant must be nonzero. |
| 03 SlowlyVaryingOfTendsto | `AuditRV.IsSlowlyVarying.of_tendsto_const` | 2.2.1; 21.2 | Nonzero finite limit implies the ratio property. |
| 04 RegularlyVaryingMul | `AuditRV.IsRegularlyVarying.mul` | 5.1; 21.2 | Product of functions, not of random variables. |
| 05 RegularlyVaryingRpow | `AuditRV.IsRegularlyVarying.rpow` | 5.1; 21.2 | Eventually positive base function. |
| 06 RVIffSlowlyVarying | `AuditRV.isRegularlyVarying_iff_slowlyVarying` | 2.2.1; 21.2 | Ratio-only representation; not Karamata integral representation. |
| 07 TailExponentPareto | `AuditTails.pareto_hasFiniteTailExponent` | 5.1; E.1 | Explicit finite exponent, not a general extended-real index. |
| 08 SubexponentialTailExponent | `AuditProbability.IsSubexponential.finiteTailExponent` | 5, equation 5.1 | Now connects a probability law to its self-convolution. |
| 09 ConvexOnRpowNeg | `AuditTails.convexOn_rpow_neg_right` | 21.2 | Correct domain Set.univ; Jensen integration remains separate. |
| 10 FrechetMaxstable | `AuditTails.frechet_cdf_maxstable` | 9.1 | Global piecewise formula and positive sample size; CDF realization remains open. iid maxima (v0.2.3): AuditExtremes.measureReal_maxLeEvent_frechet states the max-stability for independent coordinates with the Frechet distribution function; constructing that measure remains open (T061). Law level (v0.2.4): AuditExtremes.cdf_map_maxRV gives cdf(max) = F^n for measurable independent coordinates with a common law. Measure constructed (v0.2.5): AuditEVTLaws.frechetMeasure with cdf identity cdf_frechetMeasure_apply; max-stability instantiated for it in cdf_map_maxRV_frechet (product-space realization cdf_map_maxRV_pi_frechet). |
| 11 GumbelMaxstable | `AuditTails.gumbel_maxstable` | 9.1 | Correct original identity retained. iid maxima (v0.2.3): AuditExtremes.measureReal_maxLeEvent_gumbel; measure construction open (T061). Law level (v0.2.4): AuditExtremes.cdf_map_maxRV, and AuditExtremes.measureReal_map_minRV_Ioi_eq_one_sub_cdf for the minimum. Measure constructed (v0.2.5): AuditEVTLaws.gumbelMeasure with cdf identity cdf_gumbelMeasure_apply; max-stability instantiated for it in cdf_map_maxRV_gumbel (product-space realization cdf_map_maxRV_pi_gumbel). |
| 12 StableCharFnGaussian | `StableAudit.stableS1Expr_gaussian` | 7.2.1 | Correct location/scale and repaired S1 expression; scale maps to variance 2*scale^2. |
| 13 GaussianStable | `StableAudit.gaussian_stable_real_short` | 7.2.1-7.2.2 | Exponential scaling identity; use Mathlib Gaussian law theorem for distributions. |
| 14 StableCharFnCauchy | `StableAudit.stableS1Expr_cauchy` | 7.2.1 | Correct location/scale; nonnegative scale; zero scale is degenerate. Equation (7.2) is stated only for alpha != 1; the Cauchy case uses the alpha = 1 branch, where beta = 0 makes the logarithmic term vanish. |
| 15 CauchyStable | `StableAudit.cauchy_stable_short` | 7.2.1-7.2.2 | Exponential scaling identity. |
| 16 StableCharFnStable | `AuditProbability.stableS1_convolutionPower_eq` | 7.2.1-7.2.2; 15.2.1 | Conditional law theorem; existence of S1 laws remains open. The alpha = 1 logarithmic branch follows the standard S1 form; the book prints it only in 15.2.1 with misplaced parentheses (SOURCE_GATES G17). Non-vacuity (v0.2.3): AuditGaussian.convolutionPower_gaussianReal_scale instantiates both premises with Mathlib's gaussianReal at alpha = 2 (variance 2*scale^2). |
