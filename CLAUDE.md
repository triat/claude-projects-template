# [PROJECT_NAME]

> [One-sentence description of what this project does and who it's for]

---

## Project Overview

| Field       | Value                                                  |
| ----------- | ------------------------------------------------------ |
| **Type**    | [REST API / Full-stack web app / CLI tool / Library]   |
| **Status**  | [MVP / Active development / Maintenance / Production]  |
| **Goal**    | [What problem does this solve? Who uses it?]           |
| **Repo**    | [GitHub URL]                                           |

---

## Tech Stack

| Layer       | Technology                         | Version   |
| ----------- | ---------------------------------- | --------- |
| Runtime     | [Node.js / Python / Go / Other]    | [x.x.x]   |
| Framework   | [Express / FastAPI / Gin / Other]  | [x.x.x]   |
| Database    | [PostgreSQL / MongoDB / SQLite]    | [x.x.x]   |
| ORM / ODM   | [Prisma / SQLAlchemy / GORM]       | [x.x.x]   |
| Frontend    | [React / Vue / Next.js / None]     | [x.x.x]   |
| Auth        | [JWT / OAuth2 / Session / API Key] | —         |
| Testing     | [Jest / pytest / Go test / Vitest] | [x.x.x]   |
| CI/CD       | [GitHub Actions / GitLab CI]       | —         |

---

## Architecture

[Brief description — e.g., "Monolithic REST API with a React SPA, PostgreSQL for persistence, Redis for caching."]

```
src/
├── [describe your top-level structure here]
│   ├── [subdirectory — purpose]
│   └── [subdirectory — purpose]
├── [directory — purpose]
└── [directory — purpose]
```

### Architectural Boundaries (enforce strictly)

- [e.g., All DB access goes through `src/repositories/` — never query DB directly in controllers]
- [e.g., Business logic lives in `src/services/` — controllers are thin orchestrators only]
- [e.g., All routes defined in `src/routes/` — no inline route definitions elsewhere]
- [e.g., Shared types/interfaces in `src/types/` — no duplicating type definitions]

---

## Development Workflow

**Global rules apply** (see `~/.claude/rules/`). Project-specific additions:

### Session Start Ritual

Always run `/init` at the start of every session. This re-anchors context.

### Feature Development

```
/feature [feature-name]
```

This enforces: Plan → Test (RED) → Implement (GREEN) → Refactor → Review → Commit.
Do not skip steps. Do not commit without passing the review.

### Bug Fixes

```
/debug [describe the issue]
```

Systematic root-cause analysis before touching code.

### Quick Reference

| Task                  | Command                    |
| --------------------- | -------------------------- |
| Start session         | `/init`                    |
| New feature           | `/feature [name]`          |
| Plan only (no code)   | `/plan [description]`      |
| Debug an issue        | `/debug [issue]`           |
| Review current changes| `/review`                  |
| Run tests + coverage  | `/test`                    |
| Commit                | `/commit`                  |

---

## Running the Project

```bash
# Install dependencies
[command]

# Environment setup
cp .env.example .env
# Fill in required values in .env

# Start dev server
[command]

# Run tests
[command]

# Check coverage
[command]

# Build for production
[command]
```

---

## Environment Variables

See `.env.example` for all variables. Required at startup:

| Variable         | Description                          | Default      |
| ---------------- | ------------------------------------ | ------------ |
| `DATABASE_URL`   | Full connection string for the DB    | —            |
| `JWT_SECRET`     | Secret for signing JWTs              | —            |
| `PORT`           | Port for the HTTP server             | `3000`       |
| `NODE_ENV`       | Environment (development/production) | `development`|

The app **must** validate all required env vars at startup and fail fast if any are missing.

---

## Key Conventions

### Naming

- Files: `kebab-case.ts`
- Classes: `PascalCase`
- Functions/variables: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Database tables: `snake_case`

### Error Handling

- All errors extend `AppError` (or equivalent base class)
- API errors always return: `{ success: false, data: null, error: "message" }`
- API success always returns: `{ success: true, data: {...}, error: null }`
- Log with context (request ID, user ID) — never bare `console.log`

### Testing

- Unit tests: colocated as `*.test.ts` next to source files
- Integration tests: `tests/integration/`
- E2E tests: `tests/e2e/`
- Minimum 80% coverage on all metrics (lines, branches, functions, statements)
- Test behavior, not implementation details
- Every test must be independent — no shared mutable state between tests

### Database

- All schema changes require a migration file — no direct schema edits
- Never write raw SQL outside of repository files
- All queries must use parameterized inputs — no string interpolation

### Security

- Validate all user input at the boundary (request body, query params, path params)
- Use `[validation library]` for schema validation
- All endpoints require auth unless explicitly marked public
- Rate limiting applied to all public endpoints

---

## Decisions & Trade-offs

| Decision   | Choice       | Rationale                                   |
| ---------- | ------------ | ------------------------------------------- |
| [e.g. Auth]| [JWT]        | [Stateless, easy to scale horizontally]     |
| [e.g. DB]  | [PostgreSQL] | [ACID compliance, complex queries needed]   |
| [Add more] | [...]        | [...]                                       |

---

## Current Focus

**Phase / Sprint**: [e.g., MVP v1 / Sprint 3 / Hardening]

**Active work**:
- [ ] [Current task 1]
- [ ] [Current task 2]

**Recently completed**:
- [x] [Task]

**Blocked / Waiting**:
- [ ] [Blocker and reason]

---

## Known Gotchas

- [e.g., The auth middleware MUST come before the rate limiter in the middleware stack — reversing them causes auth bypass]
- [e.g., Migrations do NOT run automatically — always run `npm run migrate` after pulling changes]
- [e.g., Tests require a local PostgreSQL instance — see `docker-compose.test.yml`]
- [e.g., The `POST /upload` endpoint has a 10MB body limit set in the nginx config, not in app code]

---

## Out of Scope

Things Claude should NOT do in this project unless explicitly asked:

- [ ] Modify the database schema directly (always use migrations)
- [ ] Push to `main` or `master` directly
- [ ] Change authentication logic without a security review
- [ ] Add new dependencies without checking for alternatives in the existing stack
- [ ] [Add project-specific constraints]
