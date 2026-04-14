---
description: File research Q&A output from the current conversation into the vault
allowed-tools: [Read, Write, Edit, Glob, Grep, Bash(date*)]
---

# File Session

Capture research output from the current conversation and file it into the vault so it compounds rather than disappearing.

**Vault root**: `~/agent_brain`

## Usage

```
/file-session                    # auto-detect research content from conversation
/file-session topic-slug         # specify the topic slug directly
```

## Step 1: Identify Research Content

Scan the current conversation for Q&A exchanges that qualify as filing:
- Technical explanations or deep-dives
- Literature references or paper discussions
- Method comparisons or trade-off analyses
- Conceptual frameworks or taxonomies
- Tool/library usage guides
- Experiment design discussions
- Design decisions and rationale
- Any substantive analysis that would be valuable to retain

If `$ARGUMENTS` provides a slug, use it as the topic name. Otherwise, infer from the content.

## Step 2: Classify Destination

| Content Type | Signals | Destination |
|---|---|---|
| Topic synthesis | Broad overview, multiple references | `~/agent_brain/04-research/topics/{slug}.md` |
| Technique/method | "How to", implementation details | `~/agent_brain/05-knowledge/techniques/{slug}.md` |
| Tool knowledge | Library usage, API patterns, config | `~/agent_brain/05-knowledge/tools/{slug}.md` |
| Framework/mental model | Taxonomy, comparison, conceptual | `~/agent_brain/05-knowledge/frameworks/{slug}.md` |
| Lesson/decision | Trade-off analysis, "we should/shouldn't" | `~/agent_brain/05-knowledge/lessons/{slug}.md` |
| Idea sparked | Hypothesis, "what if", future direction | `~/agent_brain/04-research/ideas/{date}-{slug}.md` |

## Step 3: Check for Existing Notes

Before creating a new file:
- Grep `~/agent_brain/05-knowledge/` and `~/agent_brain/04-research/topics/` for the topic name and related keywords
- If an existing note covers the same subject, **update it** rather than creating a duplicate
- If updating, add a new section or append to existing sections with a date marker

## Step 4: Format and Write

Use the appropriate template from `~/agent_brain/99-templates/`:
- `knowledge-article.md` for `05-knowledge/` articles
- `research-topic.md` for `04-research/topics/` articles

Frontmatter must include:
```yaml
source: conversation
conversation_date: {today's date}
```

Add a `## Source` section at the bottom:
> Filed from conversation on {date}. Original context: {brief description of what prompted the research}.

## Step 5: Cross-reference

- Add `[[wiki-links]]` to related existing notes in the vault
- If the content relates to a project in `~/agent_brain/03-projects/`, mention the connection
- If an idea was sparked, add it to `~/agent_brain/04-research/ideas/_incubator.md`

## Step 6: Report

Tell the user:
- What was filed and where (file path)
- Whether it was a new article or an update to an existing one
- Any cross-references added
