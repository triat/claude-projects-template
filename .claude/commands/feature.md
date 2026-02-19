# Feature Development Workflow

Execute a planned task using full TDD. Run with: `/feature [NNN]`

Where `[NNN]` is the task number (e.g., `/feature 003` or `/feature 003-create-new-dashboard`).

**Do not skip any phase. Every phase is mandatory.**

---

## Phase 0: Load the task

1. Find the task file:
   ```bash
   ls .claude/tasks/ | grep -E '^NNN'
   ```
   Use the first match.

2. Read the task file in full — this is your plan. Do not re-plan. Do not invoke the planner agent.

3. Confirm the task is in `TODO` status. If it is `IN_PROGRESS`, ask the user:
   > "Task NNN is already in progress. Resume it, or start fresh?"
   If it is `DONE`, stop and notify the user — do not reopen completed tasks.

4. Update the task file: change `**Status**: TODO` → `**Status**: IN_PROGRESS`

5. Update the task file: set `**Branch**: feat/NNN-slug` (derive slug from filename)

6. Update TASKS.md:
   - Remove the entry from **📋 To Do**
   - Add it to **🔄 In Progress**:
     ```
     - **[NNN](/.claude/tasks/NNN-slug.md)** — [Title] · `feat/NNN-slug` · Started [YYYY-MM-DD]
     ```
   - If To Do becomes empty, restore `_Nothing in progress._`

7. Create the git branch:
   ```bash
   git checkout -b feat/NNN-slug
   ```

---

## Phase 1: Confirm the plan

Read the `## Plan` section of the task file aloud in a short summary:
- What will be built
- Files to create/modify
- Test approach

Ask: **"Ready to start? Or does the plan need adjusting first?"**

Wait for confirmation. If adjustments are needed, update the task file's Plan section, then proceed.

---

## Phase 2: Write Tests First (RED)

Use the `tdd-guide` sub-agent.

1. Write all tests described in the task file's Test Plan
2. Run the test suite — the new tests **must fail**
3. Show the failing test output to confirm RED state
4. Do not write any implementation code yet

If any new test passes without implementation, stop — investigate before continuing.

Add a progress note to the task file:
```markdown
## Progress Notes
- [YYYY-MM-DD] Tests written (RED confirmed): [list test files created]
```

---

## Phase 3: Implement (GREEN)

Write the minimum code to make the failing tests pass.

- Follow the Implementation Sequence from the task file exactly
- Follow existing codebase patterns (see CLAUDE.md conventions)
- Write immutable, well-named, small functions (<50 lines)
- No gold-plating — implement exactly what the tests require

Run tests after completing each file. Do not proceed if tests are failing.

Add a progress note to the task file when each major step from the Implementation Sequence is complete.

---

## Phase 4: Refactor (IMPROVE)

With all tests green:

- Remove duplication
- Improve naming and clarity
- Apply guard clauses to reduce nesting
- Verify coverage is 80%+ on new code

Run tests after each change.

---

## Phase 5: Code Review

Use the `code-reviewer` sub-agent.

- Review all files created or modified in this task
- Fix all CRITICAL and HIGH issues before proceeding
- Fix MEDIUM issues if they are quick wins

---

## Phase 6: Security Check

Use the `security-reviewer` sub-agent if the task involves any of:
- New API endpoints
- User input handling
- Authentication or authorization
- Database queries or schema changes
- File system operations

Fix any vulnerabilities before committing.

---

## Phase 7: Mark Complete and Commit

1. Update the task file:
   - Change `**Status**: IN_PROGRESS` → `**Status**: DONE`
   - Add final progress note: `- [YYYY-MM-DD] Completed. PR: [will update]`
   - Mark all Acceptance Criteria checkboxes that are now satisfied

2. Update TASKS.md:
   - Remove the entry from **🔄 In Progress**
   - Add it to **✅ Done**:
     ```
     - **[NNN](/.claude/tasks/NNN-slug.md)** — [Title] · Completed [YYYY-MM-DD]
     ```
   - If In Progress becomes empty, restore `_Nothing in progress._`

3. Stage and commit everything including the task file and TASKS.md:
   ```bash
   git add .claude/tasks/NNN-slug.md TASKS.md [all implementation files]
   ```

4. Run `/commit` to produce the conventional commit message.

5. After the PR is created, update the task file's `**PR**:` field with the PR URL.

---

## Summary Checklist

- [ ] Task file found and loaded
- [ ] Status updated to IN_PROGRESS, TASKS.md updated
- [ ] Branch created
- [ ] Plan confirmed with user
- [ ] Tests written first (RED confirmed)
- [ ] Tests pass (GREEN confirmed)
- [ ] Refactoring done, tests still green
- [ ] Coverage 80%+ on new code
- [ ] Code review passed (no CRITICAL/HIGH)
- [ ] Security review passed (if applicable)
- [ ] Task file marked DONE, all criteria checked
- [ ] TASKS.md updated to Done section
- [ ] Committed with conventional commit message
