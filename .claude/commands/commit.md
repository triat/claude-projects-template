# Smart Commit

Create a clean, conventional commit for all staged/unstaged changes. Run with: `/commit`

## Steps

1. **Run a pre-commit check**
   ```bash
   git status
   git diff --staged
   git diff
   ```

2. **Verify tests pass** — never commit broken code
   ```bash
   npm test   # or equivalent for your stack
   ```
   If tests fail, stop. Fix them first.

3. **Run a security spot-check**
   Scan the diff for:
   - Hardcoded secrets, API keys, tokens
   - `.env` files accidentally staged
   - Any obviously sensitive data

   If found: STOP, unstage the file, rotate the secret.

4. **Stage the right files**
   ```bash
   git add [specific files]
   ```
   Never use `git add .` or `git add -A` — always be explicit.

5. **Craft the commit message** using Conventional Commits format:

   ```
   <type>: <short description>

   [optional body with more detail]
   ```

   Types:
   | Type     | Use when                                                  |
   |----------|-----------------------------------------------------------|
   | `feat`   | Adding new functionality                                  |
   | `fix`    | Fixing a bug                                              |
   | `refactor`| Restructuring code without behavior change               |
   | `test`   | Adding or fixing tests                                    |
   | `docs`   | Documentation only                                        |
   | `chore`  | Build, tooling, dependency updates                        |
   | `perf`   | Performance improvement                                   |
   | `ci`     | CI/CD configuration                                       |

   Rules:
   - First line: max 72 characters, imperative mood ("add X", not "added X")
   - Body: explain WHY, not what (the diff shows what)
   - Reference issue numbers if applicable: `Fixes #123`

6. **Create the commit**
   ```bash
   git commit -m "$(cat <<'EOF'
   feat: add user email verification flow

   Sends a verification email on registration and blocks login
   until the email is confirmed. Uses a 24h expiry token.
   EOF
   )"
   ```

7. **Confirm success**
   ```bash
   git log --oneline -3
   ```

## Do NOT

- Commit with message "fix" or "update" or "wip"
- Commit files that contain secrets
- Amend published commits
- Force-push to `main` or `master`
