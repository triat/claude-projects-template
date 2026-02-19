# Conventions

## Naming

- Files: `kebab-case.ts`
- Classes: `PascalCase`
- Functions/variables: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Database tables: `snake_case`

## Error Handling

- All errors extend `AppError` (or equivalent base class)
- API errors return: `{ success: false, data: null, error: "message" }`
- API success returns: `{ success: true, data: {...}, error: null }`
- Log with context (request ID, user ID) — never bare `console.log`

## Testing

- Unit tests: colocated as `*.test.ts` next to source files
- Integration tests: `tests/integration/`
- E2E tests: `tests/e2e/`
- Minimum 80% coverage — lines, branches, functions, statements
- Test behavior, not implementation details
- Tests must be fully independent — no shared mutable state

## Database

- All schema changes require a migration file — no direct schema edits
- Never write raw SQL outside of repository files
- All queries must use parameterized inputs — no string interpolation

## Security

- Validate all user input at the boundary (body, query params, path params)
- Use `[validation library]` for schema validation
- All endpoints require auth unless explicitly marked public
- Rate limiting applied to all public endpoints

## Environment Variables

See `.env.example` for all variables. Required at startup:

| Variable       | Description                          | Default       |
| -------------- | ------------------------------------ | ------------- |
| `DATABASE_URL` | Full connection string for the DB    | —             |
| `JWT_SECRET`   | Secret for signing JWTs              | —             |
| `PORT`         | Port for the HTTP server             | `3000`        |
| `NODE_ENV`     | Environment (development/production) | `development` |

The app **must** validate all required env vars at startup and fail fast if any are missing.
