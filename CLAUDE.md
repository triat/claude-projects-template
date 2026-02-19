# [PROJECT_NAME]

> [One-sentence description of what this project does and who it's for]

**Type**: [REST API / Full-stack web app / CLI tool]
**Status**: [MVP / Active development / Production]
**Repo**: [GitHub URL]

See @.claude/docs/architecture.md for stack, structure, and boundaries.
See @.claude/docs/conventions.md for naming, error handling, testing, and security rules.

---

## Commands

| Task                   | Command               |
| ---------------------- | --------------------- |
| Start session          | `/init`               |
| New feature            | `/feature [NNN]`      |
| Plan only (no code)    | `/plan [description]` |
| Debug an issue         | `/debug [issue]`      |
| Review current changes | `/review`             |
| Run tests + coverage   | `/test`               |
| Commit                 | `/commit`             |

Always run `/init` at the start of every session.
Always run `/plan` before `/feature` — never start implementation without a task file.

---

## Running the Project

```bash
# Install dependencies
[command]

# Start dev server
[command]

# Run tests
[command]

# Check coverage
[command]
```

---

## Current Focus

**Phase**: [e.g., MVP v1 / Sprint 3 / Hardening]

- [ ] [Active task]
- [ ] [Active task]

---

## Known Gotchas

- [e.g., Auth middleware MUST come before rate limiter — reversing causes auth bypass]
- [e.g., Migrations do NOT run automatically — run `npm run migrate` after pulling]
- [e.g., Tests require a local DB — see `docker-compose.test.yml`]

---

## Off Limits

Do NOT do these unless explicitly asked:

- Modify the database schema directly (always use migrations)
- Push to `main` or `master` directly
- Change authentication logic without a security review
- Add new dependencies without checking the existing stack first

---

## Context Management

When compacting, always preserve:
- The active task ID and its current phase (e.g., "003-add-csv-export, GREEN phase")
- The list of files modified in this session
- Any failing test names or error messages
- The current branch name
