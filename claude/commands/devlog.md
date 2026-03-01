---
description: Append an entry to the project devlog
allowed-tools: [Read, Edit, Write, Glob]
---

# Devlog Entry

## Context

- Current project devlog: !`cat .claude/DEVLOG.md 2>/dev/null || echo "(no devlog yet)"`
- Today's date: !`date +%Y-%m-%d`

## Instructions

Append an entry to the project-level `.claude/DEVLOG.md` under the appropriate section.

Only log information useful to look back on later. If nothing is worth logging, say so and do nothing.

### Sections

- **Bugs Fixed** — root cause + fix
- **Decisions** — chosen approach + alternatives rejected
- **Design Choices** — pattern + rationale

### Format

`[YYYY-MM-DD] **Summary** — details`

Keep entries concise. Create the file with section headers if it doesn't exist.
