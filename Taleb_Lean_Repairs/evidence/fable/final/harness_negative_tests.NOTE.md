# Note on `harness_negative_tests.log` (v0.2.1 record, preserved unchanged)

The independent audit of v0.2.1 (finding A4) observed that Test 2 in this log shows the
inventory-mismatch message followed by `exit=0`, while the review text says the verifier
failed. Both are true of different processes: the verifier did exit 1 (its live output at
the time read `exit=1`, and the mismatch message itself is only printed on the failure
path), but the line appended to this log was produced by a shell wrapper that evaluated
`${PIPESTATUS[0]}` after an intervening pipeline, so it recorded the exit status of that
later pipeline, not the verifier's. The log is kept as received evidence of the v0.2.1
pass and is superseded by `scripts/harness_regression.py`, whose record
(`evidence/current/harness_regression.json` / `.log`, copied under
`evidence/fable/v0.2.2/`) stores the exact command, the verifier's own subprocess exit
code, its output tail and the resulting `verification.json` for every fixture.
