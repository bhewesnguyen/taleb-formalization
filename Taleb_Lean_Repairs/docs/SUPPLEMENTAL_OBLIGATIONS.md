# Supplemental obligations (outside the 158 curated families)

Source-visible work that no row of `FORMALIZATION_BACKLOG.md` covers, recorded here rather than
by redefining a parent family (independent audit of v0.2.6, finding D026-3: EVT densities had
been routed to T062, whose actual target is "Frechet and Gaussian maximum domains" — a
convergence family). Items are S-numbered so they cannot be confused with family IDs. They are
open until a checked Lean declaration and a page-level source review say otherwise; when the
parent ledger is deliberately revised they may become families of their own.

| ID | Title | Source | Target | Hypotheses and conventions | Status |
|---|---|---|---|---|---|
| S001 | Unified GEV parametrisation and the `ξ → 0` Gumbel limit | §9.1, printed pp. 173–174 (PDF 187–188) | State the one-parameter family `G_ξ(x) = exp(−(1 + ξ x)^{−1/ξ})` on `{1 + ξ x > 0}` (extended by `0`/`1` off the support), show it is a probability distribution function for every real `ξ`, and prove that `G_ξ → Λ = exp(−exp(−x))` pointwise as `ξ → 0`. Then identify `G_ξ` for `ξ > 0`, `ξ < 0` with the location/scale Fréchet (`frechetLaw`) and reverse-Weibull (`reverseWeibullLaw`) laws of `AuditRepairs/ExtremeValueAffine.lean`. | The unified location parameter is **not** the endpoint coordinate `μ` of the three displayed families (the endpoint sits at `μ − σ/ξ` in unified coordinates); the identification must state the reparametrisation explicitly. Shape conventions: this project's Fréchet shape `ξ` gives `exp(−x^{−1/ξ})`, the book's `α = 1/ξ`; reverse-Weibull `α = −1/ξ`. | open (not a closure requirement for T061, which targets the three families separately) |
| S002 | Densities of the three EVT laws | §9.1, printed p. 173 (PDF 187) for the distribution functions; densities are derived work | `HasDerivAt` of `gumbelCDF`, `frechetCDF ξ` (`x > 0`) and `reverseWeibullCDF α` (`x < 0`) with the explicit derivatives, and `withDensity` identifications `gumbelMeasure = volume.withDensity (fun x => ENNReal.ofReal (…))` etc., so that Lebesgue-density arguments (moments, tail integrals) can be run against the constructed measures. | Densities vanish off the support. The Fréchet density extends continuously by `0` at its lower endpoint for every `ξ > 0` (the factor `exp(−x^{−1/ξ})` dominates the power); the reverse-Weibull density `α(−x)^{α−1} exp(−(−x)^α)` has a jump at the upper endpoint when `α = 1` and is unbounded there when `α < 1`, so derivative statements must be on the open support. `frechetFormula`'s totalized value at `0` must not be used. | open |

Routing reminders (so the error does not recur): T011 is the general domain-of-attraction
formulation (normalised maxima converge; distinguish from convergence to the support endpoint);
T062 is the Fréchet case via regular variation and the Gaussian/Gumbel normalisers. For a Pareto
tail exponent `α` the limit law in this project's parametrisation is `frechetMeasure (1/α)` (cdf
`exp(−x^{−α})`), with the natural normalisation `M_n / (L n^{1/α})` for lower endpoint `L`.
