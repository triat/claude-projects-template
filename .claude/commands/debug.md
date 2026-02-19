# Debug Workflow

Systematic bug investigation. Run with: `/debug [describe the issue]`

**Never guess. Never apply a fix without understanding the root cause.**

---

## Steps

1. **Capture the full reproduction case**
   - Exact steps to reproduce
   - Expected behavior vs actual behavior
   - Error message and full stack trace (if any)
   - Environment details (branch, recent changes)

2. **Use the `debugger` sub-agent** to work through the systematic debugging process:
   - Classify the error type
   - Gather evidence before forming hypotheses
   - Generate 2–3 candidate root causes
   - Test hypotheses cheapest-first

3. **Fix the root cause** (not the symptom)
   - One minimal change that addresses the identified root cause
   - Do not accumulate speculative fixes

4. **Write a regression test**
   - Write a test that would have caught this bug
   - Run it to confirm it fails on the pre-fix code (if you can)
   - Confirm it passes after the fix

5. **Check for recurrence**
   - Is the same bug pattern present elsewhere in the codebase?
   - Grep for similar code patterns

6. **Update CLAUDE.md**
   - If this was a non-obvious gotcha, add it to the Known Gotchas section

7. **Commit** — use `/commit` with a `fix:` type commit message

---

## Common Shortcircuits to Avoid

- Do not add `try/catch` around the error without understanding it
- Do not comment out failing tests
- Do not update dependencies speculatively to "see if it fixes it"
- Do not hardcode a workaround for specific inputs
