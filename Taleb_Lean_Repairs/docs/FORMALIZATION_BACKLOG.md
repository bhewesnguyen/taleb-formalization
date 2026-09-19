# Book-wide formalization backlog

Source: arXiv:2001.10488v4, third edition, 17 September 2025. 523 PDF pages. Original proof pack covers elementary pieces of a small subset; it does not cover half the book.

This inventory contains 158 obligation families. A family can require many Lean declarations. No row is a claim that its book statement is already verified. All 30 numbered chapters and nine lettered chapters have a coverage entry; Chapter 1 is introductory exposition. The section and equation indexes are locator catalogs, not independent theorem counts.

Statuses: partial = some supplied lemmas exist but the family is incomplete; reuse = an existing Mathlib result should be instantiated; missing = implement after prerequisites; source-check = resolve mathematical statement first; empirical/model-needed = specify a model or reproduce data.

Priority: P0 statement repair; P1 contained reusable family; P2 substantial dependency; P3 advanced application/model/data. Every source-check row has a statement-review gate regardless of priority.

## Chapter 2

### T001 - Regular variation API

**P1 / partial / RV**. Printed pp. 9-10; PDF anchor p. 23; source: 2.2.1.

Separate ratio limits from eventual positivity and measurability; connect the positive measurable convention to the repaired predicates.

Hypotheses and gaps: Measurable functions; eventual positive values; positive scaling argument.

### T002 - Karamata representation

**P2 / missing / RV**. Printed pp. 9;379-382; PDF anchor p. 23; source: 2.2.1;21.1-21.3.

Prove the integral representation of measurable slowly varying functions and its converse.

Hypotheses and gaps: Positive measurable L; locally integrable epsilon(t)/t; epsilon tends to zero; eta has finite limit.

### T003 - Weak and strong laws

**P1 / reuse / LLN**. Printed pp. 10;137-139; PDF anchor p. 24; source: 2.2.2;7.1.

Instantiate existing laws for integrable iid real variables and their sample averages.

Hypotheses and gaps: Identical laws; appropriate independence; integrability; n positive.

### T004 - Central limit theorem

**P2 / missing / CLT**. Printed pp. 10;147-148; PDF anchor p. 24; source: 2.2.3;7.5.

Encode normalized sums and convergence in distribution to a Gaussian.

Hypotheses and gaps: Independence; finite nonzero variance; distinguish iid and triangular-array versions.

### T005 - Tail integral and excess identities

**P1 / missing / TAIL**. Printed pp. 10;18;259; PDF anchor p. 24; source: 2.2.4;2.10;13.6.

Prove E[X 1_(X>K)] = K P(X>K) + integral_K^infinity P(X>x) dx; derive excess and conditional means.

Hypotheses and gaps: Nonnegative X and K; Tonelli for extended integrals; finite first moment for real-valued identities; positive tail for conditioning.

### T006 - Kappa metric domain

**P1 / missing / KAPPA**. Printed pp. 11;156-159; PDF anchor p. 25; source: 2.2.6;8.2.

Define kappa only where n>n0>0, M(n0)>0, and log(M(n)/M(n0)) is nonzero.

Hypotheses and gaps: Finite absolute first moment; nondegenerate dispersion; no unrestricted [0,1] range claim.

### T007 - Stable law existence

**P2 / missing / CF**. Printed pp. 12-13;139-140;282; PDF anchor p. 26; source: 2.2.9;7.2.1;15.2.1.

Construct the probability measure with the repaired S1 characteristic function.

Hypotheses and gaps: 0<alpha<=2; -1<=beta<=1; scale>=0; include alpha=1 logarithmic branch and zero-scale Dirac case. Source: (7.2) covers alpha != 1 only; the alpha = 1 branch is printed in 15.2.1 with misplaced parentheses (SOURCE_GATES G17), use the standard S1 form.

### T008 - Subexponential law API

**P2 / partial / SUBEXP**. Printed pp. 13;91-93; PDF anchor p. 27; source: 2.2.12;5.1.

Extend the new nonnegative self-convolution definition to the standard equivalent n-fold tail characterizations.

Hypotheses and gaps: Probability law supported on nonnegative reals; unbounded right support; fixed positive integer n.

### T009 - Quantiles and expected shortfall

**P1 / missing / QUANT**. Printed pp. 16; PDF anchor p. 30; source: 2.2.19.

Use generalized inverses and state the atom-safe expected-shortfall formula.

Hypotheses and gaps: Probability level in (0,1); integrability; distinguish strict/non-strict tails and atoms.

### T010 - Maximum divided by sum

**P2 / missing / LLN**. Printed pp. 16-17;200; PDF anchor p. 30; source: 2.2.21;10.2.6.

Show maximum X_i^p divided by sum X_i^p tends almost surely to zero.

Hypotheses and gaps: Nonnegative iid observations; finite strictly positive pth moment; define initial zero denominators.

### T011 - Maximum domain of attraction

**P1 / source-check / EVT**. Printed pp. 17;171-177; PDF anchor p. 31; source: 2.2.22;9.1.

Define normalized maxima convergence; distinguish it from convergence to the support endpoint.

Hypotheses and gaps: Nondegenerate limiting law; positive normalizers; endpoint convergence alone is insufficient.

### T012 - Payoff versus indicator

**P1 / source-check / TAIL**. Printed pp. 18;225-227; PDF anchor p. 32; source: 2.2.23;11.2.

Prove a weighted payoff integral is generally not threshold payoff times tail probability; characterize equality almost everywhere.

Hypotheses and gaps: For an iff require nonnegative excess or monotonic payoff; cancellation invalidates unrestricted pointwise iff.

## Chapter 3

### T013 - Overview and illustrative calculations

**P3 / model-needed / APP**. Printed pp. 25-67; PDF anchor p. 39; source: 3.1-3.13.

Formalize only defined finite examples, tail ratios, and ruin models; link repeated claims to later results.

Hypotheses and gaps: Qualitative philosophy and empirical claims are not Lean propositions until a model is supplied.

### T014 - Multiplicative survival and ruin

**P1 / missing / RUIN**. Printed pp. 53;63-66; PDF anchor p. 67; source: 3.6.1;3.11.

Compute survival over n independent trials and its limit when each trial has positive ruin probability.

Hypotheses and gaps: Independent trials or explicit conditional hazard lower bound; absorbing ruin state.

## Chapter 4

### T015 - Gaussian scale mixture normalization

**P1 / missing / MOM**. Printed pp. 69-74; PDF anchor p. 83; source: 4.1.

Build a probability mixture and prove its first four moments from conditional Gaussian moments.

Hypotheses and gaps: Positive scales; probability mixing measure; integrability for each moment.

### T016 - Variance-preserving fattening

**P1 / missing / MOM**. Printed pp. 71-72; PDF anchor p. 85; source: 4.1.1.

Show symmetric mixing of variances sigma^2(1-a) and sigma^2(1+a) keeps variance and raises fourth moment.

Hypotheses and gaps: 0<=a<1; centered Gaussian components; nonzero sigma for standardized kurtosis.

### T017 - Gamma mixture density

**P3 / missing / DENS**. Printed pp. 72-74; PDF anchor p. 86; source: 4.1.2;4.7.

Derive the Bessel-K density for a Gaussian with gamma-distributed variance.

Hypotheses and gaps: Positive gamma parameters; justified integral and transform; distinguish variance from precision.

### T018 - Precision mixture and Student law

**P2 / missing / DENS**. Printed pp. 74-75; PDF anchor p. 88; source: 4.2.

Derive Student-type tails from gamma precision mixing; contrast lognormal and gamma variance mixtures.

Hypotheses and gaps: Exact mixing parametrization; all moment finiteness claims must be checked separately.

### T019 - Crossovers of perturbed Gaussian densities

**P1 / missing / CALC**. Printed pp. 75-79; PDF anchor p. 89; source: 4.3.

Locate the body/shoulder/tail sign changes through scale derivatives.

Hypotheses and gaps: Centered Gaussian; positive scale; distinguish infinitesimal perturbation from a finite mixture.

### T020 - Moment and norm comparisons

**P1 / reuse / MOM**. Printed pp. 79-86; PDF anchor p. 93; source: 4.4.1-4.4.4.

Apply Jensen, Holder, and Lp monotonicity to compare absolute mean deviation and standard deviation.

Hypotheses and gaps: Probability measure; finite relevant moments; center the variable explicitly.

### T021 - Distribution-specific absolute moments

**P1 / missing / MOM**. Printed pp. 80-86; PDF anchor p. 94; source: 4.4.2-4.4.4.

Compute Gaussian, Student, and Pareto absolute moments and MAD/STD ratios.

Hypotheses and gaps: Correct scale convention; Pareto alpha>2 for STD; moment-order restrictions.

### T022 - Estimator efficiency comparison

**P3 / missing / EST**. Printed pp. 83; PDF anchor p. 97; source: 4.4.3.

Derive asymptotic variances of MAD and standard-deviation estimators under specified laws.

Hypotheses and gaps: Define estimator and efficiency criterion; finite moments; differentiate statistical functional.

### T023 - Lp-ball volumes

**P2 / source-check / GAMMA**. Printed pp. 88-89; PDF anchor p. 102; source: 4.5;4.15.

Prove volume = (2 Gamma(1+1/p))^d / Gamma(1+d/p), and limiting cube/cross-polytope cases.

Hypotheses and gaps: p>0; natural dimension; inspect the printed factor 4 before transcription.

## Chapter 5

### T024 - One large jump and absent exponential moments

**P2 / missing / SUBEXP**. Printed pp. 91-93; PDF anchor p. 105; source: 5.1-5.2.

Prove fixed-n subexponential tail asymptotics and divergence of every positive exponential moment.

Hypotheses and gaps: Nonnegative iid law; subexponential hypothesis; distinguish the converse and concentration-theory terminology.

### T025 - Exponential boundary

**P1 / source-check / SUBEXP**. Printed pp. 91-94; PDF anchor p. 105; source: 5.0.1-5.0.3.

Show an exponential law fails the heavy-tail subexponential convolution test.

Hypotheses and gaps: Rate>0; its two-fold convolution tail ratio is 1+rate*x, not 2.

### T026 - Regular-variation uniform convergence

**P2 / missing / RV**. Printed pp. 95-98; PDF anchor p. 109; source: 5.1.

Prove uniformity on compact positive scale intervals.

Hypotheses and gaps: Positive measurable/Baire regular variation; not the ratio-only predicate without regularity.

### T027 - Potter bounds

**P2 / missing / RV**. Printed pp. 95-98; PDF anchor p. 109; source: 5.1.

Bound L(y)/L(x) by a constant times max((y/x)^epsilon,(y/x)^(-epsilon)) eventually.

Hypotheses and gaps: Measurable slowly varying positive L; epsilon>0; explicit threshold and constant.

### T028 - Tail moment threshold

**P1 / source-check / MOM**. Printed pp. 95-98; PDF anchor p. 109; source: 5.1.

Prove finite qth moment for q<alpha and infinite qth moment for q>alpha; isolate q=alpha.

Hypotheses and gaps: q>=0; nonnegative law with regularly varying tail of index -alpha; boundary requires an integral test on L.

### T029 - Tail of sums with unequal indices

**P2 / source-check / SUBEXP**. Printed pp. 98-99; PDF anchor p. 112; source: 5.2.1.

Prove the heavier regularly varying tail dominates a sum of nonnegative variables with positive weights (event-inclusion bounds, no independence needed); first prove the formula-level two-term identity -log(w1 z^(-alpha1) + w2 z^(-alpha2))/log z -> min(alpha1, alpha2) with AuditTails.HasFiniteTailExponent.

Hypotheses and gaps: Nonnegative variables and positive weights are required: with signed dependent summands, X = E Z and Y = -2 E Z give 2X + Y = 0, so the unrestricted printed Property 5.1 is false (SOURCE_GATES G18). The displayed limit under Property 5.1 (p. 99) is printed without the minus sign; state the corrected version.

### T030 - Product of exact Pareto laws

**P1 / missing / DENS**. Printed pp. 99-100; PDF anchor p. 113; source: 5.2.2.

Derive the product survival function for unequal indices and the logarithmic factor at equal indices.

Hypotheses and gaps: Independent Pareto variables; positive scales and indices.

### T031 - Breiman product theorem

**P2 / source-check / RV**. Printed pp. 100; PDF anchor p. 114; source: Principle 5.2.

Prove tail(XY) ~ E[Y^alpha] tail(X) in its standard valid form.

Hypotheses and gaps: X>=0 regularly varying; independent Y>=0; E[Y^(alpha+epsilon)] finite; nonzero alpha-moment.

### T032 - Power transformation of a law

**P1 / partial / TAIL**. Printed pp. 100; PDF anchor p. 114; source: Property 5.2;5.8.

Bridge the checked analytic exponent alpha/p to the pushforward law of X^p.

Hypotheses and gaps: X>=0; p>0; measurability; monotonic inverse; do not apply to arbitrary negative p or signed X.

### T033 - Bell shape, interpolation, and log-Pareto

**P2 / missing / DENS**. Printed pp. 101-103; PDF anchor p. 115; source: 5.3-5.5.

Derive the stated Student/Pareto examples and exponential-of-Pareto survival and moments.

Hypotheses and gaps: Exact distribution required; infinite moments use nonnegative integrals, not totalized real integrals.

### T034 - Stochastic-volatility interpretations

**P3 / model-needed / APP**. Printed pp. 103-105; PDF anchor p. 117; source: 5.6.

Separate exact mixture equivalences from finite-sample visual fits.

Hypotheses and gaps: Specify mixing law and equality of laws; simulation fit is not proof.

## Chapter 6

### T035 - Elliptical and multivariate Student laws

**P2 / missing / MULTI**. Printed pp. 108-114; PDF anchor p. 122; source: 6.1-6.3.

Define characteristic/density forms, normalization, marginals, and linear projections.

Hypotheses and gaps: Positive-definite shape matrix; distinction between scale matrix and covariance; dimension constraints.

### T036 - Uncorrelated versus independent

**P1 / missing / MULTI**. Printed pp. 113-114; PDF anchor p. 127; source: 6.3.1.

Give a non-Gaussian elliptical example with zero covariance but dependent coordinates.

Hypotheses and gaps: Finite second moments for covariance; exact joint law; independence needs a separate theorem.

### T037 - Student mutual information

**P3 / missing / ENT**. Printed pp. 114-115; PDF anchor p. 128; source: 6.4.

Compute mutual information from joint and marginal densities and study its tail parameter.

Hypotheses and gaps: Finite entropy/integrability; gamma and digamma identities; not Pearson correlation alone.

### T038 - Random matrices and undefined correlation

**P3 / model-needed / MULTI**. Printed pp. 115-117; PDF anchor p. 129; source: 6.5-6.6.

State selected spectral/concentration claims and identify when covariance is undefined.

Hypotheses and gaps: Explicit matrix ensemble and moment hypotheses; broad PCA failure slogans require a model.

### T039 - Regression with fat-tailed residuals

**P3 / model-needed / EST**. Printed pp. 117-119; PDF anchor p. 131; source: 6.7.

Derive estimator laws or inconsistency/rate claims under a specified noise design.

Hypotheses and gaps: Design matrix assumptions; independent residuals or explicit dependence; finite relevant moments.

## Chapter A

### T040 - Mixture multimodality

**P1 / missing / DENS**. Printed pp. 122-124; PDF anchor p. 136; source: A.1.

Determine modes and tail properties of a two-regime Gaussian mixture.

Hypotheses and gaps: Weight in [0,1]; positive scales; separate multimodality from asymptotic heavy tails.

### T041 - Eventual transition or failure

**P2 / missing / RUIN**. Printed pp. 124-125; PDF anchor p. 138; source: A.2.

Prove eventual hitting under stated transition probabilities.

Hypotheses and gaps: Finite Markov chain or independent hazards; irreducibility/positive reachability hypotheses.

## Chapter B

### T042 - Gaussian maximum entropy

**P2 / missing / ENT**. Printed pp. 128-129; PDF anchor p. 142; source: B.1.1.

Show Gaussian uniquely maximizes differential entropy at fixed mean and variance.

Hypotheses and gaps: Finite positive variance; admissible densities and entropy; prove global optimum via relative entropy.

### T043 - Pareto maximum entropy

**P2 / missing / ENT**. Printed pp. 129; PDF anchor p. 143; source: B.1.2.

Show Pareto maximizes entropy on [L,infinity) with a fixed log moment.

Hypotheses and gaps: L>0; feasible finite log moment; normalization; integrability; equality up to almost everywhere.

### T044 - Uniform maximum entropy and probability integral transform

**P1 / missing / CDF**. Printed pp. 129; PDF anchor p. 143; source: B.1.3.

Prove uniform entropy bound; prove continuous CDF applied to its own random variable is uniform.

Hypotheses and gaps: Finite interval; continuous CDF; generalized inverse for non-strictly increasing CDF.

### T045 - Tsallis entropy

**P3 / missing / ENT**. Printed pp. 129-132; PDF anchor p. 143; source: B.2.

Prove Shannon limit as q tends to 1 and derive admissible q-exponential optimizer.

Hypotheses and gaps: Domination to exchange limit/integral; q-dependent normalization and moment domains.

## Chapter 7

### T046 - Stable characteristic function specializations

**P1 / partial / CF**. Printed pp. 139-140; PDF anchor p. 153; source: 7.2.1.

Connect repaired expressions to actual Gaussian and Cauchy probability laws.

Hypotheses and gaps: Scale convention: Gaussian variance=2*scale^2; Cauchy nonnegative scale; use existing Gaussian theorem.

### T047 - Stable sample averages

**P2 / partial / CF**. Printed pp. 140; PDF anchor p. 154; source: 7.2.2.

Derive the average scale n^(1/alpha-1), location rules, and finite-mean convergence.

Hypotheses and gaps: Existence of stable laws; iid summands; alpha>1 for mean; alpha=1 skew location under rescaling needs logarithmic correction.

### T048 - Explicit finite-sum laws

**P2 / missing / DENS**. Printed pp. 141-145; PDF anchor p. 155; source: 7.3.

Compute uniform, exponential/gamma and selected Pareto convolutions; quantify errors in approximations.

Hypotheses and gaps: iid laws; positive sample size; distinguish exact density, weak limit, and numerical plot.

### T049 - Cumulant scaling

**P1 / missing / MOM**. Printed pp. 145-147; PDF anchor p. 159; source: 7.4;Definition 7.1.

Show kth cumulant of normalized iid sum scales as n^(1-k/2) when defined.

Hypotheses and gaps: Moment/cumulant existence or local MGF assumptions; nonzero variance.

### T050 - Lyapunov implies Lindeberg

**P2 / missing / CLT**. Printed pp. 147-148; PDF anchor p. 161; source: 7.5.

Prove the implication and a CLT under the appropriate array assumptions.

Hypotheses and gaps: Positive total variance; independent array; delta>0; uniform negligibility where required.

### T051 - LLN for powers and MS plots

**P1 / reuse / LLN**. Printed pp. 148-150; PDF anchor p. 162; source: 7.6.

Apply strong law to absolute powers; prove the maximum/sum criterion in its valid domain.

Hypotheses and gaps: Finite pth absolute moment; nonnegative transformed variables; avoid inferring a theorem from a finite plot.

### T052 - Stable mean absolute deviation

**P2 / source-check / CF**. Printed pp. 151-152; PDF anchor p. 165; source: 7.7;7.6-7.9.

Prove an absolute-moment formula using a convergent integral and fix Fourier/Hilbert constants.

Hypotheses and gaps: 1<alpha<=2; centered stable law; justified integral exchange; check Gaussian endpoint against 2*scale/sqrt(pi).

## Chapter 8

### T053 - Kappa algebra and telescoping

**P1 / source-check / KAPPA**. Printed pp. 156-158; PDF anchor p. 170; source: Definition 8.1;8.1-8.2.

Prove the explicit log-ratio formula and the composition over intermediate sample sizes.

Hypotheses and gaps: n>n0>=1; positive nonzero MAD ratios; sum from n0 to n-1, avoiding log(0).

### T054 - Stable kappa and sample equivalence

**P1 / missing / KAPPA**. Printed pp. 158-160; PDF anchor p. 172; source: 8.3.

Derive kappa=2-alpha for finite-mean strictly stable cases and equal-MAD sample-size relations.

Hypotheses and gaps: 1<alpha<=2; correct centering and stable parameterization; scale positivity.

### T055 - Kappa bounds and non-universality

**P1 / source-check / KAPPA**. Printed pp. 160-162; PDF anchor p. 174; source: 8.4.

State and prove bounds only for a specified distribution class.

Hypotheses and gaps: Finite first moment alone does not imply 0<=kappa<=1; negative examples occur later in source.

### T056 - Cubic Student summed MAD

**P2 / missing / KAPPA**. Printed pp. 164-166; PDF anchor p. 178; source: 8.6.1;Proposition 8.1.

Derive characteristic function, summed density, MAD, incomplete-gamma expression, and asymptotic kappa.

Hypotheses and gaps: iid Student with df=3 and stated scale; n>=1; all integral constants checked.

### T057 - Lognormal sum bounds

**P2 / missing / KAPPA**. Printed pp. 166-168; PDF anchor p. 180; source: 8.6.2.

Prove low/high-volatility and sample-size bounds used for kappa.

Hypotheses and gaps: Independent lognormal variables; exact parameter convention; numerical approximations separately labeled.

### T058 - Exponential summed MAD

**P1 / missing / KAPPA**. Printed pp. 168-169; PDF anchor p. 182; source: 8.6.3.

Derive gamma-sum MAD and explicit kappa formula.

Hypotheses and gaps: Positive rate; iid summands; n>=2 for nonzero log denominator.

### T059 - Negative kappa examples

**P1 / missing / KAPPA**. Printed pp. 169-170; PDF anchor p. 183; source: 8.6.4.

Provide exact bounded/discrete counterexamples and identify failure of proposed universal bounds.

Hypotheses and gaps: Exact distribution and MAD calculation; positive denominators.

## Chapter 9

### T060 - Distribution of iid maxima

**P1 / missing / CDF**. Printed pp. 171-173; PDF anchor p. 185; source: 9.1.

Prove CDF(max_i X_i)(x)=F(x)^n and minima survival analog.

Hypotheses and gaps: Independent measurable variables with common law; n>0; atoms permitted.

### T061 - GEV families as probability measures

**P1 / partial / EVT**. Printed pp. 172-173; PDF anchor p. 186; source: 9.1.

Construct global Gumbel, Frechet and reverse-Weibull CDFs and prove validity.

Hypotheses and gaps: Correct piecewise support; scale>0; shape domains; right continuity and endpoint limits.

### T062 - Frechet and Gaussian maximum domains

**P2 / missing / EVT**. Printed pp. 173-175; PDF anchor p. 187; source: 9.1.1-9.1.2.

Prove regular-variation-to-Frechet convergence and Gaussian Gumbel normalizers.

Hypotheses and gaps: Regularly varying tail; generalized inverse norming; Gaussian Mills asymptotics.

### T063 - Pickands-Balkema-de Haan

**P2 / missing / EVT**. Printed pp. 176-177; PDF anchor p. 190; source: 9.1.3;9.8-9.9.

Formalize threshold excess convergence to GPD and converse under correct hypotheses.

Hypotheses and gaps: MDA hypothesis; moving endpoint; uniform metric; admissible shape-dependent support.

### T064 - Hidden moment law

**P1 / source-check / TAIL**. Printed pp. 177-179; PDF anchor p. 191; source: Proposition 9.1;9.12.

Derive distribution of tail moment above the random maximum in the finite-moment regime.

Hypotheses and gaps: Exact Pareto or separately quantified asymptotic approximation; p<alpha for finite hidden pth moment; correct printed p>alpha.

### T065 - Empirical CDF versus tail payoff

**P2 / missing / CLT**. Printed pp. 179-181; PDF anchor p. 193; source: 9.2.1;9.3.

Separate pointwise Bernoulli CLT, uniform empirical-process convergence, and unbounded-payoff estimation.

Hypotheses and gaps: Continuity for probability integral transform; tightness for Donsker; uniform integrability for payoff limits.

## Chapter C

### T066 - Log of a Pareto variable

**P1 / source-check / DENS**. Printed pp. 183-185; PDF anchor p. 197; source: Theorem 1.

Prove log(X/L) is exponential for exact Pareto X; treat bilateral model separately.

Hypotheses and gaps: X>=L>0 and alpha>0; full support alone does not force a Laplace law.

## Chapter D

### T067 - Large deviation principle

**P2 / missing / CLT**. Printed pp. 187-188; PDF anchor p. 201; source: D.

State Cramer theorem and Chernoff rate bounds in the finite-MGF regime.

Hypotheses and gaps: iid variables; log-MGF finite near zero; exponential tightness; no blanket extension to heavy tails.

## Chapter E

### T068 - Pareto MLE and log transform

**P1 / missing / EST**. Printed pp. 189-191; PDF anchor p. 203; source: E;E.1.

Derive alpha_hat=n/sum log(X_i/L), its inverse-gamma law and bias correction.

Hypotheses and gaps: Known fixed L; iid Pareto; n>1 for estimator mean and n>2 for variance.

### T069 - Tail-exponent sampling law

**P2 / missing / EST**. Printed pp. 191-192; PDF anchor p. 205; source: E.1.

Prove finite-sample estimator moments, asymptotic variance and confidence constructions.

Hypotheses and gaps: Exact Pareto model; distinguish arbitrary RV tails from parametric equality.

## Chapter 10

### T070 - SP500 empirical claims

**P3 / empirical / APP**. Printed pp. 193-205; PDF anchor p. 207; source: 10.1-10.3.

Reproduce diagnostics with data provenance and uncertainty; connect each diagnostic to a theorem.

Hypotheses and gaps: Dataset and computation required; finite plots do not prove nonexistent moments.

### T071 - Aggregation and drawdown statistics

**P2 / missing / MOM**. Printed pp. 195-198; PDF anchor p. 209; source: 10.2.1-10.2.3.

Prove model-specific kurtosis aggregation and drawdown/kappa formulas.

Hypotheses and gaps: Independent increments where used; finite fourth moment for kurtosis; specify temporal dependence.

### T072 - Relative excess normalization

**P1 / source-check / TAIL**. Printed pp. 200; PDF anchor p. 214; source: Definition 10.1.

Correct signs and distinguish E[X given X>K]/K from mean-excess/K.

Hypotheses and gaps: Pareto alpha>1 gives alpha/(alpha-1); mean-excess ratio is 1/(alpha-1).

### T073 - Record counts and asymmetric tails

**P1 / missing / CDF**. Printed pp. 201-205; PDF anchor p. 215; source: 10.2.7-10.2.8.

Derive distribution-free record expectations for continuous iid samples and separate left/right tail diagnostics.

Hypotheses and gaps: No ties or explicit tie rule; iid for record laws; data claims remain empirical.

## Chapter F

### T074 - Risk estimator performance

**P3 / model-needed / EST**. Printed pp. 208-212; PDF anchor p. 222; source: F.1-F.2.

Define loss and derive or simulate parametric/nonparametric estimator error under specified tails.

Hypotheses and gaps: Specified model, sample size and loss; do not interpret finite simulation as universal dominance.

## Chapter G

### T075 - Learning losses and angular calibration

**P3 / model-needed / EST**. Printed pp. 213-216; PDF anchor p. 227; source: G;G.0.1.

Formalize moment/existence conditions for losses and proposed angle estimator.

Hypotheses and gaps: Exact estimator; input normalization; integrability; predictive validity requires data.

## Chapter 11

### T076 - Binary and unbounded payoff interfaces

**P1 / missing / TAIL**. Printed pp. 220-225; PDF anchor p. 234; source: Definitions 11.1-11.4.

Define measurable indicator payoffs, unbounded exposures and characteristic-scale limits.

Hypotheses and gaps: Measurability; support and integrability; source terminology differs from standard tail classifications.

### T077 - Payoff-to-binary tail ratios

**P2 / missing / RV**. Printed pp. 225-227; PDF anchor p. 239; source: Definition 11.5;Theorem 2.

Derive I1/I2 from conditional means; prove Karamata ratio alpha/(alpha-1) for regular variation.

Hypotheses and gaps: g(x)=x for displayed theorem; alpha>1; positive survival; finite tail integral.

### T078 - Gaussian tail integral and Mills ratio

**P1 / missing / TAIL**. Printed pp. 226; PDF anchor p. 240; source: 11.6.

Prove exact Gaussian tail first moment and asymptotic Mills ratio.

Hypotheses and gaps: Positive scale; normalized density; correct quantile direction.

### T079 - Adjusted payoff-equivalent probability

**P1 / source-check / TAIL**. Printed pp. 228; PDF anchor p. 242; source: Definition 11.6.

Use p_star/p=alpha/(alpha-1) for exact Pareto and explain possible p_star>1.

Hypotheses and gaps: alpha>1; matching a monetary payoff is not necessarily a probability; printed denominator sign is wrong.

### T080 - Calibration versus payoff calibration

**P2 / missing / EST**. Printed pp. 230-231; PDF anchor p. 244; source: 11.3.

Construct calibrated binary forecasts with different exposure losses.

Hypotheses and gaps: Specify joint law of forecasts and outcomes; calibration condition and loss function.

### T081 - Bounded Brier score moments

**P1 / missing / MOM**. Printed pp. 231-238; PDF anchor p. 245; source: Theorem 3;11.15-11.16.

Prove score in [0,1] and all nonnegative moments finite; then a correctly normalized CLT.

Hypotheses and gaps: Forecasts in [0,1]; n>0; no independence needed for boundedness; iid/variance for CLT.

### T082 - Score distribution transforms

**P3 / missing / EST**. Printed pp. 233-240; PDF anchor p. 247; source: 11.4.1;11.7.

Derive binary tally and Brier score laws under the stated beta/independence model.

Hypotheses and gaps: Independence of forecast errors and any outcomes as used; beta>0; normalize special functions.

### T083 - Nonlinear loss moments

**P1 / missing / TAIL**. Printed pp. 235-238; PDF anchor p. 249; source: 11.5.

Relate polynomial payoff growth to tail-index moment thresholds.

Hypotheses and gaps: Measurable payoff; growth bounds; no unrestricted claim for all nonlinear losses.

## Chapter 12

### T084 - Single forecasts and asymmetric decisions

**P3 / model-needed / APP**. Printed pp. 241-251; PDF anchor p. 255; source: 12.1-12.4.

Define losses, Bayes decisions, threshold exceedance and ruin probability in explicit models.

Hypotheses and gaps: Expected-loss existence; loss asymmetry; policy and empirical conclusions are not mathematical consequences alone.

## Chapter 13

### T085 - Beta uncertainty in quantiles

**P1 / missing / MOM**. Printed pp. 253-257; PDF anchor p. 267; source: 13.1-13.3.

For P~Beta(a,b), K=L*P^(-1/alpha), derive E[K^q]=L^q B(a-q/alpha,b)/B(a,b).

Hypotheses and gaps: L>0; alpha>0; q>=0; a>q/alpha for finiteness, otherwise divergent.

### T086 - Quantile sensitivity

**P1 / missing / CALC**. Printed pp. 257-259; PDF anchor p. 271; source: 13.3-13.5.

Derive derivative/convexity and propagation of probability uncertainty into quantile risk.

Hypotheses and gaps: P in (0,1); alpha>0; use extended moments when divergent.

## Chapter 14

### T087 - Gaussian digital payoff valuation

**P3 / missing / SDE**. Printed pp. 263-268; PDF anchor p. 277; source: 14.0.1;14.1.

Derive conditional normal exceedance probability and its time-to-maturity evolution.

Hypotheses and gaps: Specified Brownian filtration; finite horizon; conditional expectations; no-arbitrage model explicit.

### T088 - Sigmoid of a martingale

**P0 / source-check / SDE**. Printed pp. 268; PDF anchor p. 282; source: Proposition 14.1.

Replace the initial-value criterion by an Ito drift condition or conditional-expectation proof.

Hypotheses and gaps: Starting at the sigmoid inflection point does not make a nondegenerate transformed process a martingale; constants also refute the literal only-if.

### T089 - Bounded dual diffusion

**P3 / missing / SDE**. Printed pp. 268-271; PDF anchor p. 282; source: 14.2-14.3.

Solve the drift-adjusted process and prove transformed process is a martingale.

Hypotheses and gaps: Specify SDE solution, adaptedness and integrability; local martingale versus true bounded martingale.

### T090 - Probability assessor and uniform forecast

**P2 / missing / CDF**. Printed pp. 271-273; PDF anchor p. 285; source: 14.4.

Derive probability-integral-transform and forecasting implications without extra epistemic claims.

Hypotheses and gaps: Continuous specified distribution; conditional law distinguished from unconditional law.

## Chapter 15

### T091 - Population and sample Gini

**P2 / missing / GINI**. Printed pp. 277-282; PDF anchor p. 291; source: 15.1-15.2.

Connect pairwise absolute differences, Lorenz/quantile integrals, order statistics and Gini mean deviation.

Hypotheses and gaps: Nonnegative integrable X with mean>0; atoms/ties handled; exact finite-n normalization.

### T092 - Order-statistic remainder

**P2 / missing / GINI**. Printed pp. 281-282; PDF anchor p. 295; source: Lemma 15.1.

Prove weighted empirical-quantile remainder vanishes with the required normalization.

Hypotheses and gaps: iid positive integrable samples; quantile conventions; uniform empirical-process control.

### T093 - Stable domain of attraction

**P2 / source-check / CLT**. Printed pp. 282-283; PDF anchor p. 296; source: 15.9;15.2.1.

Formalize two-sided tail balance and normalization for alpha-stable convergence.

Hypotheses and gaps: 1<alpha<2; slowly varying norming; specified S1/S0 convention. Source p. 282 identifies a regularly varying variable with an alpha-stable one; that identification is false (a Pareto law is not stable), only the domain-of-attraction statement holds (SOURCE_GATES G19).

### T094 - Gini mean-deviation stable limit

**P3 / missing / GINI**. Printed pp. 283; PDF anchor p. 297; source: Theorem 1.

Derive stable limit and consistency of GMD statistic including remainder.

Hypotheses and gaps: Positive support; finite mean; RV tails; verify coupling of order statistics and transformed Xi.

### T095 - Gini ratio stable limit

**P0 / source-check / GINI**. Printed pp. 283-284;295; PDF anchor p. 297; source: Theorem 2;15.42.

Derive joint numerator/denominator fluctuations before taking their ratio.

Hypotheses and gaps: Random denominator fluctuations are of the same stable order; verify the scale using the centered variable Xi*(2F(Xi)-1-g).

### T096 - Parametric Gini MLE limit

**P2 / source-check / EST**. Printed pp. 284; PDF anchor p. 298; source: Theorem 3.

Apply a valid MLE asymptotic normality theorem and delta method to the Gini functional.

Hypotheses and gaps: Regular identifiable interior model; nonzero Fisher information; differentiable functional; exponential-family membership alone is insufficient.

### T097 - Pareto Gini estimator laws

**P2 / source-check / GINI**. Printed pp. 285-287; PDF anchor p. 299; source: Corollaries 15.1-15.2.

Derive Pareto Gini 1/(2alpha-1), MLE delta variance, and corrected stable asymptotics.

Hypotheses and gaps: alpha>1; distinguish asymptotic approximation from exact finite-n equality in law.

### T098 - Finite-sample Gini correction

**P3 / missing / GINI**. Printed pp. 287-295; PDF anchor p. 301; source: 15.5;appendix.

Derive mode/centering correction and prove its stated asymptotic or finite-n behavior.

Hypotheses and gaps: Do not infer finite-n bias from a limit mode without a justified approximation.

## Chapter 16

### T099 - Quantile-contribution estimator

**P1 / missing / GINI**. Printed pp. 299-302; PDF anchor p. 313; source: 16.2;Proposition 16.1.

Define threshold/quantile shares and prove derivative sign for one added large observation.

Hypotheses and gaps: Positive sums; frozen rank region; n and q rounding; threshold membership stable locally.

### T100 - Aggregation of concentration

**P0 / source-check / GINI**. Printed pp. 302-306; PDF anchor p. 316; source: Theorem 4.

Prove the precise sample or expectation inequality, including any covariance terms.

Hypotheses and gaps: Sample partition assumptions; do not factor E[weight*share] without justification; quantile ranks matter.

### T101 - Bias and consistency of threshold share

**P0 / source-check / GINI**. Printed pp. 305; PDF anchor p. 319; source: Theorem 5.

Prove consistency from LLN; repair strict bias and monotonicity assertions separately.

Hypotheses and gaps: Finite positive mean; nontrivial threshold; superadditivity of n*a_n alone does not imply a_n increasing.

### T102 - Mixtures and concentration

**P3 / missing / GINI**. Printed pp. 306-309; PDF anchor p. 320; source: 16.4-16.6.

Derive concentration under random tail indices and effects of increasing sample totals.

Hypotheses and gaps: Mixture support bounded away from nonintegrable regimes or explicit integrability; distinction between fixed and moving thresholds.

## Chapter 17

### T103 - Dual bounded-to-unbounded transform

**P1 / missing / CALC**. Printed pp. 314-316; PDF anchor p. 328; source: 17.2.

Prove phi(y)=L-H*log((H-y)/(H-L)) is an increasing bijection [L,H) to [L,infinity).

Hypotheses and gaps: 0<L<H; endpoints handled; inverse y=H-(H-L)*exp(-(x-L)/H).

### T104 - Shadow density and moments

**P2 / missing / MOM**. Printed pp. 316-319; PDF anchor p. 330; source: 17.3.

Push GPD through the inverse transform and compute conditional mean and higher bounded moments.

Hypotheses and gaps: Positive GPD scale; admissible support; H finite; special-function evaluation and normalization.

### T105 - Truncation versus transformation

**P2 / missing / DENS**. Printed pp. 319-321; PDF anchor p. 333; source: 17.4-17.5.

Prove distinct resulting laws and compare moments under matching parameters.

Hypotheses and gaps: Specify hard truncation, conditioning or smooth transformation; empirical fit is separate.

## Chapter 18

### T106 - Conflict-data inference

**P3 / empirical / APP**. Printed pp. 323-342; PDF anchor p. 337; source: 18.1-18.6.

Separate data cleaning, thresholds, tail fit and robustness from the reusable shadow/GPD theorems.

Hypotheses and gaps: Actual data and provenance required; historical interpretation is outside Lean proof scope.

### T107 - Rescaling and conditional expectations

**P2 / missing / TAIL**. Printed pp. 328-329; PDF anchor p. 342; source: 18.3.1-18.3.2.

Formalize deterministic rescaling and conditional tail estimators.

Hypotheses and gaps: Positive scaling and defined reference population; justify conditional expectation and dependence.

### T108 - GPD inference and bootstrap

**P3 / model-needed / EST**. Printed pp. 333-339; PDF anchor p. 347; source: 18.4-18.5.

Specify and validate threshold estimator, QQ/mean-excess diagnostics and bootstrap model.

Hypotheses and gaps: Asymptotic bootstrap validity requires hypotheses; resampling experiments are software tasks.

## Chapter H

### T109 - War-probability discussion

**P3 / model-needed / APP**. Printed pp. 343-345; PDF anchor p. 357; source: H.

Map quantitative claims to the conflict model and record philosophical claims separately.

Hypotheses and gaps: No probability of a future war follows from a severity-tail model without an arrival model.

## Chapter 19

### T110 - Pandemic tail and shadow moments

**P3 / empirical / APP**. Printed pp. 347-361; PDF anchor p. 361; source: 19.1-19.4.

Reuse the dual-transform/GPD results; reproduce estimates and sensitivity to data errors.

Hypotheses and gaps: Data and threshold assumptions; finite population cap does not by itself establish an unbounded model's mean.

## Chapter 20

### T111 - Recursive mixtures

**P1 / missing / MOM**. Printed pp. 368-371; PDF anchor p. 382; source: 20.1.1-20.1.2.

Define finite binary scale tree and normalize its mixture law.

Hypotheses and gaps: 0<=a_i<1; positive base scale; independent or explicitly weighted branches.

### T112 - Constant-error moment products

**P1 / missing / MOM**. Printed pp. 372-373; PDF anchor p. 386; source: 20.4.

Derive second and fourth moment factors (1+a^2)^N and (1+6a^2+a^4)^N.

Hypotheses and gaps: Centered Gaussian mixture; finite N; clarify centered/noncentral moments.

### T113 - Absolute-moment invariance

**P1 / missing / MOM**. Printed pp. 372-373; PDF anchor p. 386; source: 20.1.

Show centered Gaussian scale mixtures preserve first absolute moment when mean scale is fixed.

Hypotheses and gaps: Center zero; nonnegative scales; finite mean scale; does not automatically extend to nonzero location.

### T114 - Exploding moments versus limiting law

**P0 / source-check / CLT**. Printed pp. 373-377; PDF anchor p. 387; source: 20.1.3;20.3.

Prove divergence of moment sequence; independently identify any weak limit under a valid scaling.

Hypotheses and gaps: Diverging finite-N moments do not prove the weak limit has infinite moments or Pareto tails.

### T115 - Decaying-error infinite products

**P2 / missing / MOM**. Printed pp. 375; PDF anchor p. 389; source: 20.6-20.8.

Prove moment products converge under summable squared perturbations and verify q-Pochhammer identities.

Hypotheses and gaps: 0<=lambda<1; correct indices and powers; direct product proof before special-function simplification.

### T116 - Additive error recursion

**P1 / source-check / MOM**. Printed pp. 376; PDF anchor p. 390; source: 20.2.2.

Derive moments of the specified alternative recursion from its exact definition.

Hypotheses and gaps: Separate sigma from variance; recheck dimensional consistency of displayed formulas.

## Chapter 21

### T117 - Random-index mixture foundations

**P1 / missing / MOM**. Printed pp. 379-382; PDF anchor p. 393; source: 21.1-21.4.

Define a measurable family of Pareto/RV laws and its mixture.

Hypotheses and gaps: Fixed scale/support conventions; kernel measurability; moment integrability; alpha-dependence of L explicit.

### T118 - Moment convexity in Pareto exponent

**P1 / partial / CALC**. Printed pp. 381; PDF anchor p. 395; source: Proposition 21.1.

Prove m_p(alpha)=scale^p*alpha/(alpha-p) is convex on alpha>p and apply Jensen.

Hypotheses and gaps: p>0; common positive scale; random alpha>p; integrable mixing or extended expectation.

### T119 - Mixed expected shortfall

**P0 / source-check / TAIL**. Printed pp. 381-383; PDF anchor p. 395; source: Proposition 21.2;21.5-21.8.

Derive posterior tail-weighted mixing for E[X given X>K] and formulate a nonvacuous comparison.

Hypotheses and gaps: Positive tails and finite moments; compare normalized shortfall or finite K; unscaled infinite limits give no quantitative inequality.

### T120 - Density and boundary normalization

**P0 / source-check / RV**. Printed pp. 381-382; PDF anchor p. 395; source: 21.5;Karamata representation.

Differentiate S(x)=L(x)*x^(-alpha), enforce S(x0)=1 and integrate density.

Hypotheses and gaps: Absolute continuity; nonnegative density; boundary terms; printed derivative-based normalizer must be rederived.

### T121 - Sums and stochastic indices

**P2 / missing / SUBEXP**. Printed pp. 383-384; PDF anchor p. 397; source: 21.3.

Combine sum tails and mixture tails without interchanging limits illegitimately.

Hypotheses and gaps: Independence; domination/uniform regular variation; essential infimum of mixing indices can govern tails.

### T122 - Asymmetric stable mixture

**P2 / missing / CF**. Printed pp. 384-385; PDF anchor p. 398; source: 21.4.

Characterize which skew/mean properties survive mixing and which stability properties are lost.

Hypotheses and gaps: Stable law existence; finite moments where used; a mixture of stable laws is not automatically stable.

### T123 - Shifted-lognormal index mean

**P0 / source-check / MOM**. Printed pp. 385; PDF anchor p. 399; source: Proposition 21.3;21.11-21.13.

Use scale*(1+E[1/(b-1+Z)]); simplify only at b=1; audit the series exchange.

Hypotheses and gaps: Z lognormal with stated mean/log-variance; b>=1; the displayed arbitrary-b closed form is false.

### T124 - Shifted-gamma index mean

**P1 / partial / GAMMA**. Printed pp. 386; PDF anchor p. 400; source: Proposition 21.4;21.14-21.16.

Prove inverse gamma moment and corrected excess scale*s^2/(m*(m^2-s^2)).

Hypotheses and gaps: m=alpha0-1>0; s>0; m^2>s^2 for finite mean; algebraic excess already checked.

### T125 - Mixed bounded power law

**P2 / missing / MOM**. Printed pp. 386-387; PDF anchor p. 400; source: 21.7.

Compose index mixing with bounded dual transform and prove finite moments.

Hypotheses and gaps: Finite H; common support; kernel and transformation measurable; no unbounded-mean claim after capping.

## Chapter 22

### T126 - Finite-sample p-value density

**P0 / source-check / EST**. Printed pp. 391-393; PDF anchor p. 405; source: Proposition 22.1;22.1.

Derive pushforward density under the exact sampling model and normalize it.

Hypotheses and gaps: Specify t statistic law under alternative; central shifted-t need not equal a noncentral t law; p in (0,1).

### T127 - Gaussian-limit p-value law

**P2 / missing / EST**. Printed pp. 392-394; PDF anchor p. 406; source: Proposition 22.2;22.2.

Derive inverse-normal change of variables and convergence of p-value law.

Hypotheses and gaps: Sample-statistic convergence; continuity; endpoint behavior; median parameter in (0,1).

### T128 - Minimum p-value law and expectation

**P1 / source-check / CDF**. Printed pp. 395; PDF anchor p. 409; source: Proposition 22.3;22.5.

Prove survival(min)=survival^m and E[min]=integral_0^1 survival^m.

Hypotheses and gaps: Independent identical p-values; m>=1; correct negative displayed expectation formula.

### T129 - Power-of-test distribution

**P3 / source-check / EST**. Printed pp. 396; PDF anchor p. 410; source: Proposition 22.4;22.6-22.7.

Specify estimator and derive its pushforward law, including endpoint limits.

Hypotheses and gaps: Exact test statistic and alternative; distinguish estimated power from a fixed parameter.

## Chapter I

### T130 - Loss-aversion examples

**P3 / model-needed / APP**. Printed pp. 399-403; PDF anchor p. 413; source: I.1.

Calculate expected loss or utility under an explicit multiplicative/heavy-tail process.

Hypotheses and gaps: Specified utility and integrability; behavioral interpretation requires independent empirical evidence.

## Chapter 23

### T131 - Survival, hazard and residual lifetime

**P1 / missing / RUIN**. Printed pp. 405-409; PDF anchor p. 419; source: 23.1-23.2.

Define hazard and mean residual life; prove Pareto residual life scales with age.

Hypotheses and gaps: Positive survival; differentiability for hazard; alpha>1 for finite remaining mean.

### T132 - Brownian absorbing barrier

**P3 / missing / SDE**. Printed pp. 409-411; PDF anchor p. 423; source: 23.2.1.

Derive first-passage distribution using reflection and study survival asymptotics.

Hypotheses and gaps: Brownian motion with specified variance; positive initial distance; stopping-time measurability.

### T133 - Drifted barrier and Lindy interpretation

**P3 / missing / SDE**. Printed pp. 411-413; PDF anchor p. 425; source: 23.2.2-23.3.

Derive drifted hitting-time law and conditions for finite lifetime/aging.

Hypotheses and gaps: Correct drift sign; Girsanov or direct PDE hypotheses; do not equate median and infinite mean.

## Chapter 24

### T134 - Hedging-error decomposition

**P3 / model-needed / FIN**. Printed pp. 417-420; PDF anchor p. 431; source: 24.1.

Specify discrete hedge error and conditions under which quadratic approximations are valid.

Hypotheses and gaps: Self-financing strategy, payoff regularity, integrability and jump process explicit.

## Chapter 25

### T135 - Call-price curve determines a marginal law

**P2 / source-check / FIN**. Printed pp. 423-426; PDF anchor p. 437; source: Theorem 6;Lemma 25.1.

Reconstruct a terminal probability measure from a full arbitrage-free call curve.

Hypotheses and gaps: All strikes, convexity, monotonicity, endpoint slopes and finite first moment; a single forward price is insufficient.

### T136 - Put/call law uniqueness

**P2 / missing / FIN**. Printed pp. 426; PDF anchor p. 440; source: Lemma 25.2.

Use put-call parity and full strike families to prove equality of induced terminal laws.

Hypotheses and gaps: Correct one-sided derivatives at atoms; normalized laws and generating half-lines.

### T137 - Forward mean is not measure uniqueness

**P0 / source-check / FIN**. Printed pp. 426; PDF anchor p. 440; source: Lemma 25.3;25.13.

Replace invalid Radon-Nikodym conclusion with equality of first moments or full call-curve uniqueness.

Hypotheses and gaps: Equal means alone permit distinct laws; payoff difference is x-K; pricing assumptions must be explicit.

### T138 - Physical versus pricing measure

**P3 / model-needed / FIN**. Printed pp. 427; PDF anchor p. 441; source: 25.3.

Formalize exactly which law prices which contracts and numeraire.

Hypotheses and gaps: No automatic identification of physical and pricing laws; terminal marginal versus path law distinction.

## Chapter 26

### T139 - Static payoff formulas and hedging

**P2 / missing / FIN**. Printed pp. 434-439; PDF anchor p. 448; source: 26.4.

Derive Bachelier/Black-Scholes payoff integrals under specified terminal laws.

Hypotheses and gaps: Normal/lognormal parameters; nonnegative maturity/volatility; edge cases; numerical evaluation separate.

### T140 - Limits of dynamic replication

**P3 / model-needed / FIN**. Printed pp. 439-442; PDF anchor p. 453; source: 26.6.

Formulate one precise impossibility or approximation result in a specified jump/heavy-tail model.

Hypotheses and gaps: Trading strategies and admissibility defined; no universal impossibility inferred from heavy tails alone.

## Chapter 27

### T141 - Pareto call-price tail

**P1 / source-check / FIN**. Printed pp. 446-448; PDF anchor p. 460; source: 27.1-27.3;Result 1.

Prove C(K)=integral_K^infinity S(x) dx and exact power pricing for an exact Pareto tail.

Hypotheses and gaps: alpha>1; finite first moment; fixed measure; RV only yields asymptotics unless L is exactly constant.

### T142 - Log return transforms

**P1 / missing / RV**. Printed pp. 448; PDF anchor p. 462; source: Theorem 7.

Prove log(S/S0) has exponentially decaying tail for Pareto S and fails a finite RV power index.

Hypotheses and gaps: S0>0; alpha>0; regular variation and suitable asymptotic transfer; repair source proof expression.

### T143 - Shifted Pareto relative calls

**P1 / missing / FIN**. Printed pp. 448-449; PDF anchor p. 462; source: 27.4-27.6;Result 2.

Derive relative call ratios for arithmetic-return Pareto tails.

Hypotheses and gaps: K>S0; common exact tail region; alpha>1; anchor call price positive.

### T144 - Put-price power law

**P0 / source-check / FIN**. Printed pp. 449-451; PDF anchor p. 463; source: 27.7;Result 3.

Derive left-tail/limited-liability put formulas with real-valued bases.

Hypotheses and gaps: Specify support and truncation; negative bases with noninteger powers in displayed formula need correction.

### T145 - Splice no-arbitrage boundaries

**P2 / missing / FIN**. Printed pp. 451; PDF anchor p. 465; source: 27.8-27.10.

Prove convexity and slope conditions at a splice of central and tail call-price curves.

Hypotheses and gaps: Positive strike/maturity; correct derivative orientation; local inequalities versus global arbitrage freedom.

## Chapter 28

### T146 - Second versus fourth moment

**P1 / reuse / MOM**. Printed pp. 453-454; PDF anchor p. 467; source: 28.1.

Prove variance estimator behavior requires more than existence of variance.

Hypotheses and gaps: Finite fourth moment for variance of squared observations; specify estimator and LLN notion.

### T147 - Jensen, insurance and numeraire

**P2 / missing / FIN**. Printed pp. 454-456; PDF anchor p. 468; source: 28.2-28.4.

Formalize payoff convexity effects and numeraire-consistent expectation comparisons.

Hypotheses and gaps: Probability measure, payoff and units fixed; financing assumptions explicit.

### T148 - Tail betting examples

**P3 / model-needed / FIN**. Printed pp. 456-457; PDF anchor p. 470; source: 28.5.

Compute exact expected payoffs in the specified betting model.

Hypotheses and gaps: Integrability and position sizing; selected numerical examples are not investment guarantees.

## Chapter 29

### T149 - Dependence beyond correlation

**P2 / missing / MULTI**. Printed pp. 459-467; PDF anchor p. 473; source: 29.

Construct laws with matching marginals/correlation but different tail dependence and portfolio loss.

Hypotheses and gaps: Finite variances where correlation used; copula or joint law explicit; empirical portfolio claims separate.

### T150 - Portfolio expected shortfall

**P3 / model-needed / FIN**. Printed pp. 459-467; PDF anchor p. 473; source: 29.

Derive risk bounds or optimization results under an explicit joint law and constraints.

Hypotheses and gaps: Integrability; dependence; leverage and admissible set; no blanket theorem that all correlation use fails.

## Chapter 30

### T151 - Tail constraint feasibility

**P1 / missing / ENT**. Printed pp. 469-474; PDF anchor p. 483; source: 30.1-30.2.

Characterize admissible distributions with mass epsilon below K and conditional mean nu_minus.

Hypotheses and gaps: 0<epsilon<1; nu_minus<K; finite conditional moments; total mean relation.

### T152 - Gaussian tail constraint solution

**P2 / missing / ENT**. Printed pp. 474;481; PDF anchor p. 488; source: Proposition 30.1;30.2-30.3.

Derive the two linear equations, solve for mean/scale, and prove sign/limit properties of B(epsilon).

Hypotheses and gaps: Gaussian quantile below zero; K and nu_minus conventions; positive resulting scale; Mills ratio bounds.

### T153 - Two-normal small-variance limit

**P2 / missing / CLT**. Printed pp. 475; PDF anchor p. 489; source: 30.3.1.

Prove mixture constraints are approached as component variances vanish.

Hypotheses and gaps: Weak convergence to two point masses; thresholds away from atom boundary; matching means.

### T154 - Entropy optimizer existence

**P2 / source-check / ENT**. Printed pp. 476-477; PDF anchor p. 490; source: 30.4.

Prove entropy unbounded with tail-only constraints; give conditions for existence and uniqueness with extra constraints.

Hypotheses and gaps: Nonempty feasible set alone does not guarantee an optimizer; entropy defined and finite on comparison class.

### T155 - Piecewise-exponential maximum entropy

**P2 / missing / ENT**. Printed pp. 477; PDF anchor p. 491; source: 30.4.1.

Prove normalization, all three constraints, and global maximum for the candidate density.

Hypotheses and gaps: nu_minus<K<nu_plus; epsilon in (0,1); equality almost everywhere; Gibbs inequality.

### T156 - Absolute-moment entropy optimizer

**P0 / source-check / ENT**. Printed pp. 478; PDF anchor p. 492; source: 30.4.2.

Normalize truncated Laplace part and determine lambda from the absolute moment.

Hypotheses and gaps: When K<0, left contribution is -epsilon*nu_minus, not epsilon*nu_minus; existence/uniqueness of lambda.

### T157 - Power-tail maximum entropy

**P2 / missing / ENT**. Printed pp. 479; PDF anchor p. 493; source: 30.4.3.

Derive normalizer, logarithmic moment equation and uniqueness of alpha.

Hypotheses and gaps: K<0 for displayed normalizer; alpha>0; feasible log constraint; genuine global optimum.

### T158 - Multi-period averages and stable/Gaussian limits

**P2 / missing / CLT**. Printed pp. 480-481; PDF anchor p. 494; source: 30.1;30.4.4.

Derive law of averages and correctly normalized fluctuation limits for each candidate law.

Hypotheses and gaps: iid periods; finite first moment for LLN; finite variance or domain-of-attraction condition for Gaussian normalization.

