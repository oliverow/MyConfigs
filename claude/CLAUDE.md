# Must-Follow Preferences

## Communication
**Don't assume. Don't hide confusion. Surface tradeoffs.**
- Be concise. Skip summaries for simple tasks.
- Be critical — flag issues, question assumptions, push back whenever appropriate.

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## Thinking and Planning
- Do not accept my claims without checking. Verify with code, docs, or implementation before making definitive statements.
- Do not accept my plans without scrutiny. Question assumptions, identify edge cases, and consider alternatives before committing, search online for reference if needed.
- In planning mode, ask all necessary clarification questions upfront. Verify your reasoning before committing to a plan.
- Given a task, do not start implementing the first solution that comes to mind. Instead, take a moment to think through the problem, consider multiple approaches, and discuss with me before proceeding with the best course of action.

**Touch only what you must.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## Code Implementation
**Minimum code that solves the problem. Nothing speculative.**
- No features beyond what was asked.
- No abstractions for single-use code.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it. Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.
- Respect existing codebase. Do not reinvent the wheel for every new task. Reuse existing code as much as possible.
- Keep code edits neat and organized. Refactor if necessary to maintain readability.
- Keep code edits minimal and clean. No verbose or redundant code.
- Do not write tests unless explicitly asked.

## Tooling
- Never call `python3` directly and always choose uv instead (e.g., `uv run python` instead of `python`). uv path: `/home/oliver/.local/bin/uv`. When unsure, call tool `/astral:uv` for docs.

## Execution
- Do not compound commands using &&. E.g., if you want to execute `pwd && ls`, run two separate commands `pwd` and then `ls`; don't use `&&`.
- When running on GPU, if none is set for the session, first run `nvidia-smi` to check for available GPUs. Then starting from the highest indexed free GPU to the lowest. When OOM, repeat the availability check and increment the number of GPUs until success. If all are busy, ask me for instructions. Do not occupy more than 6 GPUs without explicit permission.

## Workspace Discipline
- Do not include CLAUDE.md in git.
- Do not update README.md or other documentation files unless told to.
- Do not try to operate outside the project workspace without stating your reason.

## Log and Notes

### Notion
- Many projects have a Notion page. Always ask me if you're unsure which notion page. Check there for project-specific context and updates whenever relevant. When you find the page for the first time, remember it and bookmark in the project CLAUDE.md for future reference.
- When you execute a task from Notion, make sure the task status is updated to "In Progress". When you complete a task, update the status to "Verify" and add a comment summarizing what you did. This helps me keep track of progress and provides context for future reference. Never change the task status to "Done".

### Devlog
The purpose of the devlog is to build up a knowledge base for future reference, so only include information that would be useful to look back on later.
After completing any task, think and decide if you need to append to the project-level `.claude/DEVLOG.md` under the relevant section:
- **Bugs Fixed** — root cause + fix
- **Decisions** — chosen approach + alternatives rejected
- **Design Choices** — pattern + rationale
Format: `[YYYY-MM-DD] **Summary** — details`. Keep entries concise. 

- Also check `.claude/DEVLOG.md` for bugs, decisions, and design choices that we have seen and discussed before.