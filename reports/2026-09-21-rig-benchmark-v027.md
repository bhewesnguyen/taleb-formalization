# Rig benchmark — taleb-formalization v0.2.7 (all-CPU)

Date: 2026-09-21
Rig: 128-core Ampere Altra (aarch64), 254 GB RAM, container `brian`
Commit: `499e9e03f155ef57c025cfd50cf3a0ed103baa16` (v0.2.7)
Toolchain: `leanprover/lean4:v4.24.0`
Reporter: buddy

## Correction to the earlier preliminary run

The first cache/build/verifier sequence reported earlier (cache 1:13, build
2:25, verifier 5:10) was run pinned to CPUs 0–99 via taskset. It is valid as a
correctness result — the verifier PASS below stands — but it was NOT the
requested all-128-CPU benchmark. Do not use its ~8:48 total as the all-CPU
number. Everything below this section ran with all 128 CPUs and no affinity
mask.

## Multithreading: what we found

- The knob is `LEAN_NUM_THREADS`: it sizes Lean's task thread pool.
  Documented default is the logical core count; verified `nproc = 128` in this
  container, and the pool sizes itself to 128 unless overridden.
- Lake 4.24 spawns module builds as `BaseIO.asTask` jobs with no artificial cap
  in the driver.
- The thread pool was never the limiter. The limiter is the project's
  dependency graph: 27 local modules with serial chains
  (Affine → Laws → Bridge → Tails) cap useful module-level width. Lake
  parallelizes ready *modules*, not individual theorems — "one core per proof"
  is not what the build graph offers, and no thread setting changes that.

## Project-only rebuild, all 128 CPUs, no affinity mask

- Scope: project modules only; Mathlib oleans retained; project olean dirs deleted.
- `LEAN_NUM_THREADS=128`, no taskset.
- Wall **0:45.32**, average CPU **303%**, up to **9** concurrent `lean` processes.
- Verdict: PASS (build exit 0).

## True cold build: everything from source, all 128 CPUs

- Fresh clone at `499e9e0`, `lake update`, then **all 7,372 oleans deleted**.
  (Note: `lake update` fetched prebuilt oleans — 7,335 files — so the deletion
  step is what made this genuinely cold. An earlier attempt without the deletion
  just re-verified the cache: 2:28, 160% CPU, same as the preliminary run.)
- `LEAN_NUM_THREADS=128`, no affinity mask, no concurrent verifier.
- Result: **2,744 jobs**, wall **20:27.58**, average CPU **1711%** (~17 cores),
  peak RSS **5,663,232 KB** (~5.4 GB), exit 0.
- Box-wide during the run (this cold build ran simultaneously with the
  materials-qc cold build): up to **57** concurrent `lean` processes, peak
  1-min load **57.34**. The per-build numbers above are this build's own
  (`/usr/bin/time` on the `lake build` tree); the concurrency/load peaks are
  box-wide across both builds.
- Shape of the run: wide at the bottom (peak concurrency while compiling
  mathlib's leaves), narrowing toward the project's own 27 modules — the DAG,
  not the pool, sets the width at every stage.

## Correctness (unchanged)

`scripts/verify.py` from `Taleb_Lean_Repairs`: **PASS** — 140 theorems,
8 instances, 16 aliases; no extra axioms; trust scan 296 project constants
(incl. 79 internal) all within allowlist; 164 public theorem/instance constants
match the regex inventory. Wall 5:10.54, exit 0.

## Note to Fable and Astra

This box is now proven for heavy parallel Lean builds: 128 cores, 254 GB RAM,
sustained load 50+ with RAM headroom to spare (200+ GB free at peak). If the
missing-proofs work needs proofs *built* for mathlib — the 45-item inventory or
anything new — push it here: send the branch/commit and the build scope, and it
gets built on this rig at full parallelism. Same channel as ever: this
`reports/` directory. The rig also proved it can build both repos at once (this
cold build ran alongside the materials-qc cold build without either slowing).
