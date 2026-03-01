#!/usr/bin/env bash
# Deploy: copies files FROM this repo TO ~/.claude
# Update: copies files FROM ~/.claude TO this repo (reverse direction)
#
# Tracked files (keep in sync with FILES and NESTED below):
#   settings.json  keybindings.json  CLAUDE.md  statusline-command.sh
#   agents/code-reviewer.md
#   scripts/fix-mcp-gate.sh  scripts/claude-notify.sh
#   skills/gpu-management/SKILL.md  skills/notion-task/SKILL.md
#   commands/devlog.md  commands/commit.md
#
# To update this repo after editing ~/.claude:
#   cp ~/.claude/{settings.json,keybindings.json,CLAUDE.md,statusline-command.sh} ~/.myconfig/claude/
#   cp ~/.claude/agents/code-reviewer.md ~/.myconfig/claude/agents/
#   cp ~/.claude/scripts/{fix-mcp-gate.sh,claude-notify.sh} ~/.myconfig/claude/scripts/
#   cp ~/.claude/skills/gpu-management/SKILL.md ~/.myconfig/claude/skills/gpu-management/
#   cp ~/.claude/skills/notion-task/SKILL.md ~/.myconfig/claude/skills/notion-task/
#   cp ~/.claude/commands/{devlog.md,commit.md} ~/.myconfig/claude/commands/
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"

BACKUP="$SRC/backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP/agents" "$BACKUP/scripts" "$BACKUP/skills/gpu-management" "$BACKUP/skills/notion-task" "$BACKUP/commands"
mkdir -p "$DEST/agents" "$DEST/scripts" "$DEST/skills/gpu-management" "$DEST/skills/notion-task" "$DEST/commands"

FILES="settings.json keybindings.json CLAUDE.md statusline-command.sh"
NESTED="agents/code-reviewer.md scripts/fix-mcp-gate.sh scripts/claude-notify.sh skills/gpu-management/SKILL.md skills/notion-task/SKILL.md commands/devlog.md commands/commit.md"

for f in $FILES $NESTED; do
  [ -f "$DEST/$f" ] && cp "$DEST/$f" "$BACKUP/$f"
  cp "$SRC/$f" "$DEST/$f"
  echo "  $f"
done

echo "Backup saved to $BACKUP"
echo "Done. Files deployed to $DEST"
