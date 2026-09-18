# Build audit environment

- Original archive supplies no `lean-toolchain`, `lakefile.lean`/`lakefile.toml`, or `lake-manifest.json`. Therefore no author-pinned build can be reproduced literally.
- A separate audit environment was provisioned at `audit/mathlib4`: Mathlib release `v4.24.0`, git commit `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`.
- Lean `4.24.0`, compiler commit `797c613eb9b6d4ec95db23e3e00af9ac6657f24b`, x86_64 Linux release. Binary: `audit/lean-4.24.0-linux/bin/lean`.
- Mathlib lockfile came unchanged from the above release. The nine original import roots are fetched using Mathlib's official cached `.olean` files.
- `Mathlib.Analysis.Convex.SpecificFunctions.Basic` and `Mathlib.Data.Real.Sign` are valid imports in this snapshot. Both also appear in current official documentation; they must not be reported as non-existent global blockers.
- Results are specific to this explicit audit environment. Failed compilations do not by themselves establish that the author's unseen project never compiled on some other version. Semantic counterexamples and incorrect inference directions are separately version-independent.
- Every original is checked independently and unchanged using `lake env lean /absolute/path/ProofNN_....lean`. This respects the pack's stated standalone-file format. Combining originals introduces duplicate global definitions, so it is a separate packaging concern rather than an independent-file rejection.

## References

- https://github.com/leanprover-community/mathlib4/tree/f897ebcf72cd16f89ab4577d0c826cd14afaafc7
- https://github.com/leanprover/lean4/releases/tag/v4.24.0
- https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Convex/SpecificFunctions/Basic.html
- https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Real/Sign.html

## Compile results

All 16 originals were compiled independently without edits. Results: **8 passed, 8 failed**. No import failures remain. The successful files are 01, 04, 07, 10, 11, 13, 15, and 16. Failed files are 02, 03, 05, 06, 08, 09, 12, and 14.

| Proof | Exit | Errors | Primary observed diagnostic |
|---|---:|---:|---|
|01|0|0|Accepted|
|02|1|1|Line33: `simp` made no progress|
|03|1|1|Line33: composition has wrong function and target filter|
|04|0|0|Accepted|
|05|1|2|Line50: invalid field `rpow` under supplied imports; unfinished limit|
|06|1|2|Lines54,71: no goals to be solved (redundant tactics)|
|07|0|0|Accepted; one unused-simp warning|
|08|1|1|Line66: eventual equality orientation opposite required orientation|
|09|1|4|Unqualified `univ` auto-bound as arbitrary set; affine-map argument has wrong type; polynomial tactic on inequality|
|10|0|0|Accepted|
|11|0|0|Accepted|
|12|1|2|Lines39,40: false residual goals `σ = 0 ∨ t = 0`|
|13|0|0|Accepted; one unused-simp warning|
|14|1|2|Lines38,39: false residual goals `σ = 0 ∨ t = 0`|
|15|0|0|Accepted; one unused-simp warning|
|16|0|0|Accepted; one unused-simp warning|

Raw logs are in `audit/build_logs/ProofNN_*.log`; JSON summary is `audit/build_logs/summary.json`. Successful elaboration certifies the written theorem relative to the pinned Lean/Mathlib environment; it does not certify that its statement correctly represents a probability distribution or a book theorem. In particular Proof16 compiles but its unrestricted probability interpretation is unsupported.

The Proof09 diagnostic explicitly includes `univ : Set ℝ` in the local context. Thus the as-written type has an implicit arbitrary-set parameter, not merely an unknown-name error. Since `ConvexOn` includes convexity of its domain, the written type is false for a nonconvex set.

The Proof12/14 residual goals arise from the incorrect stable-function argument order.

Mathlib checkout was clean (`git status --porcelain` empty) after testing. Toolchain and official cache archives were validated through successful Mathlib cache unpacking before these tests. Original archive bytes were never modified.
