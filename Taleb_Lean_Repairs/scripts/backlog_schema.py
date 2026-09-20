"""Single source of truth for the shape of docs/FORMALIZATION_BACKLOG.json.

Used by scripts/rebuild_curated_inventory.py when the ledger is generated and by
scripts/verify.py on every verification run, so the two cannot drift (audit of v0.2.5,
finding V025-L1: the previous verifier-side checks accepted duplicate family IDs, a
`discharged` Boolean contradicting the status, and non-string scope text).

`validate(rows)` returns a list of human-readable violations; an empty list means the ledger
is well-formed. It checks form only. Whether a credited declaration actually meets a family's
target is a review judgment recorded in FABLE_REVIEW.md, not something this module decides.
"""
STATES={'formula_proved','conditional_law_theorem','law_theorem','actual_law_constructed','source_reviewed','discharged'}
STATUSES={'partial','reuse','missing','source-check','model-needed','empirical','discharged'}
PRIORITIES={'P0','P1','P2','P3'}
UNITS={str(i) for i in range(1,31)}|set('ABCDEFGHI')
FAMILY_COUNT=158
EXPECTED_IDS=[f'T{i:03}' for i in range(1,FAMILY_COUNT+1)]
FIELDS={'id':str,'unit':str,'printed_pages':str,'pdf_anchor_page':int,'source_anchor':str,'title':str,
        'target':str,'hypotheses_and_gaps':str,'dependency_group':str,'priority':str,'status':str,
        'states':list,'declarations':list,'delivery_scope':str,'remaining_obligations':str,
        'discharged':bool,'completion':str}
NONBLANK={'unit','printed_pages','source_anchor','title','target','hypotheses_and_gaps','dependency_group','completion'}

def _typed(v,t):
    # bool is a subclass of int; keep the two apart.
    return isinstance(v,t) and not (t is int and isinstance(v,bool))

def validate(rows):
    out=[]
    if not isinstance(rows,list):
        return ['ledger is not a list']
    ids=[r.get('id') if isinstance(r,dict) else None for r in rows]
    if ids!=EXPECTED_IDS:
        dup=sorted({i for i in ids if ids.count(i)>1}); missing=sorted(set(EXPECTED_IDS)-set(ids)); extra=sorted(set(ids)-set(EXPECTED_IDS),key=str)
        out.append(f'ids must be exactly {EXPECTED_IDS[0]}..{EXPECTED_IDS[-1]} in order (got {len(ids)} rows; duplicates {dup}; missing {missing}; unexpected {extra})')
    for r in rows:
        if not isinstance(r,dict): out.append(f'row {r!r}: not an object'); continue
        rid=r.get('id','<no id>')
        for k,t in FIELDS.items():
            if k not in r: out.append(f'{rid}: missing field {k}')
            elif not _typed(r[k],t): out.append(f'{rid}: field {k} has type {type(r[k]).__name__}, expected {t.__name__}')
        for k in set(r)-set(FIELDS): out.append(f'{rid}: unexpected field {k}')
        if any(k not in r or not _typed(r[k],FIELDS[k]) for k in FIELDS): continue  # type errors already reported
        for k in NONBLANK:
            if not r[k].strip(): out.append(f'{rid}: field {k} is blank')
        if r['unit'] not in UNITS: out.append(f'{rid}: unknown unit {r["unit"]!r}')
        if r['priority'] not in PRIORITIES: out.append(f'{rid}: unknown priority {r["priority"]!r}')
        if r['status'] not in STATUSES: out.append(f'{rid}: unknown status {r["status"]!r}')
        for k in ('states','declarations'):
            if not all(isinstance(x,str) and x.strip() for x in r[k]): out.append(f'{rid}: {k} must be nonblank strings')
            if len(set(r[k]))!=len(r[k]): out.append(f'{rid}: {k} has duplicates')
        st=set(r['states'])
        if not st<=STATES: out.append(f'{rid}: unknown states {sorted(st-STATES)}')
        if not ((r['status']=='discharged')==('discharged' in st)==r['discharged']):
            out.append(f'{rid}: status, states and the discharged flag disagree')
        present=[bool(r['states']),bool(r['declarations']),bool(r['delivery_scope'].strip()),bool(r['remaining_obligations'].strip())]
        if len(set(present))!=1: out.append(f'{rid}: states, declarations, delivery_scope and remaining_obligations must be present together')
        try:
            first=int(r['printed_pages'].split(';')[0].split('-')[0])
            if r['pdf_anchor_page']!=first+14: out.append(f'{rid}: pdf_anchor_page {r["pdf_anchor_page"]} != first printed page {first} + 14')
        except ValueError:
            out.append(f'{rid}: printed_pages does not start with a page number: {r["printed_pages"]!r}')
    return out
