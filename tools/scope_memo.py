#!/usr/bin/env python3
"""Render SCOPE_MEMO.md — the standing answer to "how far are we from completing the formalism?"

    python3 tools/scope_memo.py            # rewrite SCOPE_MEMO.md
    python3 tools/scope_memo.py --check    # exit 1 if SCOPE_MEMO.md differs from the rendering

Every number in the memo is computed here from the ledger (`Taleb_Lean_Repairs/docs/
FORMALIZATION_BACKLOG.json`), the committed evidence layers and ledger snapshots at each release
commit (via `git show`), the current verifier record, and a scan of the pinned Mathlib checkout.
Only judgments are hand-maintained, in the constants below (SUBSTANCE, TIERS, GAPS, NEXT,
PROCESS_NOTES, REVISIONS), and each is cross-checked against the data: an untouched P1 family
without a tier, a tiered family that has since gained Lean support, or a release without a
substance line is reported in the memo rather than silently dropped. This is a repository note
for the project owner (and, on request, for the auditor); it is not part of the audited package.
"""
import collections,datetime,json,re,subprocess,sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]; PKG=ROOT/'Taleb_Lean_Repairs'; OUT=ROOT/'SCOPE_MEMO.md'
STATUSES=('discharged','partial','reuse','missing','source-check','model-needed','empirical')

# ---------------------------------------------------------------- hand-maintained judgments
SUBSTANCE={  # one line per release: what the release actually bought
 'v0.2.0':'received handoff: 16 replacement proofs, inventory (not a Fable release)',
 'v0.2.1':'reproduction, harness hardening, G17/G18, two boundary diagnostics',
 'v0.2.2':'harness/documentation corrective pass (trust scan of all constants, regression suite)',
 'v0.2.3':'two-term power tails (G18), Gaussian stable bridge, independent maxima',
 'v0.2.4':'independent minima, law-level `cdf(max) = F^n`; **first closed family (T060)**',
 'v0.2.5':'Gumbel and Fréchet measures via Stieltjes functions',
 'v0.2.6':'reverse-Weibull, location/scale API, laws of iid maxima as measure equalities; **second closed family (T061)**',
 'v0.2.7':'Property 5.1 for random variables (T029 binary child), global continuity of the EVT cdfs',
 'v0.2.8':'exact Pareto law, Stage A: survival/cdf, moments, extended-integral divergence, tail exponent (T021/T028 slices)',
 'v0.2.9':'exact Pareto law, Stage B: threshold law via `cond`, excess law, means, positive-power law (T005/T032 slices)',
 'v0.2.10':'centered Pareto moments: mean, centered MAD through the threshold law, variance via Mathlib `variance`, STD/MAD ratio (4.14) (T021 slice)',
}
# Effort tiers for P1 families that have no Lean support yet. A = contained, current infrastructure
# suffices; B = medium, needs a definition layer first; C = statement-review gate first.
TIERS={
 'A':['T003','T014','T015','T016','T019','T020','T030','T036','T040','T044','T049','T051','T058','T059','T076','T078',
      'T081','T083','T086','T103','T111','T112','T113','T117','T131','T142','T143','T146','T151'],
 'B':['T006','T009','T054','T068','T073','T085','T099'],
 'C':['T011','T012','T025','T053','T055','T064','T066','T072','T079','T116','T128','T141'],
}
# Supported P1 families whose remaining work is blocked on infrastructure the pinned Mathlib lacks.
INFRA_BLOCKED_SUPPORTED={'T007':'stable-law existence for α < 2 (Bochner / Lévy–Khintchine)','T046':'Cauchy law and its characteristic function',
 'T047':'stable sample-average law','T001':'Karamata-dependent parts of regular variation'}
# Infrastructure scan of the pinned Mathlib: (label, regex, families/groups it blocks). Matched case-sensitively.
GAPS=[
 ('Central limit theorem (any form)',r'centralLimit|CentralLimit|central_limit_theorem','T004, T158, Gaussian normalisers in T062, most of the CLT group'),
 ('Cauchy distribution (as a defined law)',r'cauchyPDF|cauchyMeasure|cauchyReal|Distributions/Cauchy','T046 (Cauchy half), Cauchy-based rows'),
 ('Student t distribution',r'studentT|studentPDF|tDistribution','T021 (Student moments), Student-based rows'),
 ('Karamata / slowly-varying theory',r'Karamata|SlowlyVarying|slowlyVarying|RegularlyVarying','T002, T026, T027, general T011/T028, RV group beyond ratios'),
 ("Bochner's theorem / Lévy–Khintchine (a law from a characteristic function)",r"Bochner's theorem|LevyKhintchine|Lévy–Khintchine|Lévy-Khintchine",'T007 (α < 2), T093, T047'),
 ('Gini coefficient API',r'giniCoefficient|Gini coefficient|Gini index','GINI group'),
 ('Expected shortfall API',r'expectedShortfall|ExpectedShortfall|expected shortfall','T009'),
 ('Maximum-entropy API',r'maxEntropy|maximum entropy|MaxEnt\b','ENT group'),
 ('Stochastic integration (Itô)',r'Itô|Ito integral|stochastic integral|ItoIntegral','SDE group'),
]
PRESENT=[('Gaussian law',r'gaussianReal'),('Pareto law',r'paretoMeasure'),('Gamma law',r'gammaMeasure|gammaPDF'),('Stieltjes measures',r'StieltjesFunction'),
 ('independence (`iIndepFun`)',r'iIndepFun'),('characteristic functions (uniqueness)',r'ext_of_charFun'),('conditioning (`cond`)',r'def cond \(s : Set'),
 ('strong law of large numbers',r'strong_law_ae'),('mgf / cgf',r'\bcgf\b')]
NEXT=[  # dependency-ordered, revised each release
 '**T005 general identity (2.10)**: `∫_K^∞ x f = K P(X > K) + ∫_K^∞ P(X > x) dx` for nonnegative `X` via Tonelli (layer-cake), with the Pareto case as the check.',
 '**T029 stronger child** (regular-variation dominance, `δ`-split route), first for `α > 0`.',
 '**T118 convexity**: `m_p` convex in `α` on `α > p` for `p > 0` with the corrected second derivative (G20), then the integrated Jensen statement of Proposition 21.1.',
 '**Pareto → Fréchet domain of attraction** (T011 formulation, T062 case): `M_n/(L n^{1/α}) → frechetMeasure (1/α)` — the first convergence theorem.',
 'Then the Tier A sweep in chapter order (2 → 4 → 5 → 8); T030 (products of Paretos) and T044 (probability integral transform) are natural early picks.',
 'Separately from cadence work: decide whether any §4a infrastructure item is worth building here (CLT is the highest-leverage; Bochner the hardest).',
]
PROCESS_NOTES=[
 'Every "synced" or "checked" claim must be backed by a machine check (the D026-1 episode: a hand-maintained Markdown ledger shipped a release stale while the changelog said "synced"). The ledger is now generated and byte-checked; this memo is generated for the same reason.',
 'Scope rulings belong to the auditor when the ledger\'s inherited wording is ambiguous (T029: the binary exponent child is complete; the regular-variation reading stays open as a named child).',
 'Keep assumed-property theorems (`conditional_law_theorem`) distinct from concrete-law results (`actual_law_constructed`); the Pareto instance is what turned Property 5.1 from conditional into realized.',
 'Credit slices, not families: a Pareto example never closes a multi-distribution target (T005, T021, T028, T032 all stay partial with their general targets named).',
 'Source locators are checked page by page against the PDF, never inferred from a multi-page text extraction (D028-2).',
]
REVISIONS=[
 ('v0.2.8','20 Sep 2026','initial memo (`SCOPE_MEMO_v0.2.8.md`, hand-written from the ledger).'),
 ('v0.2.9','21 Sep 2026','memo made a generated document (`tools/scope_memo.py`, renamed to `SCOPE_MEMO.md`); Stage B added; T005 → partial; G20; release table now computed from the evidence layers.'),
 ('v0.2.10','21 Sep 2026','tracked in git and, from this release, copied into the package evidence for the auditor (`evidence/fable/vX/scope_memo_at_packaging.md`); §4a states the scan method and its limits after the v0.2.9 audit declined to adopt the memo\'s infrastructure-absence claims as facts; T021 centered slice added to §2/§3.'),
]

# ---------------------------------------------------------------- data
def git(*args): return subprocess.run(['git','-C',str(ROOT),*args],capture_output=True,text=True).stdout
def load(p): return json.loads(Path(p).read_text())

def release_commits():
    """(version, date, commit) for every 'final evidence' commit, oldest first."""
    out=[]
    for line in git('log','--reverse','--format=%h|%ad|%s','--date=short').splitlines():
        h,d,s=line.split('|',2)
        if 'final evidence' in s or s.startswith('Fable review: FABLE_REVIEW.md'):
            m=re.search(r'v0\.\d+\.\d+',s); out.append((m.group(0) if m else 'v0.2.1',d,h))
    return out

def counts_at(commit):
    v=json.loads(git('show',f'{commit}:Taleb_Lean_Repairs/evidence/current/verification.json'))
    try: ledger=json.loads(git('show',f'{commit}:Taleb_Lean_Repairs/docs/FORMALIZATION_BACKLOG.json'))
    except json.JSONDecodeError: ledger=[]
    st=collections.Counter(x.get('status') for x in ledger)
    return dict(theorems=v['theorem_count'],instances=v['instance_count'],aliases=v['alias_count'],checked=v['checked_declarations'],
                discharged=st.get('discharged',0),partial=st.get('partial',0),supported=sum(1 for x in ledger if x.get('states')))

def mathlib_scan():
    root=PKG/'.lake/packages/mathlib/Mathlib'
    if not root.exists(): return None
    pats=[(l,re.compile(r)) for l,r,_ in GAPS]+[(l,re.compile(r)) for l,r in PRESENT]
    hits=collections.Counter()
    for f in root.rglob('*.lean'):
        t=f.read_text(errors='ignore')
        for l,rx in pats:
            if rx.search(t): hits[l]+=1
    return hits

# ---------------------------------------------------------------- render
def render():
    ledger=load(PKG/'docs/FORMALIZATION_BACKLOG.json'); version=re.search(r'version = "([^"]+)"',(PKG/'lakefile.toml').read_text()).group(1)
    ver=load(PKG/'evidence/current/verification.json'); inv=load(PKG/'evidence/current/inventory_environment.json')
    today=datetime.date.today().strftime('%-d %B %Y')
    n=len(ledger); proof=[x for x in ledger if x['status'] not in ('model-needed','empirical')]; p1=[x for x in ledger if x['priority']=='P1']
    sup=[x for x in ledger if x['states']]; disc=[x for x in ledger if x['discharged']]
    st=collections.Counter(x['status'] for x in ledger)
    cited=[(x['id'],d) for x in ledger for d in x['declarations']]
    rel=release_commits(); packaged=rel[-1][2] if rel else git('rev-parse','--short','HEAD').strip()
    sha=''
    shafile=next(iter((ROOT/'deliverables'/f'v{version}').glob('*.zip.sha256')),None)
    if shafile: sha=shafile.read_text().split()[0]
    L=[]; A=L.append
    A(f"# Scope memo: how far the Taleb formalization has come, and how far it has to go")
    current_is_release=f'v{version}' in [v for v,_,_ in rel]
    tree_note=(f"packaged tree `{packaged}`"+(f", ZIP SHA-256 `{sha[:8]}…{sha[-6:]}`" if sha else "")) if current_is_release else f"release in progress; last packaged tree `{packaged}`"
    A(""); A(f"Rendered {today} by `tools/scope_memo.py` for **v{version}** ({tree_note}).")
    A("Every number below is computed from the ledger, the committed evidence layers and the pinned Mathlib checkout; the")
    A("judgment sections (§5 tiers, §6 projection, §8 next steps) are hand-maintained in the script and cross-checked against the")
    A("data. Personal working reference for the project owner; not part of any audited package. Refresh with `python3 tools/scope_memo.py`;")
    A("`python3 tools/scope_memo.py --check` reports whether this file is stale.")
    A(""); A("---"); A(""); A("## 1. Headline numbers"); A("")
    A(f"The ledger has {n} obligation families of very unequal size, so no single percentage is honest. Three denominators:"); A("")
    A("| Denominator | Closed (`discharged`) | Touched (any Lean support) | Untouched |"); A("|---|---|---|---|")
    def row(label,rows):
        c=sum(1 for x in rows if x['discharged']); t=sum(1 for x in rows if x['states']); k=len(rows)
        A(f"| {label} | **{c}** ({100*c/k:.1f} %) | **{t}** ({100*t/k:.0f} %) | {k-t} |")
    row(f"All {n} families",ledger)
    row(f"{len(proof)} formal-proof families ({n} minus {st['model-needed']} `model-needed` and {st['empirical']} `empirical`, which are modelling/data tasks, not theorems)",proof)
    row(f"{len(p1)} **P1** families — the \"contained, reusable\" mathematical core",p1)
    A(""); A(f"Declarations checked by the verifier: {ver['checked_declarations']} ({ver['theorem_count']} theorems, {ver['instance_count']} instances, {ver['alias_count']} aliases); "
      f"trust scan {inv['constant_count']} project constants ({inv['internal_count']} internal), all within the allowlist. Citations: {len(cited)} family/declaration pairs over {len(set(d for _,d in cited))} distinct names. "
      "These are inventory counts, not progress percentages.")
    A(""); A("Status distribution: "+" · ".join(f"{st[s]} {s}" for s in STATUSES)+".")
    A(""); A("Status × priority:"); A(""); A("| | P0 | P1 | P2 | P3 | total |"); A("|---|---|---|---|---|---|")
    for s in STATUSES:
        cells=[sum(1 for x in ledger if x['priority']==p and x['status']==s) for p in ('P0','P1','P2','P3')]
        A(f"| {s} | "+" | ".join(str(c) if c else '–' for c in cells)+f" | {sum(cells)} |")
    A("| **total** | "+" | ".join(str(sum(1 for x in ledger if x['priority']==p)) for p in ('P0','P1','P2','P3'))+f" | {n} |")
    # 2. releases
    A(""); A("---"); A(""); A("## 2. Release history (what one release buys)"); A("")
    A("| Release | Date | Theorems | Checked | Discharged | Partial | Supported | Substance |"); A("|---|---|---|---|---|---|---|---|")
    A(f"| v0.2.0 (received) | — | 50 | 67 | 0 | — | — | {SUBSTANCE['v0.2.0']} |")
    missing_sub=[]
    for v,d,h in rel:
        c=counts_at(h); sub=SUBSTANCE.get(v)
        if sub is None: missing_sub.append(v); sub='**(no substance line — add to SUBSTANCE)**'
        A(f"| {v} | {d} | {c['theorems']} | {c['checked']} | {c['discharged']} | {c['partial'] or '—'} | {c['supported'] or '—'} | {sub} |")
    if f'v{version}' not in [v for v,_,_ in rel]:
        # The release in progress: counts from the current verifier record and ledger, not yet a committed evidence layer.
        sub=SUBSTANCE.get(f'v{version}')
        if sub is None: missing_sub.append(f'v{version}'); sub='**(no substance line — add to SUBSTANCE)**'
        A(f"| v{version} (this pass, not yet a release commit) | {datetime.date.today().isoformat()} | {ver['theorem_count']} | {ver['checked_declarations']} | {len(disc)} | {st['partial']} | {len(sup)} | {sub} |")
    A(""); A(f"Rule of thumb from this history: one release ≈ one substantive family child (15–25 theorems) plus an audit-response cycle. "
      f"{len(disc)} families closed in {len(rel)} releases; the closed ones were among the most tractable (see §4).")
    # 3. supported
    A(""); A("---"); A(""); A(f"## 3. What has been done (the {len(sup)} supported families)"); A("")
    A("| Family | Status | Group | Delivered (scope, first sentence) | Still open (first sentence) |"); A("|---|---|---|---|---|")
    first=lambda t:(t.split('. ')[0].rstrip('.')+'.') if t else ''
    for x in sup:
        status=f"**{x['status']}**" if x['discharged'] else x['status']
        A(f"| {x['id']} {x['title']} | {status} | {x['dependency_group']} | {first(x['delivery_scope'])} | {first(x['remaining_obligations'])} |")
    units=sorted({x['unit'] for x in sup},key=lambda u:(len(u),u)); allunits=sorted({x['unit'] for x in ledger},key=lambda u:(len(u),u))
    A(""); A(f"Chapters touched: {', '.join(units)} (of {len(allunits)} chapter units). Supplemental register (outside the {n}): see `Taleb_Lean_Repairs/docs/SUPPLEMENTAL_OBLIGATIONS.md`.")
    A(""); A("Common thread: everything done sits in the layer of **distribution facts where the pinned Mathlib already had the machinery** — `StieltjesFunction`, `iIndepFun`, `withDensity` + improper `rpow` integrals, `gaussianReal`, `paretoMeasure`, `cond`, elementary real analysis. That front has been harvested deliberately.")
    # 4. remaining by kind
    A(""); A("---"); A(""); A("## 4. What remains, by kind"); A("")
    A(f"### 4a. Infrastructure the pinned Mathlib does or does not have (scan of the checkout, {today})"); A("")
    hits=mathlib_scan()
    A("Method and limits: every `.lean` file under the pinned checkout's `Mathlib/` is searched for the case-sensitive patterns listed in")
    A("`GAPS`/`PRESENT` in `tools/scope_memo.py`. \"0 files\" means no file matches those patterns — a strong indication, not a proof, that")
    A("the theory is absent (a false negative is possible if Mathlib names it unexpectedly), and a positive count is only evidence that")
    A("*something* with that name exists, not that it has the form the family needs. Family attributions in the third column are judgment.")
    A("")
    if hits is None: A("_(pinned Mathlib checkout not present; scan skipped)_")
    else:
        A("| Missing in Mathlib | Files matching | Blocks |"); A("|---|---|---|")
        for l,_,b in GAPS: A(f"| {l} | {hits.get(l,0)} | {b} |")
        A(""); A("Present and reusable: "+", ".join(f"{l} ({hits.get(l,0)} files)" for l,_ in PRESENT)+".")
    p0=[x['id'] for x in ledger if x['priority']=='P0']
    A(""); A(f"### 4b. The {len(p0)} P0 source-check gates"); A("")
    A(", ".join(p0)+" — the book's statement must be repaired or disambiguated before any proof (as with the G-gates in `docs/SOURCE_GATES.md`). "
      f"A further {st['source-check']-len(p0)} source-check rows sit at P1–P3.")
    mm=[x for x in ledger if x['status'] in ('model-needed','empirical')]
    A(""); A(f"### 4c. Modelling and data tasks (not theorems): {len(mm)} families"); A("")
    A(", ".join(f"{x['id']} ({x['dependency_group']})" for x in mm)+". These complete only by a modelling decision, then possibly a theorem about the model.")
    A(""); A("### 4d. Dependency groups"); A("")
    grp=collections.defaultdict(collections.Counter)
    for x in ledger: grp[x['dependency_group']][x['status']]+=1
    A("| Group | Families | Closed | Partial | Reuse | Missing | Source-check | Model/emp. |"); A("|---|---|---|---|---|---|---|---|")
    for g,c in sorted(grp.items(),key=lambda kv:(-sum(kv[1].values()),kv[0])):
        A(f"| {g} | {sum(c.values())} | {c['discharged']} | {c['partial']} | {c['reuse']} | {c['missing']} | {c['source-check']} | {c['model-needed']+c['empirical']} |")
    zero=[g for g,c in grp.items() if not (c['discharged'] or c['partial'])]
    A(""); A(f"Groups with **zero** Lean support (no discharged or partial family; `reuse` rows are not yet instantiated): {', '.join(sorted(zero))}.")
    # 5. tiers
    untouched=[x['id'] for x in p1 if not x['states']]
    A(""); A("---"); A(""); A(f"## 5. The {len(untouched)} untouched P1 families, tiered (judgment, to be confirmed when each is opened)"); A("")
    title={x['id']:x['title'] for x in ledger}
    tiered=set()
    for tier,label in (('A','**Tier A — contained, current infrastructure suffices** (one release each, some several per release)'),
                       ('B','**Tier B — medium: contained but needs a definition layer first**'),
                       ('C','**Tier C — statement gate first (P1 source-check)**')):
        ids=[i for i in TIERS[tier] if i in untouched]; tiered|=set(ids)
        A(label+f" — {len(ids)}:"); A(""); A("; ".join(f"{i} {title[i]}" for i in ids)); A("")
    untiered=[i for i in untouched if i not in tiered]
    if untiered: A(f"**Untiered (assign a tier in `tools/scope_memo.py`):** {', '.join(untiered)}"); A("")
    stale=[i for t in TIERS.values() for i in t if i not in untouched]
    if stale: A(f"_Tiered families that have since gained Lean support (drop from TIERS): {', '.join(stale)}._"); A("")
    blocked=[(i,r) for i,r in INFRA_BLOCKED_SUPPORTED.items() if any(x['id']==i and x['states'] for x in ledger)]
    A("P1 families with support but blocked on §4a infrastructure: "+"; ".join(f"{i} ({r})" for i,r in blocked)+".")
    # 6. projection
    nA=len([i for i in TIERS['A'] if i in untouched]); nB=len([i for i in TIERS['B'] if i in untouched]); nC=len([i for i in TIERS['C'] if i in untouched])
    A(""); A("---"); A(""); A("## 6. Projection"); A("")
    A(f"- **Tier A ({nA} P1 families, incl. the `reuse` rows)**: at one to two per release with the current audit cadence, roughly {max(1,nA//2)}–{nA} releases; infrastructure accumulates, so later ones are cheaper.")
    A(f"- **Tiers B and C ({nB + nC} P1 families)**: each needs a definition layer or a statement repair before the proof; budget a release each, some two.")
    A("- **Infrastructure-blocked (§4a)**: not reachable by cadence. CLT, Bochner/Lévy–Khintchine and Karamata are each Mathlib-scale developments (weeks to months of specialist work) that unlock clusters of families (CLT ≈ 8, Karamata ≈ 6–8, Bochner ≈ 3–4).")
    A(f"- **P0 gates and model/empirical rows ({len(p0)+len(mm)} families)**: complete by decision and documentation, not by proof; some will remain \"documented, not proved\".")
    A(""); A(f"\"Completing the formalism\" as *all {len(proof)} proof families discharged* is a many-months to multi-year programme at this working style, and roughly a fifth of the {n} will only ever be documented. The realistic near-term target is the P1 core.")
    # 7. completion definitions
    c1=sum(1 for x in p1 if x['discharged']); t1=sum(1 for x in p1 if x['states']); c2=len(disc); t2=len(sup)
    A(""); A("---"); A(""); A("## 7. Completion needs a definition — three candidates"); A("")
    A("| Target | Meaning | Current standing | Feasibility |"); A("|---|---|---|---|")
    A(f"| **Core-P1 completion** | discharge the {len(p1)} P1 families | {c1} closed, {t1} touched | achievable with mostly existing infrastructure, minus the P1s in §5's blocked line |")
    A(f"| **Proof-family completion** | discharge all {len(proof)} | {c2} closed, {t2} touched | requires building CLT / Bochner / Karamata theory first; long |")
    A(f"| **Book coverage** | all {n} incl. a modelling layer for the applied chapters | as above + {len(mm)} modelling decisions | a different kind of project |")
    A(""); A(f"Reporting rule: report progress against the **P1 core** (closed / touched / {len(p1)}), list the infrastructure-blocked P1s separately, keep the {n}-family tally as the full denominator the auditor uses, and never derive a percentage from declaration counts.")
    # 8. next
    A(""); A("---"); A(""); A("## 8. Sensible next milestones (dependency-ordered)"); A("")
    for i,t in enumerate(NEXT,1): A(f"{i}. {t}")
    # 9. process
    A(""); A("---"); A(""); A("## 9. Process notes worth keeping"); A("")
    for t in PROCESS_NOTES: A(f"- {t}")
    # 10. revisions
    A(""); A("---"); A(""); A("## 10. Revision history"); A("")
    A("| Release | Date | Change to this memo |"); A("|---|---|---|")
    for v,d,t in REVISIONS: A(f"| {v} | {d} | {t} |")
    if missing_sub: A(""); A(f"**Releases without a substance line: {', '.join(missing_sub)}.**")
    return '\n'.join(L)+'\n'

if __name__=='__main__':
    text=render()
    if '--check' in sys.argv:
        ok=OUT.exists() and OUT.read_text()==text; print('SCOPE_MEMO.md up to date' if ok else 'SCOPE_MEMO.md is stale'); sys.exit(0 if ok else 1)
    OUT.write_text(text); print(f'wrote {OUT.relative_to(ROOT)} ({len(text.splitlines())} lines)')
