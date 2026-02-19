#!/usr/bin/env bash
# pre-bash-guard.sh
#
# Runs before every Bash tool call.
# Checks for patterns that should never be run automatically and blocks them,
# requiring explicit user confirmation.
#
# Exit codes:
#   0 = allow the command to proceed
#   2 = block the command (Claude will see the reason and ask the user)

set -euo pipefail

# Parse the command from the JSON tool input on stdin
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('tool_input', {}).get('command', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

if [ -z "$COMMAND" ]; then
    exit 0
fi

block() {
    local reason="$1"
    # Output a message that Claude will surface to the user
    echo "BLOCKED: $reason" >&2
    echo "Command attempted: $COMMAND" >&2
    exit 2
}

# ─── Destructive file system operations ─────────────────────────────────────

if echo "$COMMAND" | grep -qE 'rm\s+-rf\s+/($|\s)'; then
    block "Refusing 'rm -rf /' — this would destroy the entire filesystem."
fi

if echo "$COMMAND" | grep -qE 'rm\s+-rf\s+~($|\s|/)'; then
    block "Refusing 'rm -rf ~' — this would destroy your home directory."
fi

if echo "$COMMAND" | grep -qE 'rm\s+-rf\s+\*'; then
    block "Refusing 'rm -rf *' — please specify the exact path to delete."
fi

# ─── Force-pushing to protected branches ────────────────────────────────────

if echo "$COMMAND" | grep -qE 'git\s+push\s+(--force|-f)\s+.*\s+(origin\s+)?(main|master)($|\s)'; then
    block "Refusing force-push to main/master. This rewrites public history. Use --force-with-lease on a feature branch instead."
fi

# ─── Hard resets that discard uncommitted work ──────────────────────────────

if echo "$COMMAND" | grep -qE 'git\s+reset\s+--hard'; then
    block "Refusing 'git reset --hard' — this discards uncommitted changes permanently. Use 'git stash' first if you want to keep them."
fi

# ─── Database drop operations ───────────────────────────────────────────────

if echo "$COMMAND" | grep -qiE '(DROP\s+DATABASE|DROP\s+TABLE|TRUNCATE\s+TABLE)' ; then
    block "Refusing destructive SQL operation. Confirm this is intentional and run it manually."
fi

# ─── Dangerous permission changes ───────────────────────────────────────────

if echo "$COMMAND" | grep -qE 'chmod\s+777'; then
    block "Refusing 'chmod 777' — world-writable permissions are a security risk."
fi

# ─── Skip pre-commit hooks ──────────────────────────────────────────────────

if echo "$COMMAND" | grep -qE 'git\s+commit.*--no-verify'; then
    block "Refusing '--no-verify' — skipping pre-commit hooks defeats safety checks. Fix the hook failure instead."
fi

# ─── All clear ──────────────────────────────────────────────────────────────
exit 0
