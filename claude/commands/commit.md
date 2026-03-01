---
description: Review pending changes and propose a commit for approval
allowed-tools: [Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*), Read, Glob, Grep]
---

# Commit Review

## Context

- Working tree status: !`git status`
- Staged changes: !`git diff --cached --stat`
- Unstaged changes: !`git diff --stat`
- Full diff (staged + unstaged): !`git diff HEAD`
- Recent commits for style reference: !`git log --oneline -10`
- Current branch: !`git branch --show-current`

## Instructions

Review the pending changes and prepare a commit proposal for user approval.

### Step 1: Analyze Changes

- Identify what files were changed and why
- Group related changes together
- Flag any files that look unrelated to the current work (e.g., unintended changes, debug artifacts)
- Flag any files that should NOT be committed (secrets, local config, build artifacts)

### Step 2: Propose Commit

Present a clear summary:

```
Branch: <branch>

Files to stage:
  - path/to/file1.py (reason)
  - path/to/file2.py (reason)

Excluded (if any):
  - path/to/unrelated.py (reason for exclusion)

Proposed message:
  <commit message>
```

The commit message should:
- Be concise (1-2 sentences)
- Focus on the "why" not the "what"
- Follow the style of recent commits in the repo

### Step 3: Wait for Confirmation

Ask the user to confirm, modify, or reject before executing. Do NOT commit without explicit approval.

When approved, stage the agreed files and commit.
