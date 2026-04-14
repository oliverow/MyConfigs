---
description: Log session progress — update carry-forward, Notion tasks, journal, and scheduled items
allowed-tools: [Read, Write, Edit, Glob, Grep, Bash(date*), mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page]
---

# Log Progress

Lightweight mid-session checkpoint. Scans the current conversation for what was accomplished and updates all tracking systems.

**Vault root**: `~/agent_brain`

## Usage

```
/log-progress                    # auto-detect progress from conversation
/log-progress "fixed viz bug"    # provide a summary hint
```

## Step 1: Scan Conversation for Progress

Identify what was accomplished in this session:
- Tasks worked on (from carry-forward, Notion, or ad-hoc)
- Bugs fixed, features implemented, experiments run
- Decisions made, blockers hit or resolved
- Items completed, partially done, or newly discovered

If `$ARGUMENTS` provides a hint, use it to focus the scan.

## Step 2: Update Carry-Forward

Read `~/agent_brain/00-inbox/_carry-forward.md`.

For each carry-forward item that was addressed in this session:
- **Completed**: Remove from carry-forward
- **Partially done**: Add a progress note with today's date
- **Blocked**: Add blocker description

Do NOT add new items to carry-forward here — that's the EOD reviewer's job.

## Step 3: Update Notion Tasks

For each Notion task that was worked on:
- Update status (e.g., "In Progress" → "Done", or add progress note)
- Use the CV Cue + Frame Bias task database: `collection://1fc69209-450f-4da4-b851-0e225454c2d6`
- Project pages:
  - CV Cue: `https://www.notion.so/2ed0cdfe512680bca2a8cfc0d1d3f952`
  - Frame Bias: `https://www.notion.so/2640cdfe512680949d71ea73268d582d`

If no Notion tasks were relevant, skip this step.

## Step 4: Update Today's Journal

**4am rule**: A new day starts at 4:00 AM, not midnight. If the current time is before 4:00 AM, the session belongs to the *previous* calendar day's journal. For example, work at 2:30 AM on Apr 9 goes into `2026-04-08.md`.

Read or create `~/agent_brain/01-journal/daily/{effective_date}.md`.

Append a progress entry under a `### Session Log` section (create if it doesn't exist, append if it does):

```markdown
### Session Log

**{HH:MM}** — {1-2 sentence summary of what was done}
- {bullet points of specific accomplishments}
- {any decisions made or blockers encountered}
```

Use `[[wiki-links]]` when referencing projects, people, ideas, and knowledge notes.

## Step 5: Update Scheduled Items

Read `~/agent_brain/_scheduled.md`.

If any scheduled items for today were addressed in this session, check them off (`- [x]`).

## Step 6: Report

Tell the user what was updated:
- Carry-forward items resolved/updated
- Notion tasks updated
- Journal entry appended
- Scheduled items checked off
