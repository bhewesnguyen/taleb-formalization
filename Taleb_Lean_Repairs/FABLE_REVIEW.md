# Fable review of the Taleb Lean formalization handoff (v0.2.0 → v0.2.1)

Independent reproduction, audit and repair of `Taleb_Lean_Implementation_Handoff.zip`
(SHA-256 `8a8fb28af0b492c34edd02275ace60b213eedac1f41ec2514505588157cab406`), performed
18 September 2026 on the pinned toolchain (Lean `leanprover/lean4:v4.24.0`, Mathlib
`f897ebcf72cd16f89ab4577d0c826cd14afaafc7`, transitive dependencies from the supplied
`lake-manifest.json`, all unchanged). The source of comparison is Taleb, *Statistical
Consequences of Fat Tails*, arXiv:2001.10488v4 (PDF SHA-256
`758e18b7337840104db93296144d67cf5514bf2de128fe557dc84bc32a0ad567`, 523 PDF pages).
Throughout, "printed p. N" is the Arabic page printed on the page and "PDF p. N+14"
is the viewer page; the offset was verified on several pages.

## 0. Status summary

| Item | Status |
|---|---|
| Baseline reproduction (received source, no edits) | **Reproduced.** Clean `lake build` exit 0 (26 s, all 24 project modules built, 2643 jobs, no warnings); `scripts/verify.py` exit 0, `PASS: 50 theorems, 1 instance, 16 aliases`. Regenerated `verification.json` identical to the received one except `elapsed_seconds`; `axioms.log`, `declarations.json` byte-identical. Legacy claim "8 of 16 original files pass" reproduced with identical per-file exit/error/warning counts. |
| Final build (repaired source) | **Passes.** Clean `lake build` exit 0 (26 s, 2643 jobs, no warnings, no errors); `scripts/verify.py` exit 0, `PASS: 52 theorems, 1 instance, 16 aliases` (69 checked). |
| Axiom checks | **All 69 exported proof declarations depend exactly on `propext`, `Classical.choice`, `Quot.sound`.** Independently, every one of the 102 project constants the Lean environment attributes to the project modules (including 13 `def`s and 19 structure-generated constants) has the same closure. No `sorryAx`, no other axiom, no `sorry`/`admit`, no new axioms. |
| Source correspondence | **Checked for all sixteen entries against the pinned PDF** (Sections 2.2.1, 2.2.9, 2.2.12, 5.1, 5.2, 7.2.1–7.2.2, 9.1, 15.2.1, 21.2, E.1). No Lean statement contradicts the book. Two new source defects found and recorded (G17, G18). Several entries formalize *analogues* or *special cases* of book statements rather than displayed theorems; these are itemised in §6. |
| Unresolved mathematical obligations | **Unchanged in substance:** stable-law existence, Gaussian/Cauchy law identification with the S1 expression, Fréchet/Gumbel measure construction and iid maximum laws, subexponentiality of any concrete law, positive/measurable regular variation and Karamata, extended-real tail index, Pareto moment integrals, gamma inverse moments. Listed in §9 with backlog ids. |

Repairs made (§8): the verification harness now cross-checks its regex-based discovery
against the Lean environment and the documented alias map (a latent coverage hole,
demonstrated to be caught by negative tests); two boundary diagnostics were added as
checked facts behind review findings; one misleading code comment was corrected; the
documentation, replacement map and backlog were updated for the new findings. **No
theorem statement was weakened, removed or altered; no proof was changed.**

## 1. What was executed, what Lean checked, what was compared by hand

Executed (logs under `evidence/fable/`):

- `sha256sum -c SHA256SUMS` on the extracted tree: 72/72 OK (`received_current/SHA256SUMS_check_on_extracted_tree.log`).
- `lake exe cache get` (run by the repository owner in an unsandboxed terminal because the
  review sandbox had no DNS/egress; log `baseline/00_lake_exe_cache_get.log`): installed
  Lean v4.24.0, cloned nine packages at the manifest revisions, unpacked 7335 cache files.
- Baseline: `lake build`, `python3 scripts/verify.py` (`baseline/01_*.log`, `02_*.log`,
  `baseline/current_after_verify/`, `baseline/environment.md`).
- Legacy re-check: `lake env lean` on each of the 16 original files from
  `evidence/source/mathlib-proofs-16.zip` (`baseline/originals_recheck/`).
- Environment inventory: `lake env lean scripts/FableInventory.lean` (new; §5).
- Harness negative tests (`final/harness_negative_tests.log`).
- Final: `rm -rf .lake/build; lake build`, `python3 scripts/verify.py` (`final/01_*.log`,
  `02_*.log`, `final/current_after_verify/`, `final/environment.md`,
  `final/declaration_inventory.md`).
- Archive validation from a fresh extraction of the final ZIP. Because that log validates the
  ZIP itself, it lives alongside the deliverables (`deliverables/v0.2.1/archive_validation.log`), not
  inside the archive; see `CHANGELOG_FABLE.md`.

What Lean checked: the 69 declarations of §5 elaborate without `sorry`, with the stated axiom
closure, in the pinned environment. A successful build establishes the validity of the
**encoded** statements under their **stated hypotheses and the project's definitions**; it
does not establish that those statements are the book's statements.

What was compared by hand: every source anchor in `docs/REPLACEMENT_MAP.md` was located in
the PDF via the handoff's bookmark index, read in the text layer (`pdftotext -layout`) and,
for every displayed formula on which a finding rests ((7.2), 15.2.1, Property 5.1), rendered
and inspected visually. Mathematical adequacy of each formal statement was assessed by
reading the Lean source, not only its docstrings.

Not done: no comparison with current Mathlib master (novelty claims are out of scope and
none are made); no numerical or empirical claim of the book was assessed; no chapter of the
book beyond the anchored sections was audited line by line.

## 2. Inputs and integrity

| Artifact | SHA-256 | Note |
|---|---|---|
| `Taleb_Lean_Implementation_Handoff.zip` | `8a8fb28a…57cab406` | 73 files; `SHA256SUMS` lists 72 (itself excluded); all verify. |
| `evidence/source/mathlib-proofs-16.zip` (nested original submission) | `b0132c09…5d05b47c` | matches README and companion PDF; its own `SHA256SUMS` verifies. |
| `2001.10488v4.pdf` | `758e18b7…0ad567` | matches `docs/source_inventory/source_metadata.json`; 523 pages, pdfLaTeX. Not redistributed. |
| `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` | `8e32b270…ae221f4b` | companion report, 31 pages; counts in it refer to v0.2.0. |
| `Taleb_Fat_Tails_Lean_Audit.pdf`, `Taleb_Lean_Checked_Repairs.zip` | `ac94f4df…`, `cbd5c442…` | prior audit and prior v0.1 repair bundle; consulted for lineage only. |

Full hashes: `evidence/fable/received_current/RECEIVED_ARTIFACTS.sha256`; every extracted
file: `received_tree_all_files.sha256`.

## 3. Environment and baseline reproduction

Host: Ubuntu 24.04.5, kernel 7.0.0-31, x86_64, 32 CPUs, 61 GiB RAM. elan 4.2.4. Lean
4.24.0 (commit `797c613eb9b6d4ec95db23e3e00af9ac6657f24b`, identical to the received
`verification.json`), Lake 5.0.0. Python 3.12.3. The only setup change was elan installing
the v4.24.0 toolchain; no dependency was upgraded or modified (all nine checkouts at the
manifest revisions, clean working trees). Details: `evidence/fable/baseline/environment.md`.

| Command | Exit | Time | Result |
|---|---|---|---|
| `lake build` (no prior project build directory) | 0 | 26 s | `Build completed successfully (2643 jobs)`; 24 modules `Built`; 0 warnings; 101 info lines (all `#print axioms`/`#check`/`#print`). |
| `python3 scripts/verify.py` | 0 | 19 s | `PASS: 50 theorems, 1 instance, 16 aliases; no extra axioms`. |
| 16 originals via `lake env lean` | 8×0, 8×1 | ~1.5 s each | 01, 04, 07, 10, 11, 13, 15, 16 pass; 02, 03, 05, 06, 08, 09, 12, 14 fail, with the same error/warning counts as `evidence/summary.json`. |

The received `evidence/current/build.log` shows the project modules as `Replayed`, i.e. it
was captured from a warm cache; the baseline here is a clean build of the project modules
and confirms the same outcome.

## 4. Inventory reconciliation

The received figure "50 theorems + 1 instance + 16 aliases = 67" was reconciled three ways:

1. **Regex discovery** (`scripts/verify.py:declarations`) on the received source: 67.
2. **Lean environment** (`scripts/FableInventory.lean`, new): the project modules define 100
   non-internal constants (plus 35 internal auxiliaries such as equation lemmas and
   `match_` splitters). Of these, 74 are theorem-kind or instances; **67 are user-written**
   (51 in `AuditRepairs/*.lean` + 16 aliases) and **7 are generated by
   `structure StableAudit.StableParameters`** (`alpha_pos`, `alpha_le_two`, `beta_bounds`,
   `scale_nonneg`, `mk.inj`, `mk.injEq`, `mk.sizeOf_spec`). The user-written set equals the
   regex set exactly. The remaining 26 are 13 `def`s, 12 structure-generated non-theorem
   constants (projections, `rec`, `casesOn`, `noConfusion`, …) and the structure type
   `StableAudit.StableParameters` itself.
3. **Alias targets**: all 16 `Taleb.ProofNN.repaired` aliases resolve, in the environment, to
   the declarations named in `docs/replacement_map.json`.

Final package: 52 + 1 + 16 = 69 checked; environment 102 constants (the two additions are
`AuditRV.isSlowlyVarying_neg_one` and `AuditTails.frechetFormula_zero`). All 102 have the
closure `{propext, Classical.choice, Quot.sound}`. Full list with exact statements:
`evidence/fable/final/declaration_inventory.md`.

As the handoff itself states, these are not 69 independent book theorems: the count includes
16 aliases (no content), 9 diagnostics/counterexamples about the *original* files or about
Lean boundary values, several duplicate proofs of the same statement
(`gaussian_stable_real`/`_short`, `cauchy_stable`/`_short`, `gaussian_specialization` vs
`stableS1Expr_gaussian`), and foundation lemmas.

## 5. Verification harness audit

Findings on the received `scripts/verify.py` (all latent: coverage of the received source was
complete, as §4 shows):

- **H1 (coverage rule).** Declarations are discovered by the line regex
  `^(theorem|lemma|instance)\s+` over `AuditRepairs/*.lean`. Any `protected`/`private`
  theorem, an attribute on the same line, an indented declaration, or a `section … end`
  (the namespace stack pops on *every* `end`) would be silently omitted while the script
  still reports PASS. The staleness assertion on `AuditVerification.lean` does not help,
  because it is generated from the same regex.
- **H2 (aliases).** Alias names are synthesised from the sorted order of `Proofs/Proof*.lean`;
  the alias *targets* are never read, so `docs/replacement_map.json` and the code could
  drift apart unnoticed.
- **H3 (defs).** Only theorems/instances are axiom-checked. A `def` containing `sorry` that is
  used by no checked theorem would not be reported (no such `def` exists).
- **H4 (positives).** Dependency-commit check, the axiom regex, the `sorryAx`/diagnostic scan
  of the axiom run, and the "stale inventory" assertion are sound and were confirmed to work.

Repair (§8, R1): `verify.py` now runs `scripts/FableInventory.lean`, which enumerates every
constant whose defining module is a project module, and asserts (a) user-written
theorem/instance constants == regex set, (b) every listed constant is within the allowlist,
(c) alias targets == `docs/replacement_map.json`. It writes
`evidence/current/inventory_environment.json`. Negative tests
(`evidence/fable/final/harness_negative_tests.log`): a `protected theorem` appended to
`RegularVariation.lean` produced `FAIL: Environment/regex inventory mismatch:
['AuditRV.regex_blind_spot']`; a wrong target in `replacement_map.json` produced
`FAIL: Alias targets differ … Taleb.Proof16.repaired`. Source and map were restored
byte-identically afterwards (hashes in the log).

## 6. Source correspondence and new source gates

### 6.1 Definitions used by the book

- Slowly varying / regular variation: §2.2.1 (printed p. 9, PDF 23), §5.1 (printed p. 96,
  PDF 110), §E.1 (printed p. 190, PDF 204), Definition 21.1 (printed p. 380, PDF 394). In all
  four places `L` has **codomain (0, +∞)** and the class is defined through the ratio limit
  `L(kx)/L(x) → 1`. The project's `AuditRV.IsSlowlyVarying`/`IsRegularlyVarying` keep only
  the ratio limit ("ratio-only", as the handoff says). Consequence, now pinned by
  `AuditRV.isSlowlyVarying_neg_one`: the predicate holds for `fun _ => -1`, which is not a
  slowly varying function in the book's sense. Every result stated for these predicates is
  correct for the predicate but needs an explicit positivity hypothesis before it is read as
  a statement about the book's class. Sign convention: `IsRegularlyVarying L α` is the
  book's `RV_ρ` with `ρ = α`; a Paretian survival function `L(x)x^{-α}` is
  `IsRegularlyVarying S (-α)`.
- Tail exponent: printed p. 97 (PDF 111): "`log P(X>x)/log x` converges to a constant, namely
  the tail exponent `-α`". `AuditTails.HasFiniteTailExponent S α` is exactly this limit
  (with the sign flipped to make α positive) plus eventual positivity of `S`.
- Subexponential class: (5.1) printed p. 92 (PDF 106) and (2.7) printed p. 13 (PDF 27): iid,
  support in ℝ⁺, `lim (1 − F^{*2}(x))/(1 − F(x)) = 2`. `AuditProbability.IsSubexponential`
  matches this literally (`1 − F(x) = μ(Ioi x)`, self-convolution `μ ∗ μ`).
- Stable characteristic function: (7.2) printed p. 140 (PDF 154) and (2.6) printed p. 13
  (PDF 27), both **only for `α ≠ 1`**, constraints `−1 ≤ β ≤ 1`, `0 < α ≤ 2`; the book then
  says "Intuitively, `χ(t)^n` is the same form as `χ(t)`, with `µ → nµ` and `σ → n^{1/α}σ`".
  The two-branch S1 form (with the `α = 1` logarithmic branch) appears only in 15.2.1
  (printed p. 282, PDF 296) — with a misprint, see G17.
- EVT: §9.1 printed p. 173 (PDF 187): Gumbel `exp(−exp(−(x−b_n)/a_n))`; Fréchet `0` for
  `x ≤ b_n`, `exp(−((x−b_n)/a_n)^{−α})` for `x > b_n`, `ξ = 1/α`. `gumbelCDF`/`frechetCDF`
  are the standardised (`b_n = 0`, `a_n = 1`) versions.

### 6.2 New source gates (added to `docs/SOURCE_GATES.md`)

- **G17 — 15.2.1 prints the S1 characteristic function with misplaced parentheses**
  (printed p. 282, PDF 296; visually checked). Both branches close the parenthesis before the
  `tan(πα/2)` resp. `ln|t|` factor. Read literally the exponent's real part is
  `−γ^α|t|^α tan(πα/2)` (positive for `1<α<2`) resp. `−γ|t| ln|t|` (positive for `|t|<1`),
  so `|χ(t)| > 1`, impossible. `StableAudit.stableS1Expr` implements the standard S1 form
  (Samorodnitsky–Taqqu Def. 1.1.6; Nolan), which coincides with (7.2) for `α ≠ 1`. The same
  section states `α ∈ (0,2)` where (7.2)/(2.6) state `0 < α ≤ 2`. No Lean statement depends
  on the misprinted reading.
- **G18 — the displayed limit under Property 5.1 has the wrong sign** (printed p. 99,
  PDF 113; visually checked): `lim log(w₁z^{−α₁}+w₂z^{−α₂})/log z = α₂` is printed, but the
  left side tends to `−α₂` (the argument of the log tends to 0). The corrected two-term
  limit is a statement about survival-function *formulas*; it does not establish Property
  5.1 in its printed scope, which admits dependent, signed summands and is then false by
  cancellation (`X = EZ`, `Y = −2EZ`, `2X + Y = 0`; see G18 and the addendum below). Backlog
  T029 is `source-check` with the corrected formula-level statement as its first target and
  nonnegative summands as the valid probabilistic scope.

### 6.3 Correspondence classification

- Literal (statement is displayed in the book, up to standardisation): 10, 11 (§9.1);
  the definition parts of 07 (p. 97) and 08 ((5.1)); 12–16's underlying scaling claim
  (p. 140); 06 (definition of the class P, (5.7)/(2.1)).
- Special case or analogue of a displayed statement: 08 (two-summand iid case of Property
  5.1 under the subexponential hypothesis, at the level of a tail-exponent limit); 09
  (convexity of `α ↦ c^{−α}` is the survival-function analogue of the moment convexity the
  book states in (21.7) and p. 382; not itself displayed); 13, 15 (real-valued exponent
  scaling identities).
- Standard lemmas about the book's definitions, not displayed in the book: 01, 02, 03, 04,
  05 (the book's 5.2.2 concerns products of random *variables*, exponent `min α_i`, a different
  object from Proof04's product of *functions*, exponent `α₁+α₂`, as the replacement map says).
- Sourced outside the book: the `α = 1` branch of `stableS1Expr` (standard S1; in the book
  only via the misprinted 15.2.1).

## 7. Per-entry assessment, Proof01–Proof16

For each entry: the checked declaration (exact statement in
`evidence/fable/final/declaration_inventory.md`), the original file's fate on the pinned
environment (re-checked here), source anchor, and what remains open. All 16 aliases
compile and have the permitted axiom closure.

| # | Checked declaration | Original file | Statement and assumptions (as encoded) | Source | Remaining gap |
|---|---|---|---|---|---|
| 01 | `AuditRV.isSlowlyVarying_log` | passed | `IsSlowlyVarying Real.log`, no hypotheses. | §2.2.1 p. 9, §5.1 p. 96 (definition); `log` not displayed as an example. | Ratio-only predicate; `log` is non-positive on (0,1] and strictly positive only for `x > 1`, so it is in the book's positive class on `[x_min, ∞)` for any `x_min > 1` (eventual positivity). |
| 02 | `AuditRV.isSlowlyVarying_const` | failed (`simp` no progress) | `c ≠ 0 → IsSlowlyVarying (fun _ => c)`. | P1 class "L constant", p. 381. | Book needs `c > 0`; `c < 0` is admitted here (`isSlowlyVarying_neg_one`). |
| 03 | `AuditRV.IsSlowlyVarying.of_tendsto_const` | failed (wrong composition) | `c ≠ 0 → Tendsto L atTop (𝓝 c) → IsSlowlyVarying L`. | "Karamata constant", p. 9. | Converse false (G01, `log`); book's limit is positive. |
| 04 | `AuditRV.IsRegularlyVarying.mul` | passed | `IsRegularlyVarying L₁ α₁ → IsRegularlyVarying L₂ α₂ → IsRegularlyVarying (L₁·L₂) (α₁+α₂)`. | not displayed; cf. 5.2.2 p. 99 (variables, `min`). | Function-level only. |
| 05 | `AuditRV.IsRegularlyVarying.rpow` | failed (invalid field, exponent order) | `IsRegularlyVarying L α → (∀ᶠ x, 0 < L x) → IsRegularlyVarying (L^p) (p·α)`. | not displayed; power transforms (T032). | Eventual positivity is genuinely needed (`Real.div_rpow`). |
| 06 | `AuditRV.isRegularlyVarying_iff_slowlyVarying` | failed (redundant tactics) | `IsRegularlyVarying L α ↔ IsSlowlyVarying (fun x => L x / x^α)`, no sign hypothesis. | class P (5.7) p. 97, (2.1) p. 9. | True for the ratio-only predicate because Lean's `0/0 = 0`; not Karamata's representation. |
| 07 | `AuditTails.pareto_hasFiniteTailExponent` | passed (with `0 < α`, `Tendsto` only) | `0 < C → HasFiniteTailExponent (fun x => C·x^{−α}) α` for every real `α`. | p. 97 (limit definition), (E.3) p. 191 Pareto. | `α ≤ 0` is not a survival function; analytic identity only. Legacy `tailExponentReal` kept with diagnostics `tailExponentReal_zero`, `real_liminf_of_tendsto_atTop`. |
| 08 | `AuditProbability.IsSubexponential.finiteTailExponent` | failed (orientation); definition connected two unrelated functions | `IsSubexponential μ → HasFiniteTailExponent (survival μ) α → HasFiniteTailExponent (survival (μ∗μ)) α`. | (5.1) p. 92; two-summand iid case of Property 5.1 p. 99. | No concrete law is proved subexponential (T008/T024/T025); "subexponential" is the heavy-tail class, not the concentration class. |
| 09 | `AuditTails.convexOn_rpow_neg_right` | failed; as elaborated it quantified over an arbitrary `univ : Set ℝ` (false) | `0 < c → ConvexOn ℝ Set.univ (fun α => c^{−α})`. | §21.2 pp. 380–382 (moment convexity (21.7), Jensen sketch) — analogue. | Jensen/integration for stochastic α not done (T118). Diagnostic `Proof09Probe` reproduces the original's implicit variable and refutes the claim at `{0,2}` — preserved. |
| 10 | `AuditTails.frechet_cdf_maxstable` | passed (raw formula, `0 < x` only) | `0 < ξ → 0 < n → (frechetCDF ξ x)^n = frechetCDF ξ (n^{−ξ}·x)` for all `x`. | §9.1 p. 173, `ξ = 1/α`, standardised. | Not a measure; `frechetFormula ξ 0 = 1` (new diagnostic `frechetFormula_zero`) shows why the piecewise CDF is needed; iid maximum law open (T060). |
| 11 | `AuditTails.gumbel_maxstable` | passed | `0 < n → (gumbelCDF x)^n = gumbelCDF (x − log n)`. | §9.1 p. 173. | Same as 10. `n > 0` is necessary (`Real.log 0 = 0`). |
| 12 | `StableAudit.stableS1Expr_gaussian` | failed; statement false (location/scale swapped), counterexample `submitted_gaussian_counterexample` | `stableS1Expr 2 β μ σ t = exp(−(σt)² + iμt)`. | (7.2) p. 140 at `α = 2`. | Expression-level; `exp(−σ²t²)` is `N(μ, 2σ²)` (book silent; G05). Law identification open (T046). |
| 13 | `StableAudit.gaussian_stable_real_short` | passed | `(exp(−(σt)²))^n = exp(−((n^{1/2}σt)²))`. | p. 140, `σ → n^{1/α}σ`. | Real identity; distribution-level closure exists in Mathlib (`gaussianReal_conv_gaussianReal`). |
| 14 | `StableAudit.stableS1Expr_cauchy` | failed; statement false (swap), counterexample `submitted_cauchy_counterexample` | `0 ≤ σ → stableS1Expr 1 0 0 σ t = exp(−σ|t|)`. | p. 140 "Cauchy α = 1"; (7.2) excludes `α = 1`; branch from 15.2.1 (G17). | `β = 0` makes the log branch vanish; `σ = 0` is Dirac. |
| 15 | `StableAudit.cauchy_stable_short` | passed | `(exp(−σ|t|))^n = exp(−(nσ)|t|)`. | p. 140 at `α = 1`. | Real identity. |
| 16 | `AuditProbability.stableS1_convolutionPower_eq` | passed (tangent-only algebra for all `α > 0`; retained as `stableExpr_power`) | For probability measures `μ ν`, `p : StableParameters`, `n`: if `charFun μ = stableS1Expr p…` and `charFun ν = stableS1Expr p.α p.β (n·loc) (n^{1/α}·scale)` then `convolutionPower μ n = ν`. | p. 140 scaling claim; 15.2.1 S1 form (G17). | Conditional on existence (T007); non-vacuity not shown even at `α = 2` (T046). At `α = 1` sums scale without the log correction that scalar multiplication has, consistent with S1. |

Shared modules:

- `AuditRepairs/Foundations.lean` (11 results): correct as stated. `pareto_power_tail` carries
  an unused hypothesis `_hp : 0 < p` (the identity holds for all `p` because Lean's `1/0 = 0`);
  harmless, mathematically motivated. `gamma_mixture_excess(_pos)` are rational identities only
  (G13; T124).
- `AuditRepairs/ProbabilityBridge.lean`: `convolutionPower` (0-fold = `dirac 0`),
  `convolutionPower_probability`, `charFun_convolutionPower`, `law_independent_sum` reuse
  Mathlib (`charFun_conv`, `Measure.ext_of_charFun`, `IndepFun.map_add_eq_map_conv_map₀`)
  correctly; nothing is over-claimed.
- `AuditRepairs/Stable.lean`: `stableS1Expr_at_zero` needs `0 < α` (`Real.zero_rpow`);
  `submitted_alpha_one_ignores_skew` is true in Lean because `Real.tan (π/2) = 0`
  (`Real.tan_pi_div_two`), not for a mathematical reason — the comment now says so.
  `StableParameters` encodes `0 < α ≤ 2`, `−1 ≤ β ≤ 1`, `0 ≤ scale`.
- `AuditRepairs/ImplicitSetDiagnostic.lean`: intentionally keeps `autoImplicit`; the four
  declarations reproduce and refute the original Proof09 signature. Preserved unchanged.
- Boundary values reviewed: `Real.log 0 = 0`, `0 ^ y = 0` (`y ≠ 0`), `x/0 = 0`,
  `sSup univ = 0`, `tan(π/2) = 0`. Each place where the project relies on one of these is
  either guarded by a hypothesis or explicitly labelled a diagnostic; two of them are now
  pinned by theorems (`frechetFormula_zero`, `isSlowlyVarying_neg_one`).

## 8. Repairs and justification

Every change relative to the received package is listed in `CHANGELOG_FABLE.md` and in
`deliverables/v0.2.1/fable_changes.patch`. Nothing was introduced that bypasses proof checking; no
`sorry`, `admit`, `axiom`, `unsafe`, `implemented_by`, `native_decide`, or new `set_option`
that weakens checking.

- **R1 — harness hardening** (`scripts/verify.py`, new `scripts/FableInventory.lean`,
  regenerated `AuditVerification.lean`). Justification: §5 H1–H3; the prompt's requirement
  that PASS not depend on discovery rules that can omit declarations. Effect: +40 s runtime;
  a new `evidence/current/inventory_environment.json`.
- **R2 — two boundary diagnostics** (`AuditRV.isSlowlyVarying_neg_one`,
  `AuditTails.frechetFormula_zero`). Justification: they turn two review findings
  (ratio-only vs the book's positivity; raw Fréchet formula at 0) into checked facts, in the
  style of the existing diagnostics, so that a future refactor cannot silently change the
  behaviour they document. They add no mathematical content.
- **R3 — comment correction** on `submitted_alpha_one_ignores_skew` (§7).
- **R4 — documentation**: `SOURCE_GATES.md` G17, G18; `REPLACEMENT_MAP.md`/`.json` rows 14
  and 16; backlog T007 (anchor 15.2.1, misprint note) and T029 (`missing → source-check`,
  corrected statement), regenerated through `scripts/rebuild_curated_inventory.py` and
  synchronised in the Markdown (which no shipped script generates; JSON↔Markdown consistency
  was verified for all 158 rows before and after); `README.md` counts and pointers;
  `lakefile.toml` version `0.2.1`.

No mathematical correction of a theorem was needed: no encoded statement was found false or
unproved, and no hypothesis was found removable without changing meaning (the unused `_hp`
in `pareto_power_tail` was deliberately left, see §7).

## 9. Unresolved mathematical obligations

Retained from the handoff, confirmed by this review, with backlog ids:

1. Existence of a probability law with characteristic function `stableS1Expr α β μ σ` for all
   admissible parameters, including `α = 1, β ≠ 0` and `σ = 0` (T007). Until then Proof16 is
   conditional.
2. Identification of Mathlib's `gaussianReal μ v` (variance `v = 2σ²`) and a Cauchy law with
   the `α = 2` and `α = 1, β = 0` specialisations (T046); this would also show Proof16's
   hypotheses are satisfiable.
3. Fréchet/Gumbel: construct the measures from `frechetCDF`/`gumbelCDF` (monotone,
   right-continuous, limits 0/1) and prove the iid maximum law `P(max ≤ x) = F(x)^n` (T060,
   T011).
4. Subexponentiality of any concrete law (Pareto/regularly varying), the equivalent n-fold
   characterisations, and the exponential boundary (T008, T024, T025).
5. Positive/measurable regular-variation API, uniform convergence, Potter bounds, Karamata
   representation (T001, T002); an extended-real tail index for infinite/undefined cases.
6. Formula-level two-term tail exponent (corrected G18) and the probabilistic Property 5.1
   (T029); Breiman-type product results (G04).
7. Pareto moments, threshold excess, convexity in α with Jensen (T005, T118); gamma
   inverse-moment integral and its finiteness threshold (T124, G13); stable absolute moment
   factor (G05).

## 10. Limits of what has been established

- Lean checked 69 propositions under the project's definitions; correspondence with the book
  is a separate, manual judgement recorded in §6–§7 and is exact only for the entries
  classified "literal".
- The ratio-only predicates, the finite tail-exponent interface, the expression-level stable
  results and the formula-level EVT identities are all weaker than the probabilistic
  statements the book makes about random variables; the handoff says so and this review
  confirms the labels are accurate.
- The 158-row backlog was treated as an inventory of obligation families; coverage claims in
  it were spot-checked where a family touched the sixteen entries, not exhaustively.
- The book comparison covered the anchored sections; G17 and G18 were found in those
  sections. No claim is made about the rest of the book.
- No claim of novelty relative to Mathlib master is made or checked.

## 11. Recommended next tasks (dependency-ordered)

1. **Formula-level two-term tail exponent (closes G18, first target of T029).** Intended
   statement in the existing interface:
   `theorem two_power_tail {w₁ w₂ α₁ α₂ : ℝ} (hw₁ : 0 ≤ w₁) (hw₂ : 0 < w₂) (h : α₂ ≤ α₁) :
   AuditTails.HasFiniteTailExponent (fun z => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) α₂`.
   Proof sketch: factor `w₂ z^{−α₂}(1 + (w₁/w₂) z^{α₂−α₁})`, reuse
   `pareto_log_ratio_tendsto` and `tail_log_ratio_of_ratio_tendsto` with ratio limit `1`
   (or `1 + w₁/w₂` when `α₁ = α₂`). Blockers: none beyond routine limit algebra.
2. **Gaussian instantiation of the stable bridge (T046, non-vacuity of Proof16).** Intended
   statements: `charFun (gaussianReal μ v) t = stableS1Expr 2 β μ σ t` when
   `(v : ℝ) = 2 * σ ^ 2`, from Mathlib's `charFun_gaussianReal : charFun (gaussianReal μ v) t
   = cexp (t * μ * I - v * t ^ 2 / 2)`; then
   `convolutionPower (gaussianReal μ v) n = gaussianReal (n * μ) (n * v)` as a corollary of
   `stableS1_convolutionPower_eq` (or directly from `gaussianReal_conv_gaussianReal`).
   Blockers: `v : ℝ≥0` coercions and the `2σ²` conversion; choosing whether to state the
   corollary via the bridge (exercises Proof16) or via Mathlib's closure lemma (shorter).
3. **iid maximum law and a Fréchet measure (T060, unblocks 10/11 as probability
   statements).** Intended statements: for `X : Fin n → Ω → ℝ` with `iIndepFun X P` and
   identical laws with CDF `F`, `P {ω | ∀ i, X i ω ≤ x} = (F x) ^ n` (via
   `iIndepFun.meas_iInter`); construct `frechetMeasure ξ` from `frechetCDF ξ` as a
   `StieltjesFunction` and prove `IsProbabilityMeasure` and `cdf (frechetMeasure ξ) = frechetCDF ξ`.
   Blockers: monotonicity/right-continuity/limit lemmas for `frechetCDF` (real powers with
   negative exponent), and the `ProbabilityTheory.cdf`/`Measure.eq_of_cdf` API in the pinned
   snapshot.

This review stops here so that the package can undergo the next independent audit.

## 12. Addendum (v0.2.2): response to the independent audit of v0.2.1

An independent audit of the v0.2.1 archive (`Taleb_Fable_v0.2.1_Independent_Audit.md`,
SHA-256 `3f71049c…7461f809`, with evidence ZIP `a5553019…3e90f04`, 19 September 2026)
accepted the encoded mathematics and requested a corrective pass on the verification
harness and two documentation points. Every claim in it was reproduced here before acting;
all were confirmed. Nothing in this addendum changes a theorem, a proof, a definition, or a
pin.

| Audit finding | Reproduced? | Repair in v0.2.2 | Regression fixture |
|---|---|---|---|
| **A1** private `sorry` declarations escape the verifier (internal names were counted but not axiom-checked; regex skips `private`; build warnings ignored) | Yes: `private theorem … : False := by sorry` gave PASS/exit 0 with `[sorryAx]` visible only in `build.log`. | `FableInventory.lean` now collects the axiom closure of **every** project constant before any filtering (137 constants: 102 public/generated + 35 internal); `verify.py` fails on any constant outside the allowlist, on any project `axiom`, and on any `warning:`/`error:`/`sorry` line in the Lake build log. | `private_sorry_theorem`, `private_sorry_def` (rejected by the build gate; the trust scan alone is also shown to list them with `sorryAx`), `private_axiom` (no compiler warning; rejected by the trust scan). |
| **A2** namespace prefix mistaken for generated provenance | Yes: `protected theorem StableAudit.StableParameters.audit_user_theorem` was flagged generated and exempted from reconciliation. | Provenance now uses Lean's own bookkeeping: constructor/recursor kinds, `Environment.isProjectionFn`, `isAuxRecursor`, `isNoConfusion`, and absence of a declaration range (which every user-written declaration has). Namespace is not consulted. | `structure_namespace_theorem` (rejected: environment/regex mismatch). |
| **A3** `python3 -O` strips the `assert`-based acceptance checks | Yes: wrong alias target passed under `-O` with `alias_targets_match_replacement_map=true`. | All acceptance conditions are explicit `check(...)` calls raising `VerificationError`; report booleans are the validated conditions; `python_optimize` is recorded. | `alias_map_mismatch` and `alias_map_mismatch_optimized` (`PYTHONOPTIMIZE=1`), both rejected. |
| **A4** negative-test log recorded `exit=0` for Test 2 | Yes: the wrapper read a stale `PIPESTATUS`; the verifier had exited 1 (the live output showed it). | The v0.2.1 log is preserved unchanged with a note (`evidence/fable/final/harness_negative_tests.NOTE.md`); `scripts/harness_regression.py` now records, per fixture, the exact command, the verifier's own subprocess exit code, its output tail and the resulting `verification.json` (`evidence/current/harness_regression.{json,log}`). | `protected_theorem` (rejected, exit 1). |
| Hardening: dependency working trees not checked; module import coverage | — | `verify.py` fails on `git status --porcelain` output in any dependency checkout, and on any project module on disk that is not imported into the scanned environment. | `dirty_dependency`, `orphan_module`, both rejected. |
| **M1** "Property 5.1 unaffected" is too strong | Confirmed: `X = EZ`, `Y = −2EZ` (fair sign `E`, Pareto `Z`) have tails of exponent `a` but `2X + Y = 0`. | G18 qualified; §6.2 above corrected; T029 target restricted to nonnegative summands with positive weights (event-inclusion bounds), the unrestricted printed statement classified source-check. | — (documentation). |
| **M2** p. 282 identifies regularly varying with α-stable | Confirmed on the rendered page (the sentence follows the S1 display). Pareto(3/2) is regularly varying with support `[1, ∞)` but no nondegenerate 3/2-stable law has bounded-below support (Nolan, Lemma 1.10). | New gate **G19**; T093 → source-check with the note; no delivered theorem makes the identification. | — (documentation). |
| Proof01 row: `x_min ≥ 1` | Confirmed (`log 1 = 0`). | Row corrected to `x_min > 1`. | — |

Final state of v0.2.2 (details in `CHANGELOG_FABLE.md` and `evidence/fable/v0.2.2/`): clean
`lake build` exit 0; `scripts/verify.py` exit 0 — `PASS: 52 theorems, 1 instance, 16 aliases;
… trust scan: 137 project constants (incl. 35 internal) all within allowlist; 69 public
theorem/instance constants match the regex inventory`; `scripts/harness_regression.py`
exit 0 with all 10 fixtures behaving as expected; the archive re-validated from a fresh
extraction. The statuses of §0 stand, with "axiom checks" strengthened from 102 to all 137
project constants.

## 13. Addendum (v0.2.3): first mathematics increment

Both the v0.2.1 review (§11) and the independent audit recommended the same three
contained tasks. v0.2.3 delivers them. No pre-existing theorem, proof, definition or pin was
modified; twelve theorems and three `def`s were added in one existing and two new modules.
Every new declaration depends only on `propext`, `Classical.choice`, `Quot.sound`.

### 13.1 Two-term power tails — `AuditRepairs/Foundations.lean` (closes G18 at formula level; T029 → partial)

- `AuditTails.two_power_tail {w₁ w₂ α₁ α₂} (hw₁ : 0 ≤ w₁) (hw₂ : 0 < w₂) (h : α₂ ≤ α₁) :
  HasFiniteTailExponent (fun z => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) α₂`.
- `AuditTails.two_power_tail_min (hw₁ : 0 < w₁) (hw₂ : 0 < w₂) :
  HasFiniteTailExponent (fun z => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) (min α₁ α₂)`.

Source: the display under Property 5.1, printed p. 99 (PDF 113), whose printed value `α₂`
should be `−α₂`; in the project's `−log S / log z` convention the exponent is `α₂ = min`.
Proof: the ratio to the dominant term `w₂ z^{−α₂}` tends to `1` (`tendsto_rpow_neg_atTop`)
when `α₂ < α₁`, and the formula collapses to a single Pareto term when `α₂ = α₁`; then
`tail_log_ratio_of_ratio_tendsto`. Scope: statements about survival-function *formulas*,
exactly as G18 says; the probabilistic statement for sums of nonnegative variables remains
the open part of T029, and the unrestricted printed statement remains false by
cancellation.

### 13.2 Gaussian instantiation of the stable bridge — new `AuditRepairs/GaussianBridge.lean` (T046 Gaussian half)

- `AuditGaussian.varianceOfScale (σ : ℝ) : ℝ≥0 := 2σ²`; `coe_varianceOfScale`.
- `AuditGaussian.charFun_gaussianReal_eq_stableS1Expr {v : ℝ≥0} {μ σ β} (hv : (v : ℝ) = 2 * σ ^ 2)
  (t) : charFun (gaussianReal μ v) t = StableAudit.stableS1Expr 2 β μ σ t` — from Mathlib's
  `charFun_gaussianReal` and `stableS1Expr_gaussian`; `σ = 0`/`v = 0` (Dirac) included, any `β`.
- `AuditGaussian.gaussianParameters μ σ (hσ : 0 ≤ σ) : StableParameters` (α = 2, β = 0).
- `AuditGaussian.convolutionPower_gaussianReal_scale (m σ) (hσ) (n) :
  convolutionPower (gaussianReal m (varianceOfScale σ)) n
  = gaussianReal (n * m) (varianceOfScale (n ^ (1/2) * σ))` — **by applying
  `stableS1_convolutionPower_eq`**, i.e. both premises of the Proof16 replacement are
  discharged with genuine probability measures.
- `AuditGaussian.convolutionPower_gaussianReal (m) (v : ℝ≥0) (n) :
  convolutionPower (gaussianReal m v) n = gaussianReal (n * m) (n * v)` (σ = √(v/2)).

Source: printed p. 140 (PDF 154), "Gaussian … α = 2" and "µ → nµ, σ → n^{1/α}σ". The
variance convention `v = 2σ²` (G05) is now a checked identity rather than a remark. This
establishes that the conditional stable-law theorem is not vacuous; existence for `α < 2`
(T007) and the Cauchy identification (the pinned Mathlib has no Cauchy law with a
characteristic-function lemma) remain open, so T046 stays `partial`.

### 13.3 Independent maxima and the EVT formulas — new `AuditRepairs/ExtremeValueBridge.lean` (T060 → partial)

- `AuditExtremes.maxLeEvent (X : ι → Ω → ℝ) (x) : Set Ω := {ω | ∀ i, X i ω ≤ x}`;
  `maxLeEvent_eq_iInter`.
- `AuditExtremes.measure_maxLeEvent (hX : iIndepFun X P) (x) :
  P (maxLeEvent X x) = ∏ i, P (X i ⁻¹' Set.Iic x)` — Mathlib's `iIndepFun.meas_iInter`; no
  identical-distribution or measurability hypothesis beyond independence.
- `measure_maxLeEvent_of_forall_eq` (`= p ^ Fintype.card ι` in `ℝ≥0∞`) and
  `measureReal_maxLeEvent_of_forall_eq` (`= q ^ Fintype.card ι` in `ℝ`, finite measure,
  nonempty index).
- `measureReal_maxLeEvent_frechet (hξ : 0 < ξ) (hF : ∀ i x, P.real (X i ⁻¹' Iic x) = frechetCDF ξ x) (x) :
  P.real (maxLeEvent X x) = frechetCDF ξ ((Fintype.card ι : ℝ) ^ (-ξ) * x)` and
  `measureReal_maxLeEvent_gumbel (… = gumbelCDF x) : … = gumbelCDF (x − log (Fintype.card ι))`.

Source: §9.1 printed p. 173 (PDF 187). Proof10/Proof11 are thereby upgraded from
identities between formulas to statements about the maximum of independent random
variables, *conditional on the coordinates having the Fréchet/Gumbel distribution
function at every point*. Not done: constructing a measure with `frechetCDF ξ` or
`gumbelCDF` as distribution function (T061), the minimum/survival analogue, and any
domain-of-attraction statement (T011).

### 13.4 Verification of v0.2.3

`lake build` exit 0 (clean); `scripts/verify.py` exit 0 — `PASS: 64 theorems, 1 instance,
16 aliases; no extra axioms; trust scan: 158 project constants (incl. 41 internal) all within
allowlist; 81 public theorem/instance constants match the regex inventory`;
`scripts/harness_regression.py` exit 0, 10/10 fixtures as expected; archive validated from a
fresh extraction (`deliverables/v0.2.3/archive_validation_v0.2.3.log`). Evidence:
`evidence/fable/v0.2.3/`.

### 13.5 Recommended next tasks (dependency-ordered)

1. **Fréchet and Gumbel measures (T061).** Build `StieltjesFunction`s from `frechetCDF ξ`
   (`0 < ξ`) and `gumbelCDF`: monotone, right-continuous, limits `0` at `−∞` and `1` at `+∞`;
   take `StieltjesFunction.measure`, prove `IsProbabilityMeasure`, and
   `cdf (·) = frechetCDF ξ`. Then `measureReal_maxLeEvent_frechet` applies to coordinates with
   law `frechetMeasure ξ`. Blockers: continuity and limits of `x ↦ exp(−x^{−1/ξ})` at `0⁺` and
   `+∞` with Lean's real powers; the `ProbabilityTheory.cdf` API of the pinned snapshot.
2. **Nonnegative sums (T029, probabilistic half).** For `X i ≥ 0` and positive weights,
   `max_i P(w_i X_i > x) ≤ P(∑ w_i X_i > x) ≤ ∑ P(w_i X_i > x/n)` by event inclusion, then the
   minimum finite tail exponent from the coordinates' `HasFiniteTailExponent` hypotheses via
   `two_power_tail`-style squeezing. Blockers: a squeeze lemma for `HasFiniteTailExponent`
   (lower and upper bounds with the same exponent).
3. **Exact Pareto against `paretoMeasure` (T005/T021 slice).** Survival `(L/x)^α`, moments for
   `p < α` and divergence for `p ≥ α`, threshold excess; connects `pareto_hasFiniteTailExponent`
   to an actual law. Blockers: the layer-cake API (`lintegral_eq_lintegral_meas_lt`) and rpow
   integrals in the pinned snapshot.
