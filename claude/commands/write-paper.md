---
description: "Run the paper writing pipeline — from outline to polished draft. Usage: /write-paper [resume|outline|plots|lit-review|write|refine|status]"
allowed-tools: [Read, Write, Edit, Glob, Grep, Bash(date*), Bash(git*), Bash(ls*), Bash(mkdir*), Bash(latexmk*), Agent, Skill, TaskCreate, TaskGet, TaskUpdate, TaskList, SendMessage, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-create-pages, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-comment, AskUserQuestion]
---

# Paper Writing Pipeline Orchestrator

You are the orchestrator for a multi-agent paper writing pipeline inspired by PaperOrchestra. You coordinate 5 specialized agents through a structured pipeline. You do NOT write paper content yourself — you delegate to agents and manage state.

## First: Load Shared Conventions

Before doing anything, invoke the `paper-pipeline` skill to load the shared state schema, LaTeX conventions, and quality standards. All agents reference these conventions.

## Subcommands

Parse the argument string to determine the mode:

| Argument | Action |
|----------|--------|
| (none) | Full pipeline — interactive init then all 5 stages |
| `resume` | Resume from last completed stage |
| `outline` | Run Stage 1 only |
| `plots` | Run Stage 2 only |
| `lit-review` | Run Stage 3 only |
| `write` | Run Stage 4 only |
| `refine` | Run Stage 5 only |
| `status` | Show pipeline progress dashboard |

## State File

Location: `{paper_dir}/.claude/paper-state.json`

Check if this file exists. If it does, read it and use it. If it doesn't and the user is running a subcommand other than the full pipeline, tell them to run `/write-paper` first to initialize.

## Full Pipeline Flow

### Pre-Flight Checks

Before doing anything, verify the required tools are available:
1. Run `which latexmk` — if missing, tell the user to install a TeX distribution (e.g., `brew install --cask mactex-no-gui` on Mac)
2. Run `which uv` — if missing, tell the user to install uv (e.g., `curl -LsSf https://astral.sh/uv/install.sh | sh`)
3. If either is missing, stop and report. The pipeline cannot proceed without them.

### Phase 0: Initialization

1. **Detect paper directory**: Look for `.tex` files in the current directory and subdirectories (1 level deep). If found, identify the main `.tex` file and the venue from style files (e.g., `neurips_2026.sty` → NeurIPS 2026).

2. **Gather inputs interactively**: Ask the user these questions (skip any that are already clear from context):
   - What is the working title?
   - What venue is this for? (auto-detected if possible)
   - Where is the codebase? (paths to code repos)
   - Where are the experiment results? (log files, CSVs, Notion experiment trackers)
   - Any existing notes? (Obsidian notes, Notion pages, reference PDFs)
   - Any additional context? (key contributions, target narrative, anything else)

3. **Auto-discover context**:
   - Search `~/agent_brain/03-projects/` for project folders matching the paper topic
   - Search Notion for project pages that might be relevant (use `notion-search`)
   - Report what you found and ask the user to confirm which to include

4. **Create state file**: Write `paper-state.json` with all gathered inputs. Create the `.claude/` directory in the paper dir if needed.

5. **Create Notion task**: Use the `notion-task` skill pattern — create a task for this paper with:
   - Title: "Write {venue} paper: {title}"
   - Context: Links to inputs, deadline, venue
   - Requirements: All 5 pipeline stages as checklist items

6. **Create vault note**: Write a project note at `~/agent_brain/03-projects/{slug}/overview.md` using the `paper-project` template (from `~/agent_brain/99-templates/paper-project.md`). If the project directory already exists, update rather than overwrite.

7. **Confirm**: Show the user a summary of the initialized state and ask to proceed to Stage 1.

### Phase 1: Outline Generation

Spawn the outliner agent. First, read `~/.claude/agents/paper-outliner.md` to get the full agent instructions. Then spawn a general-purpose agent with those instructions embedded in the prompt:

```
Agent({
  prompt: "{full contents of paper-outliner.md instructions}\n\nState file: {paper_dir}/.claude/paper-state.json\nPaper directory: {paper_dir}\nMain tex file: {main_tex}",
  description: "Stage 1: Outline generation"
})
```

After the agent completes:
- **Merge state**: Read `{paper_dir}/.claude/stage-output-outline.json` and merge its contents into `paper-state.json` (update the `outline` key + set `meta.last_updated` and `meta.current_stage = "parallel"`)
- Show the user a summary: number of sections, figures planned, target citations
- Ask: "Outline complete. Review it at {outline_path}. Want to proceed to Stages 2+3 (Plots + Literature Review in parallel)?"
- Suggest: "You can also run `/propose-commit` to checkpoint this progress."

### Phase 2+3: Plots + Literature Review (PARALLEL)

Read `~/.claude/agents/paper-plotter.md` and `~/.claude/agents/paper-lit-reviewer.md` for agent instructions. Spawn BOTH agents in a SINGLE message (this is critical for parallel execution):

```
Agent({
  prompt: "{full contents of paper-plotter.md instructions}\n\nState file: {paper_dir}/.claude/paper-state.json\nPaper directory: {paper_dir}",
  description: "Stage 2: Plot generation"
})
Agent({
  prompt: "{full contents of paper-lit-reviewer.md instructions}\n\nState file: {paper_dir}/.claude/paper-state.json\nPaper directory: {paper_dir}",
  description: "Stage 3: Literature review"  
})
```

Each agent writes to its own output file (`stage-output-plots.json` and `stage-output-literature.json`). No race condition since they don't share files.

After both complete:
- **Merge state**: Read both output files and merge into `paper-state.json` (update `plots` and `literature` keys + set `meta.current_stage = "writing"`)
- Show summary: figures generated, papers found/verified, sections drafted
- Ask: "Stages 2+3 complete. Ready to proceed to Stage 4 (Section Writing)?"

### Phase 4: Section Writing

Read `~/.claude/agents/paper-writer.md` for agent instructions. Spawn the agent with those instructions + state file path.

After completion:
- **Merge state**: Read `stage-output-writing.json` and merge into `paper-state.json` (update `writing` key + set `meta.current_stage = "refinement"`)
- Report: sections completed, compilation status, page count
- Ask: "Draft complete. Ready for Stage 5 (Iterative Refinement)?"

### Phase 5: Iterative Refinement

Read `~/.claude/agents/paper-reviewer.md` for agent instructions. Spawn the agent with those instructions + state file path.

After completion:
- **Merge state**: Read `stage-output-refinement.json` and merge into `paper-state.json` (update `refinement` key + set `meta.current_stage = "done"`)
- Report: final scores, iterations performed, key improvements
- Show remaining weaknesses
- Ask: "Pipeline complete. Want to run `/wrapup` to commit and update all context?"

## Resume Logic

When `/write-paper resume` is invoked:

1. Read `paper-state.json`
2. Check each stage's status in order:
   - If `outline.status != "done"` → start from Stage 1
   - If `plots.status != "done"` OR `literature.status != "done"` → start from Stages 2+3
   - If `writing.status != "done"` → start from Stage 4
   - If `refinement.status != "done"` → start from Stage 5
   - If all done → report "Pipeline already complete"
3. Show the user where you're resuming from and ask to confirm

## Status Dashboard

When `/write-paper status` is invoked, read the state file and display:

```
Paper: {title}
Venue: {venue} | Deadline: {deadline}
Stage: {current_stage}

  [x] Outline     — {sections} sections, {figures} figures planned
  [x] Plots       — {n} figures generated
  [x] Lit Review  — {verified}/{found} papers verified, {bib_entries} bib entries
  [ ] Writing     — {completed}/{total} sections
  [ ] Refinement  — not started
```

## Agent Spawning Protocol

For each stage, spawn agents as follows:

1. **Read** the agent definition file (`~/.claude/agents/paper-{name}.md`) to get the full behavioral instructions
2. **Spawn** a general-purpose Agent with:
   - The full contents of the agent definition (everything after the frontmatter `---`) as the main prompt
   - Appended context: state file path, paper directory, main tex file path
   - A short `description` field (e.g., "Stage 1: Outline generation")
3. **After completion**: Read the agent's output file (`stage-output-{stage}.json`) and merge into `paper-state.json`

The agent definition files in `~/.claude/agents/` are the single source of truth for each agent's behavior. The orchestrator reads them and passes them as prompts — it does not duplicate their instructions.

## Between Stages

After every stage:
1. Read the updated state file to confirm success
2. Show the user a concise summary of what was produced
3. Always ask before proceeding to the next stage — never auto-advance
4. Suggest `/propose-commit` for git checkpointing
5. If the user wants to re-run a stage, that's fine — agents read current state and overwrite their section

## Error Handling

- If an agent fails or produces incomplete output, report what happened and ask the user how to proceed
- If LaTeX compilation fails during Stage 4 or 5, the agent should attempt to fix it (up to 3 attempts)
- If state file is corrupted, offer to re-initialize from scratch
- Never silently skip a stage or swallow errors
