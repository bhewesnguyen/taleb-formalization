#!/usr/bin/env python3
"""Recreate navigational indexes from the user's versioned PDF. Requires PyMuPDF.
Usage: python3 scripts/index_book.py /path/to/2001.10488v4.pdf
These are locators, not an automated extraction of formal theorem statements.
"""
from pathlib import Path
import sys,json,re,hashlib
import pymupdf
pdf=Path(sys.argv[1]); target=Path(__file__).resolve().parents[1]/'docs/source_inventory'
expected='758e18b7337840104db93296144d67cf5514bf2de128fe557dc84bc32a0ad567'
actual=hashlib.sha256(pdf.read_bytes()).hexdigest()
if actual!=expected: raise SystemExit('Source PDF differs from the pinned third-edition input. Do not overwrite this inventory.')
d=pymupdf.open(pdf);toc=d.get_toc();target.mkdir(parents=True,exist_ok=True)
units=[dict(unit=re.match(r'^(\d+|[A-I]) ',n)[1],title=n,pdf_start=s) for l,n,s in toc if re.match(r'^(\d+|[A-I]) ',n)]
for i,u in enumerate(units):
 u.update(pdf_end=units[i+1]['pdf_start']-1 if i+1<len(units) else 496)
 u.update(printed_start=u['pdf_start']-14,printed_end=u['pdf_end']-14,coverage='Formalization inventory only; no whole-chapter correctness certificate.')
sections=[dict(depth=l,title=n,bookmark_pdf_page=s,bookmark_printed_page=s-14,locator_status='PDF bookmark; verify exact formula page before implementation') for l,n,s in toc]
eq=[];labels=[]
for i,page in enumerate(d):
 if i<14 or i>=496: continue
 s=page.get_text().replace('ﬁ','fi').replace('ﬂ','fl')
 for m in re.finditer(r'(?m)^\(([0-9]{1,2}|[A-I])\.([0-9]{1,3})\)\s*$',s):
  eq.append(dict(label=m[0].strip(),pdf_page=i+1,printed_page=i-13,kind='Numbered equation locator; may be a repeated equation/reference',status='Candidate locator, not an independent theorem'))
 for m in re.finditer(r'(?m)^(Theorem(?: [0-9]+)?|Proposition [0-9.]+|Lemma [0-9.]+|Corollary [0-9.]+|Definition [A-I0-9.]+|Principle [0-9.]+|Property [0-9.]+|Result [0-9]+)([^\n]*)\n',s):
  labels.append(dict(label=m[0].strip(),pdf_page=i+1,printed_page=i-13,status='Heading candidate; prose references and duplicates need filtering'))
for name,value in [('chapter_coverage',units),('section_index',sections),('equation_index',eq),('statement_heading_index',labels)]:
 (target/(name+'.json')).write_text(json.dumps(value,indent=2)+'\n')
print(f'{len(units)} units; {len(sections)} bookmarks; {len(eq)} equation locators; {len(labels)} heading candidates')
