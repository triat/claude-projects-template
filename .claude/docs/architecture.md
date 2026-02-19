# Architecture

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

## Structure

[Brief description — e.g., "Monolithic REST API with a React SPA, PostgreSQL for persistence."]

```
src/
├── [describe your top-level structure here]
│   ├── [subdirectory — purpose]
│   └── [subdirectory — purpose]
├── [directory — purpose]
└── [directory — purpose]
```

## Boundaries (enforce strictly)

- [e.g., All DB access goes through `src/repositories/` — never query DB directly in controllers]
- [e.g., Business logic lives in `src/services/` — controllers are thin orchestrators only]
- [e.g., All routes defined in `src/routes/` — no inline route definitions elsewhere]
- [e.g., Shared types in `src/types/` — no duplicating type definitions across files]

## Decisions & Trade-offs

| Decision    | Choice       | Rationale                                 |
| ----------- | ------------ | ----------------------------------------- |
| [e.g. Auth] | [JWT]        | [Stateless, easy to scale horizontally]   |
| [e.g. DB]   | [PostgreSQL] | [ACID compliance, complex queries needed] |
