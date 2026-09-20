# Taleb Lean implementation handoff, v0.2.7 (Fable-reviewed, audited five times; probabilistic Property 5.1)

This is an implemented and checked replacement project for the submitted `mathlib-proofs-16.zip`, plus a book-wide formalization inventory for Taleb's third edition. The previous audit ZIP already contained working repairs. This handoff retains that work and adds useful foundation lemmas, probability interfaces, sixteen importable replacement entry points, and repeatable verification.

v0.2.1 is the received v0.2.0 package after an independent reproduction and audit pass; v0.2.2 is v0.2.1 after a corrective pass requested by a second independent audit (harness and documentation only); v0.2.3 adds the first mathematics increment recommended by both reviews — the corrected two-term power-tail lemma (G18), the Gaussian instantiation of the stable bridge (T046), and the independent-maximum law with its Frechet/Gumbel consequences (T060); v0.2.4 answers the second independent audit (recursive module coverage, isolated regression fixtures, wording, ledger states) and closes T060 with the independent-minimum survival law and the law-level `cdf(max) = F^n` / `P(min > x) = S^n` theorems — the first fully discharged backlog family; v0.2.5 answers the third audit (regression-runner CLI defects, source anchor, ledger scope) and constructs the Gumbel and Fréchet probability measures from their distribution functions, instantiating the maximum law for them (T061 children 1–2); v0.2.6 answers the fourth audit (shared ledger validator, two wording repairs) and closes T061 with the reverse-Weibull measure, the positive location/scale pushforward for all three families and the law of the maximum of iid location/scale coordinates as an equality of measures — the second discharged family; v0.2.7 answers the fifth audit (the Markdown ledger had shipped a release stale while the changelog claimed it was synced — both renderings are now generated together and checked; a false continuity claim and a task-routing error corrected, with a correction history in `FABLE_REVIEW.md` §17.1) and proves Property 5.1 for random variables: the survival function of a nonnegative weighted sum has log-tail exponent `min α β`, without independence (T029, probabilistic half). No pre-existing theorem, proof, definition or pin has been changed in any of these releases. Read `FABLE_REVIEW.md` (findings, per-entry assessment, unresolved obligations, §12–§17 addenda), `CHANGELOG_FABLE.md` (every change since v0.2.0) and `docs/AUDIT_HISTORY.md` (the audit rounds). The received evidence is preserved unchanged under `evidence/fable/received_current/`; the review's runs are under `evidence/fable/baseline/`, `evidence/fable/final/` (v0.2.1), `evidence/fable/v0.2.2/`, `evidence/fable/v0.2.3/`, `evidence/fable/v0.2.4/`, `evidence/fable/v0.2.5/`, `evidence/fable/v0.2.6/` and `evidence/fable/v0.2.7/`.

## Start here

Install Lean using elan, then run inside this directory:

```sh
lake exe cache get
lake build
python3 scripts/verify.py
```

Use the included `lean-toolchain` and `lake-manifest.json`. Lean 4.24.0 is intentional. If dependencies are fetched by hand rather than through `lake exe cache get`, note that Lake locates the ProofWidgets cloud release by its tag (`v0.0.74`), so the tag must be fetched along with the pinned commit (observed by the v0.2.4 auditor). Mathlib is pinned to `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. Elan selects this project's version even if another project uses a newer Lean. Initial dependency/cache download requires network access. Do not delete the lockfile or update dependencies before reproducing the checks.

The verification script checks installed dependency commits, rebuilds the aggregate project, reruns every axiom query, and writes `evidence/current/verification.json`. Expected result: 140 theorem declarations, eight probability-measure instances, and 16 aliases (164 checked declarations; v0.2.0 had 50 theorems, v0.2.1 added two boundary diagnostics, v0.2.3 twelve theorems, v0.2.4 nineteen theorems on independent extrema, v0.2.5 twenty theorems and two instances constructing the Gumbel and Fréchet laws, v0.2.6 twenty-two theorems and five instances for the reverse-Weibull and location/scale laws, v0.2.7 fifteen theorems for global continuity of the EVT distribution functions and the probabilistic Property 5.1, see `CHANGELOG_FABLE.md`). These are not 164 independent book theorems. Only `propext`, `Classical.choice`, and `Quot.sound` are permitted in their axiom closure. No `sorryAx` is accepted.

Since v0.2.1 the script also runs `scripts/FableInventory.lean`, which asks the Lean environment for every constant defined in the project modules. Since v0.2.2 this trust scan covers **all** such constants — 296 at present, including 79 internally named ones (`private`, `match_`, `_proof_`, equation lemmas) — and collects each axiom closure before any filtering; the script fails unless every one stays inside the allowlist, no project constant is an `axiom`, every project module on disk (walking subdirectories, since v0.2.4) is imported into the scanned environment, the user-written public theorem/instance constants (provenance decided by Lean's own bookkeeping, not by namespace) coincide with the regex-discovered set, each `Taleb.ProofNN.repaired` alias targets the declaration named in `docs/replacement_map.json`, and every Lean declaration that `docs/FORMALIZATION_BACKLOG.json` credits to a family exists (since v0.2.4); since v0.2.5 the ledger's schema is validated in the same run, and since v0.2.6 by `scripts/backlog_schema.py`, the validator shared with the ledger generator (exact ID sequence `T001…T158`, typed fields, fixed vocabularies, status/state/Boolean agreement, delivery fields present together; audit V025-L1); since v0.2.7 the human-readable `docs/FORMALIZATION_BACKLOG.md` must equal `render_markdown(JSON)` byte for byte — both files are written by the generator from the same validated rows (audit D026-1: the Markdown had shipped a release stale). `python3 scripts/backlog_schema_probes.py` (seconds) replays twelve malformed ledgers and five rendering mutations against these checks. It also fails on any `warning:`/`error:`/`sorry` line in the Lake build log and on any dependency checkout with a modified working tree. All acceptance conditions are explicit checks, not Python `assert`s, so `python3 -O` cannot disable them. Results: `evidence/current/inventory_environment.json`, `verification.json`.

`python3 scripts/harness_regression.py` (about 25–35 minutes; uses a fresh disposable copy under `/tmp`; `--only` accepts only known fixture IDs and a caller-supplied `--scratch` is resolved to an absolute path, since v0.2.5) runs fourteen fixtures — private `sorry` theorem and def, private axiom, user theorem inside a structure namespace, `protected` theorem, wrong alias target in ordinary and `PYTHONOPTIMIZE=1` mode, un-imported flat module, un-imported *nested* module containing a `sorry` (audit V1), a ledger with a duplicate family ID (audit V025-L1, since v0.2.6), dirty dependency, plus three positive controls (the valid package, an imported nested module with a public theorem, and — since v0.2.6 — a theorem placed after a section end inside a namespace, which the v0.2.5 discovery would have misnamed). Since v0.2.4 every fixture starts from re-extracted sources **and** a pristine copy of the project's `.lake/build`, and the restored source-tree hash is checked against the pristine hash before the mutation is applied (audit R1); the verifier's exact command, subprocess exit code and resulting `verification.json` are recorded per fixture (`evidence/current/harness_regression.{json,log}`). It must report `ALL FIXTURES BEHAVED AS EXPECTED` after any change to the verification scripts.

## Using the proofs

```lean
import AuditRepairs

#check Taleb.Proof01.repaired
#check Taleb.Proof08.repaired
#check Taleb.Proof16.repaired
```

Read `docs/REPLACEMENT_MAP.md` before porting call sites. Proof08 and Proof16 now have stronger semantic interfaces, and the false original statements cannot retain their old signatures. The per-proof files import shared implementations, so all sixteen can be imported together without duplicate global definitions.

- `AuditRepairs/RegularVariation.lean`: repaired original ratio-limit lemmas.
- `AuditRepairs/Tails.lean`: finite tail-index interface, limit transport, convexity, and global piecewise Frechet formula identity.
- `AuditRepairs/Stable.lean`: correct S1 expression, specializations, scaling, and original-statement counterexamples.
- `AuditRepairs/Foundations.lean`: eleven additional ratio/tail/moment-algebra results, plus (v0.2.3) the corrected two-term power-tail exponent lemmas `two_power_tail` and `two_power_tail_min` (book Property 5.1 display, G18).
- `AuditRepairs/ProbabilityBridge.lean`: genuine subexponential measure definition, finite exponent under self-convolution, convolution powers, independent-sum law, and conditional stable-law identification.
- `AuditRepairs/GaussianBridge.lean` (v0.2.3): Mathlib's `gaussianReal μ v` has the S1 characteristic function at `α = 2` when `v = 2σ²` (zero scale included), and the conditional stable convolution theorem instantiated at `α = 2`: `N(m, v)^{*n} = N(n m, n v)` through the S1 interface.
- `AuditRepairs/ExtremeValueLaws.lean` (v0.2.5–v0.2.7): the Gumbel, Fréchet (`ξ > 0`) and reverse-Weibull (`α > 0`, upper endpoint `0`) distribution functions as `StieltjesFunction`s (right-continuous and, since v0.2.7, proved globally continuous), their Lebesgue–Stieltjes measures `gumbelMeasure`, `frechetMeasure ξ hξ`, `reverseWeibullMeasure α hα` with `IsProbabilityMeasure` and exact `cdf` identities, analytic max-stability, the maximum law instantiated for each (`cdf_map_maxRV_gumbel`/`_frechet`/`_reverseWeibull`), and product-space iid realizations.
- `AuditRepairs/ExtremeValueAffine.lean` (v0.2.6): the positive affine pushforward `affineLaw ν μ σ = ν.map (fun z => μ + σ z)` with `cdf (affineLaw ν μ σ) x = cdf ν ((x − μ)/σ)` for `σ > 0`; the location/scale families `gumbelLaw`, `frechetLaw`, `reverseWeibullLaw` with their `G((x − μ)/σ)` distribution functions; and the law of the maximum of iid location/scale coordinates as an equality of measures (`map_maxRV_gumbelLaw`: `gumbelLaw (μ + σ log n) σ`; `map_maxRV_frechetLaw`: `frechetLaw ξ μ (σ n^ξ)`; `map_maxRV_reverseWeibullLaw`: `reverseWeibullLaw α μ (σ n^{−1/α})`).
- `AuditRepairs/ExtremeValueBridge.lean` (v0.2.3–v0.2.4): for independent coordinates `P(∀ i, Xᵢ ∈ B) = ∏ P(Xᵢ ∈ B)` for any measurable `B`, the four threshold events (max ≤ x, max < x, min > x, min ≥ x) with their product and `pⁿ` forms, the maximum and minimum as random variables (`maxRV`, `minRV`) with measurability, the law-level theorems `cdf (P.map (maxRV X)) x = (cdf ν x)^n` and `(P.map (minRV X)).real (Ioi x) = (ν.real (Ioi x))^n = (1 − cdf ν x)^n` for measurable coordinates with common law `ν`, and the Frechet/Gumbel max-stability statements for independent maxima whose coordinates have those distribution functions.
- `AuditRepairs/ImplicitSetDiagnostic.lean`: deliberately reproduces original Proof09's implicit-variable trap and disproves the resulting claim. All production repair modules disable `autoImplicit`; this diagnostic deliberately retains it.
- `Proofs/`: the sixteen named replacement entry points.
- `AuditVerification.lean`: axiom queries for every exported proof declaration.
- `scripts/FableInventory.lean`: environment-based inventory of every project constant with axiom closures and Lean-derived provenance, used by `scripts/verify.py` as the trust scan and as an independent cross-check of the regex discovery.
- `scripts/harness_regression.py`: fixture-based regression suite for the verifier itself.
- `AuditRepairs/WeightedSums.lean` (v0.2.7): Property 5.1 for random variables — for pointwise nonnegative `X, Y`, positive weights and survival functions with finite log-tail exponents `α, β`, the survival function of `aX + bY` (and its pushforward law) has exponent `min α β`, with no independence hypothesis (`hasFiniteTailExponent_weightedSum`); reusable rescaling, max, sum and squeeze rules for `HasFiniteTailExponent`.
- `scripts/backlog_schema.py`, `scripts/backlog_schema_probes.py` (v0.2.6–v0.2.7): the ledger validator and Markdown renderer shared by generator and verifier, and their malformed-ledger and rendering probes.
- `docs/SUPPLEMENTAL_OBLIGATIONS.md` (v0.2.7): S-numbered source obligations outside the 158 families (unified GEV parametrisation, EVT densities).

## What is still open

Existence of a stable probability law for every admissible S1 parameter tuple is not proved here; the stable convolution theorem takes actual probability measures and their characteristic-function identities as explicit premises, and since v0.2.3 those premises are shown to hold for Gaussian laws (`α = 2`) but for no `α < 2`. The generic maximum/minimum laws are complete (T060, discharged in v0.2.4), and the three EVT families are constructed as probability measures with location/scale and the law of iid maxima identified (T061, discharged in v0.2.6). Not stated: the unified GEV form in `ξ` with its `ξ → 0` Gumbel limit and the densities of the three laws (supplemental obligations S001/S002 in `docs/SUPPLEMENTAL_OBLIGATIONS.md`, outside the 158 families), and convergence of normalised maxima to these laws — domains of attraction (T011 general formulation, T062 Fréchet/Gaussian cases), which is where the EVT chapter's actual limit theorems live. General infinite/undefined tail indices need a separate extended-real design; the current safe interface concerns finite positive-tail log-ratio limits.

The legacy tangent-only expression and real-valued liminf are preserved for audit comparisons and counterexamples, not as recommended probabilistic definitions. The new subexponential predicate means the heavy-tail convolution class, not the different concentration-theory use of the word subexponential.

## Remaining mathematics

- `docs/FORMALIZATION_BACKLOG.md` and `.json`: 158 obligation families, with source locators, hypotheses, dependency groups, priorities, and status.
- `docs/MATHLIB_AND_WORK_ORDER.md`: existing infrastructure, candidate contributions, and a realistic implementation order.
- `docs/SOURCE_GATES.md`: specific source defects and statement checks to resolve before proof search.
- `docs/source_inventory/`: all 39 chapter/lettered units, 353 PDF bookmarks, 315 numbered-equation locator occurrences, and 71 statement-heading candidates.

These counts describe a structured inventory, not an exhaustive count of atomic mathematical propositions. Equations, definitions, simulations, empirical claims, and theorems are different objects. The full book has not been formally verified or subjected to the same line-by-line correctness audit as the original sixteen files. Chapter 1 is introductory exposition; the inventory links substantive mathematics in later chapters. The JSON locator indexes expose where further atomization is needed.

## Provenance and scope

Source: Nassim Nicholas Taleb, *Statistical Consequences of Fat Tails*, arXiv:2001.10488v4, third edition, 17 September 2025, 523 PDF pages. Printed Arabic pages are PDF page minus 14. PDF bookmarks are navigational hints and can precede the precise displayed formula; verify formulas at their rendered pages.

Original archive SHA-256:
`b0132c09a8835107abaac916578e5e61a703b5a09a800c2e874c24d15d05b47c`

Source PDF SHA-256:
`758e18b7337840104db93296144d67cf5514bf2de128fe557dc84bc32a0ad567`

The prior original-file evidence remains in `evidence/`; fresh handoff checks are under `evidence/current/`. Original PASS/FAIL logs intentionally include failures. The book itself and dependency binaries are not redistributed in this package. The Fable review re-ran the sixteen original files on the pinned environment and reproduced the 8 passed / 8 failed result with identical per-file diagnostics (`evidence/fable/baseline/originals_recheck/`).

The new results are candidates for adaptation and review, not accepted Mathlib contributions. The dependency inventory describes the pinned snapshot and does not establish novelty relative to current Mathlib master. No external contribution or publication has been made.

This project contains noncomputable real/measure-theoretic mathematics. It is not the friend's quantum/classical application's runnable implementation, numerical certification, or deployment. That software requires its actual repository and concrete input/output contract. Formalization and an office demo should have separate acceptance criteria.
