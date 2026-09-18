#!/usr/bin/env python3
"""Build this project and check the printed axiom closure of every exported proof.
Run after `lake exe cache get`. Requires Python 3.9+, git, elan/Lean and Lake.
The axiom allowlist covers standard Lean/Mathlib foundations, not arbitrary axioms.
"""
import hashlib,json,re,subprocess,sys,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'evidence/current'; OUT.mkdir(parents=True,exist_ok=True)

def run(args,log=None):
    p=subprocess.run(args,cwd=ROOT,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    if log: (OUT/log).write_text(p.stdout)
    if p.returncode:
        print(p.stdout); raise RuntimeError('Command failed: '+' '.join(args))
    return p.stdout.strip()

def declarations():
    result=[]
    for path in sorted((ROOT/'AuditRepairs').glob('*.lean')):
        namespaces=[]
        for line in path.read_text().splitlines():
            if re.match(r'^namespace ',line): namespaces.append(line.split()[1])
            elif re.match(r'^end\b',line) and namespaces: namespaces.pop()
            m=re.match(r'^(theorem|lemma|instance)\s+(\S+)',line)
            if m: result.append(dict(name='.'.join(namespaces+[m[2]]),kind=m[1],file=str(path.relative_to(ROOT))))
    result += [dict(name=f'Taleb.Proof{i:02}.repaired',kind='alias',file=str(f.relative_to(ROOT)))
               for i,f in enumerate(sorted((ROOT/'Proofs').glob('Proof*.lean')),1)]
    return result

def main():
    start=time.monotonic()
    version=run(['lake','env','lean','--version'])
    assert 'version 4.24.0' in version, version
    deps=json.loads((ROOT/'lake-manifest.json').read_text())['packages']
    commits={}
    for d in deps:
        actual=run(['git','-C',str(ROOT/'.lake/packages'/d['name']),'rev-parse','HEAD'])
        assert actual==d['rev'], f"Dependency {d['name']}: {actual} != {d['rev']}"
        commits[d['name']]=actual
    ds=declarations()
    expected=['import AuditRepairs','']+['#print axioms '+d['name'] for d in ds]
    assert (ROOT/'AuditVerification.lean').read_text()=='\n'.join(expected)+'\n', 'Verification inventory is stale'
    build=run(['lake','build'],'build.log')
    output=run(['lake','env','lean','AuditVerification.lean'],'axioms.log')
    found={}
    for n, ax in re.findall(r"'([^']+)' depends on axioms: \[([^]]*)\]",output):
        found[n]=[a.strip() for a in ax.replace('\n',' ').split(',') if a.strip()]
    for n in re.findall(r"'([^']+)' does not depend on any axioms",output): found[n]=[]
    allow={'propext','Classical.choice','Quot.sound'}
    assert set(found)=={d['name'] for d in ds}, 'Missing or unexpected axiom output'
    assert all(set(ax)<=allow for ax in found.values()), 'Unexpected axioms: '+str(found)
    assert not re.search(r'\bsorryAx\b|(?:error|warning):',output), 'Compiler diagnostics in axiom run'
    source_hashes={str(f.relative_to(ROOT)):hashlib.sha256(f.read_bytes()).hexdigest()
                   for f in sorted(ROOT.rglob('*.lean')) if '.lake' not in f.parts}
    report=dict(status='PASS',lean=version,dependency_commits=commits,
        theorem_count=sum(d['kind'] in ('theorem','lemma') for d in ds),
        instance_count=sum(d['kind']=='instance' for d in ds),alias_count=sum(d['kind']=='alias' for d in ds),
        checked_declarations=len(ds),allowed_axioms=sorted(allow),axioms=found,
        source_sha256=source_hashes,elapsed_seconds=round(time.monotonic()-start,2),
        scope='Checks formal propositions and their axiom dependencies. Does not certify book coverage or numerical software.')
    (OUT/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
    (OUT/'declarations.json').write_text(json.dumps(ds,indent=2)+'\n')
    print(f"PASS: {report['theorem_count']} theorems, {report['instance_count']} instance, {report['alias_count']} aliases; no extra axioms")

if __name__=='__main__':
    try: main()
    except Exception as e:
        (OUT/'verification.json').write_text(json.dumps({'status':'FAIL','error':str(e)},indent=2)+'\n')
        print(e,file=sys.stderr);sys.exit(1)
