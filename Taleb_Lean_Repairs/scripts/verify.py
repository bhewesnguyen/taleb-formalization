#!/usr/bin/env python3
"""Build this project and check the axiom closure of every project constant.
Run after `lake exe cache get`. Requires Python 3.9+, git, elan/Lean and Lake.
The axiom allowlist covers standard Lean/Mathlib foundations, not arbitrary axioms.

Two layers of checking:

1. Public API (the "checked declarations" count reported for the current tree): declarations
   are discovered by a line regex, recursively under `AuditRepairs/`, plus one alias per
   `Proofs/Proof*.lean`; `AuditVerification.lean` must be exactly the generated
   `#print axioms` list for them, and the printed closures must stay within the
   allowlist. This layer is what the README counts refer to.
2. Trust scan (independent of the regex): `scripts/FableInventory.lean` asks the Lean
   environment for every constant defined in the project modules, including private
   and otherwise internally named ones, and collects each closure before any
   filtering. The script fails unless every constant is within the allowlist, no
   project constant is an `axiom`, every project module on disk (walking
   subdirectories) is imported into the environment, the user-written public
   theorem/instance constants (provenance decided by Lean's own bookkeeping, not by
   namespace) equal the regex set, each `Taleb.ProofNN.repaired` alias targets the
   declaration named in `docs/replacement_map.json`, the ledger `docs/FORMALIZATION_BACKLOG.json`
   is well-formed (`scripts/backlog_schema.py`, shared with its generator), the Markdown ledger is
   its rendering byte for byte, and every Lean declaration it credits to a family exists in the
   environment.

Additional gates: the Lake build log must contain no `warning:`/`error:` line and no
`sorry`; dependency checkouts must be at the manifest revisions with clean working
trees. All acceptance conditions are explicit checks that raise `VerificationError`;
none is a Python `assert`, so `python3 -O` / `PYTHONOPTIMIZE` cannot disable them.
"""
import hashlib,json,re,subprocess,sys,time
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
from backlog_schema import validate as validate_backlog, render_markdown   # shared with scripts/rebuild_curated_inventory.py
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'evidence/current'; OUT.mkdir(parents=True,exist_ok=True)
ALLOW={'propext','Classical.choice','Quot.sound'}
DIAG=re.compile(r"(^|\s)(warning|error):|\bsorryAx\b|declaration uses 'sorry'")

class VerificationError(Exception): pass

def check(cond,message):
    if not cond: raise VerificationError(message)

def run(args,log=None):
    p=subprocess.run(args,cwd=ROOT,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    if log: (OUT/log).write_text(p.stdout)
    if p.returncode:
        print(p.stdout); raise VerificationError('Command failed: '+' '.join(args))
    return p.stdout.strip()

def module_name(path):
    """Lean module name of a source file from its path relative to the project root
    (`AuditRepairs/Nested/Orphan.lean` -> `AuditRepairs.Nested.Orphan`)."""
    return '.'.join(path.relative_to(ROOT).with_suffix('').parts)

def declarations():
    """Public-API discovery (regex), recursive over `AuditRepairs/`. Deliberately narrow in the
    syntax it recognises (column-0 `theorem`/`lemma`/`instance`); the trust scan fails closed on
    anything it misses."""
    result=[]
    for path in sorted((ROOT/'AuditRepairs').rglob('*.lean')):
        # One stack for namespaces and sections: `end` closes whichever is innermost. Sections
        # contribute no name component. (v0.2.6: a namespace-only stack popped the namespace at
        # `end <Section>`, misnaming every declaration after a section end; masked in v0.2.5
        # because none followed, caught by the failed AuditVerification build in v0.2.6.)
        scopes=[]
        for line in path.read_text().splitlines():
            if re.match(r'^namespace ',line): scopes.append(line.split()[1])
            elif re.match(r'^(noncomputable )?section\b',line): scopes.append(None)
            elif re.match(r'^end\b',line) and scopes: scopes.pop()
            m=re.match(r'^(theorem|lemma|instance)\s+(\S+)',line)
            if m: result.append(dict(name='.'.join([n for n in scopes if n]+[m[2]]),kind=m[1],file=str(path.relative_to(ROOT))))
    result += [dict(name=f'Taleb.Proof{i:02}.repaired',kind='alias',file=str(f.relative_to(ROOT)))
               for i,f in enumerate(sorted((ROOT/'Proofs').glob('Proof*.lean')),1)]
    return result

def modules_on_disk():
    """Every Lean module of the project, walking subdirectories (audit finding V1: a shallow
    glob let an unimported nested module escape the coverage check)."""
    mods={'AuditRepairs'}
    for root in ('AuditRepairs','Proofs'):
        mods|={module_name(f) for f in (ROOT/root).rglob('*.lean')}
    return mods

def main():
    start=time.monotonic()
    version=run(['lake','env','lean','--version'])
    check('version 4.24.0' in version, 'Unexpected Lean version: '+version)
    deps=json.loads((ROOT/'lake-manifest.json').read_text())['packages']
    commits={}
    for d in deps:
        pkg=str(ROOT/'.lake/packages'/d['name'])
        actual=run(['git','-C',pkg,'rev-parse','HEAD'])
        check(actual==d['rev'], f"Dependency {d['name']}: {actual} != {d['rev']}")
        dirty=run(['git','-C',pkg,'status','--porcelain'])
        check(dirty=='', f"Dependency {d['name']} has working-tree modifications:\n{dirty}")
        commits[d['name']]=actual
    ds=declarations()
    regex_checked={d['name'] for d in ds}
    expected=['import AuditRepairs','']+['#print axioms '+d['name'] for d in ds]
    check((ROOT/'AuditVerification.lean').read_text()=='\n'.join(expected)+'\n', 'Verification inventory is stale')
    build=run(['lake','build'],'build.log')
    build_diag=[l for l in build.splitlines() if DIAG.search(l)]
    check(not build_diag, 'Compiler diagnostics in lake build:\n'+'\n'.join(build_diag))
    output=run(['lake','env','lean','AuditVerification.lean'],'axioms.log')
    found={}
    for n, ax in re.findall(r"'([^']+)' depends on axioms: \[([^]]*)\]",output):
        found[n]=[a.strip() for a in ax.replace('\n',' ').split(',') if a.strip()]
    for n in re.findall(r"'([^']+)' does not depend on any axioms",output): found[n]=[]
    check(set(found)==regex_checked, 'Missing or unexpected axiom output: '+str(sorted(set(found)^regex_checked)))
    check(all(set(ax)<=ALLOW for ax in found.values()), 'Unexpected axioms: '+str({n:a for n,a in found.items() if not set(a)<=ALLOW}))
    check(not DIAG.search(output), 'Compiler diagnostics in axiom run')
    # Trust scan from the Lean environment (see module docstring).
    inv_out=run(['lake','env','lean','scripts/FableInventory.lean'],'inventory_environment.log')
    inv=json.loads(inv_out[inv_out.index('{'):])
    (OUT/'inventory_environment.json').write_text(json.dumps(inv,indent=2,ensure_ascii=False)+'\n')
    rows=inv['constants']
    bad={r['name']:r['axioms'] for r in rows if not set(r['axioms'])<=ALLOW}
    check(not bad, 'Constants outside the axiom allowlist (all project constants, including private/internal ones, are scanned): '+str(bad))
    check(not inv['axiom_kind_constants'], 'Project declares axioms: '+str(inv['axiom_kind_constants']))
    missing_modules=sorted(modules_on_disk()-set(inv['imported_project_modules']))
    check(not missing_modules, 'Project modules on disk that are not imported into the environment (unscanned): '+str(missing_modules))
    env_public={r['name'] for r in rows if not r['isInternal'] and not r['generated'] and (r['kind']=='theorem' or r['isInstance'])}
    check(env_public==regex_checked, 'Environment/regex inventory mismatch: '+str(sorted(env_public^regex_checked)))
    rmap={f"Taleb.Proof{m['proof']:02}.repaired":m['declaration'] for m in json.loads((ROOT/'docs/replacement_map.json').read_text())}
    aliases={r['name']:r['aliasOf'] for r in rows if r['aliasOf']}
    check(aliases==rmap, 'Alias targets differ from docs/replacement_map.json: '+str({k:(aliases.get(k),rmap.get(k)) for k in set(aliases)|set(rmap) if aliases.get(k)!=rmap.get(k)}))
    # Backlog ledger: shape validated by the validator shared with the generator (audit V025-L1),
    # then existence in the scanned environment of every credited Lean declaration.
    env_names={r['name'] for r in rows}
    backlog=json.loads((ROOT/'docs/FORMALIZATION_BACKLOG.json').read_text())
    schema=validate_backlog(backlog)
    check(not schema, 'docs/FORMALIZATION_BACKLOG.json schema violations: '+str(schema))
    # The human-readable ledger is derived, not maintained by hand (audit D026-1: it shipped a release stale).
    check((ROOT/'docs/FORMALIZATION_BACKLOG.md').read_bytes()==render_markdown(backlog).encode('utf-8'), 'docs/FORMALIZATION_BACKLOG.md is not the rendering of docs/FORMALIZATION_BACKLOG.json (run scripts/rebuild_curated_inventory.py)')
    cited={(b['id'],d) for b in backlog for d in b.get('declarations',[])}
    dangling=sorted(f"{i}:{d}" for i,d in cited if d not in env_names)
    check(not dangling, 'docs/FORMALIZATION_BACKLOG.json cites declarations that do not exist in the environment: '+str(dangling))
    source_hashes={str(f.relative_to(ROOT)):hashlib.sha256(f.read_bytes()).hexdigest()
                   for f in sorted(ROOT.rglob('*.lean')) if '.lake' not in f.parts}
    # Report values are the actual validated conditions, not constants.
    report=dict(status='PASS',lean=version,dependency_commits=commits,
        theorem_count=sum(d['kind'] in ('theorem','lemma') for d in ds),
        instance_count=sum(d['kind']=='instance' for d in ds),alias_count=sum(d['kind']=='alias' for d in ds),
        checked_declarations=len(ds),allowed_axioms=sorted(ALLOW),axioms=found,
        environment_inventory=dict(
            constants_scanned=len(rows),internal=inv['internal_count'],generated=inv['generated_count'],
            user_theorem_or_instance=len(env_public),
            defs=sum(r['kind']=='def' and not r['generated'] and not r['isInternal'] for r in rows),
            imported_project_modules=len(inv['imported_project_modules']),
            all_within_allowlist=(not bad),no_project_axioms=(not inv['axiom_kind_constants']),
            all_disk_modules_imported=(not missing_modules),
            public_inventory_matches_regex=(env_public==regex_checked),
            alias_targets_match_replacement_map=(aliases==rmap),
            backlog_schema_valid=(not schema),backlog_families=len(backlog),
            backlog_discharged=sum(b['status']=='discharged' for b in backlog),
            backlog_cited_declarations_exist=(not dangling),backlog_cited_declaration_count=len(cited),
            backlog_cited_distinct_declarations=len({d for _,d in cited})),
        build_diagnostics_clean=(not build_diag),dependency_worktrees_clean=True,
        python_optimize=(not __debug__),
        source_sha256=source_hashes,elapsed_seconds=round(time.monotonic()-start,2),
        scope='Checks formal propositions and their axiom dependencies. Does not certify book coverage or numerical software.')
    (OUT/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
    (OUT/'declarations.json').write_text(json.dumps(ds,indent=2)+'\n')
    print(f"PASS: {report['theorem_count']} theorems, {report['instance_count']} instance, {report['alias_count']} aliases; no extra axioms; "
          f"trust scan: {len(rows)} project constants (incl. {inv['internal_count']} internal) all within allowlist; "
          f"{len(env_public)} public theorem/instance constants match the regex inventory")

if __name__=='__main__':
    try: main()
    except Exception as e:
        (OUT/'verification.json').write_text(json.dumps({'status':'FAIL','error':str(e)},indent=2)+'\n')
        print(e,file=sys.stderr);sys.exit(1)
