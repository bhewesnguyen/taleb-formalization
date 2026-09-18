#!/usr/bin/env python3
"""Render the handoff report from the checked package and curated inventory.
Requires reportlab; uses DejaVu fonts available on Ubuntu.
"""
from pathlib import Path
import sys,json,hashlib,re,collections,html
from reportlab.pdfgen import canvas
from reportlab.platypus import SimpleDocTemplate,Paragraph,Spacer,Table,TableStyle,PageBreak,KeepTogether,Preformatted
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.enums import TA_LEFT
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
R=Path(__file__).resolve().parents[1]
out=Path(sys.argv[1]) if len(sys.argv)>1 else R/'Taleb_Lean_Handoff_and_Formalization_Backlog.pdf'
out.parent.mkdir(parents=True,exist_ok=True)
v=json.loads((R/'evidence/current/verification.json').read_text());assert v['status']=='PASS'
for f,h in v['source_sha256'].items():assert hashlib.sha256((R/f).read_bytes()).hexdigest()==h,f
rows=json.loads((R/'docs/FORMALIZATION_BACKLOG.json').read_text())
meta=json.loads((R/'docs/source_inventory/source_metadata.json').read_text())
maprows=json.loads((R/'docs/replacement_map.json').read_text())
for n,f in [('Body','DejaVuSans.ttf'),('Bold','DejaVuSans-Bold.ttf'),('Mono','DejaVuSansMono.ttf')]:
 pdfmetrics.registerFont(TTFont(n,'/usr/share/fonts/truetype/dejavu/'+f))
pdfmetrics.registerFontFamily('Body',normal='Body',bold='Bold',italic='Body',boldItalic='Bold')
navy=colors.HexColor('#132c43');teal=colors.HexColor('#127f91');gray=colors.HexColor('#506171');pale=colors.HexColor('#edf4f6')
styles={
 'title':ParagraphStyle('title',fontName='Bold',fontSize=30,leading=35,textColor=navy,spaceAfter=18),
 'sub':ParagraphStyle('sub',fontName='Body',fontSize=13,leading=19,textColor=gray,spaceAfter=15),
 'h1':ParagraphStyle('h1',fontName='Bold',fontSize=19,leading=24,textColor=navy,spaceAfter=13,keepWithNext=True),
 'h2':ParagraphStyle('h2',fontName='Bold',fontSize=12,leading=16,textColor=teal,spaceBefore=11,spaceAfter=6,keepWithNext=True),
 'body':ParagraphStyle('body',fontName='Body',fontSize=9.5,leading=14,spaceAfter=8,textColor=navy),
 'small':ParagraphStyle('small',fontName='Body',fontSize=8,leading=11.5,spaceAfter=5,textColor=gray),
 'cardtitle':ParagraphStyle('cardtitle',fontName='Bold',fontSize=10,leading=13,textColor=navy,spaceAfter=3),
 'card':ParagraphStyle('card',fontName='Body',fontSize=8.6,leading=12.2,spaceAfter=4,textColor=navy),
 'meta':ParagraphStyle('meta',fontName='Body',fontSize=7.7,leading=10.4,spaceAfter=4,textColor=teal),
 'table':ParagraphStyle('table',fontName='Body',fontSize=8,leading=11,textColor=navy),
 'th':ParagraphStyle('th',fontName='Bold',fontSize=8,leading=11,textColor=colors.white),
 'code':ParagraphStyle('code',fontName='Mono',fontSize=8,leading=12,textColor=navy,backColor=pale,borderPadding=8,spaceAfter=10),
}
def clean(s):
 return s.replace('\u2014',' - ').replace('\u2013','-').replace('\u2011','-')
def markup(s):
 s=html.escape(clean(s))
 s=re.sub(r'`([^`]+)`',r'<font name="Mono">\1</font>',s)
 return s
story=[]
def para(s,sty='body'):return Paragraph(markup(s),styles[sty])
def add(s,sty='body'):story.append(para(s,sty))
def heading(s):add(s,'h1')
def table(data,widths):
 cells=[[para(str(c),'th' if i==0 else 'table') for c in row] for i,row in enumerate(data)]
 t=Table(cells,colWidths=widths,repeatRows=1,hAlign='LEFT')
 t.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),navy),('VALIGN',(0,0),(-1,-1),'TOP'),('LEFTPADDING',(0,0),(-1,-1),7),('RIGHTPADDING',(0,0),(-1,-1),7),('TOPPADDING',(0,0),(-1,-1),7),('BOTTOMPADDING',(0,0),(-1,-1),7),('ROWBACKGROUNDS',(0,1),(-1,-1),[colors.white,pale]),('LINEBELOW',(0,0),(-1,0),0.6,teal)]))
 story.append(t);story.append(Spacer(1,10))
def new():story.append(PageBreak())
def footer(c,d):
 w,h=d.pagesize;c.setStrokeColor(teal);c.setLineWidth(.8);c.line(45,h-39,w-45,h-39)
 c.setFont('Bold',7);c.setFillColor(gray);c.drawString(45,h-30,'TALEB LEAN HANDOFF  |  IMPLEMENTATION + FORMALIZATION INVENTORY')
 c.setFont('Body',7);c.drawString(45,27,'18 September 2026  |  Lean 4.24.0  |  Mathlib v4.24.0');c.drawRightString(w-45,27,str(d.page))

story.append(Spacer(1,25));add('Repairs implemented.\nThe remaining mathematics mapped.','title')
add('A reproducible Lean project and a book-wide formalization backlog for Statistical Consequences of Fat Tails, third edition.','sub')
table([['DELIVERED','CHECKED SCOPE'],['16 replacement entry points','Shared, importable implementations for Proof01 through Proof16.'],['50 theorem declarations + 1 instance','Aggregate build and complete printed axiom closure pass. Sixteen aliases expose the original file organization.'],['158 obligation families','Source anchors, hypotheses, dependency groups and priorities across 30 numbered and 9 lettered chapters.'],['New probability bridges','Self-convolution subexponentiality, independent-sum laws and conditional stable-law identification.']],[160,345])
add('The previous audit ZIP already contained implemented repairs. This handoff retains them, improves the probability interfaces, adds small reusable lemmas, and makes reproduction and book coverage easier to inspect.','body')
add('The complete book is not formalized. Some source statements need correction before proof search. This package does not establish stable-law existence for all parameters, acceptance into Mathlib, or readiness of a separate quantum/classical application.','body')
add('Deliverables: Taleb_Lean_Implementation_Handoff.zip and this report. The ZIP contains all source, documentation, JSON indexes, verification scripts, and compiler evidence.','small')
add('Source: arXiv:2001.10488v4, 17 September 2025; 523 PDF pages. Formalization inventory date: 18 September 2026.','small')

new();heading('How to reproduce and use the handoff')
add('Extract the ZIP, enter Taleb_Lean_Repairs, and run these commands with elan/Lean installed. The first command downloads pinned dependencies and precompiled Mathlib artifacts.')
story.append(Preformatted('lake exe cache get\nlake build\npython3 scripts/verify.py',styles['code']))
add('Lean version: 4.24.0. Mathlib commit:','small');story.append(Preformatted('f897ebcf72cd16f89ab4577d0c826cd14afaafc7',styles['code']))
add('Keep lean-toolchain and lake-manifest.json. The included project version applies even when the user has a newer default Lean installation. No dependency upgrade is needed to reproduce this handoff.')
add('Verification result','h2')
add(f"PASS: {v['theorem_count']} theorems, {v['instance_count']} instance, {v['alias_count']} aliases. The script checks dependency commits, an aggregate Lake build and freshly evaluated axiom queries for all {v['checked_declarations']} proof declarations. Their dependencies are restricted to propext, Classical.choice and Quot.sound. No sorryAx is accepted.")
add('Fifty theorems does not mean fifty new book proofs: the count includes diagnostic counterexamples, simpler variants and foundation lemmas. Aliases add no independent mathematical content. The verification JSON records hashes of every Lean source file.')
add('evidence/current/build.log, axioms.log and verification.json are fresh handoff evidence. The older evidence directory intentionally retains original-file failures: the submitted archive had eight passing and eight failing files on this baseline.')
add('Import the complete project','h2');story.append(Preformatted('import AuditRepairs\n\n#check Taleb.Proof01.repaired\n#check Taleb.Proof08.repaired\n#check Taleb.Proof16.repaired',styles['code']))
add('The entry points share definitions, preventing the duplicate global declarations in the original standalone files. False or underspecified original statements have deliberately changed signatures; see docs/REPLACEMENT_MAP.md before updating client code.')
add('Original input archive SHA-256','small');story.append(Preformatted('b0132c09a8835107abaac916578e5e61a703\nb5a09a800c2e874c24d15d05b47c',styles['code']))

new();heading('Replacement map for all sixteen files')
add('The map gives the principal replacement. Supporting original-scope identities remain in the shared modules. The exact declaration names and import paths are in the ZIP.')
short=[
('01','Log is slowly varying','Retain sound argument; simpler algebra.'),('02','Nonzero constant is slowly varying','Remove failing no-op tactic.'),('03','Nonzero limiting constant implies slow variation','Correct limit composition.'),('04','Product of regular-varying functions','Retain the ratio argument.'),('05','Real power closure','Fix continuity and exponent order; eventual positivity.'),('06','RV iff power-normalized SV','Shorter shared proof; unnecessary sign hypothesis removed.'),('07','Finite Pareto tail exponent','Explicit positive-tail finite-limit interface.'),('08','Subexponential convolution tail exponent','Now uses a probability law and its self-convolution.'),('09','Convexity of c^(-alpha)','Qualify Set.univ and prove the correct statement.'),('10','Frechet maximum-scaling identity','Global support-aware formula; n>0.'),('11','Gumbel maximum-scaling identity','Correct original argument retained.'),('12','Gaussian specialization','Correct parameter order; repaired S1 expression.'),('13','Gaussian exponential scaling','Sound algebra, simplified.'),('14','Cauchy specialization','Correct parameter order and nonnegative scale.'),('15','Cauchy exponential scaling','Sound algebra, simplified.'),('16','Stable convolution-power law','Conditional measure equality via corrected S1 function.')]
table([['FILE','REPLACEMENT','CHANGE / LIMIT'],*short],[37,200,268])
add('Proof09, Proof12 and Proof14 have checked counterexamples to the original statements. Their intended corrected statements are proved. The ImplicitSetDiagnostic module intentionally retains autoImplicit to reproduce the old error; production repair modules disable it.','small')

new();heading('What the added code actually proves')
add('Eleven small foundation results','h2')
add('Foundations.lean adds: the zero-index equivalence; pure-power regular variation; invariance under eventual equality and nonzero scaling; slow-variation product and power closure; uniqueness and liminf agreement for finite tail exponents; the analytic Pareto power-transform exponent; and the corrected shifted-gamma excess identity and its positive sign.')
add('A probability-level subexponential interface','h2')
add('IsSubexponential now requires a probability measure on the nonnegative reals, an eventually positive survival function, and a limit of its self-convolution tail divided by its own tail equal to 2. The checked theorem preserves an existing finite tail exponent under that self-convolution. It does not prove that every regularly varying distribution is subexponential; that is a separate backlog family.')
add('Convolution and stable-law identification','h2')
add('The package defines zero-fold convolution as the point mass at zero, proves convolution powers are probability measures, proves their characteristic functions are powers, and reuses Mathlib to identify the resulting stable law when both required characteristic-function premises are supplied. An independent-sum theorem connects random-variable laws to convolution.')
add('S1 normalization and specializations','h2')
add('The corrected piecewise expression includes the skewed alpha=1 logarithmic branch. Its Gaussian and centered Cauchy specializations and its value 1 at t=0 are checked. Stable scale and Gaussian standard deviation are different: exp(-scale^2*t^2) has variance 2*scale^2.')
add('Remaining semantic obligations','h2')
add('Stable-law existence is still open in this project. Frechet/Gumbel expressions still need measure construction and iid maximum-law bridges. General infinite or undefined tail indices still need an extended-real design. The safe finite interface is used in the new results; legacy definitions remain only for comparison and diagnostics.')
add('The gamma mixture formula is repaired algebraically. Its inverse-moment integral and finiteness threshold are recorded as outstanding probability work. This distinction prevents a rational identity from being reported as a proved mixture theorem.')

new();heading('Mathlib first: reuse before extending')
add('These are facts about the pinned source snapshot. No absence claim or contribution-novelty claim is made about current Mathlib master. Check upstream again before proposing a contribution.')
table([['AREA','ALREADY AVAILABLE','NEXT CONTRIBUTION'],['Characteristic functions','Convolution product, uniqueness of finite measures, independent-sum law','Stable measure existence and parameter API; reuse the bridge machinery.'],['Gaussian distributions','Gaussian characteristic function and Gaussian convolution closure','Specializations and applications, not duplicate basic closure proofs.'],['Tails and integrals','Layer-cake integrals, real powers, gamma/beta integrals','Pareto moments, threshold excess and explicit divergence criteria.'],['Pareto / CDF','Pareto probability measure, density/CDF bridge, CDF uniqueness','Exact survival/moment corollaries, iid extrema and EVT laws.'],['LLN / convexity','Strong laws and integral Jensen','Estimator corollaries and moment convexity with all hypotheses.'],['Regular variation','Asymptotic equivalence, filters and power continuity','Coherent positive/measurable API; uniform convergence, Potter and Karamata.']],[110,194,201])
add('Existing declarations directly used or identified','h2')
add('charFun_conv; Measure.ext_of_charFun; IndepFun.map_add_eq_map_conv_map₀; charFun_gaussianReal; gaussianReal_conv_gaussianReal; isProbabilityMeasure_paretoMeasure; Integrable.integral_eq_integral_meas_lt; ConvexOn.map_integral_le; strong_law_ae_real. Exact source modules are in docs/MATHLIB_AND_WORK_ORDER.md.')
add('Large dependencies','h2')
add('Generalized CLT, stable domains of attraction, Karamata/EVT, statistical estimator asymptotics, differential-entropy optimization and stochastic calculus should be treated as substantial theorem families. A file containing a plausible formula is not a completed contribution in any of these areas.')

new();heading('Work order and the near-term objective')
table([['STEP','CONCRETE TARGET','DEPENDENCIES / EXIT'],['1','Reproduce the repaired package','Pinned build and all 67 proof-declaration axiom queries pass.'],['2','Exact Pareto tail and moment API','Use existing paretoMeasure; prove integrals and divergent cases.'],['3','iid maxima/minima and valid EVT measures','Use independence and CDF/Stieltjes infrastructure; connect formula identities.'],['4','RV and subexponential infrastructure','Agree definitions; add uniform convergence, Potter bounds, Karamata and closure.'],['5','Stable laws and limit theorems','Construct laws; prove domains of attraction and sample-average results.'],['6','Book applications','Kappa, Gini, mixtures, quantiles, shadow moments and selected pricing results.']],[39,207,259])
add('Good first backlog slices','h2')
add('T005: threshold tail integrals; T032: power-transform pushforward; T060: iid maximum/minimum laws; T068: exact Pareto MLE; T118: Pareto moment convexity; T124: shifted-gamma inverse moments. Pick one small slice after examining its prerequisites, instead of tying all six to one deadline.')
add('A realistic weekend result','h2')
add('Reproduce this handoff, choose one contained reusable contribution, and settle its mathematical statement. Full-book formalization and Mathlib review are separate milestones; upstream acceptance is not controlled by the local build.')
add('The Monday software objective','h2')
add('This Lean project uses noncomputable real and measure-theoretic objects. It is not executable quantum/classical application software. Work on that application needs its repository, runnable baseline, input/output examples and the exact paper claim to demonstrate. A local demo should have its own acceptance test and clearly identify which mathematical contract, if any, is connected to its computation.')
add('The handoff is designed to be passed directly to your friend for reproduction and further implementation.','small')

new();heading('Source statements to repair before formalization')
add('The following checks are targeted findings from the inventory pass. They extend the initial audit but do not constitute a complete correctness audit of the book. Except for explicitly named Lean lemmas, these are mathematical checks recorded for the next implementation stage. Printed page numbers below need +14 for the PDF viewer.')
source=(R/'docs/SOURCE_GATES.md').read_text();chunks=re.split(r'(?m)^## ',source)[1:]
for chunk in chunks:
 title,body=chunk.split('\n',1)
 if title=='Additional review gates':continue
 block=[para(title,'h2')]
 for part in body.strip().split('\n\n'):block.append(para(part.replace('\n',' '),'body'))
 story.append(KeepTogether(block))

new();heading('How to read the remaining-mathematics inventory')
add('The 158 rows below are formalization families. Each may expand into definitions, integrability lemmas, convergence machinery, a main theorem and corollaries. They are not a promise of 158 independent missing theorems or an exhaustive atomic extraction of every implicit argument.')
table([['STATUS','MEANING','#'],['missing','Implement after prerequisites.',95],['source-check','Resolve the mathematical statement first.',33],['partial','Some delivered ingredients exist; family incomplete.',8],['reuse','Instantiate or connect existing Mathlib facts.',4],['model-needed','Specify a mathematical or software model first.',15],['empirical','Reproduce data/calculations; not a proof-only task.',3]],[94,368,43])
add('Priorities: P0 = statement repair; P1 = comparatively contained reusable family; P2 = substantial dependency family; P3 = advanced application, model or data work. A source-check status always requires mathematical review, regardless of priority. These are dependency priorities, not day estimates.')
add('Coverage and locator evidence','h2')
add('All 39 chapter/lettered units have coverage entries. Chapter 1 is introductory exposition. The source indexes contain 353 PDF bookmarks, 315 numbered-equation locator occurrences and 71 statement-heading candidates. Equation and heading indexes can include repeats or prose references; they are navigational evidence, not theorem counts.')
add('Every source body page through printed page 482 was included in the locator scan. Unnumbered mathematics is represented through the curated families and needs further atomization when implemented. Source-specific hypotheses and corrections are included in each row. The scan and curated inventory have reproducible Python scripts in the ZIP.')
add('The printed page ranges below are source anchors, not assurances that every needed dependency is on that page. The JSON gives a PDF anchor page as well. PDF bookmarks can precede the exact formula; consult the rendered source before choosing a precise theorem statement.')
add('Dependency groups: RV regular variation; TAIL survival integrals; MOM moments; CF characteristic functions; CDF extrema/distribution functions; QUANT quantiles; LLN laws of large numbers; CLT limit laws; EVT extreme values; SUBEXP convolution tails; GAMMA special functions; DENS densities; CALC calculus/convexity; KAPPA metric; EST estimators; GINI inequality; MULTI multivariate laws; ENT entropy; RUIN survival/barriers; SDE stochastic processes; FIN pricing; APP model/data applications.','small')

new();heading('The outstanding formalization families')
last=None
for r in rows:
 block=[]
 if r['unit']!=last:
  block.append(para('Chapter '+r['unit'],'h2'));last=r['unit']
 block.append(para(r['id']+'  '+r['title'],'cardtitle'))
 block.append(para(f"{r['priority']} | {r['status']} | {r['dependency_group']} | Printed pp. {r['printed_pages']} | Source {r['source_anchor']}",'meta'))
 block.append(para(r['target'],'card'))
 block.append(para('Hypotheses / gap: '+r['hypotheses_and_gaps'],'card'))
 block.append(Spacer(1,7));story.append(KeepTogether(block))

new();heading('Acceptance record and provenance')
add('A backlog family becomes completed only after the formal proposition matches a corrected mathematical statement, required assumptions are explicit, its code compiles in a pinned project, the axiom closure is checked, and source differences are documented. Definitions and conditional bridges should retain their scope labels until the missing existence and model-identification theorems are supplied.')
add('Exact source input','h2');add(meta['edition']);add('Source PDF SHA-256:','small');story.append(Preformatted(meta['source_sha256'][:32]+'\n'+meta['source_sha256'][32:],styles['code']))
add('The original proof ZIP hash is verified and its untouched bytes are included under evidence/source. The source book and dependency binaries are not included. The archive has SHA256SUMS for its contents; verification.json separately hashes every Lean file.')
add('Primary references','h2')
for label,url in [('Versioned book: arXiv:2001.10488v4','https://arxiv.org/abs/2001.10488v4'),('Pinned Mathlib source tree','https://github.com/leanprover-community/mathlib4/tree/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib'),('Characteristic functions in the pinned source','https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/MeasureTheory/Measure/CharacteristicFunction.lean'),('Pareto distribution in the pinned source','https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Probability/Distributions/Pareto.lean')]:
 story.append(Paragraph(f'<link href="{url}" color="#127f91">{html.escape(label)}</link>',styles['body']))
add('Prior evidence: Taleb_Fat_Tails_Lean_Audit.pdf and Taleb_Lean_Checked_Repairs.zip, recovered from the previous completed audit. The earlier implementation is acknowledged as the foundation of this expanded handoff.','small')
add('Verification scope: compilation validates the Lean propositions under their definitions and standard foundational axioms. It does not validate empirical conclusions, guarantee current upstream novelty, certify arbitrary numerical implementations, or establish a theorem that is still listed as a premise.','small')

doc=SimpleDocTemplate(str(out),pagesize=(595.28,841.89),rightMargin=45,leftMargin=45,topMargin=58,bottomMargin=48,title='Taleb Lean Handoff and Formalization Backlog',author='Technical audit and implementation handoff')
doc.build(story,onFirstPage=footer,onLaterPages=footer)
print(out)
