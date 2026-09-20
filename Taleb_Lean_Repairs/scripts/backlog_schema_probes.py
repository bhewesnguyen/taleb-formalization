#!/usr/bin/env python3
"""Probes for scripts/backlog_schema.py: deliberately malformed ledgers must be rejected.

    python3 scripts/backlog_schema_probes.py [--out DIR]

Runs in seconds, needs no Lean. Each probe mutates an in-memory copy of the shipped
docs/FORMALIZATION_BACKLOG.json and checks that `validate` reports a violation mentioning the
expected fragment; the unmodified ledger must validate cleanly. The first three probes are the
gaps reported by the independent audit of v0.2.5 (V025-L1). Four rendering probes (audit of
v0.2.6, D026-1) check that the shipped Markdown equals `render_markdown(JSON)` and that a stale
status, scope or declaration list in either rendering is detected. Results are written to
`<out>/backlog_schema_probes.json` (default `evidence/current/`). Exit 0 only if every probe
behaves as expected. `scripts/harness_regression.py` additionally exercises the verifier end
to end on the duplicate-ID case (fixture `backlog_duplicate_id`).
"""
import argparse,copy,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(Path(__file__).resolve().parent))
from backlog_schema import validate, render_markdown

def load(): return json.loads((ROOT/'docs/FORMALIZATION_BACKLOG.json').read_text())
def load_md(): return (ROOT/'docs/FORMALIZATION_BACKLOG.md').read_text()

# Rendering-consistency probes (audit of v0.2.6, D026-1): the shipped Markdown must be the rendering
# of the JSON, and a stale status, scope or declaration list in either rendering must be detected.
def r_md_stale_status(md,rows):   return md.replace('**P1 / discharged / EVT**','**P1 / partial / EVT**',1),rows
def r_md_stale_scope(md,rows):    return md.replace('Delivery scope: All three standardised EVT laws','Delivery scope: Gumbel and Frechet (xi > 0) probability measures',1),rows
def r_json_stale_scope(md,rows):  rows=copy.deepcopy(rows); rows[60]['delivery_scope']='Gumbel and Frechet only'; return md,rows
def r_json_dropped_decl(md,rows): rows=copy.deepcopy(rows); rows[60]['declarations']=rows[60]['declarations'][:-1]; return md,rows
RENDER_PROBES=[('markdown_stale_status',r_md_stale_status),('markdown_stale_scope',r_md_stale_scope),
               ('json_stale_scope',r_json_stale_scope),('json_dropped_declaration',r_json_dropped_decl)]

def p_dup_id(rows):        rows[2]['id']='T002'                       # T003 replaced by a second T002 (audit)
def p_flag(rows):          rows[59]['discharged']=False               # T060: Boolean contradicts status/state (audit)
def p_scope_type(rows):    rows[0]['delivery_scope']=123              # non-string scope (audit)
def p_missing_row(rows):   del rows[157]
def p_extra_field(rows):   rows[0]['note']='x'
def p_blank_title(rows):   rows[5]['title']='   '
def p_bad_state(rows):     rows[0]['states'].append('proved_everything')
def p_bad_status(rows):    rows[1]['status']='done'
def p_dup_decl(rows):      rows[0]['declarations'].append(rows[0]['declarations'][0])
def p_scope_without(rows): rows[1]['delivery_scope']='some scope'     # scope on a row without states
def p_anchor(rows):        rows[0]['pdf_anchor_page']=99
def p_bool_as_int(rows):   rows[59]['discharged']=1                   # int is not bool

PROBES=[('duplicate_id',p_dup_id,'ids must be exactly'),
        ('discharged_flag_false',p_flag,'disagree'),
        ('scope_not_string',p_scope_type,'expected str'),
        ('missing_row',p_missing_row,'ids must be exactly'),
        ('extra_field',p_extra_field,'unexpected field'),
        ('blank_title',p_blank_title,'is blank'),
        ('unknown_state',p_bad_state,'unknown states'),
        ('unknown_status',p_bad_status,'unknown status'),
        ('duplicate_declaration',p_dup_decl,'has duplicates'),
        ('scope_without_states',p_scope_without,'present together'),
        ('wrong_pdf_anchor',p_anchor,'pdf_anchor_page'),
        ('discharged_flag_int',p_bool_as_int,'expected bool')]

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--out',default=str(ROOT/'evidence/current')); a=ap.parse_args()
    out=Path(a.out).resolve(); out.mkdir(parents=True,exist_ok=True)
    results=[]; base=load(); clean=validate(base)
    results.append(dict(probe='unmodified_ledger',violations=clean,expected='none',behaved_as_expected=(clean==[])))
    for name,mut,frag in PROBES:
        rows=copy.deepcopy(base); mut(rows); v=validate(rows)
        ok=any(frag in x for x in v)
        results.append(dict(probe=name,violations=v,expected_fragment=frag,behaved_as_expected=ok))
        print(f"{name:<24} {'rejected' if v else 'ACCEPTED'} -> {'ok' if ok else 'UNEXPECTED'}")
    md=load_md(); consistent=(md==render_markdown(base))
    results.append(dict(probe='markdown_is_rendering_of_json',expected='equal',behaved_as_expected=consistent))
    print(f"{'markdown_is_rendering_of_json':<28} {'equal' if consistent else 'DIFFERENT'} -> {'ok' if consistent else 'UNEXPECTED'}")
    for name,mut in RENDER_PROBES:
        m2,r2=mut(md,base); changed=(m2!=md) or (r2 is not base)
        detected=(m2!=render_markdown(r2)); ok=changed and detected
        results.append(dict(probe=name,expected='rendering mismatch detected',behaved_as_expected=ok))
        print(f"{name:<28} {'detected' if detected else 'MISSED'} -> {'ok' if ok else 'UNEXPECTED'}")
    all_ok=all(r['behaved_as_expected'] for r in results)
    (out/'backlog_schema_probes.json').write_text(json.dumps(dict(all_probes_behaved_as_expected=all_ok,results=results),indent=2)+'\n')
    print('unmodified ledger valid:',clean==[]); print('ALL PROBES BEHAVED AS EXPECTED' if all_ok else 'SOME PROBE MISBEHAVED')
    sys.exit(0 if all_ok else 1)

if __name__=='__main__': main()
