#!/usr/bin/env bash
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"

BACKUP="$SRC/backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP/agents" "$BACKUP/scripts"
mkdir -p "$DEST/agents" "$DEST/scripts"

FILES="settings.json keybindings.json CLAUDE.md statusline-command.sh"
NESTED="agents/code-reviewer.md scripts/fix-mcp-gate.sh"

for f in $FILES $NESTED; do
  [ -f "$DEST/$f" ] && cp "$DEST/$f" "$BACKUP/$f"
  cp "$SRC/$f" "$DEST/$f"
  echo "  $f"
done

echo "Backup saved to $BACKUP"
echo "Done. Files deployed to $DEST"
