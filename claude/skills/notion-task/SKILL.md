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

Log each event as a **comment** on the task (e.g., "Attempted A, hit B issue, discussed C with user, pivoting to D"). Comments have a built-in timeline, making them ideal for intermediate progress. Keep it concise but traceable.

**Important:** Do not update the task's main content with temporary progress or intermediate checkpoints. The main content should only contain conclusive information — final results, decisions, and specs. Use comments for everything in-progress.

When logging experiment results (e.g., accuracy, metrics), always format as a **table** for easy comparison.

## When Completing a Notion Task

1. Update the task status to **"Verify"** (never "Done")
2. **Update the page content** with results, findings, and conclusions — append a "## Results" section (or fill in the deliverables section if one exists). The page body is the permanent record; anyone reading the task later should find the outcomes inline, not have to dig through comments.
3. Add a brief comment noting completion (e.g., "Results added, moving to Verify") — comments are for status updates and discussion, not for housing results.

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

## Global Experiment Tracker

- Some projects have a global/master experiment tracker. Check if the project page has one. 
- When you complete formal experiments or ablations, update the global tracker with results for later paper writing. 
- Do not update the global tracker with quick probes or informal experiments — only well-defined experiments with clear results that would support a paper section or figure.

## Output After Edits

After every Notion page creation or modification, always output the **name/title** and **Notion link** of the page you just created or edited (e.g., "Updated: [Task Name](notion-url)"). This applies to tasks, tracker pages, experiment trackers, and any other Notion page.

## Finding the Right Page

- Many projects have a Notion page (often stored in project memory). If unsure which one, ask the user.
- When you find a project's Notion page for the first time, bookmark it in the project-level CLAUDE.md for future reference.
