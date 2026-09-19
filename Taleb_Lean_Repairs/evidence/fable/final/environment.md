# Final environment record (Fable review, v0.2.1)

Recorded: 2026-09-18T23:55:05Z. Repository commit of the verified source: a89acb0161c7be1e7f90bc145a8c73e18a42c3ac.
Host, toolchain and dependency checkouts are unchanged from `../baseline/environment.md` (same machine, same session):

- lake env lean --version: Lean (version 4.24.0, x86_64-unknown-linux-gnu, commit 797c613eb9b6d4ec95db23e3e00af9ac6657f24b, Release)
- lake --version: Lake version 5.0.0-src+797c613 (Lean version 4.24.0)
- lean-toolchain: leanprover/lean4:v4.24.0; lakefile.toml version: version = "0.2.1"
- python3: Python 3.12.3

## Dependency checkouts (git rev-parse HEAD; status --porcelain empty)
- mathlib: f897ebcf72cd16f89ab4577d0c826cd14afaafc7 OK clean
- plausible: dfd06ebfe8d0e8fa7faba9cb5e5a2e74e7bd2805 OK clean
- LeanSearchClient: 99657ad92e23804e279f77ea6dbdeebaa1317b98 OK clean
- importGraph: d768126816be17600904726ca7976b185786e6b9 OK clean
- proofwidgets: 556caed0eadb7901e068131d1be208dd907d07a2 OK clean
- aesop: 725ac8cd67acd70a7beaf47c3725e23484c1ef50 OK clean
- Qq: dea6a3361fa36d5a13f87333dc506ada582e025c OK clean
- batteries: 8da40b72fece29b7d3fe3d768bac4c8910ce9bee OK clean
- Cli: 91c18fa62838ad0ab7384c03c9684d99d306e1da OK clean

## Commands, exit codes, wall time
| # | command | exit | seconds | log |
|---|---|---|---|---|
| 1 | rm -rf .lake/build; lake build | 0 | 26 | 01_lake_build.log |
| 2 | python3 scripts/verify.py | 0 | 58 | 02_verify_py.log, current_after_verify/ |

## Result
- lake build: `Build completed successfully (2643 jobs)`; 24 project modules Built; 0 warnings; 0 errors.
- verify.py: `PASS: 52 theorems, 1 instance, 16 aliases; no extra axioms; environment cross-check: 102 project constants, 69 user theorem/instance, all within allowlist`
- axioms.log: 69 declarations, each `[propext, Classical.choice, Quot.sound]`; no sorryAx; no compiler diagnostics.
- inventory_environment.json: 102 project constants (69 user theorem/instance, 13 defs, 19 structure-generated, 35 internal auxiliaries excluded), all within the allowlist; 16 alias targets match docs/replacement_map.json.
- Harness negative tests: see harness_negative_tests.log (both hardened checks fail as intended when violated).

## Source hashes of every Lean file (from verification.json)
- 33430da9a37dce493d1ce0ce5746943bc22c9a9a5fcb82f0922a96e27e87143d  AuditRepairs/Foundations.lean
- d9f0af52cd5c0ed208de09bf920ad13634125119c4fc6cb2f96ef949018c12a5  AuditRepairs/ImplicitSetDiagnostic.lean
- 48bd0a051d8ec0869ac0173b76a332ed6396e034c36bc33b246a4cf0c3ecd68f  AuditRepairs/ProbabilityBridge.lean
- 82028bbce0f3a33c11524d5e8ebec42911a92418ccc63df921ec2eab33565ed3  AuditRepairs/RegularVariation.lean
- 041bd6c14490eb1c14b3d484a38b5d6e94d7d47b122ce1c74b709cea159ab942  AuditRepairs/Stable.lean
- 5fa7b09d5158e7b970c870a33622a94490c4d016f898cf286308242a4d786329  AuditRepairs/Tails.lean
- 7e9e29752681e7de931013b65a433f83258e336dce744390ae9dea481795f1c2  AuditRepairs.lean
- 0bbf79d61ca9b284d12f5a12f7446821d7e5e300a76a1a39b17ae5c52b5a3b82  AuditVerification.lean
- b6efa20176b1edc74417a06660b651eb406772fe03b71ad89a817c2e31c4473a  Proofs/Proof01_SlowlyVaryingLog.lean
- 392e254c39dfa418a607e1a5847f8d8b3583e5b6ea56b34341435e67f1ee5d4b  Proofs/Proof02_SlowlyVaryingConst.lean
- bd87bec95a6f58a70f988498d6d2f5ec3d00edb45c0681613816cad1d0a84054  Proofs/Proof03_SlowlyVaryingOfTendsto.lean
- 575999d2dc39cad7eeb0cc67949b55cc1fa63caf6baa4c99e16a4d3c0a73b4e8  Proofs/Proof04_RegularlyVaryingMul.lean
- e4d709a852a4555b0f5c059b4d0628793681f4a483e44f82b21b9331c08626ad  Proofs/Proof05_RegularlyVaryingRpow.lean
- 576c56100ff2a71eedf8d34e851d1d9711079ad6a8e44b81f7aa0f502b118d09  Proofs/Proof06_RVIffSlowlyVarying.lean
- 73f6cbc8df606f5af273ea7b4a5d81b6c1763a09dce9eaaa4c21ced73b7c6e69  Proofs/Proof07_TailExponentPareto.lean
- 304a11206d51622c2663082f6b7e2e46ee6b289357b6c17915b73af69107ea34  Proofs/Proof08_SubexponentialTailExponent.lean
- 6850864fe0bf957ef9dfc346910a23535254b807a0b23f1a093183355163815b  Proofs/Proof09_ConvexOnRpowNeg.lean
- 4e6b279b83a0766ad88f851dd9bafad45d27c2716e54a6c99c4900e0aa49b966  Proofs/Proof10_FrechetMaxstable.lean
- a83b8af388ca5c2aadc9149b92a0d2645fbcdb5f314faed2f0f6bf0724355391  Proofs/Proof11_GumbelMaxstable.lean
- 120939fde368e0f9526e73cdae7b3690defdfc2fdcc0421173d1349580baf26f  Proofs/Proof12_StableCharFnGaussian.lean
- 958decc2594333312e700336fc86105d54543feccbc4e059c00eb2cef67915d1  Proofs/Proof13_GaussianStable.lean
- e02bfc33e05b239fa21aaf773fedb390bedfe3c11c4718a292af5ea832be87cc  Proofs/Proof14_StableCharFnCauchy.lean
- bd7a9a584fb02cb8bcfbecb45450df4d381ae5e9f362108b67cda343ba2be6ce  Proofs/Proof15_CauchyStable.lean
- c35b181b49cad8dd239280f08ceca0ac6af58d5879517aad6ca6b33644604532  Proofs/Proof16_StableCharFnStable.lean
- 9f67522c8e2722efd3b3429cc255fde0e1eeb744c2df2ae475c1b4a3bbb40bc0  scripts/FableInventory.lean
