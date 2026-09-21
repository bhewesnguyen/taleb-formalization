# Fable handoff after the v0.2.8 audit

Date: 21 September 2026.

Use this handoff with the independent v0.2.8 audit and progress ledger. It records the mathematical scope ruling, two small documentation repairs, and the next contained implementation milestone. Runtime and package reproduction results belong to the independent audit report; this handoff does not substitute supplied logs for an independent execution.

## Accepted mathematics and scope

Accept Pareto Stage A against the pinned Mathlib `ProbabilityTheory.paretoMeasure`. The support, endpoint, strict-survival and CDF statements have the correct conventions. The extended nonnegative moments prove finiteness for `p < α` and divergence for `p >= α`, including the boundary. The real moment formula is restricted to the integrable range.

The formula for every real `p < α`, including negative orders, is valid. The positive endpoint `L > 0` keeps the support away from zero. Do not narrow the theorem to nonnegative p merely to match the earlier minimum specification.

Accept T021 and T028 as `partial`. T021 has an exact-Pareto moment slice; its other distribution families and centered deviation ratios remain open. T028 has an exact-Pareto slice with the boundary settled for that law; its general regularly varying boundary remains a statement-review gate. Moving T028 from `source-check` to `partial` records checked work without discharging that general gate.

T029 stays `partial`. Its binary finite-exponent child is complete, and its stronger regular-variation ratio child remains open. The new theorem is a checked specialization to concrete Mathlib Pareto marginal laws. It assumes measurable, pointwise nonnegative coordinates with those laws and discharges their finite-exponent premises using the actual Pareto survival theorem. The `actual_law_constructed` facet is accepted for those concrete marginal laws under the ledger's reuse convention. No separate joint sample-space construction or almost-sure-nonnegativity wrapper is claimed or required for acceptance of Stage A.

## D028-1: credit the delivered moment formula to T118

The existing T118 row is now stale: it says the work is a tail-kernel prerequisite only and lists identification of the Pareto moment formula as still missing. Stage A has proved that identification for the actual pinned law.

Update the authoritative T118 row in `scripts/rebuild_curated_inventory.py`, then regenerate both ledger formats through the existing shared renderer:

1. Keep status `partial` and `discharged = false`.
2. Retain `AuditTails.convexOn_rpow_neg_right` and add the cross-citation `AuditPareto.integral_rpow_paretoMeasure`.
3. Retain `formula_proved`; add `law_theorem` and `actual_law_constructed` for the exact moment-law slice. These facets do not assert that the moment function's convexity has been proved.
4. Replace the "prerequisite only" scope with the two delivered components: convexity of the tail kernel, and identification of `m_p(α) = L^p * α / (α - p)` for the actual Pareto law with `L > 0`, `α > 0`, and `p < α`.
5. Remove moment identification from the remaining obligations. Keep convexity of the moment function and the integrated Jensen inequality open, with common positive scale, `p > 0`, mixing support in `α > p`, and the necessary measurability/integrability or extended-expectation conditions.
6. Add the precise formula anchor: equation (21.7), printed p. 382 / PDF 396, following Proposition 21.1 on printed p. 381 / PDF 395.

One additional citation is sufficient for this repair. It changes 146 family/declaration pairs to 147 while leaving the number of distinct declarations at 142, before any Stage B additions. Do not mistake this credit correction for new formalized mathematics or a discharged family.

For the later convexity task, derive the general formula directly. The source's following second-derivative display omits the factor `p` and replaces `(α-p)^3` with `(α-1)^3`, while retaining the numerator's scale power. It agrees at `p = 1`. For general `p > 0`, the correct expression is

`m_p''(α) = 2 * p * L^p / (α - p)^3`, for `α > p`.

Record this source correction with the future T118 specification. Convexity and Jensen are not added to the Stage B implementation gate below.

## D028-2: correct one T028 source locator

The new T028 delivery scope attributes the constant-factor tail `P(X > x) = C x^(-α)` to printed p. 97 / PDF 111. The expression is on printed p. 95 / PDF 109. Printed p. 97 / PDF 111 contains the log-tail-exponent discussion and Definition 5.1 of the regular-variation class.

Correct the authoritative generator row and regenerate JSON and Markdown together. Use both anchors if both claims are mentioned. The density anchor, printed p. 86 / PDF 100, is correct. No Lean change or family-status change follows from this locator repair.

## Next milestone: Pareto Stage B

Complete the following two core law-identification results, building on Stage A. Keep the pinned toolchain and Mathlib commit. Reuse existing laws and probability APIs.

### A. Conditioning above a threshold and the excess law

For `L > 0`, `α > 0` and `L <= K`, prove an equality of measures:

```text
ProbabilityTheory.cond (paretoMeasure L α) (Set.Ioi K)
  = paretoMeasure K α
```

The pinned `Mathlib.Probability.ConditionalProbability` API already defines `cond ν s` as `(ν s)⁻¹ • ν.restrict s`. Reuse it. Its `cond_isProbabilityMeasure`, `cond_apply` and `cond_apply'` lemmas provide the relevant normalization and event formulas. Prove that the strict conditioning event has positive finite probability using Stage A's survival formula, then establish the law equality through event or CDF identities.

Include `K = L`. At that endpoint the conditioning event has probability one because the Pareto law has no mass at L. Do not state the lower endpoint K result for arbitrary `K < L`, where the conditional law remains the original Pareto(L, α).

Define or identify the conditional excess law by pushing this measure forward under `x -> x - K`. Prove its global strict survival:

```text
S_excess(y) = if y < 0 then 1 else (K / (K + y))^α.
```

The value at `y = 0` is 1. The rational-power formula requires `y >= 0`; it is not the global formula on negative y. A global CDF identity is a useful equivalent form if it makes the law identification clearer.

This is a Pareto slice for T005. Keep the general tail-integral/Tonelli identity open unless it is separately proved. Its source display is equation (2.10), printed p. 18 / PDF 32; the proof is displayed on printed p. 260 / PDF 274.

### B. Positive-power pushforward

For `L > 0`, `α > 0` and `q > 0`, prove an equality of measures:

```text
(paretoMeasure L α).map (fun x => x ^ q)
  = paretoMeasure (L ^ q) (α / q).
```

Both parameters on the right must be shown positive. A route through exact CDF identities and `Measure.eq_of_cdf` is appropriate. Prove the inverse-event relation on the positive support, then transfer it almost everywhere under the Pareto measure. Do not assume that the totalized real-power function has the required monotonicity or inverse-event behavior on all of the real line.

This is the exact-Pareto law slice of T032. Keep its broader power-transformation target open. The source correspondence is Property 5.2 and equation (5.8), printed p. 100 / PDF 114. Neither `q = 0` nor `q < 0` belongs to this target.

### Contained moment corollaries

If they follow directly from Stage A and the new conditional law without expanding the core work, derive for `α > 1`:

- Conditional raw mean: `E[X | X > K] = α K / (α - 1)`.
- Conditional excess mean: `E[X - K | X > K] = K / (α - 1)`.

Keep these two quantities distinct. Establish integrability before asserting a real mean. If divergence for `α <= 1` is claimed, state and prove it using an extended nonnegative integral. These corollaries are useful additions, but proving the two core law identities and the excess distribution does not depend on adding an unrelated moment or convexity project.

## Ledger, verification and delivery

Credit only the statements actually delivered. T005 should become `partial` once its exact-Pareto conditional/excess slice is proved; T032 remains `partial` with its new law-identification slice. Neither broad family closes automatically. T029 remains partial and its stronger regular-variation child stays named precisely. Leave the two discharged EVT families and open supplemental obligations at their reviewed scopes.

Run the normal build and verification workflow, the existing schema/rendering probes, and the regression harness. Include the new declarations in the normal trust scan and ledger-reference checks. Regenerate the Markdown from the validated rows, retaining the raw-byte comparison. A new mathematical milestone does not itself justify adding verifier fixtures that merely duplicate existing checks.

The historical D027-3 index annotation was described as a file outside the reviewed source archive/bundle. Treat that as a packaging-evidence boundary, not a mathematical defect. In the next delivery, include the relevant index file or a verifiable excerpt/path in the handoff evidence so that the historical correction can be checked directly. Do not edit an old supplied validation log to conceal the original count.

Package a reviewable release with the source snapshot, audit brief, exact dependency pins, manifest, machine-readable verification records, patch routes and bundle. Preserve visible correction history. State any incomplete child explicitly and give its exact blocker rather than changing the target silently.
