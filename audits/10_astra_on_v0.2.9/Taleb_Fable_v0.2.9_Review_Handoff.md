# Fable implementation handoff after the v0.2.9 audit

Prepared 21 September 2026. Use this alongside the v0.2.9 independent audit and progress ledger. This document gives the next implementation scope; it does not replace the audit's execution evidence.

## Decision on the delivered mathematics

The source audit accepts Pareto Stage B: the threshold conditional law, the excess law, the finite conditional and excess means, conditional raw first-moment divergence, and the positive-power law. The strict threshold includes K=L correctly. The power preimages are computed on the positive support, so totalized powers on negative bases do not enter the law proof. No new mathematical repair is required for these delivered theorems.

T005 correctly moves from missing to partial. T032 correctly gains an exact-Pareto law slice. Their general targets remain open. The T118 moment cross-credit, T028 source locator and archived deliverables-index repair are accepted.

## D029-1: clarify the divergent-moment scope

Only `AuditPareto.lintegral_id_cond_paretoMeasure_eq_top` is exported. It proves divergence of the conditional raw first moment, not a separate extended first moment of `excessLaw`.

Update the grouped mean rows in the audit brief and changelog, T005's `delivery_scope` at the generator, and the generated ledger renderings to say:

> For 0<alpha<=1, the conditional raw first moment diverges as an extended nonnegative integral.

The module introduction, detailed Fable review and main T005 target already state this precisely. Preserve their scope. No new Lean theorem is needed to resolve this low documentation issue. If a later release chooses to claim divergence for the excess law too, add and cite its explicit extended-integral theorem; that addition is optional for the next milestone.

One optional wording improvement to G20: qualify "agrees only at p=1" as "for positive moment orders" or "as an identity in alpha". Negative orders admit accidental pointwise equalities, although they do not restore the printed formula as a general derivative identity. This is not another acceptance gate and does not change the accepted T118 repair.

## Next contained mathematics milestone: the exact-Pareto centered ratio

Focus on the Pareto slice of T021, against the existing pinned `paretoMeasure L alpha`. Reuse Stage A and Stage B. Keep the general T005 layer-cake theorem for a separate later milestone.

Let `nu = paretoMeasure L alpha`, with L>0, and let

`m = alpha*L/(alpha-1)`.

Use actual integrals and Mathlib variance for the identified law. The target is the mean absolute deviation about the mean, `integral |x-m| dnu`. This is distinct from the raw absolute first moment and the median absolute deviation.

### 1. Mean and centered absolute moment for alpha>1

Record or reuse the ordinary expectation `integral x dnu = m`, and establish the needed integrability of the identity, x-m, and |x-m|. Show m>L so Stage B applies at K=m.

Prove

`MAD = integral |x-m| dnu`

`    = 2*L^alpha*m^(1-alpha)/(alpha-1)`

`    = 2*L*(alpha-1)^(alpha-2)/alpha^(alpha-1)`.

The first form is a useful proof intermediate; the last makes the scale and shape dependence explicit. This theorem needs only alpha>1, even though the eventual standard-deviation ratio needs alpha>2.

Recommended route: reuse the Stage B threshold and excess laws at K=m. Their conditional mean excess is m/(alpha-1), and the event probability is S(m)=(L/m)^alpha. Relate the conditional integral back to the unnormalized upper-tail integral through `ProbabilityTheory.cond`. This gives

`integral over x>m of (x-m) dnu = S(m)*m/(alpha-1)`.

Then use the integrable centered variable's zero mean to prove `MAD = 2*integral max(x-m,0) dnu`. This avoids repeating a density calculation. A direct split of the absolute-deviation integral at m is also acceptable; the result must still be an integral theorem under the actual law.

Do not merely simplify the final rational/power expression. The relationship between the centered absolute integral and the tail/excess calculation is the main new proof.

### 2. Variance and standard deviation for alpha>2

Stage A supplies the second raw moment `alpha*L^2/(alpha-2)`. Establish `MemLp id 2 nu`, then use the pinned `ProbabilityTheory.variance_eq_sub` to obtain

`variance id nu = alpha*L^2 / ((alpha-1)^2*(alpha-2))`.

Define standard deviation transparently as the nonnegative square root of that variance, or reuse an equivalent existing interface. Prove

`STD = L/(alpha-1) * sqrt(alpha/(alpha-2))`.

The pinned bridge `MeasureTheory.memLp_two_iff_integrable_sq` is available in `Mathlib/MeasureTheory/Function/L2Space.lean`, lines 48-50. It accepts almost-everywhere strong measurability. `ProbabilityTheory.variance_eq_sub` in `Mathlib/Probability/Moments/Variance.lean`, lines 191-193, requires `MemLp X 2 mu` on a probability measure. These signatures were checked in the exact pinned checkout.

Do not infer divergent variance from Mathlib's real-valued `variance` outside its finite range: it is defined using `evariance.toReal`. Infinite-range statements are not required for this contained milestone. If claimed, formulate them with `evariance` or an appropriate extended nonnegative integral.

### 3. The book's STD/MD ratio for alpha>2

Prove positivity of the mean absolute deviation before division and derive

`STD / MAD = alpha^(alpha-1/2) / (2*sqrt(alpha-2)*(alpha-1)^(alpha-1))`.

The book writes the equivalent form

`1 / (2*sqrt(alpha-2)*(alpha-1)^(alpha-1)*alpha^(1/2-alpha))`.

Source: Eq. (4.14), printed p.86 / PDF 100 of the supplied v4 book. The density and standard deviation on that page agree with the same Pareto law. In the implementation, disambiguate real exponents and real fractions explicitly wherever Lean's type inference needs help.

An optional numerical corollary is L=1, alpha=3: mean 3/2, variance 3/4, MAD 4/9, and ratio `9*sqrt(3)/8`. This is a useful sanity example, not a required separate test suite.

### Delivery accounting

Credit exactly the delivered Pareto centered-moment and ratio slice to T021. Keep the family partial while the stated Gaussian and Student targets remain open. Reuse existing named declarations where appropriate rather than inflating the theorem count with duplicate aliases. Preserve the distinction between a formula identity, an identified-law integral theorem and the broader family target.

## Separate later milestone: general T005 upper-tail identities

Use a probability measure P, a measurable real random variable X that is nonnegative almost everywhere, and K>=0. Let A={X>K}, and let S(t)=P{X>t} in the extended nonnegative reals.

First prove, without a finite-first-moment assumption,

`integral_plus over A of ofReal(X) dP = ofReal(K)*P(A) + integral_plus over t>K of S(t) dt`,

and

`integral_plus of ofReal(X-K) dP = integral_plus over t>K of S(t) dt`.

Here `integral_plus` means Lean's `lintegral`. Both sides may be infinite. No density or no-atoms assumption is required; in particular, mass at X=K is excluded consistently by the strict threshold. Prove the excess formula directly rather than by subtracting potentially infinite quantities.

Reuse `MeasureTheory.lintegral_eq_lintegral_meas_lt` in the pinned `Mathlib/MeasureTheory/Integral/Layercake.lean`, lines 493-495. It already accepts almost-everywhere nonnegativity and `AEMeasurable`, without a sigma-finiteness premise. For the truncated first moment, apply it to `A.indicator X` and split the threshold integral over `(0,K]` and `(K,infinity)`. For the excess, apply it to `max(X-K,0)` and translate the integration variable.

Only after adding `Integrable X P` and proving the tail integral finite should the implementation derive the ordinary real identity. With

`J = integral over t>K of P.real{X>t} dt`,

the real identity is `integral over A of X dP = K*P.real(A) + J`. For P(A)!=0, write s=P.real(A)>0 and derive the conditional raw mean K+J/s and conditional mean excess J/s separately. The pinned real layer-cake result `Integrable.integral_eq_integral_meas_lt` is available in the same file at lines 515-517.

The general source identity is Eq. (2.10), printed p.18 / PDF 32; its indicator/Fubini proof is on printed p.260 / PDF 274, Eqs. (13.4)-(13.7). The current Pareto conditional/excess results are consistency checks for its eventual general realization.

## Packaging and verification

Use the existing pinned toolchain, verification command and release procedure. Regenerate and validate both ledger renderings after source-row changes. Report the declarations actually added and any remaining scope precisely. Do not add regression fixtures merely for the documentation edits or small corollaries; add one only if implementation exposes a concrete verifier defect.

Preserve source and audit history, include the new exact statements and their hypotheses in the next brief, and distinguish existing proof reuse from new formalization. This handoff makes no claim that its proposed new theorems have already been implemented or compiled.
