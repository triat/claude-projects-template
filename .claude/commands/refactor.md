# Refactor

Clean up code structure without changing behavior. Run with: `/refactor [scope]`

Where `[scope]` is optional — a file path, directory, or plain description (e.g., `/refactor src/services/auth.ts` or `/refactor the order processing module`). If omitted, targets recently changed files.

**Behavior must not change. If it does, that's a bug — not a refactor.**

---

## Phase 0: Identify scope

1. If a scope was provided, use it exactly.
2. If no scope was provided, identify candidates from recent changes:
   ```bash
   git diff --name-only HEAD~5
   ```
3. State the agreed scope clearly before proceeding:
   > "Refactoring scope: `src/services/auth.ts`. Out of scope: everything else."

Ask the user to confirm or adjust the scope before continuing.

---

## Phase 1: Verify test coverage

Before touching any code, confirm tests exist and pass:

```bash
npm test -- --coverage 2>&1 | tail -20
```

Check coverage for the files in scope:
- If coverage on in-scope files is **below 80%**, stop and notify the user:
  > "Coverage on `[file]` is [X]%. Safe refactoring requires 80%+. Add tests first, then run `/refactor` again — or run `/feature` to add tests as part of a task."
- If coverage is 80%+, proceed.
- Record the baseline: note which tests cover the in-scope code.

---

## Phase 2: Identify targets

Use the `refactor-cleaner` sub-agent to scan the in-scope code and produce a prioritized list of targets:

- Dead code (unreachable blocks, unused exports, commented-out code)
- Duplicated logic (copy-paste blocks that should be extracted)
- Long functions (>50 lines)
- Deep nesting (>4 levels)
- Magic numbers and strings
- Misleading or unclear names
- Large files (>800 lines)

Present the list to the user:
> "Found [N] refactoring opportunities. Proceeding in priority order."

Do not wait for approval on each individual item — proceed through the list unless the user interrupts.

---

## Phase 3: Refactor incrementally

Use the `refactor-cleaner` sub-agent to apply changes.

**Rules:**
- One category of change at a time (e.g., extract functions, then rename, then remove dead code)
- Run tests after each change:
  ```bash
  npm test
  ```
- If tests fail after a change: revert that change immediately, note it, move on
- Never mix refactoring with feature additions or bug fixes

After each logical group of changes, commit:
```bash
git add [changed files]
git commit -m "refactor: [what changed and why]"
```

Examples of good incremental commit messages:
- `refactor: extract calculateDiscount() from processOrder()`
- `refactor: remove dead exportToPdf route handler`
- `refactor: replace magic timeout values with named constants`
- `refactor: flatten nested conditionals in validateUser() with guard clauses`

---

## Phase 4: Final verification

After all changes:

1. Run the full test suite:
   ```bash
   npm test -- --coverage
   ```
2. Confirm:
   - All tests pass
   - Coverage did not decrease from baseline
   - No new linting errors:
     ```bash
     npm run lint
     ```

---

## Phase 5: Report

Output a summary in this format:

```
## Refactor Complete: [Scope]

### Changes Made
| File | What changed | Why |
|------|-------------|-----|
| `path/to/file.ts` | Extracted `fn()` from `bigFn()` | Function was 90 lines doing two things |

### Dead Code Removed
- [List with justification, or "None"]

### Skipped (and why)
- [Anything that looked messy but was left alone — explain]

### Test Results
Coverage: [X]% → [Y]% (baseline → after)
All tests: PASS
```

---

## Summary Checklist

- [ ] Scope defined and confirmed
- [ ] Baseline test coverage verified (80%+)
- [ ] Refactoring targets identified
- [ ] Changes applied incrementally, tests run after each
- [ ] Each logical step committed separately
- [ ] Final test suite passes
- [ ] Coverage did not decrease
- [ ] No new linting errors
- [ ] Summary report produced
