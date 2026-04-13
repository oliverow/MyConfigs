---
description: Append an entry to the project devlog
allowed-tools: [Read, Glob, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page]
---

# Devlog Entry

## Context

- Today's date: !`date +%Y-%m-%d`

## Instructions

Append an entry to the project's **Devlog** page on Notion. Each Notion project page should have a child page called "Devlog".

**Finding the devlog page:**
1. Search Notion for the project name (check CLAUDE.md or memory for the project's Notion page name).
2. Fetch the project page to find the "Devlog" child page.
3. Fetch the Devlog page to get current content.
4. Append the new entry under the appropriate section using `notion-update-page`.

If no Devlog page exists under the project, create one (use `notion-create-pages` with parent = project page ID).

Only log information useful to look back on later. If nothing is worth logging, say so and do nothing.

### Sections

- **Bugs Fixed** — root cause + fix
- **Decisions** — chosen approach + alternatives rejected
- **Design Choices** — pattern + rationale
- **Baselines** — baseline experiment results

### Format

Each entry is a paragraph: `\[YYYY-MM-DD\] **Summary** — details`

Keep entries concise. Append new entries at the top of the relevant section (newest first).
