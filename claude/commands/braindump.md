---
description: Capture a thought to the agent brain inbox
allowed-tools: [Read, Write, Glob, Bash(date*)]
---

# Braindump — Quick Capture

Take the user's input and write it to the agent brain inbox as fast as possible.

## Steps

1. Get the current timestamp: `date '+%Y-%m-%d-%H%M%S %Y-%m-%dT%H:%M:%S'` (first token = filename slug, second = ISO timestamp)
2. Parse the user's input for hints:
   - `@project-name` → add to `projects: [project-name]` in frontmatter
   - `#personal` → add tag `personal` (will be routed to 02-personal/ during processing)
   - `#idea` → set `type: idea` (will be routed to 04-research/ideas/ during processing)
   - Strip the hints from the content body
3. Write to `~/agent_brain/00-inbox/{YYYY-MM-DD-HHMMSS}.md`:

```yaml
---
created: {ISO timestamp}
type: braindump
tags: [{any parsed tags}]
source: cli
status: inbox
projects: [{any parsed projects}]
---
```
# {first ~8 words as title}

{full content}

4. Append to `~/agent_brain/00-inbox/_capture-log.md`:
   `| {date} | cli | {first ~50 chars of content} | inbox |`

5. Confirm briefly: "Captured to inbox. `{filename}`"

## Important
- Be FAST. No subagent, no MCP, no analysis. Just write and confirm.
- If the user's message is empty, ask what they want to capture.
