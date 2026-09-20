# Final declaration inventory (Fable review, v0.2.7)

Generated from `evidence/current/inventory_environment.json` (Lean 4.24.0; every project constant, axiom closure collected before any filtering) and `evidence/current/declarations.json`.

- Project constants scanned: **296** = 164 public user-written theorem/instance + 33 public user-written defs + 1 structure type + 19 Lean-generated public constants + 79 internally named constants.
- Public user-written theorem/instance constants: **164** = 140 theorems + 8 instances + 16 aliases; equals the `#print axioms` set of `AuditVerification.lean` (164).
- Axiom closures over all scanned constants: `['Classical.choice', 'Quot.sound', 'propext']` x258; `['propext']` x34; `[]` x4. No `sorryAx`; no project `axiom`.
- Imported project modules: 28; backlog: 158 families, 2 discharged (T060, T061), 123 citations over 122 distinct declarations, schema valid, Markdown equals rendering.

## Count reconciliation

| quantity | v0.2.0 | v0.2.1 | v0.2.2 | v0.2.3 | v0.2.4 | v0.2.5 | v0.2.6 | v0.2.7 |
|---|---|---|---|---|---|---|---|---|
| theorem declarations (regex) | 50 | 52 | 52 | 64 | 83 | 103 | 125 | **140** |
| instances | 1 | 1 | 1 | 1 | 1 | 3 | 8 | **8** |
| aliases | 16 | 16 | 16 | 16 | 16 | 16 | 16 | 16 |
| checked declarations | 67 | 69 | 69 | 81 | 100 | 122 | 149 | **164** |
| environment: constants axiom-checked | 100 | 102 | 137 | 158 | 189 | 216 | 270 | **296** (217 + 79 internal) |
| new in v0.2.7 | | | | | | | | 15 theorems, 1 def: global continuity of `frechetCDF`/`reverseWeibullCDF`; `AuditRepairs/WeightedSums.lean` (analytic rescaling/max/sum/squeeze rules for `HasFiniteTailExponent`, event inclusions, probabilistic Property 5.1 for random variables and for pushforward laws) |

## Public user-written declarations with exact statements

### `AuditRepairs.WeightedSums`

- **`AuditProbability.hasFiniteTailExponent_survival_map_weightedSum`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {X Y : Ω → ℝ} {a b α β : ℝ},
    0 < a →
      0 < b →
        (∀ (ω : Ω), 0 ≤ X ω) →
          (∀ (ω : Ω), 0 ≤ Y ω) →
            Measurable X →
              Measurable Y →
                AuditTails.HasFiniteTailExponent (AuditProbability.survival (MeasureTheory.Measure.map X P)) α →
                  AuditTails.HasFiniteTailExponent (AuditProbability.survival (MeasureTheory.Measure.map Y P)) β →
                    AuditTails.HasFiniteTailExponent
                      (AuditProbability.survival (MeasureTheory.Measure.map (fun ω => a * X ω + b * Y ω) P)) (Min.min α β)
  ```
- **`AuditProbability.hasFiniteTailExponent_weightedSum`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {X Y : Ω → ℝ} {a b α β : ℝ},
    0 < a →
      0 < b →
        (∀ (ω : Ω), 0 ≤ X ω) →
          (∀ (ω : Ω), 0 ≤ Y ω) →
            AuditTails.HasFiniteTailExponent (AuditProbability.survivalRV P X) α →
              AuditTails.HasFiniteTailExponent (AuditProbability.survivalRV P Y) β →
                AuditTails.HasFiniteTailExponent (AuditProbability.survivalRV P fun ω => a * X ω + b * Y ω) (Min.min α β)
  ```
- **`AuditProbability.survivalRV_eq_survival_map`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} {X : Ω → ℝ},
    Measurable X → AuditProbability.survivalRV P X = AuditProbability.survival (MeasureTheory.Measure.map X P)
  ```
- **`AuditProbability.weightedSum_event_lower_left`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {X Y : Ω → ℝ} {a b t : ℝ},
    0 < a → 0 < b → (∀ (ω : Ω), 0 ≤ Y ω) → {ω | a⁻¹ * t < X ω} ⊆ {ω | t < a * X ω + b * Y ω}
  ```
- **`AuditProbability.weightedSum_event_lower_right`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {X Y : Ω → ℝ} {a b t : ℝ},
    0 < a → 0 < b → (∀ (ω : Ω), 0 ≤ X ω) → {ω | b⁻¹ * t < Y ω} ⊆ {ω | t < a * X ω + b * Y ω}
  ```
- **`AuditProbability.weightedSum_event_upper`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {X Y : Ω → ℝ} {a b t : ℝ},
    0 < a → 0 < b → {ω | t < a * X ω + b * Y ω} ⊆ {ω | (2 * a)⁻¹ * t < X ω} ∪ {ω | (2 * b)⁻¹ * t < Y ω}
  ```
- **`AuditTails.HasFiniteTailExponent.add`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {S₁ S₂ : ℝ → ℝ} {α β : ℝ},
    AuditTails.HasFiniteTailExponent S₁ α →
      AuditTails.HasFiniteTailExponent S₂ β → AuditTails.HasFiniteTailExponent (fun t => S₁ t + S₂ t) (Min.min α β)
  ```
- **`AuditTails.HasFiniteTailExponent.comp_const_mul`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {S : ℝ → ℝ} {α c : ℝ},
    AuditTails.HasFiniteTailExponent S α → 0 < c → AuditTails.HasFiniteTailExponent (fun t => S (c * t)) α
  ```
- **`AuditTails.HasFiniteTailExponent.max`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {S₁ S₂ : ℝ → ℝ} {α β : ℝ},
    AuditTails.HasFiniteTailExponent S₁ α →
      AuditTails.HasFiniteTailExponent S₂ β →
        AuditTails.HasFiniteTailExponent (fun t => Max.max (S₁ t) (S₂ t)) (Min.min α β)
  ```
- **`AuditTails.HasFiniteTailExponent.of_le_of_le`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {L S U : ℝ → ℝ} {γ : ℝ},
    AuditTails.HasFiniteTailExponent L γ →
      AuditTails.HasFiniteTailExponent U γ →
        (∀ᶠ (t : ℝ) in Filter.atTop, L t ≤ S t) →
          (∀ᶠ (t : ℝ) in Filter.atTop, S t ≤ U t) → AuditTails.HasFiniteTailExponent S γ
  ```
- **`AuditTails.log_add_le_log_two_add_max`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {s₁ s₂ : ℝ}, 0 < s₁ → 0 < s₂ → Real.log (s₁ + s₂) ≤ Real.log 2 + Max.max (Real.log s₁) (Real.log s₂)
  ```
- **`AuditTails.log_max_of_pos`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {s₁ s₂ : ℝ}, 0 < s₁ → 0 < s₂ → Real.log (Max.max s₁ s₂) = Max.max (Real.log s₁) (Real.log s₂)
  ```
- **`AuditTails.neg_log_div_log_antitone`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {s t x : ℝ}, 0 < s → s ≤ t → 1 < x → -Real.log t / Real.log x ≤ -Real.log s / Real.log x
  ```

### `AuditRepairs.ExtremeValueAffine`

- **`AuditEVTLaws.affineLaw_isProbabilityMeasure`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (ν : MeasureTheory.Measure ℝ) [MeasureTheory.IsProbabilityMeasure ν] (μ σ : ℝ),
    MeasureTheory.IsProbabilityMeasure (AuditEVTLaws.affineLaw ν μ σ)
  ```
- **`AuditEVTLaws.affineLaw_zero_one`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (ν : MeasureTheory.Measure ℝ), AuditEVTLaws.affineLaw ν 0 1 = ν
  ```
- **`AuditEVTLaws.affine_preimage_Iic`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {μ σ : ℝ}, 0 < σ → ∀ (x : ℝ), (fun z => μ + σ * z) ⁻¹' Set.Iic x = Set.Iic ((x - μ) / σ)
  ```
- **`AuditEVTLaws.cdf_affineLaw`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ν : MeasureTheory.Measure ℝ} {μ σ : ℝ} [MeasureTheory.IsProbabilityMeasure ν],
    0 < σ →
      ∀ (x : ℝ), ↑(ProbabilityTheory.cdf (AuditEVTLaws.affineLaw ν μ σ)) x = ↑(ProbabilityTheory.cdf ν) ((x - μ) / σ)
  ```
- **`AuditEVTLaws.cdf_frechetLaw`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ} (hξ : 0 < ξ) {μ σ : ℝ},
    0 < σ →
      ∀ (x : ℝ), ↑(ProbabilityTheory.cdf (AuditEVTLaws.frechetLaw ξ hξ μ σ)) x = AuditTails.frechetCDF ξ ((x - μ) / σ)
  ```
- **`AuditEVTLaws.cdf_gumbelLaw`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {μ σ : ℝ},
    0 < σ → ∀ (x : ℝ), ↑(ProbabilityTheory.cdf (AuditEVTLaws.gumbelLaw μ σ)) x = AuditTails.gumbelCDF ((x - μ) / σ)
  ```
- **`AuditEVTLaws.cdf_reverseWeibullLaw`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ} (hα : 0 < α) {μ σ : ℝ},
    0 < σ →
      ∀ (x : ℝ),
        ↑(ProbabilityTheory.cdf (AuditEVTLaws.reverseWeibullLaw α hα μ σ)) x =
          AuditEVTLaws.reverseWeibullCDF α ((x - μ) / σ)
  ```
- **`AuditEVTLaws.frechetLaw_isProbabilityMeasure`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (ξ : ℝ) (hξ : 0 < ξ) (μ σ : ℝ), MeasureTheory.IsProbabilityMeasure (AuditEVTLaws.frechetLaw ξ hξ μ σ)
  ```
- **`AuditEVTLaws.gumbelLaw_isProbabilityMeasure`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (μ σ : ℝ), MeasureTheory.IsProbabilityMeasure (AuditEVTLaws.gumbelLaw μ σ)
  ```
- **`AuditEVTLaws.map_maxRV_frechetLaw`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {ι : Type u_2} [inst_2 : Fintype ι] [inst_3 : Nonempty ι] {ξ : ℝ} (hξ : 0 < ξ) {μ σ : ℝ},
    0 < σ →
      ∀ (X : ι → Ω → ℝ),
        ProbabilityTheory.iIndepFun X P →
          (∀ (i : ι), Measurable (X i)) →
            (∀ (i : ι), MeasureTheory.Measure.map (X i) P = AuditEVTLaws.frechetLaw ξ hξ μ σ) →
              MeasureTheory.Measure.map (AuditExtremes.maxRV X) P =
                AuditEVTLaws.frechetLaw ξ hξ μ (σ * ↑(Fintype.card ι) ^ ξ)
  ```
- **`AuditEVTLaws.map_maxRV_gumbelLaw`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {ι : Type u_2} [inst_2 : Fintype ι] [inst_3 : Nonempty ι] {μ σ : ℝ},
    0 < σ →
      ∀ (X : ι → Ω → ℝ),
        ProbabilityTheory.iIndepFun X P →
          (∀ (i : ι), Measurable (X i)) →
            (∀ (i : ι), MeasureTheory.Measure.map (X i) P = AuditEVTLaws.gumbelLaw μ σ) →
              MeasureTheory.Measure.map (AuditExtremes.maxRV X) P =
                AuditEVTLaws.gumbelLaw (μ + σ * Real.log ↑(Fintype.card ι)) σ
  ```
- **`AuditEVTLaws.map_maxRV_reverseWeibullLaw`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {ι : Type u_2} [inst_2 : Fintype ι] [inst_3 : Nonempty ι] {α : ℝ} (hα : 0 < α) {μ σ : ℝ},
    0 < σ →
      ∀ (X : ι → Ω → ℝ),
        ProbabilityTheory.iIndepFun X P →
          (∀ (i : ι), Measurable (X i)) →
            (∀ (i : ι), MeasureTheory.Measure.map (X i) P = AuditEVTLaws.reverseWeibullLaw α hα μ σ) →
              MeasureTheory.Measure.map (AuditExtremes.maxRV X) P =
                AuditEVTLaws.reverseWeibullLaw α hα μ (σ * ↑(Fintype.card ι) ^ (-(1 / α)))
  ```
- **`AuditEVTLaws.measurable_affine`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (μ σ : ℝ), Measurable fun z => μ + σ * z
  ```
- **`AuditEVTLaws.reverseWeibullLaw_isProbabilityMeasure`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (α : ℝ) (hα : 0 < α) (μ σ : ℝ), MeasureTheory.IsProbabilityMeasure (AuditEVTLaws.reverseWeibullLaw α hα μ σ)
  ```

### `AuditRepairs.ExtremeValueLaws`

- **`AuditEVTLaws.cdf_frechetMeasure`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ} (hξ : 0 < ξ), ProbabilityTheory.cdf (AuditEVTLaws.frechetMeasure ξ hξ) = AuditEVTLaws.frechetStieltjes ξ hξ
  ```
- **`AuditEVTLaws.cdf_frechetMeasure_apply`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ} (hξ : 0 < ξ) (x : ℝ),
    ↑(ProbabilityTheory.cdf (AuditEVTLaws.frechetMeasure ξ hξ)) x = AuditTails.frechetCDF ξ x
  ```
- **`AuditEVTLaws.cdf_gumbelMeasure`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ProbabilityTheory.cdf AuditEVTLaws.gumbelMeasure = AuditEVTLaws.gumbelStieltjes
  ```
- **`AuditEVTLaws.cdf_gumbelMeasure_apply`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (x : ℝ), ↑(ProbabilityTheory.cdf AuditEVTLaws.gumbelMeasure) x = AuditTails.gumbelCDF x
  ```
- **`AuditEVTLaws.cdf_map_maxRV_frechet`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ} {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {ι : Type u_2} [inst_2 : Fintype ι] [inst_3 : Nonempty ι] (hξ : 0 < ξ) (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = AuditEVTLaws.frechetMeasure ξ hξ) →
          ∀ (x : ℝ),
            ↑(ProbabilityTheory.cdf (MeasureTheory.Measure.map (AuditExtremes.maxRV X) P)) x =
              AuditTails.frechetCDF ξ (↑(Fintype.card ι) ^ (-ξ) * x)
  ```
- **`AuditEVTLaws.cdf_map_maxRV_gumbel`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {ι : Type u_2} [inst_2 : Fintype ι] [inst_3 : Nonempty ι] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = AuditEVTLaws.gumbelMeasure) →
          ∀ (x : ℝ),
            ↑(ProbabilityTheory.cdf (MeasureTheory.Measure.map (AuditExtremes.maxRV X) P)) x =
              AuditTails.gumbelCDF (x - Real.log ↑(Fintype.card ι))
  ```
- **`AuditEVTLaws.cdf_map_maxRV_pi_frechet`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ} {ι : Type u_1} [inst : Fintype ι] [inst_1 : Nonempty ι] (hξ : 0 < ξ) (x : ℝ),
    ↑(ProbabilityTheory.cdf
            (MeasureTheory.Measure.map (AuditExtremes.maxRV fun i ω => ω i)
              (MeasureTheory.Measure.pi fun x => AuditEVTLaws.frechetMeasure ξ hξ)))
        x =
      AuditTails.frechetCDF ξ (↑(Fintype.card ι) ^ (-ξ) * x)
  ```
- **`AuditEVTLaws.cdf_map_maxRV_pi_gumbel`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ι : Type u_1} [inst : Fintype ι] [inst_1 : Nonempty ι] (x : ℝ),
    ↑(ProbabilityTheory.cdf
            (MeasureTheory.Measure.map (AuditExtremes.maxRV fun i ω => ω i)
              (MeasureTheory.Measure.pi fun x => AuditEVTLaws.gumbelMeasure)))
        x =
      AuditTails.gumbelCDF (x - Real.log ↑(Fintype.card ι))
  ```
- **`AuditEVTLaws.cdf_map_maxRV_pi_reverseWeibull`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ} {ι : Type u_1} [inst : Fintype ι] [inst_1 : Nonempty ι] (hα : 0 < α) (x : ℝ),
    ↑(ProbabilityTheory.cdf
            (MeasureTheory.Measure.map (AuditExtremes.maxRV fun i ω => ω i)
              (MeasureTheory.Measure.pi fun x => AuditEVTLaws.reverseWeibullMeasure α hα)))
        x =
      AuditEVTLaws.reverseWeibullCDF α (↑(Fintype.card ι) ^ (1 / α) * x)
  ```
- **`AuditEVTLaws.cdf_map_maxRV_reverseWeibull`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ} {Ω : Type u_1} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [MeasureTheory.IsProbabilityMeasure P]
    {ι : Type u_2} [inst_2 : Fintype ι] [inst_3 : Nonempty ι] (hα : 0 < α) (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = AuditEVTLaws.reverseWeibullMeasure α hα) →
          ∀ (x : ℝ),
            ↑(ProbabilityTheory.cdf (MeasureTheory.Measure.map (AuditExtremes.maxRV X) P)) x =
              AuditEVTLaws.reverseWeibullCDF α (↑(Fintype.card ι) ^ (1 / α) * x)
  ```
- **`AuditEVTLaws.cdf_reverseWeibullMeasure`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ} (hα : 0 < α),
    ProbabilityTheory.cdf (AuditEVTLaws.reverseWeibullMeasure α hα) = AuditEVTLaws.reverseWeibullStieltjes α hα
  ```
- **`AuditEVTLaws.cdf_reverseWeibullMeasure_apply`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ} (hα : 0 < α) (x : ℝ),
    ↑(ProbabilityTheory.cdf (AuditEVTLaws.reverseWeibullMeasure α hα)) x = AuditEVTLaws.reverseWeibullCDF α x
  ```
- **`AuditEVTLaws.continuous_frechetCDF`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, 0 < ξ → Continuous (AuditTails.frechetCDF ξ)
  ```
- **`AuditEVTLaws.continuous_gumbelCDF`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  Continuous AuditTails.gumbelCDF
  ```
- **`AuditEVTLaws.continuous_reverseWeibullCDF`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ}, 0 < α → Continuous (AuditEVTLaws.reverseWeibullCDF α)
  ```
- **`AuditEVTLaws.frechetCDF_continuousWithinAt_Ici`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, 0 < ξ → ∀ (x₀ : ℝ), ContinuousWithinAt (AuditTails.frechetCDF ξ) (Set.Ici x₀) x₀
  ```
- **`AuditEVTLaws.frechetCDF_monotone`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, 0 < ξ → Monotone (AuditTails.frechetCDF ξ)
  ```
- **`AuditEVTLaws.frechetCDF_nonneg`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ} (x : ℝ), 0 ≤ AuditTails.frechetCDF ξ x
  ```
- **`AuditEVTLaws.frechetCDF_of_nonpos`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ x : ℝ}, x ≤ 0 → AuditTails.frechetCDF ξ x = 0
  ```
- **`AuditEVTLaws.frechetCDF_of_pos`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ x : ℝ}, 0 < x → AuditTails.frechetCDF ξ x = Real.exp (-x ^ (-1 / ξ))
  ```
- **`AuditEVTLaws.frechetCDF_tendsto_atBot`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, Filter.Tendsto (AuditTails.frechetCDF ξ) Filter.atBot (nhds 0)
  ```
- **`AuditEVTLaws.frechetCDF_tendsto_atTop`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, 0 < ξ → Filter.Tendsto (AuditTails.frechetCDF ξ) Filter.atTop (nhds 1)
  ```
- **`AuditEVTLaws.frechetMeasure_isProbabilityMeasure`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (ξ : ℝ) (hξ : 0 < ξ), MeasureTheory.IsProbabilityMeasure (AuditEVTLaws.frechetMeasure ξ hξ)
  ```
- **`AuditEVTLaws.gumbelCDF_monotone`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  Monotone AuditTails.gumbelCDF
  ```
- **`AuditEVTLaws.gumbelCDF_tendsto_atBot`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  Filter.Tendsto AuditTails.gumbelCDF Filter.atBot (nhds 0)
  ```
- **`AuditEVTLaws.gumbelCDF_tendsto_atTop`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  Filter.Tendsto AuditTails.gumbelCDF Filter.atTop (nhds 1)
  ```
- **`AuditEVTLaws.gumbelMeasure_isProbabilityMeasure`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  MeasureTheory.IsProbabilityMeasure AuditEVTLaws.gumbelMeasure
  ```
- **`AuditEVTLaws.neg_one_div_nonpos`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {ξ : ℝ}, 0 < ξ → -1 / ξ ≤ 0
  ```
- **`AuditEVTLaws.reverseWeibullCDF_continuousWithinAt_Ici`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ} (x₀ : ℝ), ContinuousWithinAt (AuditEVTLaws.reverseWeibullCDF α) (Set.Ici x₀) x₀
  ```
- **`AuditEVTLaws.reverseWeibullCDF_le_one`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ} (x : ℝ), AuditEVTLaws.reverseWeibullCDF α x ≤ 1
  ```
- **`AuditEVTLaws.reverseWeibullCDF_maxstable`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ},
    0 < α →
      ∀ (x : ℝ) (n : ℕ), AuditEVTLaws.reverseWeibullCDF α x ^ n = AuditEVTLaws.reverseWeibullCDF α (↑n ^ (1 / α) * x)
  ```
- **`AuditEVTLaws.reverseWeibullCDF_monotone`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ}, 0 < α → Monotone (AuditEVTLaws.reverseWeibullCDF α)
  ```
- **`AuditEVTLaws.reverseWeibullCDF_of_neg`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α x : ℝ}, x < 0 → AuditEVTLaws.reverseWeibullCDF α x = Real.exp (-(-x) ^ α)
  ```
- **`AuditEVTLaws.reverseWeibullCDF_of_nonneg`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α x : ℝ}, 0 ≤ x → AuditEVTLaws.reverseWeibullCDF α x = 1
  ```
- **`AuditEVTLaws.reverseWeibullCDF_tendsto_atBot`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ}, 0 < α → Filter.Tendsto (AuditEVTLaws.reverseWeibullCDF α) Filter.atBot (nhds 0)
  ```
- **`AuditEVTLaws.reverseWeibullCDF_tendsto_atTop`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {α : ℝ}, Filter.Tendsto (AuditEVTLaws.reverseWeibullCDF α) Filter.atTop (nhds 1)
  ```
- **`AuditEVTLaws.reverseWeibullMeasure_isProbabilityMeasure`** (instance) — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (α : ℝ) (hα : 0 < α), MeasureTheory.IsProbabilityMeasure (AuditEVTLaws.reverseWeibullMeasure α hα)
  ```

### `AuditRepairs.ExtremeValueBridge`

- **`AuditExtremes.cdf_map_maxRV`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    {ν : MeasureTheory.Measure ℝ} [inst_2 : Nonempty ι] [MeasureTheory.IsProbabilityMeasure P] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = ν) →
          ∀ (x : ℝ),
            ↑(ProbabilityTheory.cdf (MeasureTheory.Measure.map (AuditExtremes.maxRV X) P)) x =
              ↑(ProbabilityTheory.cdf ν) x ^ Fintype.card ι
  ```
- **`AuditExtremes.maxLeEvent_eq_iInter`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} (X : ι → Ω → ℝ) (x : ℝ), AuditExtremes.maxLeEvent X x = ⋂ i, X i ⁻¹' Set.Iic x
  ```
- **`AuditExtremes.maxLtEvent_eq_iInter`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} (X : ι → Ω → ℝ) (x : ℝ), AuditExtremes.maxLtEvent X x = ⋂ i, X i ⁻¹' Set.Iio x
  ```
- **`AuditExtremes.maxRV_preimage_Iic`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : Fintype ι] [inst_1 : Nonempty ι] (X : ι → Ω → ℝ) (x : ℝ),
    AuditExtremes.maxRV X ⁻¹' Set.Iic x = AuditExtremes.maxLeEvent X x
  ```
- **`AuditExtremes.measurable_maxRV`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] [inst_1 : Fintype ι] [inst_2 : Nonempty ι] {X : ι → Ω → ℝ},
    (∀ (i : ι), Measurable (X i)) → Measurable (AuditExtremes.maxRV X)
  ```
- **`AuditExtremes.measurable_minRV`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] [inst_1 : Fintype ι] [inst_2 : Nonempty ι] {X : ι → Ω → ℝ},
    (∀ (i : ι), Measurable (X i)) → Measurable (AuditExtremes.minRV X)
  ```
- **`AuditExtremes.measureReal_map_minRV_Ioi`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    {ν : MeasureTheory.Measure ℝ} [inst_2 : Nonempty ι] [MeasureTheory.IsProbabilityMeasure P] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = ν) →
          ∀ (x : ℝ),
            (MeasureTheory.Measure.map (AuditExtremes.minRV X) P).real (Set.Ioi x) = ν.real (Set.Ioi x) ^ Fintype.card ι
  ```
- **`AuditExtremes.measureReal_map_minRV_Ioi_eq_one_sub_cdf`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    {ν : MeasureTheory.Measure ℝ} [inst_2 : Nonempty ι] [MeasureTheory.IsProbabilityMeasure P] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = ν) →
          ∀ (x : ℝ),
            (MeasureTheory.Measure.map (AuditExtremes.minRV X) P).real (Set.Ioi x) =
              (1 - ↑(ProbabilityTheory.cdf ν) x) ^ Fintype.card ι
  ```
- **`AuditExtremes.measureReal_maxLeEvent_frechet`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    [MeasureTheory.IsFiniteMeasure P] [Nonempty ι] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      ∀ {ξ : ℝ},
        0 < ξ →
          (∀ (i : ι) (x : ℝ), P.real (X i ⁻¹' Set.Iic x) = AuditTails.frechetCDF ξ x) →
            ∀ (x : ℝ), P.real (AuditExtremes.maxLeEvent X x) = AuditTails.frechetCDF ξ (↑(Fintype.card ι) ^ (-ξ) * x)
  ```
- **`AuditExtremes.measureReal_maxLeEvent_gumbel`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    [MeasureTheory.IsFiniteMeasure P] [Nonempty ι] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι) (x : ℝ), P.real (X i ⁻¹' Set.Iic x) = AuditTails.gumbelCDF x) →
        ∀ (x : ℝ), P.real (AuditExtremes.maxLeEvent X x) = AuditTails.gumbelCDF (x - Real.log ↑(Fintype.card ι))
  ```
- **`AuditExtremes.measureReal_maxLeEvent_of_forall_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    [MeasureTheory.IsFiniteMeasure P] [Nonempty ι] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      ∀ (x : ℝ) {q : ℝ},
        (∀ (i : ι), P.real (X i ⁻¹' Set.Iic x) = q) → P.real (AuditExtremes.maxLeEvent X x) = q ^ Fintype.card ι
  ```
- **`AuditExtremes.measureReal_minGtEvent_of_forall_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    [MeasureTheory.IsFiniteMeasure P] [Nonempty ι] (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      ∀ (x : ℝ) {q : ℝ},
        (∀ (i : ι), P.real (X i ⁻¹' Set.Ioi x) = q) → P.real (AuditExtremes.minGtEvent X x) = q ^ Fintype.card ι
  ```
- **`AuditExtremes.measure_iInter_preimage`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P → ∀ {B : Set ℝ}, MeasurableSet B → P (⋂ i, X i ⁻¹' B) = ∏ i, P (X i ⁻¹' B)
  ```
- **`AuditExtremes.measure_maxLeEvent`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P → ∀ (x : ℝ), P (AuditExtremes.maxLeEvent X x) = ∏ i, P (X i ⁻¹' Set.Iic x)
  ```
- **`AuditExtremes.measure_maxLeEvent_of_forall_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      ∀ (x : ℝ) {p : ENNReal},
        (∀ (i : ι), P (X i ⁻¹' Set.Iic x) = p) → P (AuditExtremes.maxLeEvent X x) = p ^ Fintype.card ι
  ```
- **`AuditExtremes.measure_maxLeEvent_of_map_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    {ν : MeasureTheory.Measure ℝ} (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = ν) →
          ∀ (x : ℝ), P (AuditExtremes.maxLeEvent X x) = ν (Set.Iic x) ^ Fintype.card ι
  ```
- **`AuditExtremes.measure_maxLtEvent`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P → ∀ (x : ℝ), P (AuditExtremes.maxLtEvent X x) = ∏ i, P (X i ⁻¹' Set.Iio x)
  ```
- **`AuditExtremes.measure_minGeEvent`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P → ∀ (x : ℝ), P (AuditExtremes.minGeEvent X x) = ∏ i, P (X i ⁻¹' Set.Ici x)
  ```
- **`AuditExtremes.measure_minGtEvent`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P → ∀ (x : ℝ), P (AuditExtremes.minGtEvent X x) = ∏ i, P (X i ⁻¹' Set.Ioi x)
  ```
- **`AuditExtremes.measure_minGtEvent_of_forall_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      ∀ (x : ℝ) {p : ENNReal},
        (∀ (i : ι), P (X i ⁻¹' Set.Ioi x) = p) → P (AuditExtremes.minGtEvent X x) = p ^ Fintype.card ι
  ```
- **`AuditExtremes.measure_minGtEvent_of_map_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} [inst_1 : Fintype ι]
    {ν : MeasureTheory.Measure ℝ} (X : ι → Ω → ℝ),
    ProbabilityTheory.iIndepFun X P →
      (∀ (i : ι), Measurable (X i)) →
        (∀ (i : ι), MeasureTheory.Measure.map (X i) P = ν) →
          ∀ (x : ℝ), P (AuditExtremes.minGtEvent X x) = ν (Set.Ioi x) ^ Fintype.card ι
  ```
- **`AuditExtremes.measure_preimage_of_map_eq`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : MeasurableSpace Ω] {P : MeasureTheory.Measure Ω} {ν : MeasureTheory.Measure ℝ}
    {X : ι → Ω → ℝ},
    (∀ (i : ι), Measurable (X i)) →
      (∀ (i : ι), MeasureTheory.Measure.map (X i) P = ν) → ∀ {B : Set ℝ}, MeasurableSet B → ∀ (i : ι), P (X i ⁻¹' B) = ν B
  ```
- **`AuditExtremes.minGeEvent_eq_iInter`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} (X : ι → Ω → ℝ) (x : ℝ), AuditExtremes.minGeEvent X x = ⋂ i, X i ⁻¹' Set.Ici x
  ```
- **`AuditExtremes.minGtEvent_eq_iInter`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} (X : ι → Ω → ℝ) (x : ℝ), AuditExtremes.minGtEvent X x = ⋂ i, X i ⁻¹' Set.Ioi x
  ```
- **`AuditExtremes.minRV_preimage_Ioi`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {Ω : Type u_1} {ι : Type u_2} [inst : Fintype ι] [inst_1 : Nonempty ι] (X : ι → Ω → ℝ) (x : ℝ),
    AuditExtremes.minRV X ⁻¹' Set.Ioi x = AuditExtremes.minGtEvent X x
  ```

### `AuditRepairs.GaussianBridge`

- **`AuditGaussian.charFun_gaussianReal_eq_stableS1Expr`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {v : NNReal} {μ σ β : ℝ},
    ↑v = 2 * σ ^ 2 →
      ∀ (t : ℝ), MeasureTheory.charFun (ProbabilityTheory.gaussianReal μ v) t = StableAudit.stableS1Expr 2 β μ σ t
  ```
- **`AuditGaussian.coe_varianceOfScale`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (σ : ℝ), ↑(AuditGaussian.varianceOfScale σ) = 2 * σ ^ 2
  ```
- **`AuditGaussian.convolutionPower_gaussianReal`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (m : ℝ) (v : NNReal) (n : ℕ),
    AuditProbability.convolutionPower (ProbabilityTheory.gaussianReal m v) n =
      ProbabilityTheory.gaussianReal (↑n * m) (↑n * v)
  ```
- **`AuditGaussian.convolutionPower_gaussianReal_scale`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ (m σ : ℝ),
    0 ≤ σ →
      ∀ (n : ℕ),
        AuditProbability.convolutionPower (ProbabilityTheory.gaussianReal m (AuditGaussian.varianceOfScale σ)) n =
          ProbabilityTheory.gaussianReal (↑n * m) (AuditGaussian.varianceOfScale (↑n ^ (1 / 2) * σ))
  ```

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
- **`AuditTails.two_power_tail`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {w₁ w₂ α₁ α₂ : ℝ},
    0 ≤ w₁ → 0 < w₂ → α₂ ≤ α₁ → AuditTails.HasFiniteTailExponent (fun z => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) α₂
  ```
- **`AuditTails.two_power_tail_min`** — axioms `['Classical.choice', 'Quot.sound', 'propext']`

  ```lean
  ∀ {w₁ w₂ α₁ α₂ : ℝ},
    0 < w₁ → 0 < w₂ → AuditTails.HasFiniteTailExponent (fun z => w₁ * z ^ (-α₁) + w₂ * z ^ (-α₂)) (Min.min α₁ α₂)
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

- `AuditEVTLaws.affineLaw` : `MeasureTheory.Measure ℝ → ℝ → ℝ → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.frechetLaw` : `(ξ : ℝ) → 0 < ξ → ℝ → ℝ → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.frechetMeasure` : `(ξ : ℝ) → 0 < ξ → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.frechetStieltjes` : `(ξ : ℝ) → 0 < ξ → StieltjesFunction` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.gumbelLaw` : `ℝ → ℝ → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.gumbelMeasure` : `MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.gumbelStieltjes` : `StieltjesFunction` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.reverseWeibullCDF` : `ℝ → ℝ → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.reverseWeibullLaw` : `(α : ℝ) → 0 < α → ℝ → ℝ → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.reverseWeibullMeasure` : `(α : ℝ) → 0 < α → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.reverseWeibullStieltjes` : `(α : ℝ) → 0 < α → StieltjesFunction` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.maxLeEvent` : `{Ω : Type u_1} → {ι : Type u_2} → (ι → Ω → ℝ) → ℝ → Set Ω` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.maxLtEvent` : `{Ω : Type u_1} → {ι : Type u_2} → (ι → Ω → ℝ) → ℝ → Set Ω` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.maxRV` : `{Ω : Type u_1} → {ι : Type u_2} → [Fintype ι] → [Nonempty ι] → (ι → Ω → ℝ) → Ω → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.minGeEvent` : `{Ω : Type u_1} → {ι : Type u_2} → (ι → Ω → ℝ) → ℝ → Set Ω` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.minGtEvent` : `{Ω : Type u_1} → {ι : Type u_2} → (ι → Ω → ℝ) → ℝ → Set Ω` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.minRV` : `{Ω : Type u_1} → {ι : Type u_2} → [Fintype ι] → [Nonempty ι] → (ι → Ω → ℝ) → Ω → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditGaussian.gaussianParameters` : `ℝ → (σ : ℝ) → 0 ≤ σ → StableAudit.StableParameters` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditGaussian.varianceOfScale` : `ℝ → NNReal` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.IsSubexponential` : `MeasureTheory.Measure ℝ → Prop` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.convolutionPower` : `MeasureTheory.Measure ℝ → ℕ → MeasureTheory.Measure ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.survival` : `MeasureTheory.Measure ℝ → ℝ → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.survivalRV` : `{Ω : Type u_1} → [inst : MeasurableSpace Ω] → MeasureTheory.Measure Ω → (Ω → ℝ) → ℝ → ℝ` — axioms `['Classical.choice', 'Quot.sound', 'propext']`
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

- `AuditEVTLaws.affineLaw.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.affine_preimage_Iic._simp_1_1` (theorem) — axioms `['propext']`
- `AuditEVTLaws.affine_preimage_Iic._simp_1_2` (theorem) — axioms `['propext']`
- `AuditEVTLaws.frechetLaw.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.gumbelLaw.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.gumbelStieltjes._proof_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.map_maxRV_frechetLaw._simp_1_1` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_frechetLaw._simp_1_2` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_frechetLaw._simp_1_3` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_frechetLaw._simp_1_4` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_frechetLaw._simp_1_5` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_frechetLaw._simp_1_6` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.map_maxRV_frechetLaw._simp_1_7` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_reverseWeibullLaw._simp_1_1` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_reverseWeibullLaw._simp_1_2` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_reverseWeibullLaw._simp_1_3` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_reverseWeibullLaw._simp_1_4` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_reverseWeibullLaw._simp_1_5` (theorem) — axioms `['propext']`
- `AuditEVTLaws.map_maxRV_reverseWeibullLaw._simp_1_6` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditEVTLaws.map_maxRV_reverseWeibullLaw._simp_1_7` (theorem) — axioms `['propext']`
- `AuditEVTLaws.reverseWeibullLaw.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.maxLeEvent.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.maxLtEvent.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.maxRV.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.maxRV_preimage_Iic._simp_1_3` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.minGeEvent.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.minGtEvent.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.minRV.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditExtremes.minRV_preimage_Ioi._simp_1_3` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditGaussian.gaussianParameters._proof_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditGaussian.gaussianParameters._proof_2` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditGaussian.gaussianParameters._proof_3` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditGaussian.varianceOfScale._proof_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditGaussian.varianceOfScale._proof_2` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
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
- `AuditProbability.survival.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.survivalRV.eq_1` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_1` (theorem) — axioms `['propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_2` (theorem) — axioms `['propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_3` (theorem) — axioms `['propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_4` (theorem) — axioms `['propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_5` (theorem) — axioms `['propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_6` (theorem) — axioms `['propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_7` (theorem) — axioms `['Classical.choice', 'Quot.sound', 'propext']`
- `AuditProbability.weightedSum_event_upper._simp_1_8` (theorem) — axioms `['propext']`
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
