# Claude Code Project Template

A batteries-included template for Claude Code that solves the four most common pain points:

| Pain point             | Solution                                      |
|------------------------|-----------------------------------------------|
| Context gets lost      | `CLAUDE.md` + `/init` session ritual          |
| Too much back-and-forth| Pre-built command workflows (`/feature`, etc) |
| Quality inconsistency  | 8 specialized sub-agents with strict formats  |
| No clear workflow      | Enforced TDD + review + commit pipeline       |

---

## How to Use This Template

### For a new project

```bash
# Copy the template into your project
cp -r /path/to/claude-project-template/.claude /your/new/project/
cp /path/to/claude-project-template/CLAUDE.md /your/new/project/

# Fill in CLAUDE.md
# Search for all placeholders: [REPLACE_ME] / [e.g. ...] / [description]
```

### After copying

1. **Fill in `CLAUDE.md`** — replace all placeholder values with your project's real details
2. **Set your stack's test command** in the `/test` and `/feature` commands if different from `npm test`
3. **Open Claude Code** in your project root
4. Run `/init` to start your first session

---

## Structure

```
.
├── CLAUDE.md                      # Project context — fill this in per project
└── .claude/
    ├── settings.json              # Permissions (pre-allowed safe tools) + hooks
    ├── agents/                    # Sub-agents (invoked by commands or explicitly)
    │   ├── planner.md             # Creates implementation plans
    │   ├── architect.md           # ADRs and architecture decisions
    │   ├── tdd-guide.md           # Enforces write-tests-first
    │   ├── code-reviewer.md       # Post-implementation review
    │   ├── security-reviewer.md   # Security audit before commits
    │   ├── build-error-resolver.md# Systematic build failure analysis
    │   ├── debugger.md            # Root-cause debugging methodology
    │   └── refactor-cleaner.md    # Safe refactoring without behavior change
    ├── commands/                  # Custom slash commands
    │   ├── init.md                # /init  — session startup ritual
    │   ├── feature.md             # /feature — full TDD feature workflow
    │   ├── plan.md                # /plan  — planning only, no implementation
    │   ├── debug.md               # /debug — systematic bug investigation
    │   ├── review.md              # /review — code + security review
    │   ├── test.md                # /test  — run tests + coverage check
    │   └── commit.md              # /commit — safe conventional commit
    └── hooks/
        ├── post-edit-format.sh    # Auto-formats files after every Write/Edit
        └── pre-bash-guard.sh      # Blocks dangerous shell commands
```

---

## Commands Reference

| Command              | What it does                                                   |
|----------------------|----------------------------------------------------------------|
| `/init`              | Re-reads CLAUDE.md, checks git state, orients the session     |
| `/feature [name]`    | Full TDD cycle: plan → test → implement → review → commit      |
| `/plan [description]`| Planning only — explores codebase, produces plan, waits       |
| `/debug [issue]`     | Systematic root-cause analysis and fix                        |
| `/review`            | Code review + optional security review of current changes     |
| `/test`              | Runs tests, checks coverage against 80% threshold             |
| `/commit`            | Pre-commit checks, conventional commit message, safety guards |

---

## Agents Reference

Agents are invoked automatically by commands or you can invoke them directly:

> "Use the security-reviewer agent to audit the auth changes"

| Agent                  | When to use                                                |
|------------------------|------------------------------------------------------------|
| `planner`              | Before writing any code for a non-trivial feature          |
| `architect`            | When choosing between fundamentally different approaches   |
| `tdd-guide`            | When you need to enforce the RED-GREEN-REFACTOR cycle      |
| `code-reviewer`        | After implementing a feature, before committing            |
| `security-reviewer`    | Before committing anything touching auth, input, or APIs   |
| `build-error-resolver` | When the build or tests are broken                         |
| `debugger`             | When a bug's root cause is unclear                         |
| `refactor-cleaner`     | When cleaning up code without changing behavior            |

---

## Hooks

### `post-edit-format.sh`
Automatically runs the appropriate formatter after every file write or edit:
- TypeScript/JS → Prettier + ESLint
- Python → black + isort + ruff
- Go → gofmt + goimports
- Rust → rustfmt

Formatters are only invoked if installed — nothing breaks if they aren't.

### `pre-bash-guard.sh`
Blocks dangerous commands before they execute:
- `rm -rf /`, `rm -rf ~`, `rm -rf *`
- Force-pushing to `main`/`master`
- `git reset --hard`
- Destructive SQL (`DROP DATABASE`, `DROP TABLE`, `TRUNCATE`)
- `chmod 777`
- `git commit --no-verify`

---

## Customizing for Your Stack

### Change the test command
Edit `.claude/commands/test.md` and `.claude/commands/feature.md` to replace `npm test` with your stack's command.

### Add more allowed commands to `settings.json`
Add entries to the `permissions.allow` array. Use glob patterns: `"Bash(docker*)"`

### Add project-specific guards to `pre-bash-guard.sh`
Follow the pattern at the bottom of the file — add a `grep -qE` check and call `block "reason"`.

### Adjust coverage thresholds
Search for `80%` across the commands and agents if your project needs a different threshold.

---

## CLAUDE.md Checklist

When filling in `CLAUDE.md` for a new project, make sure you've covered:

- [ ] Project name and one-sentence description
- [ ] Tech stack table (all layers)
- [ ] Architecture overview and diagram
- [ ] Architectural boundaries (what goes where)
- [ ] How to run the project locally
- [ ] All required environment variables
- [ ] Naming conventions
- [ ] Error handling conventions
- [ ] Testing conventions
- [ ] Current sprint focus
- [ ] Known gotchas
- [ ] What Claude should NOT do in this project
