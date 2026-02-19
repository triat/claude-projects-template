# Test Runner

Run the full test suite and check coverage. Run with: `/test`

## Steps

1. **Run all tests**
   ```bash
   # Adjust command for your stack (set in CLAUDE.md)
   npm test
   # or: pytest, go test ./..., etc.
   ```

2. **Check coverage**
   ```bash
   # Adjust for your stack
   npm run test:coverage
   # or: pytest --cov, go test -cover ./..., etc.
   ```

3. **Report results**:
   ```
   ## Test Results

   Tests: [X passed / Y failed / Z skipped]
   Coverage:
   - Lines:      [X%]  [PASS / FAIL — threshold: 80%]
   - Branches:   [X%]  [PASS / FAIL — threshold: 80%]
   - Functions:  [X%]  [PASS / FAIL — threshold: 80%]
   - Statements: [X%]  [PASS / FAIL — threshold: 80%]
   ```

4. **If tests fail**:
   - Use the `build-error-resolver` or `debugger` sub-agent
   - Never comment out failing tests
   - Never mark tests as `.skip` without leaving a TODO and reason

5. **If coverage is below 80%**:
   - Identify which files/functions are uncovered
   - Add tests for the uncovered paths
   - Re-run until threshold is met

## Coverage Thresholds

| Metric     | Minimum |
|------------|---------|
| Lines      | 80%     |
| Branches   | 80%     |
| Functions  | 80%     |
| Statements | 80%     |

These are project minimums. Aim higher on critical business logic.
