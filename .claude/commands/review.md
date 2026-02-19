# Code Review

Review all uncommitted or recently changed code. Run with: `/review`

## Steps

1. **Identify what to review**
   ```bash
   git diff HEAD
   git diff --staged
   ```
   List all files that have changes.

2. **Use the `code-reviewer` sub-agent** to conduct a full review:
   - Correctness, error handling, tests, patterns, security, readability
   - Flag all CRITICAL, HIGH, MEDIUM, and LOW issues

3. **Use the `security-reviewer` sub-agent** if any changed files involve:
   - API endpoints or request handling
   - Authentication or authorization
   - User input or validation
   - Database queries
   - File system operations

4. **Fix issues by priority**:
   - CRITICAL: Fix immediately before doing anything else
   - HIGH: Fix before committing
   - MEDIUM: Fix now if quick, or create a follow-up task
   - LOW: Fix if time allows, otherwise note it

5. **Re-run the test suite** after fixes to confirm nothing regressed.

6. **Report the outcome**:
   ```
   ## Review Complete

   Issues fixed: [list]
   Issues deferred: [list with reason]
   Verdict: APPROVED / NEEDS MORE WORK
   ```

## When to Run `/review`

- Before every commit
- After a long coding session where you've lost track of changes
- When you want a second opinion on an approach
