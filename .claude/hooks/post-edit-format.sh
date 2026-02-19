#!/usr/bin/env bash
# post-edit-format.sh
#
# Runs after every Write or Edit tool call.
# Reads the file path from stdin (JSON tool input) and auto-formats it
# using the appropriate formatter for the file type.
#
# Formatters are only run if they are installed — this script never fails
# hard, so a missing formatter just means no formatting for that type.

set -euo pipefail

# Parse file_path from the JSON tool input on stdin
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('tool_input', {}).get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

# Nothing to format
if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

EXT="${FILE_PATH##*.}"

case "$EXT" in
    ts|tsx)
        if command -v npx &>/dev/null; then
            npx --no-install prettier --write "$FILE_PATH" 2>/dev/null || true
            npx --no-install eslint --fix --quiet "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    js|jsx|mjs|cjs)
        if command -v npx &>/dev/null; then
            npx --no-install prettier --write "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    py)
        if command -v black &>/dev/null; then
            black --quiet "$FILE_PATH" 2>/dev/null || true
        fi
        if command -v isort &>/dev/null; then
            isort --quiet "$FILE_PATH" 2>/dev/null || true
        fi
        if command -v ruff &>/dev/null; then
            ruff check --fix --quiet "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    go)
        if command -v gofmt &>/dev/null; then
            gofmt -w "$FILE_PATH" 2>/dev/null || true
        fi
        if command -v goimports &>/dev/null; then
            goimports -w "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    rs)
        if command -v rustfmt &>/dev/null; then
            rustfmt "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    json)
        if command -v npx &>/dev/null; then
            npx --no-install prettier --write "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    md|mdx)
        if command -v npx &>/dev/null; then
            npx --no-install prettier --write "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    css|scss|sass)
        if command -v npx &>/dev/null; then
            npx --no-install prettier --write "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    yaml|yml)
        if command -v npx &>/dev/null; then
            npx --no-install prettier --write "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
esac

exit 0
