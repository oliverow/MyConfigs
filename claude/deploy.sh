#!/usr/bin/env bash
# Deploy: copies files FROM this repo TO ~/.claude
# Update: copies files FROM ~/.claude TO this repo (reverse direction)
#
# Tracked files (keep in sync with FILES and NESTED below):
#   settings.json  keybindings.json  CLAUDE.md  statusline-command.sh
#   agents/code-reviewer.md  agents/researcher-analyst.md
#   agents/paper-outliner.md  agents/paper-plotter.md  agents/paper-lit-reviewer.md
#   agents/paper-writer.md  agents/paper-reviewer.md
#   scripts/fix-mcp-gate.sh  scripts/claude-notify.sh  scripts/ntfy-notify.sh
#   skills/gpu-management/SKILL.md  skills/notion-task/SKILL.md  skills/update-context/SKILL.md
#   skills/paper-pipeline/SKILL.md
#   commands/devlog.md  commands/propose-commit.md  commands/queue-notify.md  commands/wrapup.md  commands/braindump.md
#   commands/file-session.md  commands/log-progress.md  commands/write-paper.md
#   .claude/commands/commit-setup.md
#
# To update this repo after editing ~/.claude:
#   cp ~/.claude/{settings.json,keybindings.json,CLAUDE.md,statusline-command.sh} ~/.myconfig/claude/
#   cp ~/.claude/agents/{code-reviewer.md,researcher-analyst.md,paper-outliner.md,paper-plotter.md,paper-lit-reviewer.md,paper-writer.md,paper-reviewer.md} ~/.myconfig/claude/agents/
#   cp ~/.claude/scripts/{fix-mcp-gate.sh,claude-notify.sh,ntfy-notify.sh} ~/.myconfig/claude/scripts/
#   cp ~/.claude/skills/gpu-management/SKILL.md ~/.myconfig/claude/skills/gpu-management/
#   cp ~/.claude/skills/notion-task/SKILL.md ~/.myconfig/claude/skills/notion-task/
#   cp ~/.claude/skills/update-context/SKILL.md ~/.myconfig/claude/skills/update-context/
#   cp ~/.claude/skills/paper-pipeline/SKILL.md ~/.myconfig/claude/skills/paper-pipeline/
#   cp ~/.claude/commands/{devlog.md,propose-commit.md,queue-notify.md,wrapup.md,braindump.md,file-session.md,log-progress.md,write-paper.md} ~/.myconfig/claude/commands/
#   cp ~/.claude/.claude/commands/commit-setup.md ~/.myconfig/claude/.claude/commands/
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"

BACKUP="$SRC/backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP/agents" "$BACKUP/scripts" "$BACKUP/skills/gpu-management" "$BACKUP/skills/notion-task" "$BACKUP/skills/update-context" "$BACKUP/skills/paper-pipeline" "$BACKUP/commands" "$BACKUP/.claude/commands"
mkdir -p "$DEST/agents" "$DEST/scripts" "$DEST/skills/gpu-management" "$DEST/skills/notion-task" "$DEST/skills/update-context" "$DEST/skills/paper-pipeline" "$DEST/commands" "$DEST/.claude/commands"

FILES="settings.json keybindings.json CLAUDE.md statusline-command.sh"
NESTED="agents/code-reviewer.md agents/researcher-analyst.md agents/paper-outliner.md agents/paper-plotter.md agents/paper-lit-reviewer.md agents/paper-writer.md agents/paper-reviewer.md scripts/fix-mcp-gate.sh scripts/claude-notify.sh scripts/ntfy-notify.sh skills/gpu-management/SKILL.md skills/notion-task/SKILL.md skills/update-context/SKILL.md skills/paper-pipeline/SKILL.md commands/devlog.md commands/propose-commit.md commands/queue-notify.md commands/wrapup.md commands/braindump.md commands/file-session.md commands/log-progress.md commands/write-paper.md .claude/commands/commit-setup.md"

for f in $FILES $NESTED; do
  [ -f "$DEST/$f" ] && cp "$DEST/$f" "$BACKUP/$f"
  cp "$SRC/$f" "$DEST/$f"
  echo "  $f"
done

echo "Backup saved to $BACKUP"
echo "Done. Files deployed to $DEST"
