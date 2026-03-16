---
name: notion-task
description: "Use when: executing a task from Notion, the user mentions a \"task\" (likely means Notion task), the user asks to add/create a task, or when working with Notion task databases. Handles task creation, status updates, progress logging, and completion workflow."
user-invocable: false
---

# Notion Task Workflow

## Creating a New Task

When the user asks to add a task to Notion:

1. **Don't write it as-is.** The user's description is usually a rough sketch.
2. **Ask all clarifying questions upfront** — context, scope, constraints, edge cases, acceptance criteria. Get everything needed to write a complete spec.
3. Expand into a professional design doc with:
   - **Context/Problem** — why this task exists
   - **Requirements** — explicit, atomic, verifiable items
   - **Deliverables** — concrete outputs with acceptance criteria
   - **Constraints/Decisions** — known tradeoffs, chosen approaches
4. Make it decision-dense. No vague bullets. Every requirement should be testable.

## When Starting a Notion Task

1. Update the task status to **"In Progress"**

## During Execution — Progress Logging

As you work on the task, log progress on the Notion task whenever a lifecycle event occurs:

- Encountered a blocker or unexpected issue
- Proposed a solution or workaround
- Discussed alternatives with the user
- Changed approach

Log each event as a high-level summary on the task (e.g., "Attempted A, hit B issue, discussed C with user, pivoting to D"). Keep it concise but traceable — someone reading the task later should understand the journey.

## When Completing a Notion Task

1. Update the task status to **"Verify"** (never "Done")
2. Add a comment summarizing what was done

## Project Tracker Updates

Projects on Notion have a **Progress Tracker** — a concise ramp-up dashboard with a priority stack, research directions database, and decision log. When updating a Notion task, assess whether the change shifts the project narrative.

**Update the tracker when something changes the story:**
- Surprising or unexpected results that challenge assumptions
- A direction was invalidated or a new one emerged
- A key decision or pivot was made
- A blocker was hit or resolved
- Priorities need reordering based on new information

**Do NOT update the tracker when:** results are as expected, routine progress doesn't change the project-level picture, or work is incremental within an established direction.

**How to update:**
- Keep the priority stack concise — update status and next steps, don't expand prose
- Add Decision Log entries for pivots, key results, insights, and dead ends
- Update Research Directions database status and "Next Step" field
- If a priority was resolved, remove or demote it; if a new one emerged, slot it in

## Finding the Right Page

- Many projects have a Notion page (often stored in project memory). If unsure which one, ask the user.
- When you find a project's Notion page for the first time, bookmark it in the project-level CLAUDE.md for future reference.
