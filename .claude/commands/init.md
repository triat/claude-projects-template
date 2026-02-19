# Session Initialization

Run this at the start of every Claude Code session to re-anchor context and avoid working on stale assumptions.

## Steps

1. **Read CLAUDE.md** — Load the full project context: stack, architecture, conventions, current focus, known gotchas.

2. **Check git status**
   ```bash
   git status
   git log --oneline -10
   git stash list
   ```
   Report:
   - Current branch
   - Any uncommitted changes (staged or unstaged)
   - Any stashed work
   - The last 10 commits (to understand recent activity)

3. **Check for open TODOs in the codebase**
   Search for `TODO`, `FIXME`, `HACK`, `XXX` in source files. Briefly list any found.

4. **Summarize the session starting point**
   Produce a short briefing in this format:

   ---
   ## Session Ready

   **Branch**: `[branch-name]`
   **Status**: [Clean / Has uncommitted changes: list them]
   **Recent work**: [1–2 sentence summary from git log]
   **Current focus** (from CLAUDE.md): [Copy the active sprint/phase section]
   **Known gotchas to watch**: [Copy the gotchas from CLAUDE.md]

   ---

5. **Ask what to work on**
   "What would you like to work on today?" — then wait for the user's answer before doing anything else.

## Important

Do not start implementing anything during `/init`. This is an orientation step, not a work step.
