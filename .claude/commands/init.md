# Session Initialization

Run this at the start of every Claude Code session to re-anchor context and avoid working on stale assumptions.

**Do not start implementing anything during `/init`. This is orientation only.**

---

## Step 1: Read CLAUDE.md and CLAUDE.local.md

Load the full project context: stack, architecture, conventions, current focus, and known gotchas.

If `CLAUDE.local.md` exists, read it too — it contains personal/machine-specific overrides (local DB URLs, personal preferences, machine-specific gotchas) that take highest precedence over `CLAUDE.md`.

---

## Step 2: Read TASKS.md

Load the task board to understand what is queued, in progress, and done.

If a task shows **IN_PROGRESS**, read its full task file from `.claude/tasks/` — this is likely what the user will want to continue.

---

## Step 3: Check git state

```bash
git status
git log --oneline -10
git stash list
```

Note:
- Current branch
- Uncommitted changes (staged or unstaged)
- Stashed work
- The last 10 commits

Cross-reference the current branch with the IN_PROGRESS task (if any). If they match, say so.

---

## Step 4: Check for inline TODOs

Scan source files for `TODO`, `FIXME`, `HACK`, `XXX`. List any found briefly — these are potential tasks that haven't been formally queued yet.

---

## Step 5: Produce the session briefing

```
## Session Ready

**Branch**: `[branch-name]`
**Git status**: [Clean / Uncommitted changes: list files]
**Recent commits**: [1–2 sentence summary of what was done recently]

### Task Board
🔄 In Progress: [task ID and title, or "None"]
📋 To Do: [count] task(s) queued — next up: [first TODO task ID and title]
✅ Done: [count] task(s) completed

### Resuming
[If IN_PROGRESS task exists]:
Task [NNN-slug] is in progress. Last progress note: "[copy last entry from ## Progress Notes]"
Ready to continue from [last completed phase].

### From CLAUDE.md
**Current focus**: [copy the active sprint/phase]
**Gotchas to watch**: [copy the known gotchas]
```

---

## Step 6: Ask what to work on

If there is an IN_PROGRESS task:
> "It looks like you were working on **[NNN — title]**. Want to continue, or is there something else?"

If there are only TODO tasks:
> "You have [N] task(s) queued. Want to start **[NNN — first task]**, or is there something else?"

If there are no tasks at all:
> "No tasks queued. What would you like to work on? (Run `/plan [description]` to create a task first.)"

Then wait. Do not do anything until the user responds.
