# Received artifacts, by round

Third-party inputs to this project, kept **unchanged** and outside the Lean project so that they
are neither zipped into the delivered package nor hashed into its `SHA256SUMS`. Verify with
`cd audits && sha256sum -c --strict RECEIVED_ARTIFACTS.sha256`.

| Round | Folder | Contents | Our response |
|---|---|---|---|
| Prior audit of the original 16 files | `01_prior_audit/` | `Taleb_Fat_Tails_Lean_Audit.pdf` (26 pp.), `Taleb_Lean_Checked_Repairs.zip` (v0.1 repair bundle) | Consumed by the v0.2.0 handoff; lineage only. |
| Handoff v0.2.0 (received input) | `02_handoff_v0.2.0/` | `Taleb_Lean_Implementation_Handoff.zip` (`8a8fb28a…57cab406`), companion `Taleb_Lean_Handoff_and_Formalization_Backlog.pdf` | `Taleb_Lean_Repairs/FABLE_REVIEW.md` §0–§11 (v0.2.1). |
| Astra audit of v0.2.1 | `03_astra_on_v0.2.1/` | `Taleb_Fable_v0.2.1_Independent_Audit.{md,pdf}`, `Taleb_Fable_v0.2.1_Audit_Evidence.zip` | `FABLE_REVIEW.md` §12 (v0.2.2 corrective pass). |
| Astra audit of v0.2.3 | `04_astra_on_v0.2.3/` | `Taleb_Fable_v0.2.3_Independent_Audit.pdf`, `Taleb_Proof_Progress_v0.2.3.md` (158-family ledger) | `FABLE_REVIEW.md` §14 (v0.2.4). |
| Astra audit of v0.2.4 | `05_astra_on_v0.2.4/` | `Taleb_Fable_v0.2.4_Independent_Audit.pdf`, `Taleb_Proof_Progress_v0.2.4.md`, `Taleb_Fable_v0.2.4_Audit_and_Progress.zip` (audit evidence, sub-reviews, optional runner patch, T061 API note) | `FABLE_REVIEW.md` §15 (v0.2.5). |
| Astra audit of v0.2.5 | `06_astra_on_v0.2.5/` | `Taleb_Fable_v0.2.5_Independent_Audit.pdf`, `Taleb_Proof_Progress_v0.2.5.md`, `Taleb_Fable_v0.2.5_Audit_and_Progress.zip` (evidence, sub-reviews, Python probes) | `FABLE_REVIEW.md` §16 (v0.2.6). |
| Astra audit of v0.2.6 | `07_astra_on_v0.2.6/` | `Taleb_Fable_v0.2.6_Independent_Audit.pdf`, `Taleb_Proof_Progress_v0.2.6.md`, `Taleb_Fable_v0.2.6_Audit_and_Progress.zip` (review handoff, sub-reviews, ledger/verifier probes, three isolated regression runs) | `FABLE_REVIEW.md` §17 (v0.2.7). |
| Astra audit of v0.2.7 | `08_astra_on_v0.2.7/` | `Taleb_Fable_v0.2.7_Independent_Audit.pdf`, `Taleb_Proof_Progress_v0.2.7.md`, `Taleb_Fable_v0.2.7_Review_Handoff.md`, `Taleb_Fable_v0.2.7_Audit_and_Progress.zip` (sub-reviews, probes, three isolated regression shards, extra real stale-Markdown CLI case) | `FABLE_REVIEW.md` §18 (v0.2.8). |
| Astra audit of v0.2.8 | `09_astra_on_v0.2.8/` | `Taleb_Fable_v0.2.8_Independent_Audit.pdf`, `Taleb_Proof_Progress_v0.2.8.md`, `Taleb_Fable_v0.2.8_Review_Handoff.md`, `Taleb_Fable_v0.2.8_Audit_and_Progress.zip` (sub-reviews, probes, three isolated regression shards, extra real CRLF-only CLI case) | `FABLE_REVIEW.md` §19 (v0.2.9). |

Source book (not committed, `.gitignore`d at the repository root): Taleb, *Statistical Consequences of
Fat Tails*, arXiv:2001.10488v4, `2001.10488v4.pdf`, SHA-256
`758e18b7337840104db93296144d67cf5514bf2de128fe557dc84bc32a0ad567`, 523 PDF pages, printed page =
PDF page − 14.

Outgoing packages live in `../deliverables/vX.Y.Z/`; the project itself is `../Taleb_Lean_Repairs/`, and
its `docs/AUDIT_HISTORY.md` lists the same rounds from inside the shipped package.
