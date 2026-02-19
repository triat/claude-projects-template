# Feature Development Workflow

Full TDD-enforced feature workflow. Run with: `/feature [feature-name]`

**Do not skip any phase. Every phase is mandatory.**

---

## Phase 1: Plan

Use the `planner` sub-agent to create an implementation plan.

- Explore the codebase to understand existing patterns before suggesting anything
- Produce a plan in the standard format (see planner agent)
- **Stop here and present the plan to the user**
- Wait for explicit approval before proceeding to Phase 2
- If the plan needs changes, revise and re-present

---

## Phase 2: Write Tests First (RED)

Use the `tdd-guide` sub-agent.

1. Write all tests described in the plan's Test Plan section
2. Run the test suite — the new tests **must fail**
3. Show the failing test output to confirm RED state
4. Do not write any implementation code yet

If any new test passes without implementation, stop — the test is wrong or the feature already exists. Investigate.

---

## Phase 3: Implement (GREEN)

Write the minimum code to make the failing tests pass.

- Follow the implementation sequence from the plan
- Follow existing codebase patterns (see CLAUDE.md conventions)
- Write immutable, well-named, small functions
- No gold-plating: implement exactly what the tests require

Run tests after completing each file. Do not proceed if tests are failing.

---

## Phase 4: Refactor (IMPROVE)

With all tests green:

- Remove duplication
- Improve naming and clarity
- Apply guard clauses to reduce nesting
- Verify coverage is 80%+ on new code

Run tests after each refactoring change.

---

## Phase 5: Code Review

Use the `code-reviewer` sub-agent.

- Review all files created or modified in this feature
- Surface any CRITICAL or HIGH issues
- Fix all CRITICAL and HIGH issues before proceeding
- Fix MEDIUM issues if they are quick wins

---

## Phase 6: Security Check

Use the `security-reviewer` sub-agent if the feature involves any of:
- New API endpoints
- User input handling
- Authentication or authorization logic
- Database queries
- File operations

Fix any vulnerabilities before committing.

---

## Phase 7: Commit

Run `/commit` to produce a clean, conventional commit.

---

## Summary Checklist

- [ ] Plan approved by user
- [ ] Tests written first (RED confirmed)
- [ ] Tests pass (GREEN confirmed)
- [ ] Refactoring done, tests still green
- [ ] Coverage 80%+ on new code
- [ ] Code review passed (no CRITICAL/HIGH issues)
- [ ] Security review passed (if applicable)
- [ ] Committed with conventional commit message
