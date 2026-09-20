"""Single source of truth for the shape of docs/FORMALIZATION_BACKLOG.json.

Used by scripts/rebuild_curated_inventory.py when the ledger is generated and by
scripts/verify.py on every verification run, so the two cannot drift (audit of v0.2.5,
finding V025-L1: the previous verifier-side checks accepted duplicate family IDs, a
`discharged` Boolean contradicting the status, and non-string scope text).

`validate(rows)` returns a list of human-readable violations; an empty list means the ledger
is well-formed. It checks form only. Whether a credited declaration actually meets a family's
target is a review judgment recorded in FABLE_REVIEW.md, not something this module decides.

`render_markdown(rows)` is the single rendering of the human-readable ledger
docs/FORMALIZATION_BACKLOG.md from the same rows (audit of v0.2.6, finding D026-1: the Markdown
had been synchronised by hand and was shipped a release stale). The generator writes it and
scripts/verify.py requires the shipped file to equal it byte for byte.
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

MARKDOWN_PREAMBLE='# Book-wide formalization backlog\n\nSource: arXiv:2001.10488v4, third edition, 17 September 2025. 523 PDF pages. Original proof pack covers elementary pieces of a small subset; it does not cover half the book.\n\nThis inventory contains 158 obligation families. A family can require many Lean declarations. Only rows marked discharged claim completion of their stated, reviewed scope; every other row is open, whatever partial support it records. All 30 numbered chapters and nine lettered chapters have a coverage entry; Chapter 1 is introductory exposition. The section and equation indexes are locator catalogs, not independent theorem counts.\n\nStatuses: partial = some supplied lemmas exist but the family is incomplete; reuse = an existing Mathlib result should be instantiated; missing = implement after prerequisites; source-check = resolve mathematical statement first; empirical/model-needed = specify a model or reproduce data.; discharged = every stated target of the family is met by checked Lean declarations, with source correspondence reviewed and differences documented (reopened if a child obligation is discovered).\n\nDelivery states (since v0.2.4, per family, listed with the credited Lean declarations) are nonexclusive facets describing scoped components, not rungs of a completion ladder: formula_proved = an analytic/formula-level statement is checked; conditional_law_theorem = a probability-level theorem is checked whose hypotheses include an unresolved realization or property premise (existence of a law with a given characteristic/distribution function, or an assumed property such as subexponentiality or a finite exponent); law_theorem = a probability-law theorem under ordinary hypotheses only (independence, measurability, a common law), with no such premise; actual_law_constructed = a concrete probability measure realizes the object (reuse of a Mathlib law counts as realization, not novelty); source_reviewed = the source correspondence has been reviewed at page level; discharged = the whole-family judgment above. Since v0.2.5 each supported family also carries a delivery scope (what the credited work covers) and its remaining obligations. Families without delivery states have no Lean support yet. State counts overlap across families and must not be added as completed work; one declaration may support several families.\n\nPriority: P0 statement repair; P1 contained reusable family; P2 substantial dependency; P3 advanced application/model/data. Every source-check row has a statement-review gate regardless of priority.\n\n'

def render_markdown(rows):
    """The human-readable ledger, derived from the validated rows. Chapter headings follow the
    row order (the book's chapter sequence with the lettered appendices interleaved)."""
    out=[MARKDOWN_PREAMBLE.rstrip('\n'),'']
    unit=None
    for r in rows:
        if r['unit']!=unit:
            unit=r['unit']; out+= [f"## Chapter {unit}",'']
        out+=[f"### {r['id']} - {r['title']}",'',
              f"**{r['priority']} / {r['status']} / {r['dependency_group']}**. Printed pp. {r['printed_pages']}; PDF anchor p. {r['pdf_anchor_page']}; source: {r['source_anchor']}.",'',
              r['target'],'',f"Hypotheses and gaps: {r['hypotheses_and_gaps']}",'']
        if r['states']:
            out+=[f"Delivered ({', '.join(r['states'])}): "+', '.join(f'`{d}`' for d in r['declarations'])+'.','',
                  f"Delivery scope: {r['delivery_scope']}",'',f"Remaining obligations: {r['remaining_obligations']}",'']
    return '\n'.join(out)+'\n'
