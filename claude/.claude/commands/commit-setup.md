---
description: Sync ~/.claude settings to ~/.myconfig/claude repo and commit
allowed-tools: [Bash(cp:*), Bash(cd:*), Bash(git:*), Bash(mkdir:*), Bash(ls:*), Bash(diff:*), Bash(cat:*), Read]
---

# Sync Claude Config

## Context

First, read the deploy script and check repo status:
1. Read `~/.myconfig/claude/deploy.sh` (source of truth for tracked files)
2. Run `git -C ~/.myconfig status --short` to see current repo status

## Instructions

Sync tracked Claude config files from `~/.claude` to `~/.myconfig/claude` and commit.

### Step 1: Copy files

Read the `FILES` and `NESTED` lists from `deploy.sh` to determine which files to sync. Copy each from `~/.claude` to `~/.myconfig/claude`, creating directories as needed. Also sync any new files that exist in `~/.claude` matching the tracked patterns (skills, commands, agents, scripts) but aren't yet in deploy.sh.

### Step 2: Check for new files

If new files were found that aren't in deploy.sh, update deploy.sh to include them (add to NESTED list, update the mkdir and comment block).

### Step 3: Diff and confirm

Show the user `git diff` in `~/.myconfig` so they can review what changed. Ask for confirmation before committing.

### Step 4: Commit

Stage changed files and commit with a concise message describing what changed. Do NOT push unless the user asks.
