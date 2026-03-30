---
description: Propose a commit and update all context sources (Notion, devlog, memory, CLAUDE.md)
allowed-tools: [Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*), Read, Glob, Grep, Skill, Agent]
---

# Wrapup

Run the following two skills in sequence:

1. **`/propose-commit`** — Review pending changes and propose a commit for user approval. Do NOT proceed to step 2 until the user has approved and the commit is done.

2. **`/update-context`** — Update all context sources (Notion, devlog, memory, CLAUDE.md) with what was accomplished.
