# Fable implementation handoff after the v0.2.7 audit

The v0.2.7 binary weighted-sum mathematics is accepted. No Lean repair was identified in the new weighted-sum or continuity proofs. The next pass should correct the small documentation and ledger issues below, then implement a contained exact-Pareto milestone against the pinned Mathlib law.

This handoff specifies scope and acceptance criteria. Independent runtime results belong to the companion audit report; they are not asserted here.

## 1. Preserve the accepted milestone and clarify T029

The delivered result is correct: for pointwise nonnegative coordinates, positive weights, and finite log-tail exponents, the weighted sum has exponent equal to the minimum. The measurable pushforward corollary is also correct. Independence is not required.

The prior audit requested this exponent result. Fable delivered it. The older curated target's phrase "heavier regularly varying tail dominates" is a family-scope ambiguity in the audit and ledger history, not a newly discovered mathematical defect in this release.

Keep T029 partial conservatively while its original stronger regular-variation target remains open. Describe the completed binary exponent result as a completed child. Do not change the parent target merely to obtain a third discharged family. Conversely, do not present finite-family, almost-sure-nonnegativity, or infinite-exponent extensions as new conditions for accepting the already delivered binary milestone. Track any agreed extensions separately and keep the finite-real-exponent restriction visible.

### D027-1: stale gap text and delivery facets

Edit the T029 source row in `scripts/rebuild_curated_inventory.py`, then regenerate both ledger files through the existing shared renderer.

Replace the stale sentence "The probabilistic statement about sums of random variables remains open" with wording such as:

> The binary probabilistic finite-log-exponent statement was delivered in v0.2.7 for pointwise nonnegative coordinates and positive weights. The original unequal-index regular-variation dominance target remains open. Finite-family and almost-sure extensions are separately recorded follow-ups, not missing premises of the delivered theorem.

Add `conditional_law_theorem` to T029's delivery facets because, under this ledger's existing definition, the two weighted-sum exponent theorems assume the coordinate finite-exponent properties. This is a classification correction under the project's vocabulary, not a criticism of ordinary mathematical implication or a demand to prove the premises universally.

Retain `law_theorem`, and explain its exact support: `AuditProbability.survivalRV_eq_survival_map` identifies the event-tail function with the tail of the actual pushforward under the ordinary measurability hypothesis. Keep `formula_proved` and `source_reviewed`. Do not add `actual_law_constructed` solely because a theorem assumes arbitrary probability laws.

Ensure `delivery_scope`, `remaining_obligations`, `hypotheses_and_gaps`, and the review narrative agree. The rendering check catches mismatched copies, not stale meaning shared by both copies.

### The precise stronger regular-variation child

Use the following target when this child is implemented. Let `X,Y` be measurable nonnegative real-valued coordinates on one probability space, let `a,b > 0`, and suppose their eventually positive survival functions are regularly varying with indices `-alpha,-beta`, with `0 <= alpha < beta`. A first version restricted to `0 < alpha < beta` matches the usual positive-shape source convention.

For `Z = a X + b Y`, prove

\[
\frac{S_Z(t)}{S_X(t/a)}\longrightarrow 1,
\qquad
\frac{S_Z(t)}{S_X(t)}\longrightarrow a^\alpha.
\]

No independence is needed. For each `0 < delta < 1`, use

\[
S_X(t/a)\leq S_Z(t)
\leq S_X((1-\delta)t/a)+S_Y(\delta t/b).
\]

After division by `S_X(t/a)`, regular variation gives the first upper term's limit `(1-delta)^(-alpha)`; the strictly lighter tail gives limit zero for the other term. Let `delta` tend to zero. This is a separate ratio proof; the existing exponent theorem alone does not imply it.

Do not omit the weight in the denominator. Do not extend this claim to comparable equal-index dependent tails without new hypotheses. Exact iid convolution asymptotics remain in the subexponential workstream.

## 2. Correct the supplemental specification

### D027-2: S001 needs an explicit zero-shape branch

Correct `docs/SUPPLEMENTAL_OBLIGATIONS.md` so its proposed unified GEV definition includes the Gumbel branch explicitly. For the standardized family, specify

\[
G_0(x)=\exp(-\exp(-x)),
\]

and for `xi != 0` with `1 + xi*x > 0`, specify

\[
G_\xi(x)=\exp(-(1+\xi x)^{-1/\xi}).
\]

Outside that support, use zero when `xi > 0` and one when `xi < 0`. Do not substitute `xi = 0` into the totalized division/power expression. State the desired pointwise limit at zero against this explicit branch.

Correct the source range to printed pp. 172-173 / PDF pp. 186-187. Equation (9.1), the maximum law, and the unified GEV kernel following (9.2) are on printed p. 172; the zero-shape limit and three named distribution-function forms are on printed p. 173. The source writes the unified kernel with a proportionality sign. The supplemental task should specify the normalized, support-complete CDF and its explicit zero-shape branch, then prove the stated limit.

Preserve and sharpen the endpoint reparametrization warning. For canonical location `mu`, scale `sigma > 0`, and nonzero shape `xi`, the endpoint is

\[
e=\mu-\sigma/\xi.
\]

The correspondence to the existing endpoint-coordinate API is:

| Canonical shape | Existing law, with positivity proof arguments suppressed |
|---|---|
| `xi > 0` | `frechetLaw xi e (sigma/xi)` |
| `xi < 0` | `reverseWeibullLaw (-1/xi) e (-sigma/xi)` |
| `xi = 0` | `gumbelLaw mu sigma` |

This is a documentation correction to an open supplemental task. Do not implement S001 or reopen T061 as part of the next contained Pareto milestone. S002 also remains separate.

## 3. Correct the evidence summary count

### D027-3: archive-validation probe count

The v0.2.7 external `archive_validation_v0.2.7.log`, step 7, says "17 probes ok" while the probe set and supporting records have 18 results. Correct the summary to 18 with a visible correction note. Preserve the original release artifact and its provenance; do not silently rewrite an archived log or pretend the correction is a new execution.

Use the machine-readable probe result to populate future human summaries. This typo does not call for another Lean fixture or a new expensive full regression run by itself.

## 4. Next contained mathematics milestone: exact Pareto law and moments

Keep the first implementation stage focused on the actual pinned law, its global distribution functions, and exact nonnegative moments. Stop and package that coherent result before adding general regular-variation integration theory or multiple other distribution families.

The inspected pinned file is `Mathlib/Probability/Distributions/Pareto.lean`. It already defines:

- `ProbabilityTheory.paretoPDFReal L alpha x` and its nonnegative extended-valued version;
- `ProbabilityTheory.paretoMeasure L alpha` as `volume.withDensity`;
- `isProbabilityMeasure_paretoMeasure` under `0 < L` and `0 < alpha`;
- CDF-to-integral identities.

Reuse those definitions. The probability theorem is a lemma, so install its instance locally when required. Do not introduce a parallel Pareto probability measure and later leave its identification with Mathlib open. No pin upgrade is needed for this scope.

### Stage A: law identification and exact moments

Assume `L > 0` and `alpha > 0`. Prove the support statement and global CDF and strict survival identities for the pinned law. A convenient convention is

\[
F(x)=
\begin{cases}
0,&x<L,\\
1-(L/x)^\alpha,&x\geq L,
\end{cases}
\qquad
S(x)=
\begin{cases}
1,&x<L,\\
(L/x)^\alpha,&x\geq L.
\end{cases}
\]

Check `x = L` explicitly: the CDF is zero and strict survival is one because this law has no mass at the lower endpoint. An equivalent `x <= L` branch convention is fine. Keep support guards on expressions involving division and real powers.

For real moment order `p >= 0`, prove integrability exactly when `p < alpha`, and under that condition prove

\[
\int x^p\,d\operatorname{Pareto}(L,\alpha)
=\frac{\alpha L^p}{\alpha-p}.
\]

The `p = 0` case must give one. The support is positive, so these are also absolute moments; make that connection explicit where a ledger target uses absolute-moment language.

For `p >= alpha`, prove divergence in the extended nonnegative integral interface, for example

\[
\int^-\!\operatorname{ENNReal.ofReal}(x^p)\,
d\operatorname{Pareto}(L,\alpha)=\top.
\]

Use proper Lean `lintegral` notation in the implementation. Include the boundary `p = alpha`, whose density-weighted integrand has the logarithmically divergent `x^(-1)` behavior. A totalized real integral may equal zero for a nonintegrable function; that value is never evidence of finiteness or the divergent moment's mathematical value.

Prefer an extended-integral piecewise formula or an explicit finite/divergent pair plus the integrability equivalence. Establish the required measurability and almost-everywhere nonnegativity, then derive the real-integral formula only in the integrable range. `affineLaw` supplies useful pushforward and CDF infrastructure, but it does not replace these integration arguments.

This stage can credit the exact-Pareto slices of T021 and T028, with any CDF/support prerequisites recorded in their scope. It does not discharge the entire multi-distribution T021 or the general regularly varying T028 family. Do not add the source's unrelated moment or domain-of-attraction targets to this milestone.

### Stage B: conditional, excess, and positive-power laws

Implement this as the next stage after Stage A is accepted, or as a separately reported child if Stage A is already complete and verified. It is not required to make the first Pareto package reviewable.

For a threshold `K >= L`, prove the positive survival probability and the normalized restricted-law identity

\[
\mathcal L(X\mid X>K)=\operatorname{Pareto}(K,\alpha).
\]

State the normalization explicitly in the chosen conditional-law API. Derive the excess-law survival for `y >= 0`,

\[
\Pr(X-K>y\mid X>K)=(K/(K+y))^\alpha.
\]

For `alpha > 1`, this gives conditional mean `alpha*K/(alpha-1)` and mean excess `K/(alpha-1)`; use extended nonnegative integrals for the divergent cases. Credit only the exact-Pareto slice of T005. The general tail-integral identity and arbitrary-law conditional formulas remain open unless separately proved.

For positive power `q > 0`, identify the pushforward measure exactly:

\[
\operatorname{Pareto}(L,\alpha).\operatorname{map}(x\mapsto x^q)
=\operatorname{Pareto}(L^q,\alpha/q).
\]

Include measurability, the inverse-event argument on the positive support, and equality of measures. Credit the exact-Pareto slice of T032 while preserving any broader remaining target. Do not use the formula-only exponent identity as a substitute for law identification.

## 5. Keep the verification and handoff proportionate

Apply the documentation corrections at their generating sources, regenerate the paired ledgers, and run the existing fast schema/rendering probes. Add public declarations and precise ledger citations for the Pareto results actually proved. Keep the existing verifier, trust scan, and release gates intact.

Document the next release with the precise definitions, parameter conventions, proof hypotheses, and completed slices. Keep assumed properties distinct from concrete law identification. Preserve the audit-response history, unchanged source targets, and explicitly open work. Do not claim completion percentages from declaration counts or from the number of families touched.

There is no requested repair patch for the accepted v0.2.7 Lean mathematics. The required corrections are the three documentation/ledger items above. The next new proof work is the contained Stage A Pareto milestone.
