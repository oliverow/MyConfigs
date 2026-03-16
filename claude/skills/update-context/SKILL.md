---
name: update-context
description: "Update all context sources (Notion, devlog, memory, CLAUDE.md) after milestones. Use when: completing a task, fixing a bug, making a design decision, changing approach, hitting/resolving a blocker, encountering surprising results, or when the user invokes /update-context."
user-invocable: true
---

# Update Context

Ensure all context sources are up-to-date after changes. Run through each source below and update what's relevant. Skip sources that have nothing new to record.

## Context Sources

### 1. Notion Task
If a Notion task is active for the current work:
- Update **status** (In Progress, Verify, etc.)
- Log **progress** — blockers, decisions, approach changes, surprising results
- On completion, add a **summary comment** and set status to "Verify"
- Assess whether changes shift the project narrative — if so, update the **project tracker** (see `notion-task` skill, "Project Tracker Updates" section)

### 2. Devlog
If any of these occurred, invoke `/devlog`:
- Bug fixed (root cause + fix)
- Design decision made (chosen approach + rejected alternatives)
- Surprising or unexpected result encountered (what happened + why)

### 3. Claude Memory
Save memories when you learned something worth recalling in future sessions:
- **user** — new info about the user's role, preferences, expertise
- **feedback** — corrections or guidance the user gave
- **project** — ongoing work context, deadlines, decisions, stakeholder info
- **reference** — pointers to external resources (Notion pages, dashboards, docs)

Do not duplicate existing memories. Check before writing.

### 4. Project CLAUDE.md
Update the **project-level** CLAUDE.md if:
- A Notion page was discovered for the first time (bookmark it)
- A new convention or pattern was established that future sessions need

Do NOT update for ephemeral information. Only persist durable project knowledge.

### 5. Active Plan
If a plan exists in the current session:
- Mark completed steps as done
- Note any deviations or scope changes

## Auto-Trigger Milestones

Invoke this skill automatically (without user prompting) when any of these occur:

- Task completed or moved to verify
- Feature branch finished (pre-commit or pre-PR)
- Bug fixed and verified
- Significant design decision made
- Approach changed mid-task
- Blocker encountered or resolved
- Surprising or unexpected results encountered

## Behavior

- Run through all 5 sources in order. For each, assess whether there's something new to record.
- If nothing changed for a source, skip it silently.
- When auto-triggered, briefly tell the user what you're updating and why (e.g., "Updating context — bug fix verified").
- When manually invoked, report what was updated and what was skipped.
