#!/usr/bin/env python3
"""Regression suite for scripts/verify.py: deliberately defective fixtures must be REJECTED.

Usage (from the project root, after `lake exe cache get` and `lake build`):

    python3 scripts/harness_regression.py [--scratch DIR] [--out DIR] [--only ID,ID]

The suite copies this project (sources plus `.lake/packages` and `.lake/build`) into a
scratch directory, and for each fixture: restores the pristine sources, applies one
mutation, runs `python3 scripts/verify.py` as a subprocess (optionally with
`PYTHONOPTIMIZE=1`), and records the exact command, the verifier's own process exit
code, its output, and the resulting `evidence/current/verification.json` of the copy.
The real project is never mutated; only the record is written, by default to
`evidence/current/harness_regression.json` and `.log`.

Every fixture except `valid` must produce exit code 1 and a FAIL record whose error
message contains the expected phrase. The suite's own exit code is 0 only if every
fixture behaved as expected. For the two `sorry` fixtures the suite additionally runs
`scripts/FableInventory.lean` alone on the mutated copy and checks that the private
constant is listed with `sorryAx`, showing that the trust scan would report it even if
the build-diagnostic gate were absent.
"""
import argparse,json,os,shutil,subprocess,sys,tarfile,tempfile,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

def sh(args,cwd,env=None):
    e=dict(os.environ); e.update(env or {})
    p=subprocess.run(args,cwd=cwd,text=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,env=e)
    return p.returncode,p.stdout,p.stderr

def append(path,text):
    with open(path,'a') as f: f.write(text)

# ---- fixtures: (id, description, mutation(copy_root), expected_status, expected_error_substring, env, check_inventory_sorry_name)
def fx_valid(c): pass
def fx_private_sorry_theorem(c):
    append(c/'AuditRepairs/RegularVariation.lean',"\nprivate theorem audit_private_gap : False := by sorry\n")
def fx_private_sorry_def(c):
    append(c/'AuditRepairs/Tails.lean',"\nprivate noncomputable def audit_gap_def : ℝ := sorry\n")
def fx_private_axiom(c):
    append(c/'AuditRepairs/Foundations.lean',
        "\nprivate axiom audit_private_axiom : (1 : ℝ) = 2\nprivate theorem audit_uses_private_axiom : (1 : ℝ) = 2 := audit_private_axiom\n")
def fx_structure_namespace_theorem(c):
    append(c/'AuditRepairs/Stable.lean',"\nprotected theorem StableAudit.StableParameters.audit_user_theorem : True := True.intro\n")
def fx_protected_theorem(c):
    append(c/'AuditRepairs/RegularVariation.lean',"\nnamespace AuditRV\nprotected theorem regex_blind_spot : (1 : ℝ) = 1 := rfl\nend AuditRV\n")
def fx_alias_map_mismatch(c):
    p=c/'docs/replacement_map.json'; m=json.loads(p.read_text())
    m[15]['declaration']='AuditProbability.charFun_convolutionPower'
    p.write_text(json.dumps(m,indent=2)+'\n')
def fx_orphan_module(c):
    (c/'AuditRepairs/Orphan.lean').write_text("import Mathlib.Data.Real.Basic\n\nnoncomputable def orphan : ℝ := 0\n")
def fx_dirty_dependency(c):
    append(c/'.lake/packages/Cli/README.md',"\n<!-- regression fixture: tracked dependency file modified -->\n")

FIXTURES=[
 ('valid','Unmodified copy of the project.',fx_valid,'PASS','',{},None),
 ('private_sorry_theorem',"private theorem ... : False := by sorry appended to RegularVariation.lean (audit finding A1).",
  fx_private_sorry_theorem,'FAIL','Compiler diagnostics in lake build',{},'_private.AuditRepairs.RegularVariation.0.audit_private_gap'),
 ('private_sorry_def',"private noncomputable def ... : ℝ := sorry appended to Tails.lean (audit finding A1).",
  fx_private_sorry_def,'FAIL','Compiler diagnostics in lake build',{},'_private.AuditRepairs.Tails.0.audit_gap_def'),
 ('private_axiom',"private axiom (no sorry, no compiler warning) plus a private theorem using it, appended to Foundations.lean (audit finding A1).",
  fx_private_axiom,'FAIL','outside the axiom allowlist',{},None),
 ('structure_namespace_theorem',"User-written protected theorem inside the StableParameters namespace, appended to Stable.lean (audit finding A2).",
  fx_structure_namespace_theorem,'FAIL','Environment/regex inventory mismatch',{},None),
 ('protected_theorem',"protected theorem AuditRV.regex_blind_spot appended to RegularVariation.lean (regex-invisible declaration; audit finding A4 record).",
  fx_protected_theorem,'FAIL','Environment/regex inventory mismatch',{},None),
 ('alias_map_mismatch',"docs/replacement_map.json entry for Proof16 points at a wrong declaration (audit finding A3, ordinary mode).",
  fx_alias_map_mismatch,'FAIL','Alias targets differ',{},None),
 ('alias_map_mismatch_optimized',"Same mutation as alias_map_mismatch, verifier run with PYTHONOPTIMIZE=1 (audit finding A3, optimized mode).",
  fx_alias_map_mismatch,'FAIL','Alias targets differ',{'PYTHONOPTIMIZE':'1'},None),
 ('orphan_module',"New module AuditRepairs/Orphan.lean (a def, no theorem) that no project file imports; it is neither built nor scanned unless the import-coverage check fires.",
  fx_orphan_module,'FAIL','not imported into the environment',{},None),
 ('dirty_dependency',"Tracked file modified inside .lake/packages/Cli (dependency working tree not clean).",
  fx_dirty_dependency,'FAIL','working-tree modifications',{},None),
]

def snapshot_sources(dest_tar):
    with tarfile.open(dest_tar,'w') as t:
        for p in sorted(ROOT.iterdir()):
            if p.name=='.lake': continue
            t.add(p,arcname=p.name)

def restore_sources(copy,src_tar):
    for p in list(copy.iterdir()):
        if p.name=='.lake': continue
        shutil.rmtree(p) if p.is_dir() else p.unlink()
    with tarfile.open(src_tar) as t: t.extractall(copy)
    sh(['git','checkout','--','.'],cwd=copy/'.lake/packages/Cli')   # undo dirty_dependency if it ran
    shutil.rmtree(copy/'evidence/current',ignore_errors=True)

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--scratch',default='',help='scratch directory (default: a fresh unique directory under $TMPDIR, so concurrent runs cannot collide)')
    ap.add_argument('--out',default=str(ROOT/'evidence/current'))
    ap.add_argument('--only',default='')
    a=ap.parse_args()
    out=Path(a.out); out.mkdir(parents=True,exist_ok=True)
    if a.scratch:
        scratch=Path(a.scratch)
        if scratch.exists(): raise SystemExit(f'scratch directory {scratch} already exists; refusing to reuse it')
        scratch.mkdir(parents=True)
    else:
        scratch=Path(tempfile.mkdtemp(prefix='taleb_harness_regression_'))
    copy=scratch/'Taleb_Lean_Repairs'
    only=set(a.only.split(',')) if a.only else None
    src_tar=scratch/'sources.tar'; snapshot_sources(src_tar)
    copy.mkdir(); (copy/'.lake').mkdir()
    # `cp -a` is much faster than shutil for the multi-GB dependency tree (reflinks where available).
    for sub in ('packages','build'):
        if (ROOT/'.lake'/sub).exists():
            rc,_,se=sh(['cp','-a',str(ROOT/'.lake'/sub),str(copy/'.lake'/sub)],cwd=ROOT)
            if rc: raise SystemExit('could not copy .lake/'+sub+': '+se)
    results=[]; log=[]
    log.append(f"# verify.py regression suite; started {time.strftime('%Y-%m-%dT%H:%M:%SZ',time.gmtime())}; scratch copy {copy}")
    for fid,desc,mut,exp_status,exp_sub,env,sorry_name in FIXTURES:
        if only and fid not in only: continue
        restore_sources(copy,src_tar); mut(copy)
        cmd=['python3','scripts/verify.py']; t0=time.monotonic()
        rc,so,se=sh(cmd,cwd=copy,env=env); dt=round(time.monotonic()-t0,1)
        vj=copy/'evidence/current/verification.json'
        rec=json.loads(vj.read_text()) if vj.exists() else {}
        status=rec.get('status'); err=rec.get('error','')
        ok=(status==exp_status) and ((rc==0) if exp_status=='PASS' else (rc!=0 and exp_sub in err))
        inv_note=''
        if sorry_name:
            irc,iso,ise=sh(['lake','env','lean','scripts/FableInventory.lean'],cwd=copy)
            try:
                inv=json.loads(iso[iso.index('{'):]); row=next((r for r in inv['constants'] if r['name']==sorry_name),None)
                inv_ok=row is not None and 'sorryAx' in row['axioms']
                inv_note=f"trust scan alone lists {sorry_name} with axioms {row['axioms'] if row else None} -> {'reported' if inv_ok else 'NOT reported'}"
            except Exception as e:
                inv_ok=False; inv_note=f"trust scan alone could not be evaluated: {e}"
            ok=ok and inv_ok
        results.append(dict(id=fid,description=desc,command=cmd,env_overrides=env,cwd=str(copy),
            verifier_exit_code=rc,seconds=dt,verification_status=status,verification_error=err,
            expected_status=exp_status,expected_error_contains=exp_sub,trust_scan_note=inv_note,
            stdout_tail=so.strip().splitlines()[-3:],stderr_tail=se.strip().splitlines()[-3:],behaved_as_expected=ok))
        log+= [f"\n## fixture {fid}: {desc}",
               f"command: {' '.join(cmd)}  (cwd={copy}; env overrides={env or 'none'})",
               f"verifier subprocess exit code: {rc}  (expected: {'0' if exp_status=='PASS' else 'nonzero'}); wall time {dt}s",
               f"verification.json: status={status} error={err!r}  (expected status {exp_status}{', error containing '+repr(exp_sub) if exp_sub else ''})"]
        if inv_note: log.append(inv_note)
        log.append(f"regression verdict: {'OK, behaved as expected' if ok else 'UNEXPECTED BEHAVIOUR'}")
        print(f"{fid:<32} exit={rc} status={status} -> {'ok' if ok else 'UNEXPECTED'}",flush=True)
    restore_sources(copy,src_tar)
    all_ok=all(r['behaved_as_expected'] for r in results)
    summary=dict(all_fixtures_behaved_as_expected=all_ok,fixture_count=len(results),
        real_project_mutated=False,scratch_copy=str(copy),results=results)
    (out/'harness_regression.json').write_text(json.dumps(summary,indent=2,ensure_ascii=False)+'\n')
    log.append(f"\n# summary: {len(results)} fixtures; all behaved as expected: {all_ok}. The real project was not mutated.")
    (out/'harness_regression.log').write_text('\n'.join(log)+'\n')
    shutil.rmtree(scratch,ignore_errors=True)
    print('ALL FIXTURES BEHAVED AS EXPECTED' if all_ok else 'SOME FIXTURE MISBEHAVED',flush=True)
    sys.exit(0 if all_ok else 1)

if __name__=='__main__': main()
