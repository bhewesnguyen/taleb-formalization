# Final declaration inventory (Fable review, v0.2.2)

Generated from `evidence/current/inventory_environment.json` (Lean 4.24.0; every project constant, axiom closure collected before any filtering) and `evidence/current/declarations.json` (regex-based public API checked by `AuditVerification.lean`).

- Project constants scanned: **137** = 69 public user-written theorem/instance + 13 public user-written defs + 1 structure type + 19 Lean-generated public constants + 35 internally named constants (equation lemmas, `match_`/`_proof_`/`_simp` auxiliaries, `_private` names).
- Public user-written theorem/instance constants: **69** = 52 theorems + 1 instance + 16 aliases; equals the set checked by `#print axioms` in `AuditVerification.lean` (69).
- Axiom closures over **all** scanned constants: `['Classical.choice', 'Quot.sound', 'propext']` x120; `['propext']` x13; `[]` x4. Allowlist `{propext, Classical.choice, Quot.sound}`; no `sorryAx`; no project `axiom`.
- Provenance rules that fired (Lean bookkeeping, not namespace): noDeclarationRange: 41, projection: 8, auxRecursor: 2, constructor: 1, noConfusion: 1, recursor: 1.
- Imported project modules: 23 (all modules on disk are imported; checked by verify.py).

## Count reconciliation

| quantity | received v0.2.0 | v0.2.1 | v0.2.2 |
|---|---|---|---|
| theorem declarations (regex) | 50 | 52 | 52 |
| instances | 1 | 1 | 1 |
| aliases | 16 | 16 | 16 |
| checked declarations | 67 | 69 | 69 |
| environment: constants axiom-checked | 100 public/generated (measured by this review) | 102 | **137** (102 + 35 internal) |
| environment: user-written public theorem/instance | 67 | 69 | 69 |

## Public user-written declarations with exact statements

Types pretty-printed with `pp.fullNames`, `pp.proofs false`. Aliases show their target.

### `AuditRepairs.Foundations`

- **`AuditMoments.gamma_mixture_excess`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (scale m s : ℝ),
  m ≠ 0 →
    m ^ 2 - s ^ 2 ≠ 0 → scale * (1 + m / (m ^ 2 - s ^ 2)) - scale * (1 + 1 / m) = scale * s ^ 2 / (m * (m ^ 2 - s ^ 2))
  ```
- **`AuditMoments.gamma_mixture_excess_pos`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {scale m s : ℝ}, 0 < scale → 0 < m → s ≠ 0 → 0 < m ^ 2 - s ^ 2 → 0 < scale * s ^ 2 / (m * (m ^ 2 - s ^ 2))
  ```
- **`AuditRV.IsRegularlyVarying.congr`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L M : ℝ → ℝ} {α : ℝ}, AuditRV.IsRegularlyVarying L α → L =ᶠ[Filter.atTop] M → AuditRV.IsRegularlyVarying M α
  ```
- **`AuditRV.IsRegularlyVarying.const_mul`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ} {α c : ℝ}, AuditRV.IsRegularlyVarying L α → c ≠ 0 → AuditRV.IsRegularlyVarying (fun x => c * L x) α
  ```
- **`AuditRV.IsSlowlyVarying.mul`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L M : ℝ → ℝ}, AuditRV.IsSlowlyVarying L → AuditRV.IsSlowlyVarying M → AuditRV.IsSlowlyVarying fun x => L x * M x
  ```
- **`AuditRV.IsSlowlyVarying.rpow`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ},
  AuditRV.IsSlowlyVarying L →
    (∀ᶠ (x : ℝ) in Filter.atTop, 0 < L x) → ∀ (p : ℝ), AuditRV.IsSlowlyVarying fun x => L x ^ p
  ```
- **`AuditRV.regularlyVarying_power`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (α : ℝ), AuditRV.IsRegularlyVarying (fun x => x ^ α) α
  ```
- **`AuditRV.regularlyVarying_zero_iff`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ}, AuditRV.IsRegularlyVarying L 0 ↔ AuditRV.IsSlowlyVarying L
  ```
- **`AuditTails.HasFiniteTailExponent.liminf_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {S : ℝ → ℝ} {α : ℝ}, AuditTails.HasFiniteTailExponent S α → AuditTails.tailExponentReal S = α
  ```
- **`AuditTails.HasFiniteTailExponent.unique`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {S : ℝ → ℝ} {α β : ℝ}, AuditTails.HasFiniteTailExponent S α → AuditTails.HasFiniteTailExponent S β → α = β
  ```
- **`AuditTails.pareto_power_tail`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {C α p : ℝ}, 0 < C → 0 < p → AuditTails.HasFiniteTailExponent (fun y => C * (y ^ (1 / p)) ^ (-α)) (α / p)
  ```

### `AuditRepairs.ProbabilityBridge`

- **`AuditProbability.IsSubexponential.finiteTailExponent`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {μ : MeasureTheory.Measure ℝ} {α : ℝ},
  AuditProbability.IsSubexponential μ →
    AuditTails.HasFiniteTailExponent (AuditProbability.survival μ) α →
      AuditTails.HasFiniteTailExponent (AuditProbability.survival (μ.conv μ)) α
  ```
- **`AuditProbability.charFun_convolutionPower`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (μ : MeasureTheory.Measure ℝ) [MeasureTheory.IsProbabilityMeasure μ] (n : ℕ) (t : ℝ),
  MeasureTheory.charFun (AuditProbability.convolutionPower μ n) t = MeasureTheory.charFun μ t ^ n
  ```
- **`AuditProbability.convolutionPower_probability`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (μ : MeasureTheory.Measure ℝ) [MeasureTheory.IsProbabilityMeasure μ] (n : ℕ),
  MeasureTheory.IsProbabilityMeasure (AuditProbability.convolutionPower μ n)
  ```
- **`AuditProbability.law_independent_sum`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
  {X Y : Ω → ℝ},
  AEMeasurable X P →
    AEMeasurable Y P →
      ProbabilityTheory.IndepFun X Y P →
        MeasureTheory.Measure.map (fun ω => X ω + Y ω) P =
          (MeasureTheory.Measure.map X P).conv (MeasureTheory.Measure.map Y P)
  ```
- **`AuditProbability.stableS1_convolutionPower_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {μ ν : MeasureTheory.Measure ℝ} [MeasureTheory.IsProbabilityMeasure μ] [MeasureTheory.IsProbabilityMeasure ν]
  (p : StableAudit.StableParameters) (n : ℕ),
  (∀ (t : ℝ), MeasureTheory.charFun μ t = StableAudit.stableS1Expr p.alpha p.beta p.location p.scale t) →
    (∀ (t : ℝ),
        MeasureTheory.charFun ν t =
          StableAudit.stableS1Expr p.alpha p.beta (↑n * p.location) (↑n ^ (1 / p.alpha) * p.scale) t) →
      AuditProbability.convolutionPower μ n = ν
  ```

### `AuditRepairs.RegularVariation`

- **`AuditRV.IsRegularlyVarying.mul`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L₁ L₂ : ℝ → ℝ} {α₁ α₂ : ℝ},
  AuditRV.IsRegularlyVarying L₁ α₁ →
    AuditRV.IsRegularlyVarying L₂ α₂ → AuditRV.IsRegularlyVarying (fun x => L₁ x * L₂ x) (α₁ + α₂)
  ```
- **`AuditRV.IsRegularlyVarying.rpow`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ} {α p : ℝ},
  AuditRV.IsRegularlyVarying L α →
    (∀ᶠ (x : ℝ) in Filter.atTop, 0 < L x) → AuditRV.IsRegularlyVarying (fun x => L x ^ p) (p * α)
  ```
- **`AuditRV.IsSlowlyVarying.of_tendsto_const`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ} {c : ℝ}, c ≠ 0 → Filter.Tendsto L Filter.atTop (nhds c) → AuditRV.IsSlowlyVarying L
  ```
- **`AuditRV.isRegularlyVarying_iff_slowlyVarying`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ} {α : ℝ}, AuditRV.IsRegularlyVarying L α ↔ AuditRV.IsSlowlyVarying fun x => L x / x ^ α
  ```
- **`AuditRV.isSlowlyVarying_const`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {c : ℝ}, c ≠ 0 → AuditRV.IsSlowlyVarying fun x => c
  ```
- **`AuditRV.isSlowlyVarying_log`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  AuditRV.IsSlowlyVarying Real.log
  ```
- **`AuditRV.isSlowlyVarying_neg_one`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  AuditRV.IsSlowlyVarying fun x => -1
  ```

### `AuditRepairs.Tails`

- **`AuditTails.convexOn_rpow_neg_right`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {c : ℝ}, 0 < c → ConvexOn ℝ Set.univ fun α => c ^ (-α)
  ```
- **`AuditTails.frechetFormula_zero`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, ξ ≠ 0 → AuditTails.frechetFormula ξ 0 = 1
  ```
- **`AuditTails.frechet_cdf_maxstable`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, 0 < ξ → ∀ (x : ℝ) (n : ℕ), 0 < n → AuditTails.frechetCDF ξ x ^ n = AuditTails.frechetCDF ξ (↑n ^ (-ξ) * x)
  ```
- **`AuditTails.frechet_formula_maxstable`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ},
  0 < ξ → ∀ {x : ℝ}, 0 < x → ∀ (n : ℕ), AuditTails.frechetFormula ξ x ^ n = AuditTails.frechetFormula ξ (↑n ^ (-ξ) * x)
  ```
- **`AuditTails.gumbel_maxstable`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {x : ℝ} (n : ℕ), 0 < n → AuditTails.gumbelCDF x ^ n = AuditTails.gumbelCDF (x - Real.log ↑n)
  ```
- **`AuditTails.pareto_hasFiniteTailExponent`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {C α : ℝ}, 0 < C → AuditTails.HasFiniteTailExponent (fun x => C * x ^ (-α)) α
  ```
- **`AuditTails.pareto_log_ratio_tendsto`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {C α : ℝ}, 0 < C → Filter.Tendsto (fun x => -Real.log (C * x ^ (-α)) / Real.log x) Filter.atTop (nhds α)
  ```
- **`AuditTails.real_liminf_of_tendsto_atTop`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {f : ℝ → ℝ}, Filter.Tendsto f Filter.atTop Filter.atTop → Filter.liminf f Filter.atTop = 0
  ```
- **`AuditTails.subexponential_ratio_tailExponent`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {S T : ℝ → ℝ} {α : ℝ},
  Filter.Tendsto (fun x => T x / S x) Filter.atTop (nhds 2) →
    Filter.Tendsto (fun x => -Real.log (S x) / Real.log x) Filter.atTop (nhds α) →
      (∀ᶠ (x : ℝ) in Filter.atTop, T x ≠ 0) →
        (∀ᶠ (x : ℝ) in Filter.atTop, 0 < S x) →
          Filter.Tendsto (fun x => -Real.log (T x) / Real.log x) Filter.atTop (nhds α)
  ```
- **`AuditTails.tailExponentReal_pareto`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {C α : ℝ}, 0 < C → (AuditTails.tailExponentReal fun x => C * x ^ (-α)) = α
  ```
- **`AuditTails.tailExponentReal_zero`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  (AuditTails.tailExponentReal fun x => 0) = 0
  ```
- **`AuditTails.tail_log_ratio_of_ratio_tendsto`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {S T : ℝ → ℝ} {α k : ℝ},
  k ≠ 0 →
    Filter.Tendsto (fun x => T x / S x) Filter.atTop (nhds k) →
      Filter.Tendsto (fun x => -Real.log (S x) / Real.log x) Filter.atTop (nhds α) →
        (∀ᶠ (x : ℝ) in Filter.atTop, T x ≠ 0) →
          (∀ᶠ (x : ℝ) in Filter.atTop, S x ≠ 0) →
            Filter.Tendsto (fun x => -Real.log (T x) / Real.log x) Filter.atTop (nhds α)
  ```

### `AuditRepairs.ImplicitSetDiagnostic`

- **`Proof09Probe.pair_not_convex`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ¬Convex ℝ {0, 2}
  ```
- **`Proof09Probe.signature_probe`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {univ : Set ℝ} {c : ℝ}, 0 < c → (ConvexOn ℝ univ fun α => c ^ (-α)) → ConvexOn ℝ univ fun α => c ^ (-α)
  ```
- **`Proof09Probe.submitted_statement_counterexample`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ¬Proof09Probe.statement ⋯
  ```

### `AuditRepairs.Stable`

- **`StableAudit.cauchy_specialization`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ}, 0 ≤ σ → StableAudit.stableExpr 1 0 0 σ t = Complex.exp { re := -(σ * |t|), im := 0 }
  ```
- **`StableAudit.cauchy_stable`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ} (n : ℕ), Real.exp (-(σ * |t|)) ^ n = Real.exp (-(↑n * σ * |t|))
  ```
- **`StableAudit.cauchy_stable_short`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ} (n : ℕ), Real.exp (-(σ * |t|)) ^ n = Real.exp (-(↑n * σ * |t|))
  ```
- **`StableAudit.gaussian_specialization`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ}, StableAudit.stableExpr 2 0 0 σ t = Complex.exp { re := -(σ * t) ^ 2, im := 0 }
  ```
- **`StableAudit.gaussian_specialization_general`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {β μ σ t : ℝ}, StableAudit.stableExpr 2 β μ σ t = Complex.exp { re := -(σ * t) ^ 2, im := μ * t }
  ```
- **`StableAudit.gaussian_stable_real`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ} (n : ℕ), Real.exp (-(σ * t) ^ 2) ^ n = Real.exp (-(↑n ^ (1 / 2) * σ * t) ^ 2)
  ```
- **`StableAudit.gaussian_stable_real_short`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ} (n : ℕ), Real.exp (-(σ * t) ^ 2) ^ n = Real.exp (-(↑n ^ (1 / 2) * σ * t) ^ 2)
  ```
- **`StableAudit.stableExpr_power`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α β μ σ : ℝ} (n : ℕ) (t : ℝ),
  0 < α → StableAudit.stableExpr α β μ σ t ^ n = StableAudit.stableExpr α β (↑n * μ) (↑n ^ (1 / α) * σ) t
  ```
- **`StableAudit.stableS1Expr_at_zero`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α β μ σ : ℝ}, 0 < α → StableAudit.stableS1Expr α β μ σ 0 = 1
  ```
- **`StableAudit.stableS1Expr_cauchy`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ}, 0 ≤ σ → StableAudit.stableS1Expr 1 0 0 σ t = Complex.exp { re := -(σ * |t|), im := 0 }
  ```
- **`StableAudit.stableS1Expr_gaussian`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {β μ σ t : ℝ}, StableAudit.stableS1Expr 2 β μ σ t = Complex.exp { re := -(σ * t) ^ 2, im := μ * t }
  ```
- **`StableAudit.stableS1Expr_power`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α β μ σ : ℝ} (n : ℕ) (t : ℝ),
  0 < α → StableAudit.stableS1Expr α β μ σ t ^ n = StableAudit.stableS1Expr α β (↑n * μ) (↑n ^ (1 / α) * σ) t
  ```
- **`StableAudit.submitted_alpha_one_ignores_skew`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {β μ σ t : ℝ}, StableAudit.stableExpr 1 β μ σ t = Complex.exp { re := -|σ * t|, im := μ * t }
  ```
- **`StableAudit.submitted_cauchy_counterexample`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  StableAudit.stableExpr 1 0 1 0 1 ≠ Complex.exp { re := -(1 * |1|), im := 0 }
  ```
- **`StableAudit.submitted_gaussian_counterexample`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  StableAudit.stableExpr 2 0 1 0 1 ≠ Complex.exp { re := -1 ^ 2, im := 0 }
  ```

### `Proofs.Proof01_SlowlyVaryingLog`

- **`Taleb.Proof01.repaired`** (alias of `AuditRV.isSlowlyVarying_log`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  AuditRV.IsSlowlyVarying Real.log
  ```

### `Proofs.Proof02_SlowlyVaryingConst`

- **`Taleb.Proof02.repaired`** (alias of `AuditRV.isSlowlyVarying_const`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {c : ℝ}, c ≠ 0 → AuditRV.IsSlowlyVarying fun x => c
  ```

### `Proofs.Proof03_SlowlyVaryingOfTendsto`

- **`Taleb.Proof03.repaired`** (alias of `AuditRV.IsSlowlyVarying.of_tendsto_const`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ} {c : ℝ}, c ≠ 0 → Filter.Tendsto L Filter.atTop (nhds c) → AuditRV.IsSlowlyVarying L
  ```

### `Proofs.Proof04_RegularlyVaryingMul`

- **`Taleb.Proof04.repaired`** (alias of `AuditRV.IsRegularlyVarying.mul`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L₁ L₂ : ℝ → ℝ} {α₁ α₂ : ℝ},
  AuditRV.IsRegularlyVarying L₁ α₁ →
    AuditRV.IsRegularlyVarying L₂ α₂ → AuditRV.IsRegularlyVarying (fun x => L₁ x * L₂ x) (α₁ + α₂)
  ```

### `Proofs.Proof05_RegularlyVaryingRpow`

- **`Taleb.Proof05.repaired`** (alias of `AuditRV.IsRegularlyVarying.rpow`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ} {α p : ℝ},
  AuditRV.IsRegularlyVarying L α →
    (∀ᶠ (x : ℝ) in Filter.atTop, 0 < L x) → AuditRV.IsRegularlyVarying (fun x => L x ^ p) (p * α)
  ```

### `Proofs.Proof06_RVIffSlowlyVarying`

- **`Taleb.Proof06.repaired`** (alias of `AuditRV.isRegularlyVarying_iff_slowlyVarying`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L : ℝ → ℝ} {α : ℝ}, AuditRV.IsRegularlyVarying L α ↔ AuditRV.IsSlowlyVarying fun x => L x / x ^ α
  ```

### `Proofs.Proof07_TailExponentPareto`

- **`Taleb.Proof07.repaired`** (alias of `AuditTails.pareto_hasFiniteTailExponent`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {C α : ℝ}, 0 < C → AuditTails.HasFiniteTailExponent (fun x => C * x ^ (-α)) α
  ```

### `Proofs.Proof08_SubexponentialTailExponent`

- **`Taleb.Proof08.repaired`** (alias of `AuditProbability.IsSubexponential.finiteTailExponent`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {μ : MeasureTheory.Measure ℝ} {α : ℝ},
  AuditProbability.IsSubexponential μ →
    AuditTails.HasFiniteTailExponent (AuditProbability.survival μ) α →
      AuditTails.HasFiniteTailExponent (AuditProbability.survival (μ.conv μ)) α
  ```

### `Proofs.Proof09_ConvexOnRpowNeg`

- **`Taleb.Proof09.repaired`** (alias of `AuditTails.convexOn_rpow_neg_right`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {c : ℝ}, 0 < c → ConvexOn ℝ Set.univ fun α => c ^ (-α)
  ```

### `Proofs.Proof10_FrechetMaxstable`

- **`Taleb.Proof10.repaired`** (alias of `AuditTails.frechet_cdf_maxstable`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, 0 < ξ → ∀ (x : ℝ) (n : ℕ), 0 < n → AuditTails.frechetCDF ξ x ^ n = AuditTails.frechetCDF ξ (↑n ^ (-ξ) * x)
  ```

### `Proofs.Proof11_GumbelMaxstable`

- **`Taleb.Proof11.repaired`** (alias of `AuditTails.gumbel_maxstable`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {x : ℝ} (n : ℕ), 0 < n → AuditTails.gumbelCDF x ^ n = AuditTails.gumbelCDF (x - Real.log ↑n)
  ```

### `Proofs.Proof12_StableCharFnGaussian`

- **`Taleb.Proof12.repaired`** (alias of `StableAudit.stableS1Expr_gaussian`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {β μ σ t : ℝ}, StableAudit.stableS1Expr 2 β μ σ t = Complex.exp { re := -(σ * t) ^ 2, im := μ * t }
  ```

### `Proofs.Proof13_GaussianStable`

- **`Taleb.Proof13.repaired`** (alias of `StableAudit.gaussian_stable_real_short`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ} (n : ℕ), Real.exp (-(σ * t) ^ 2) ^ n = Real.exp (-(↑n ^ (1 / 2) * σ * t) ^ 2)
  ```

### `Proofs.Proof14_StableCharFnCauchy`

- **`Taleb.Proof14.repaired`** (alias of `StableAudit.stableS1Expr_cauchy`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ}, 0 ≤ σ → StableAudit.stableS1Expr 1 0 0 σ t = Complex.exp { re := -(σ * |t|), im := 0 }
  ```

### `Proofs.Proof15_CauchyStable`

- **`Taleb.Proof15.repaired`** (alias of `StableAudit.cauchy_stable_short`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {σ t : ℝ} (n : ℕ), Real.exp (-(σ * |t|)) ^ n = Real.exp (-(↑n * σ * |t|))
  ```

### `Proofs.Proof16_StableCharFnStable`

- **`Taleb.Proof16.repaired`** (alias of `AuditProbability.stableS1_convolutionPower_eq`) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {μ ν : MeasureTheory.Measure ℝ} [MeasureTheory.IsProbabilityMeasure μ] [MeasureTheory.IsProbabilityMeasure ν]
  (p : StableAudit.StableParameters) (n : ℕ),
  (∀ (t : ℝ), MeasureTheory.charFun μ t = StableAudit.stableS1Expr p.alpha p.beta p.location p.scale t) →
    (∀ (t : ℝ),
        MeasureTheory.charFun ν t =
          StableAudit.stableS1Expr p.alpha p.beta (↑n * p.location) (↑n ^ (1 / p.alpha) * p.scale) t) →
      AuditProbability.convolutionPower μ n = ν
  ```

## Public definitions (axiom closure checked)

- `AuditProbability.IsSubexponential` : `MeasureTheory.Measure ℝ → Prop` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.convolutionPower` : `MeasureTheory.Measure ℝ → ℕ → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.survival` : `MeasureTheory.Measure ℝ → ℝ → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditRV.IsRegularlyVarying` : `(ℝ → ℝ) → ℝ → Prop` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditRV.IsSlowlyVarying` : `(ℝ → ℝ) → Prop` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.HasFiniteTailExponent` : `(ℝ → ℝ) → ℝ → Prop` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.frechetCDF` : `ℝ → ℝ → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.frechetFormula` : `ℝ → ℝ → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.gumbelCDF` : `ℝ → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.tailExponentReal` : `(ℝ → ℝ) → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `Proof09Probe.statement` : `{univ : Set ℝ} → {c : ℝ} → 0 < c → Prop` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.stableExpr` : `ℝ → ℝ → ℝ → ℝ → ℝ → ℂ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.stableS1Expr` : `ℝ → ℝ → ℝ → ℝ → ℝ → ℂ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`

## Lean-generated public constants (axiom closure checked)

- `StableAudit.StableParameters.alpha` (def, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.alpha_le_two` (theorem, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.alpha_pos` (theorem, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.beta` (def, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.beta_bounds` (theorem, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.casesOn` (def, auxRecursor) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.ctorIdx` (def, noDeclarationRange) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.location` (def, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.mk` (constructor, constructor) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.mk.inj` (theorem, noDeclarationRange) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.mk.injEq` (theorem, noDeclarationRange) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.mk.noConfusion` (def, noDeclarationRange) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.mk.sizeOf_spec` (theorem, noDeclarationRange) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.noConfusion` (def, noConfusion) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.noConfusionType` (def, noDeclarationRange) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.rec` (recursor, recursor) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.recOn` (def, auxRecursor) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.scale` (def, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.scale_nonneg` (theorem, projection) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

## Internally named constants (axiom closure checked)

- `AuditMoments.gamma_mixture_excess._simp_1_1` (theorem) — axioms `['propext']`
- `AuditMoments.gamma_mixture_excess._simp_1_2` (theorem) — axioms `['propext']`
- `AuditMoments.gamma_mixture_excess._simp_1_3` (theorem) — axioms `['propext']`
- `AuditMoments.gamma_mixture_excess._simp_1_4` (theorem) — axioms `['propext']`
- `AuditMoments.gamma_mixture_excess._simp_1_5` (theorem) — axioms `['propext']`
- `AuditMoments.gamma_mixture_excess._simp_1_6` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditMoments.gamma_mixture_excess._simp_1_7` (theorem) — axioms `['propext']`
- `AuditProbability.IsSubexponential._proof_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.convolutionPower._sunfold` (def) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.convolutionPower.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.convolutionPower.eq_2` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.convolutionPower.match_1` (def) — axioms `[]`
- `AuditRV.IsRegularlyVarying.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditRV.IsSlowlyVarying.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditRV.isRegularlyVarying_iff_slowlyVarying._simp_1_1` (theorem) — axioms `['propext']`
- `AuditRV.isRegularlyVarying_iff_slowlyVarying._simp_1_2` (theorem) — axioms `['propext']`
- `AuditRV.isRegularlyVarying_iff_slowlyVarying._simp_1_3` (theorem) — axioms `['propext']`
- `AuditRV.isRegularlyVarying_iff_slowlyVarying._simp_1_4` (theorem) — axioms `['propext']`
- `AuditRV.isRegularlyVarying_iff_slowlyVarying._simp_1_5` (theorem) — axioms `['propext']`
- `AuditRV.isRegularlyVarying_iff_slowlyVarying._simp_1_6` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditRV.isRegularlyVarying_iff_slowlyVarying._simp_1_7` (theorem) — axioms `['propext']`
- `AuditTails.frechetCDF.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.frechetFormula.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.gumbelCDF.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditTails.real_liminf_of_tendsto_atTop._simp_1_1` (theorem) — axioms `['propext']`
- `AuditTails.tailExponentReal.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters._sizeOf_1` (def) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters._sizeOf_inst` (def) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.StableParameters.mk._flat_ctor` (def) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.stableExpr._proof_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.stableExpr.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `StableAudit.stableS1Expr.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `_private.AuditRepairs.ProbabilityBridge.0.AuditProbability.convolutionPower.match_1.eq_1` (theorem) — axioms `[]`
- `_private.AuditRepairs.ProbabilityBridge.0.AuditProbability.convolutionPower.match_1.eq_2` (theorem) — axioms `[]`
- `_private.AuditRepairs.ProbabilityBridge.0.AuditProbability.convolutionPower.match_1.splitter` (def) — axioms `[]`
