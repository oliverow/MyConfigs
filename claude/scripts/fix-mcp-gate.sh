#!/bin/bash
set -euo pipefail
CLAUDE_JSON="$HOME/.claude.json"
if [ -f "$CLAUDE_JSON" ] && command -v jq &>/dev/null; then
    tmp=$(mktemp)
    jq '.cachedGrowthBookFeatures.tengu_claudeai_mcp_connectors = true' \
        "$CLAUDE_JSON" > "$tmp" && mv "$tmp" "$CLAUDE_JSON"
fi
exit 0