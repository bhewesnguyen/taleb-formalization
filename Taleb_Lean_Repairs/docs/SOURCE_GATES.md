# Source gates before proof search

These are targeted mathematical checks found while building the inventory, not a completed audit of every book theorem. Page numbers below are printed Arabic pages; add 14 for PDF viewer pages. G01-G16 come from the handoff's inventory pass; G17-G18 were added by the independent Fable review (see `FABLE_REVIEW.md`); G19 and the qualification of G18 come from the subsequent independent audit of that review (v0.2.2). The more complex backlog entries marked source-check need full derivations. The concrete checks below explain why literal transcription would fail. Except where explicitly named, these checks are mathematical arguments in this document, not additional Lean theorems delivered in the package.

## G01. Slow variation is not convergence to a constant

Sections 2.2.1 and 21.2. The function log(x) is slowly varying and diverges. `AuditRV.isSlowlyVarying_log` is already checked. Eventual constant-tail approximations require an additional quantitative or asymptotic assumption.

## G02. Exponential is a boundary, not a member of the heavy-tail subexponential class

Pages 91-93. If X,Y are independent exponentials of rate r>0, P(X+Y>x)/P(X>x)=1+r*x for x>=0. It diverges instead of tending to 2. Use the convolution definition in `AuditProbability.IsSubexponential`. Gamma/Laplace exponential tails do not become heavy-tail subexponential merely because they are mentioned alongside a boundary case.

## G03. The moment boundary of general regular variation is undecided by alpha alone

Pages 91-98. For nonnegative moment order q and survival S(x)=x^(-alpha)L(x), q<alpha gives the usual finite-moment result, and q>alpha divergence. At q=alpha the deciding integral is proportional to integral L(x)/x dx. For example, a normalized eventual survival proportional to x^(-1)/(log x)^2 has index 1 and finite mean. Exact Pareto statements cannot be silently generalized at the boundary.

## G04. Product tails need assumptions

Page 100, Principle 5.2. Multiplication by the thin-tailed variable Y=0 yields zero, not a heavy tail. The useful replacement is a Breiman-type theorem for independent nonnegative variables with a finite (alpha+epsilon) moment of Y and a positive alpha moment. Dependence and cancellation need separate treatment.

## G05. Stable absolute moment fails the Gaussian endpoint check

Page 152, equation (7.9), visually checked. With alpha=2, beta=0 and location zero, the displayed formula gives scale/sqrt(pi). The chapter's characteristic function is exp(-scale^2*t^2), corresponding to Gaussian variance 2*scale^2 and E|X|=2*scale/sqrt(pi). Resolve this factor of two before formalizing the general stable moment derivation. The delivered S1 specializations fix the parameter-order errors in the original Lean files, but do not prove the corrected general absolute-moment integral.

## G06. A hidden finite moment cannot have p>alpha for an exact Pareto tail

Pages 177-178, Proposition 9.1 and equation (9.12), visually checked. The hidden moment is defined as integral_K^infinity x^p f(x) dx. For Pareto density alpha*L^alpha*x^(-alpha-1), this equals alpha*L^alpha*K^(p-alpha)/(alpha-p) only when p<alpha. It diverges for p>=alpha. The printed p>alpha domain cannot give a real-valued finite hidden-moment density. Re-derive the distribution in the valid finite-moment regime and distinguish exact Pareto from approximation.

## G07. Full support does not force a Laplace log-growth law

Page 184, Theorem 1, visually checked. The one-sided result log(X/L)~Exponential(alpha) follows from exact Pareto X. Allowing the log variable to range over all reals does not determine its negative side, symmetry, or mixing weights. An independent bilateral/symmetry model is required for a Laplace conclusion.

## G08. Shortfall ratios have sign and normalization errors

Page 200, Definition 10.1, and page 228, Definition 11.6, visually checked. For a Pareto law with alpha>1, E[X given X>K]/K=alpha/(alpha-1)>1 and E[X-K given X>K]/K=1/(alpha-1). A second division by K changes the limit. The printed alpha/(1-alpha) is negative and cannot be the ratio of positive tail payoffs. The adjusted payoff-equivalent factor may exceed one; it is then not a probability.

## G09. The sigmoid martingale statement is false as written

Page 268, Proposition 14.1, visually checked. Let X_t be constantly 1. Both X_t and logistic(X_t) are martingales, but logistic(1) is not 1/2, refuting the literal only-if statement. Even for nondegenerate Brownian motion started at zero, symmetry of the unconditional mean does not prove the sigmoid process is a martingale. For dX=b(X)dt+sigma(X)dW, the drift of f(X) is f'(X)b(X)+(1/2)f''(X)sigma(X)^2. A local drift condition over the reachable states, plus integrability, is the right target.

## G10. Gini ratios require joint fluctuation analysis

Pages 283-285 and 295, Theorem 2 and equation (15.42). The numerator and denominator share observations. At stable order, denominator fluctuations cannot be dropped as if they were smaller. The appendix itself introduces Xi*(2F(Xi)-1-g). Verify its tail constants and scaling before accepting the displayed limit parameter. This is a source-review gate, not a completed counterexample or repaired Gini theorem.

## G11. Strict bias and monotonicity need stronger hypotheses

Page 305, Theorem 5. If every observation lies above the fixed threshold h, the empirical and population threshold shares both equal 1; strict downward bias fails. Also, superadditivity of n*a_n alone does not imply that a_n increases: b_n=floor(n/2) is superadditive, while b_2/2=1/2>b_3/3=1/3. Consistency from an appropriate LLN is a separate, plausible claim and should be proved independently.

## G12. Shifted-lognormal mixture mean has an invalid generalization

Page 385, equations (21.11)-(21.13), visually checked and carried forward from the first audit. Set b=2, alpha0=3, log-variance=1 and scale=1. Every conditional Pareto mean for alpha=2+Z, Z>0, lies in (1,2). The printed closed form gives 1+e>2. The correct general expression is scale*(1+E[1/(b-1+Z)]). At b=1 and E[Z]=alpha0-1 it simplifies to scale*(1+exp(log-variance)/(alpha0-1)). Termwise integration of the proposed lognormal series needs an independent convergence argument.

## G13. Shifted-gamma correction needs scale and a finite inverse moment

Page 386, equations (21.14)-(21.16), visually checked and carried forward. Set m=alpha0-1 and let alpha-1 have gamma shape m^2/s^2 and scale s^2/m. For m^2>s^2, the mixture mean is scale*(1+m/(m^2-s^2)); its excess over the fixed-index mean is scale*s^2/(m*(m^2-s^2)). The displayed equation repeats the primed expectation and omits scale. If m^2<=s^2, the inverse moment diverges despite alpha>1 almost surely. `AuditMoments.gamma_mixture_excess` and `gamma_mixture_excess_pos` check the repaired algebra and sign. The gamma integral and its divergence threshold remain backlog items.

## G14. The minimum-p-value expectation formula has the wrong sign and integrand

Page 395 after Proposition 22.3, visually checked. The displayed integral is negative for a positive density; at m=1 it is -1. For m independent [0,1] values with CDF F, E[min]=integral_0^1 (1-F(p))^m dp, equivalently integral_0^1 p*m*f(p)*(1-F(p))^(m-1) dp when a density exists. Identical marginal distributions alone do not give the product survival law.

## G15. A forward mean does not identify a probability measure

Page 426, Lemma 25.3 and equation (25.13), visually checked. The point mass at 1 and the equal mixture of point masses at 0 and 2 have the same first moment and different laws. Equality of forward expectations cannot imply a Radon-Nikodym derivative of 1. The payoff identity is (x-K)_+-(K-x)_+=x-K. A full arbitrage-free option curve across strikes can determine a terminal marginal; a single mean cannot, and neither identifies an entire path law.

## G16. Absolute-moment constraint has a sign error

Page 478, Section 30.4.2, visually checked. Under the chapter's K<0 setting, the left tail is negative, so its contribution to E|X| is -epsilon*nu_minus. The printed constraint uses +epsilon*nu_minus. Correct this sign before solving for the truncated-Laplace rate or proving maximum entropy.

## G17. The S1 characteristic function in 15.2.1 is printed with misplaced parentheses

Page 282 (PDF page 296), Section 15.2.1, visually checked during the Fable review. The displayed two-branch S1 characteristic function closes its parenthesis too early in both branches: `exp(-gamma^alpha |t|^alpha (1 - i beta sign(t)) tan(pi alpha/2) + i delta t)` for alpha != 1 and `exp(-gamma |t| (1 + i beta (2/pi) sign(t)) ln|t| + i delta t)` for alpha = 1. Read literally, the real part of the exponent is `-gamma^alpha |t|^alpha tan(pi alpha/2)` (positive for 1 < alpha < 2) and `-gamma |t| ln|t|` (positive for |t| < 1), so the modulus would exceed 1, which no characteristic function can do. The intended standard S1 form (Samorodnitsky and Taqqu 1994, Definition 1.1.6; Nolan) has the tangent and the logarithm inside the parenthesis: `exp(-gamma^alpha |t|^alpha (1 - i beta sign(t) tan(pi alpha/2)) + i delta t)` and `exp(-gamma |t| (1 + i beta (2/pi) sign(t) ln|t|) + i delta t)`. Equation (7.2) on page 140 prints the alpha != 1 branch correctly but states it only for alpha != 1; the alpha = 1 logarithmic branch appears in the book only in the misprinted display of 15.2.1. `StableAudit.stableS1Expr` implements the standard S1 form. The same section states alpha in (0, 2), whereas (7.2) and (2.6) state 0 < alpha <= 2; the project uses 0 < alpha <= 2 in `StableAudit.StableParameters`. No Lean statement depends on the misprinted reading.

## G18. The displayed limit under Property 5.1 has the wrong sign

Page 99 (PDF page 113), directly below Property 5.1, visually checked during the Fable review. The display reads `lim_{z -> infinity} log(w1 z^(-alpha1) + w2 z^(-alpha2)) / log(z) = alpha2` for `alpha2 <= alpha1` and `w2 > 0`. Since `w1 z^(-alpha1) + w2 z^(-alpha2)` tends to 0, its logarithm tends to minus infinity and the quotient tends to `-alpha2`. With the book's own convention on page 97 that `log P(X > x) / log x` converges to `-alpha`, the tail exponent of the two-term survival formula is `alpha2 = min(alpha1, alpha2)`. The finite-exponent interface `AuditTails.HasFiniteTailExponent` (which uses `-log S(x) / log x`) is the right vehicle for a corrected formula-level lemma.

The corrected two-term limit does not establish Property 5.1 in its printed scope. The property allows dependent, signed summands ("neither independent nor identically distributed") with positive weights, and cancellation then defeats it (independent-audit counterexample, September 2026): let `Z` have `P(Z > x) = x^(-a)` for `x >= 1`, let `E` be an independent fair sign, and set `X = E Z`, `Y = -2 E Z`. Both right tails have exponent `a` (`P(X > x) = x^(-a)/2`, `P(Y > x) = (x/2)^(-a)/2`), yet `2 X + Y = 0` identically, so the positively weighted sum has no right tail at all. A valid target is the finite sum of nonnegative variables with positive weights, where for `n` summands the event inclusions `max_i P(w_i X_i > x) <= P(sum_i w_i X_i > x) <= sum_i P(w_i X_i > x/n)` need no independence and yield the minimum finite logarithmic tail exponent under the tail-limit hypotheses; exact convolution-tail asymptotics are a separate, stronger target. The unrestricted printed statement is therefore classified source-check; the probabilistic statement remains backlog family T029. The corrected formula-level content is checked in Lean since v0.2.3: `AuditTails.two_power_tail` (ordered form, exponent `alpha2` for `alpha2 <= alpha1`, `w1 >= 0`, `w2 > 0`) and `AuditTails.two_power_tail_min` (exponent `min(alpha1, alpha2)` for positive weights), both in `AuditRepairs/Foundations.lean`.

Resolution (v0.2.7): the two-summand case of that valid target is proved for random variables in `AuditRepairs/WeightedSums.lean` — `AuditProbability.hasFiniteTailExponent_weightedSum` (pointwise nonnegative `X, Y`, positive weights, no independence; exponent `min`), via exactly these event inclusions and reusable rescaling/max/sum/squeeze rules on `HasFiniteTailExponent`. This is exponent equality, not the survival-ratio asymptotics a regular-variation reading of Property 5.1 would assert; the finite-family extension is open (T029 remains partial).

## G19. Regular variation is identified with alpha-stability on page 282

Page 282 (PDF page 296), the paragraph below the S1 characteristic function in Section 15.2.1, raised by the independent audit of the Fable review and confirmed on the rendered page: "a regularly-varying random variable of order alpha is alpha-stable, with the same tail coefficient". This identification is false. Regular variation is a tail property; stability is an exact distributional property of independent sums. A Pareto law with `alpha = 3/2` has a regularly varying tail and support `[1, infinity)`, whereas every nondegenerate `3/2`-stable law has support equal to the whole real line (Nolan, *Stable Distributions*, Lemma 1.10), so the Pareto law is not stable. The correct relation is the domain-of-attraction statement: suitably normalized partial sums of such variables converge in distribution to an alpha-stable law with the same index. Backlog family T093 targets that statement; do not inherit the identification into a theorem. No delivered Lean statement makes it.

## Additional review gates

The backlog also flags the general Lp-ball volume factor, kappa's log(0) index and non-universal bounds, recursive moment explosion versus weak limits, source density normalization in Chapter 21, p-value sampling-model assumptions, real powers of negative bases in put pricing, and existence of entropy maximizers. These are not all certified errors; they identify precise definitions and derivations that must be checked before formalization.
