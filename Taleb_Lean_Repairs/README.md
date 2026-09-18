# Taleb Lean implementation handoff, v0.2.0

This is an implemented and checked replacement project for the submitted `mathlib-proofs-16.zip`, plus a book-wide formalization inventory for Taleb's third edition. The previous audit ZIP already contained working repairs. This handoff retains that work and adds useful foundation lemmas, probability interfaces, sixteen importable replacement entry points, and repeatable verification.

## Start here

Install Lean using elan, then run inside this directory:

```sh
lake exe cache get
lake build
python3 scripts/verify.py
```

Use the included `lean-toolchain` and `lake-manifest.json`. Lean 4.24.0 is intentional. Mathlib is pinned to `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. Elan selects this project's version even if another project uses a newer Lean. Initial dependency/cache download requires network access. Do not delete the lockfile or update dependencies before reproducing the checks.

The verification script checks installed dependency commits, rebuilds the aggregate project, reruns every axiom query, and writes `evidence/current/verification.json`. Expected result: 50 theorem declarations, one probability-measure instance, and 16 aliases. These are not 67 independent book theorems. Only `propext`, `Classical.choice`, and `Quot.sound` are permitted in their axiom closure. No `sorryAx` is accepted.

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
- `AuditRepairs/Foundations.lean`: eleven additional ratio/tail/moment-algebra results.
- `AuditRepairs/ProbabilityBridge.lean`: genuine subexponential measure definition, finite exponent under self-convolution, convolution powers, independent-sum law, and conditional stable-law identification.
- `AuditRepairs/ImplicitSetDiagnostic.lean`: deliberately reproduces original Proof09's implicit-variable trap and disproves the resulting claim. All production repair modules disable `autoImplicit`; this diagnostic deliberately retains it.
- `Proofs/`: the sixteen named replacement entry points.
- `AuditVerification.lean`: axiom queries for every exported proof declaration.

## What is still open

Existence of a stable probability law for every admissible S1 parameter tuple is not proved here. The stable convolution theorem takes actual probability measures and their characteristic-function identities as explicit premises. The Frechet/Gumbel formula identities do not by themselves construct measures or establish iid maximum laws. General infinite/undefined tail indices need a separate extended-real design; the current safe interface concerns finite positive-tail log-ratio limits.

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

The prior original-file evidence remains in `evidence/`; fresh handoff checks are under `evidence/current/`. Original PASS/FAIL logs intentionally include failures. The book itself and dependency binaries are not redistributed in this package.

The new results are candidates for adaptation and review, not accepted Mathlib contributions. The dependency inventory describes the pinned snapshot and does not establish novelty relative to current Mathlib master. No external contribution or publication has been made.

This project contains noncomputable real/measure-theoretic mathematics. It is not the friend's quantum/classical application's runnable implementation, numerical certification, or deployment. That software requires its actual repository and concrete input/output contract. Formalization and an office demo should have separate acceptance criteria.
