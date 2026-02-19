# Claude Code Project Template

A batteries-included template that makes Claude Code consistent, autonomous, and high-quality across every project session.

| Pain point              | Solution                                          |
| ----------------------- | ------------------------------------------------- |
| Context gets lost       | `CLAUDE.md` + `@`-imported docs + `/init` ritual  |
| Tasks forgotten between sessions | File-based task board (`TASKS.md`)       |
| Too much back-and-forth | Pre-built command workflows                       |
| Quality inconsistency   | 9 specialized sub-agents with strict formats      |
| Inconsistent UI design  | Design system doc + `ui-designer` agent + `/ui`   |
| No clear workflow       | Enforced TDD + review + commit pipeline           |

---

## How to Use This Template

### Copy to a new project

```bash
cp -r /path/to/claude-project-template/.claude /your/new/project/
cp /path/to/claude-project-template/CLAUDE.md /your/new/project/
cp /path/to/claude-project-template/TASKS.md /your/new/project/
```

### Set up (do this once per project)

1. **Fill in `CLAUDE.md`** — project name, type, status, repo URL, run commands, gotchas
2. **Fill in `.claude/docs/architecture.md`** — stack table, directory structure, architectural boundaries
3. **Fill in `.claude/docs/conventions.md`** — naming, error handling, testing, env vars (or leave defaults)
4. **Fill in `.claude/docs/design-system.md`** — run `npx shadcn@latest init`, pick a theme, paste the generated CSS variables into the color token table; set your font and sidebar width
5. **Open Claude Code** in your project root and run `/init`

---

## Structure

```
.
├── CLAUDE.md                          # Project identity, commands, focus, gotchas
├── TASKS.md                           # Task board dashboard (auto-maintained by Claude)
├── .mcp.json                          # MCP server declarations (GitHub, DB, Fetch)
└── .claude/
    ├── settings.json                  # Permissions + hooks config
    ├── docs/                          # @-imported into CLAUDE.md every session
    │   ├── architecture.md            # Stack, directory structure, boundaries
    │   ├── conventions.md             # Naming, errors, testing, security, env vars
    │   ├── design-system.md           # UI tokens, component library, patterns, inventory
    │   └── mcp.md                     # MCP server reference — tools, usage, setup checklist
    ├── tasks/                         # One file per task, created by /plan
    │   └── _TEMPLATE.md               # Reference format for task files
    ├── agents/                        # Sub-agents with YAML frontmatter
    │   ├── planner.md                 # Creates implementation plans (Read/Glob/Grep only)
    │   ├── architect.md               # ADRs and architecture decisions (Opus)
    │   ├── tdd-guide.md               # Enforces write-tests-first
    │   ├── code-reviewer.md           # Post-implementation review (Read/Glob/Grep only)
    │   ├── security-reviewer.md       # Security audit (Opus)
    │   ├── build-error-resolver.md    # Systematic build failure analysis
    │   ├── debugger.md                # Root-cause debugging methodology
    │   ├── refactor-cleaner.md        # Safe refactoring without behavior change
    │   └── ui-designer.md             # Consistent UI using the design system
    ├── commands/                      # Custom slash commands
    │   ├── init.md                    # /init    — session startup ritual
    │   ├── plan.md                    # /plan    — creates task file, no code
    │   ├── feature.md                 # /feature — full TDD cycle from task file
    │   ├── ui.md                      # /ui      — design-system-aware component builder
    │   ├── debug.md                   # /debug   — systematic bug investigation
    │   ├── review.md                  # /review  — code + security review
    │   ├── test.md                    # /test    — run tests + coverage check
    │   └── commit.md                  # /commit  — safe conventional commit
    └── hooks/
        ├── post-edit-format.sh        # Auto-formats files after every Write/Edit
        └── pre-bash-guard.sh          # Blocks dangerous shell commands
```

---

## Task Workflow

Tasks are persisted as numbered files so Claude never loses track between sessions.

```
/plan add CSV export to reports
```
→ Creates `.claude/tasks/003-add-csv-export-reports.md` with plan
→ Adds entry to `TASKS.md` under To Do
→ Waits for your approval before any code is written

```
/feature 003
```
→ Reads the task file as its plan (no re-planning)
→ Updates status `TODO → IN_PROGRESS`, creates the branch
→ Runs full TDD cycle, updating progress notes in the task file
→ On completion: updates status to `DONE`, updates `TASKS.md`

```
/init
```
→ Reads `TASKS.md`, highlights the in-progress task, reads its progress notes
→ Asks if you want to resume — restoring full context from where you left off

---

## Commands Reference

| Command               | What it does                                                        |
| --------------------- | ------------------------------------------------------------------- |
| `/init`               | Reads CLAUDE.md + TASKS.md, checks git state, orients the session  |
| `/plan [description]` | Creates a numbered task file with full plan, waits for approval     |
| `/feature [NNN]`      | Executes task NNN: TDD cycle → review → security → commit          |
| `/ui [description]`   | Builds UI component using the design system and existing patterns   |
| `/debug [issue]`      | Systematic root-cause analysis and fix                              |
| `/review`             | Code review + optional security review of current changes          |
| `/test`               | Runs tests, checks coverage against 80% threshold                  |
| `/commit`             | Pre-commit checks, conventional commit message, safety guards       |

---

## Example Workflows

### 1. Starting a new session

You open Claude Code the next morning. You don't remember exactly where you left off.

```
/init
```

Claude reads `CLAUDE.md`, loads `TASKS.md`, checks git state, and produces:

```
## Session Ready

Branch: feat/003-invoice-export
Git status: 1 unstaged change — src/services/export.ts
Recent commits: added CSV formatter utility (yesterday)

Task Board
🔄 In Progress: 003-invoice-export
📋 To Do: 2 tasks queued — next up: 004-email-notifications
✅ Done: 2 tasks

Resuming
Task 003 is in progress. Last note: "GREEN phase — all tests passing,
refactor step next."

It looks like you were working on 003 — invoice export. Want to continue?
```

You type "yes" and pick up exactly where you left off.

---

### 2. Planning and building a feature

```
/plan add pagination to the users API endpoint
```

Claude explores the codebase, finds the existing endpoint pattern, and produces a task file at `.claude/tasks/005-paginate-users-endpoint.md`. It shows you the plan — files to change, implementation sequence, test strategy — and asks for approval.

You reply: "Looks good, approved."

```
/feature 005
```

Claude reads the task file and begins:

1. Writes failing tests for the paginated endpoint (shows RED output)
2. Implements the minimal pagination logic (tests go GREEN)
3. Refactors and hits 80%+ coverage
4. Runs code review — flags one MEDIUM issue (missing index on `created_at`), fixes it
5. Runs security review — confirms query uses parameterized inputs
6. Marks task DONE in the file, moves it to ✅ Done in `TASKS.md`
7. Commits with message: `feat: add cursor-based pagination to GET /users`

---

### 3. Building a UI component

```
/ui stats card showing total revenue, number of orders, and trend vs last month
```

Claude:
1. Reads `.claude/docs/design-system.md` — loads the color tokens, spacing scale, and existing patterns
2. Checks the Component Inventory — no existing stats card
3. Checks Component Patterns — finds the dashboard card pattern established earlier
4. Builds the component using shadcn `Card` primitives, matching the existing pattern exactly
5. Uses only `text-muted-foreground`, `bg-card`, `text-foreground` — no raw colors
6. Adds the component to the inventory in `design-system.md`

Every stats card in your app now looks identical because they all follow the same pattern.

---

### 4. Debugging a production issue

Users are reporting that login fails after being idle for 30 minutes.

```
/debug login fails after ~30 minutes of inactivity — users get a 401 but refreshing fixes it
```

Claude:
1. Searches for token refresh logic in `src/auth/`
2. Forms two hypotheses: (a) access token TTL mismatch with refresh window, (b) refresh token not being sent on retry
3. Tests hypothesis (a) first — finds that `ACCESS_TOKEN_TTL=1800` (30 min) but the refresh is only triggered at `TTL - 60s`, leaving a race window
4. Writes a failing test that reproduces the race condition
5. Fixes the refresh trigger to `TTL * 0.8` — test goes green
6. Adds the gotcha to `CLAUDE.md`: "Access token refresh triggers at 80% of TTL — not at expiry minus fixed seconds"
7. Commits: `fix: prevent auth race condition on token refresh near expiry`

---

### 5. Reviewing before a commit

You've been coding for a few hours and want a second opinion before committing.

```
/review
```

Claude diffs all changed files and runs two agents in sequence:

- **code-reviewer** finds one HIGH issue: a missing `await` on an async DB call that would silently fail
- **security-reviewer** finds one MEDIUM issue: a new endpoint is missing rate limiting

Claude fixes both, then asks: "Issues resolved — ready to commit?"

```
/commit
```

Claude checks for secrets in the diff, stages the right files, and proposes:

```
fix: add missing await on user update and rate limit POST /export

The missing await caused silent failures on concurrent updates.
Rate limiting added to match the convention on all other POST endpoints.
```

You approve, commit is created.

---

## Agents Reference

Agents have YAML frontmatter with a `description` field — Claude uses this to auto-select the right agent without you having to name it explicitly. You can also invoke them directly:

> "Use the security-reviewer agent to audit these auth changes."

| Agent                  | Auto-selected when...                                      | Model  |
| ---------------------- | ---------------------------------------------------------- | ------ |
| `planner`              | Starting a new feature or task                             | Sonnet |
| `architect`            | Choosing between fundamentally different approaches        | Opus   |
| `tdd-guide`            | Implementing any feature or bug fix                        | Sonnet |
| `code-reviewer`        | After implementing, before committing                      | Sonnet |
| `security-reviewer`    | Committing changes to auth, APIs, input, or DB queries     | Opus   |
| `build-error-resolver` | Build or tests are failing                                 | Sonnet |
| `debugger`             | Bug cause is unclear or fix isn't working                  | Sonnet |
| `refactor-cleaner`     | Cleaning up code without changing behavior                 | Sonnet |
| `ui-designer`          | Any UI component or screen work                            | Sonnet |

Read-only agents (`planner`, `architect`, `code-reviewer`) have `tools: Read, Glob, Grep` — they cannot modify files, which prevents accidental edits during analysis.

---

## Design System

The design system lives in `.claude/docs/design-system.md` and is imported into every Claude session. It acts as the single source of truth for all UI decisions.

**Fill in once at project start:**
- Component library (shadcn/ui recommended — pre-filled)
- Color tokens — paste the CSS variables from `npx shadcn@latest init`
- Font family, sidebar width, page max-width

**Grows automatically over the project:**
- `/ui` adds every new component to the Component Inventory
- New structural patterns are documented in Component Patterns
- Each session Claude reads the inventory before building — no duplicates, no drift

---

## MCP Servers

MCP (Model Context Protocol) gives Claude native access to external tools. Servers are declared in `.mcp.json` at the project root and enabled in `.claude/settings.json`.

| Server | Package | What it enables |
|--------|---------|-----------------|
| **GitHub** | `@modelcontextprotocol/server-github` | Read issues, open PRs, post comments, search code |
| **PostgreSQL** | `@modelcontextprotocol/server-postgres` | Query live DB data (read-only) during debugging and planning |
| **Fetch** | `@modelcontextprotocol/server-fetch` | Fetch docs, CVE databases, changelogs, API specs |

### Setup

**GitHub** — create a token at https://github.com/settings/tokens (scopes: `repo`, `read:org`) and export it:
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # add to ~/.zshrc or ~/.bashrc
```

**PostgreSQL** — replace the placeholder in `.mcp.json`:
```json
"args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://user:pass@localhost/mydb"]
```
Use your **development** database only. For MySQL/SQLite, swap the package for `@modelcontextprotocol/server-mysql` or `@modelcontextprotocol/server-sqlite`.

**Fetch** — no credentials needed, works out of the box.

### Verify
```bash
claude mcp list          # should show github, postgres, fetch as connected
```

### How agents use MCP

| Agent | MCP tools used |
|-------|---------------|
| `planner` | GitHub: reads linked issues before planning; Fetch: reads third-party API docs |
| `debugger` | Postgres: queries live data to inspect state; GitHub: reads bug reports; Fetch: looks up error docs |
| `build-error-resolver` | Fetch: reads library changelogs and breaking change notes |
| `security-reviewer` | Fetch: checks CVE databases (OSV, NVD); GitHub: scans full repo for vulnerable patterns |

---

## Hooks

### `post-edit-format.sh`
Runs after every file write or edit. Auto-formats based on file extension:
- `.ts`, `.tsx`, `.js`, `.jsx` → Prettier + ESLint
- `.py` → black + isort + ruff
- `.go` → gofmt + goimports
- `.rs` → rustfmt
- `.json`, `.md`, `.css`, `.yaml` → Prettier

Formatters only run if installed — nothing breaks if they aren't.

### `pre-bash-guard.sh`
Blocks before execution:
- `rm -rf /`, `rm -rf ~`, `rm -rf *`
- Force-pushing to `main`/`master`
- `git reset --hard`
- Destructive SQL (`DROP DATABASE`, `DROP TABLE`, `TRUNCATE`)
- `chmod 777`
- `git commit --no-verify`

---

## Customizing for Your Stack

### Test command
Edit `.claude/commands/test.md` and `.claude/commands/feature.md` — replace `npm test` with your stack's command (`pytest`, `go test ./...`, etc.).

### Allowed shell commands
Add to the `permissions.allow` array in `.claude/settings.json`:
```json
"Bash(docker*)", "Bash(make*)", "Bash(cargo*)"
```

### Additional bash guards
Add to `.claude/hooks/pre-bash-guard.sh` following the existing pattern:
```bash
if echo "$COMMAND" | grep -qE 'your-pattern'; then
    block "Reason shown to Claude"
fi
```

### Coverage threshold
Search for `80%` across `.claude/commands/` and `.claude/agents/` to update the threshold.

### Design system
Edit `.claude/docs/design-system.md` — update the color token table, typography scale, and spacing scale to match your project's actual values after running `npx shadcn@latest init`.

---

## Setup Checklist

Copy this into your project's first task or keep it handy:

**`CLAUDE.md`**
- [ ] Project name and description
- [ ] Type, status, and repo URL
- [ ] Run commands (install, dev, test, coverage)
- [ ] Current focus / active sprint
- [ ] Known gotchas
- [ ] Off-limits rules

**`.claude/docs/architecture.md`**
- [ ] Tech stack table
- [ ] Directory structure
- [ ] Architectural boundaries

**`.claude/docs/conventions.md`**
- [ ] Naming conventions (or confirm defaults apply)
- [ ] Error handling pattern
- [ ] Environment variables table

**`.claude/docs/design-system.md`**
- [ ] Component library confirmed (shadcn/ui or alternative)
- [ ] Color tokens (from `npx shadcn@latest init`)
- [ ] Font family
- [ ] Default border radius
- [ ] Sidebar width / page max-width
