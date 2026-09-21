# Rig benchmark — taleb-formalization v0.2.7 (2026-09-21)

Machine: 128-core Ampere Altra (aarch64), 254 GB RAM. Container `brian`,
no CPU cap, no memory limit. Fresh clone.

Verified commit: `499e9e03f155ef57c025cfd50cf3a0ed103baa16` (v0.2.7)
Toolchain: `leanprover/lean4:v4.24.0` (aarch64, via elan)

## Cold-cache run

| step | wall | avg CPU | peak RSS | result |
|---|---|---|---|---|
| `lake exe cache get` | 1:13 | 232% | 1.9 GB | 7,335 files, exit 0 |
| `lake build` | 2:25 | 160% | 3.7 GB | 2,744 jobs, 0 warnings, exit 0 |
| `scripts/verify.py` | 5:10 | 100% | 3.6 GB | PASS, exit 0 |

Verifier: 140 theorems, 8 instances, 16 aliases. Axiom closure exactly
`propext`, `Classical.choice`, `Quot.sound`. 296 project constants scanned;
164 public checked constants match the inventory. No `sorryAx`, no extra axioms.

VM baseline (2 cores / 7 GB): cache ~4 min, build ~7 min, verify ~8 min
(~19 min total). Rig total: ~8:48.

## Parallelism findings (same day)

- No x86/ARM issue: dependency oleans are architecture-independent; the
  aarch64 toolchain elaborated all 2,744 jobs natively.
- `LEAN_NUM_THREADS` is the documented thread-pool knob (default = core
  count). The pool was not the limiter here.
- Forced rebuild of the project's own modules with `LEAN_NUM_THREADS=128`:
  0:45 wall at 303% avg CPU, up to 9 concurrent `lean` processes. Lake 4.24
  does parallelize module elaboration; this project's DAG (27 modules, with
  chains like Affine → Laws → Bridge → Tails) caps useful width around ~9.
- 128 cores cannot be saturated by the project's own modules. A from-source
  cold build of all dependencies (no cache) is the true saturation test —
  running next, results to follow on this branch.
