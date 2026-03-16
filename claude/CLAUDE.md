# Must-Follow Preferences

## Communication
**Don't assume. Don't hide confusion. Surface tradeoffs.**
- Be concise. Skip summaries for simple tasks.
- Be critical — flag issues, question assumptions, push back whenever you spot concerns.
- Ask questions whenever anything is unclear. Don't guess silently.

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## Agents
- Use agent teams whenever you have more than one simple task, e.g., an implementation task would require a coding agent, a review agent, and a validating agent.
- When working as a team, make sure the team lead does not do the work of other agents.
- When working as a team, always have a review agent that is not the implementer. The reviewer should check the implementation and test results against the requirements, and push back if there are any concerns to discuss further.

## Thinking and Planning
- Do not accept my claims without checking. Verify with code, docs, or implementation before making definitive statements.
- Do not accept my plans without scrutiny. Question assumptions, identify edge cases, and consider alternatives before committing, search online for reference if needed.
- In planning mode, ask all necessary clarification questions upfront. Verify your reasoning before committing to a plan.
- Given a task, do not start implementing the first solution that comes to mind. Instead, take a moment to think through the problem, consider multiple approaches, and discuss with me before proceeding with the best course of action.
- Given a task, try to break it down into smaller subtasks with verifiable completion criteria.

## Code Implementation
**Touch only what you must. Minimum code that solves the problem.**
- No features beyond what was asked. No abstractions for single-use code. No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.
- Don't "improve" adjacent code, comments, or formatting. Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.
- Remove imports/variables/functions that YOUR changes made unused. Don't remove pre-existing dead code unless asked.
- Respect existing codebase. Reuse existing code. Do not write tests unless explicitly asked.
- The test: Every changed line should trace directly to the user's request.
- When facing cases not covered by instructions, do not catch and handle them silently. Instead, raise exceptions in code and ask for clarification.

## Tooling
- Never call `python3` directly and always choose uv instead (e.g., `uv run python` instead of `python`). When unsure, call tool `/astral:uv` for docs.
- Always confirm with me before installing new tools or libraries.
- Use `/commit` to propose commits. Do not commit directly.
- Always use native Claude tools, such as Read(), Search(), and Write(), over bash equivalents whenever possible.

## Session Management
- After the first exchange, use `/rename` to give the session a short, descriptive name (2-4 words) based on the topic. Do this silently without asking.

## Execution
- Do not stack commands. Do not compound commands using &&. E.g., if you want to execute `pwd && ls`, run two separate commands `pwd` and then `ls`.
- Before `cd`, check if you are already in the correct directory.
- Do not execute multiline inline python or bash commands. Write and execute a temporary script file under `/tmp` instead.

## Workspace Discipline
- Do not include CLAUDE.md in git.
- Do not update README.md or other documentation files unless told to.
- Do not try to operate outside the project workspace without stating your reason.
- No need to clean up files in `/tmp`.

## Notion
- When I say "task", I likely mean a Notion task. See `notion-task` skill for the full workflow (creation, progress logging, completion).
- Check Notion for project-specific context when relevant. Ask me if unsure which page.
- When you find a project's Notion page for the first time, bookmark it in the project CLAUDE.md for future reference.

## Context Updates
- At milestones (task completion, bug fix, design decision, approach change, blocker, surprising results), invoke the `update-context` skill to update all context sources.

## Devlog
- After completing tasks, consider using `/devlog` to log bugs fixed, decisions, and design choices.
- Check `.claude/DEVLOG.md` for prior context before starting work.
