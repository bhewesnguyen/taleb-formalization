# Baseline reproduction environment (Fable review)

Recorded: 2026-09-18T23:24:02Z
Repository commit at time of baseline run: eff6e82f4dea4dee9d1e25cb893a608f6ed0df35 (source tree identical to received ZIP; see received_current/received_tree_all_files.sha256)

## Host
- OS: Ubuntu 24.04.5 LTS, kernel 7.0.0-31-generic, x86_64
- CPUs: 32; RAM: 61 GiB; free disk on workspace fs: 152G

## Toolchain
- elan: elan 4.2.4 (227caca13 2026-08-25)
- lean-toolchain file: leanprover/lean4:v4.24.0
- lake env lean --version: Lean (version 4.24.0, x86_64-unknown-linux-gnu, commit 797c613eb9b6d4ec95db23e3e00af9ac6657f24b, Release)
- lake --version: Lake version 5.0.0-src+797c613 (Lean version 4.24.0)
- Toolchains present in ~/.elan/toolchains: leanprover--lean4---v4.24.0 leanprover--lean4---v4.33.1 
- python3: Python 3.12.3
- Lean toolchain v4.24.0 was NOT present before this review; elan installed it during `lake exe cache get` (see 00_lake_exe_cache_get.log). No other toolchain or system change was made.

## Dependency checkouts (.lake/packages/<name>, git rev-parse HEAD; all clean working trees)
- mathlib: f897ebcf72cd16f89ab4577d0c826cd14afaafc7 (matches manifest)
- plausible: dfd06ebfe8d0e8fa7faba9cb5e5a2e74e7bd2805 (matches manifest)
- LeanSearchClient: 99657ad92e23804e279f77ea6dbdeebaa1317b98 (matches manifest)
- importGraph: d768126816be17600904726ca7976b185786e6b9 (matches manifest)
- proofwidgets: 556caed0eadb7901e068131d1be208dd907d07a2 (matches manifest)
- aesop: 725ac8cd67acd70a7beaf47c3725e23484c1ef50 (matches manifest)
- Qq: dea6a3361fa36d5a13f87333dc506ada582e025c (matches manifest)
- batteries: 8da40b72fece29b7d3fe3d768bac4c8910ce9bee (matches manifest)
- Cli: 91c18fa62838ad0ab7384c03c9684d99d306e1da (matches manifest)

## Mathlib cache
- Source: Azure cache, origin leanprover-community/mathlib4; leantar 0.1.15; 7335 files downloaded and unpacked (`Completed successfully!`, exit 0).
- The network step was executed by the repository owner in the IDE terminal, because the agent's sandbox has no DNS resolution / no allow-listed egress to github.com, releases.lean-lang.org or lakecache.blob.core.windows.net. Everything after that step ran offline inside the sandbox.

## Commands, exit codes, wall time
| # | command | exit | seconds | log |
|---|---|---|---|---|
| 0 | lake exe cache get (user, IDE terminal) | 0 | n/a | 00_lake_exe_cache_get.log |
| 1 | lake build (clean: no prior .lake/build in project) | 0 | 26 | 01_lake_build.log |
| 2 | python3 scripts/verify.py | 0 | 19 | 02_verify_py.log, current_after_verify/ |

## Result
- lake build: `Build completed successfully (2643 jobs)`; 24 project modules reported `Built` (none replayed); 0 warnings, 0 errors, 101 info lines (all `#print axioms`/`#check`/`#print` outputs).
- verify.py: `PASS: 50 theorems, 1 instance, 16 aliases; no extra axioms`.
- evidence/current/verification.json produced here is identical to the received one except `elapsed_seconds`; axioms.log and declarations.json are byte-identical to the received files.
