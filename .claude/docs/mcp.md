# MCP Servers

MCP (Model Context Protocol) servers give Claude native access to external tools — GitHub, your database, and the web — without workarounds or manual copy-pasting.

All three servers are declared in `.mcp.json` at the project root and enabled via `.claude/settings.json`. See setup notes below.

---

## GitHub

**Package**: `@modelcontextprotocol/server-github`
**Required env var**: `GITHUB_PERSONAL_ACCESS_TOKEN`

Create a token at https://github.com/settings/tokens with scopes: `repo`, `read:org`, `read:user`.

### What it unlocks

| Tool | Used by | When |
|------|---------|------|
| `list_issues` / `get_issue` | planner | Reading the issue being implemented before planning |
| `search_issues` | planner, debugger | Finding related issues or bug reports |
| `create_pull_request` | /commit workflow | Opening the PR after committing |
| `list_pull_requests` / `get_pull_request` | /review | Reading PR context and existing comments |
| `add_issue_comment` | debugger | Posting a comment when a fix is pushed |
| `create_issue` | any agent | Filing a bug found during review |
| `search_code` | planner, debugger | Searching across the repo beyond local files |

### Example prompts

```
/plan implement the feature described in issue #42
```
Claude reads the issue, its comments, and any linked PRs before producing the plan.

```
/commit
```
After committing, Claude opens the PR with a description derived from the task file.

```
/debug users can't log in after password reset — see issue #87
```
Claude reads the issue, the comments, and the linked code before forming hypotheses.

---

## Database (PostgreSQL)

**Package**: `@modelcontextprotocol/server-postgres`
**Connection string**: set directly in `.claude/settings.json` (see setup)

> ⚠️ The database MCP provides **read-only** access. It cannot INSERT, UPDATE, DELETE, or DROP. Safe to use in development.

### What it unlocks

| Tool | Used by | When |
|------|---------|------|
| `query` | debugger | Inspecting live data to understand a bug |
| `query` | planner | Checking actual schema before planning migrations |
| `query` | build-error-resolver | Verifying DB state when tests fail unexpectedly |

### Example prompts

```
/debug orders are missing from the dashboard for user ID 1042
```
Claude queries `SELECT * FROM orders WHERE user_id = 1042` directly to inspect the actual data state.

```
/plan add soft delete to the products table
```
Claude checks the real schema before planning — no schema file drift, no assumptions.

### Setup note

Replace `REPLACE_WITH_YOUR_DATABASE_URL` in `.mcp.json` with your actual dev database URL.
Use your **development** database only — never point this at production.

For MySQL/SQLite, replace the package:
- MySQL: `@modelcontextprotocol/server-mysql`
- SQLite: `@modelcontextprotocol/server-sqlite`

---

## Fetch

**Package**: `@modelcontextprotocol/server-fetch`
**No credentials required.**

### What it unlocks

| Tool | Used by | When |
|------|---------|------|
| `fetch` | build-error-resolver | Fetching error message explanations from docs |
| `fetch` | security-reviewer | Checking NVD/OSV for CVE details |
| `fetch` | planner | Reading API documentation for third-party integrations |
| `fetch` | any agent | Fetching a library's changelog before upgrading |

### Example prompts

```
/debug getting "ECONNRESET" errors from the Redis client
```
Claude fetches the ioredis documentation for ECONNRESET to understand the exact cause before touching code.

```
use the security-reviewer to check if express 4.18.1 has known CVEs
```
Claude fetches https://osv.dev to check advisories without leaving the session.

---

## Setup Checklist

- [ ] `GITHUB_PERSONAL_ACCESS_TOKEN` set in your shell environment (`.zshrc` / `.bashrc`)
- [ ] Database URL replaced in `.claude/settings.json` (dev DB only)
- [ ] Verify servers start: run `claude mcp list` in the project root
- [ ] Test GitHub: ask Claude "list the open issues in this repo"
- [ ] Test DB: ask Claude "describe the tables in the database"
- [ ] Test Fetch: ask Claude "fetch https://httpbin.org/get and show me the response"
