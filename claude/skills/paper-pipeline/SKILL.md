---
name: paper-pipeline
description: "Shared conventions, state schema, and utilities for the paper writing pipeline. Referenced by all paper-* agents and the /write-paper orchestrator."
user-invocable: false
---

# Paper Writing Pipeline — Shared Conventions

This skill defines the canonical state schema, LaTeX conventions, and quality standards shared across all paper pipeline agents. Every paper-* agent MUST read and follow these conventions.

## Paper State File

All pipeline state lives in `{paper_dir}/.claude/paper-state.json`. The orchestrator owns this file — agents do NOT write to it directly.

### Agent Output Protocol

Agents write their results to a **separate output file** instead of modifying `paper-state.json`:
- Each agent writes to `{paper_dir}/.claude/stage-output-{stage_name}.json` (e.g., `stage-output-plots.json`, `stage-output-literature.json`)
- The output file contains ONLY the agent's section of the state (e.g., just the `plots` object for paper-plotter)
- The **orchestrator** reads each agent's output file and merges it into `paper-state.json` after the agent completes
- This prevents race conditions when Stages 2+3 run in parallel

### Schema

```json
{
  "meta": {
    "title": "",
    "venue": "",
    "venue_format": "neurips|icml|iclr|cvpr|eccv|aaai|acl|emnlp|other",
    "deadline": "",
    "authors": [],
    "paper_dir": "",
    "repo_dir": "",
    "main_tex": "",
    "notion_task_url": "",
    "vault_note": "",
    "created": "",
    "last_updated": "",
    "current_stage": "init|outline|parallel|writing|refinement|done"
  },
  "inputs": {
    "codebases": [],
    "experiment_logs": [],
    "notion_pages": [],
    "obsidian_notes": [],
    "pdfs": [],
    "freeform": ""
  },
  "outline": {
    "status": "pending",
    "file": "",
    "sections": [
      {
        "id": "introduction",
        "title": "Introduction",
        "subsections": [],
        "content_bullets": [],
        "length_target": "",
        "citation_hints": []
      }
    ],
    "visualization_plan": [
      {
        "id": "fig1",
        "type": "conceptual|bar|line|scatter|table|attention|ablation|comparison",
        "title": "",
        "description": "",
        "data_source": "",
        "placement": "section_id",
        "aspect_ratio": "wide|square|tall"
      }
    ],
    "lit_search_strategy": {
      "keywords": [],
      "seed_papers": [],
      "subfields": [],
      "target_total_citations": 40,
      "per_section_targets": {}
    },
    "writing_plan": [
      {
        "section_id": "",
        "key_arguments": [],
        "evidence_sources": [],
        "tone": "formal|technical|narrative",
        "length_target_words": 0
      }
    ]
  },
  "plots": {
    "status": "pending",
    "figures": [
      {
        "id": "",
        "type": "",
        "description": "",
        "file": "",
        "script": "",
        "tex_label": "",
        "caption": "",
        "compiled": false
      }
    ]
  },
  "literature": {
    "status": "pending",
    "bibtex_file": "",
    "papers_found": 0,
    "papers_verified": 0,
    "citation_registry": [],
    "drafted_sections": []
  },
  "writing": {
    "status": "pending",
    "sections_completed": [],
    "sections_remaining": [],
    "compilation_success": false,
    "page_count": 0
  },
  "refinement": {
    "status": "pending",
    "iterations": [
      {
        "iteration": 1,
        "scores": {
          "novelty": 0,
          "clarity": 0,
          "soundness": 0,
          "significance": 0,
          "presentation": 0,
          "completeness": 0,
          "overall": 0
        },
        "feedback": [],
        "changes_made": []
      }
    ],
    "final_score": null,
    "acceptance_threshold": 6.0,
    "max_iterations": 3
  }
}
```

### Agent Output Protocol (Details)

Each agent writes its output to `{paper_dir}/.claude/stage-output-{stage}.json`:

| Agent | Output file | Contents |
|-------|------------|----------|
| paper-outliner | `stage-output-outline.json` | `{"outline": {...}}` |
| paper-plotter | `stage-output-plots.json` | `{"plots": {...}}` |
| paper-lit-reviewer | `stage-output-literature.json` | `{"literature": {...}}` |
| paper-writer | `stage-output-writing.json` | `{"writing": {...}}` |
| paper-reviewer | `stage-output-refinement.json` | `{"refinement": {...}}` |

The orchestrator merges each output into `paper-state.json` and updates `meta.last_updated`. Agents should NOT read or write `paper-state.json` directly — they read it for input context but write results to their own output file.

## LaTeX Conventions

### File Organization

Adapt to whatever structure already exists in the paper directory. Two modes:

**Monolithic mode** (single `.tex` file):
- Use section markers for each pipeline-generated section:
  ```latex
  % === BEGIN PIPELINE SECTION: introduction ===
  \section{Introduction}
  ...
  % === END PIPELINE SECTION: introduction ===
  ```
- This lets agents find and replace their sections without disturbing user-written content.

**Modular mode** (separate section files):
- Create `sections/{section_id}.tex` for each section
- Add `\input{sections/{section_id}}` to the main `.tex` file
- Figures go in `figures/` directory
- BibTeX goes in `references.bib`

**Decision rule**: If the main `.tex` file already has `\input{}` statements for sections, use modular mode. Otherwise, use monolithic mode.

### Figure Placement

```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=\linewidth]{figures/{id}.pdf}
  \caption{{caption text}}
  \label{fig:{id}}
\end{figure}
```

For wide figures spanning two columns (CVPR/ECCV):
```latex
\begin{figure*}[t]
  ...
\end{figure*}
```

### Table Format

```latex
\begin{table}[t]
  \centering
  \caption{{caption text}}
  \label{tab:{id}}
  \begin{tabular}{lcc}
    \toprule
    ...
    \midrule
    ...
    \bottomrule
  \end{tabular}
\end{table}
```

Always use `booktabs` (`\toprule`, `\midrule`, `\bottomrule`).

### BibTeX Format

Key format: `{firstauthor_lastname}{year}{first_significant_word}` (e.g., `wang2026segment`)

```bibtex
@inproceedings{wang2026segment,
  title     = {Full Title Here},
  author    = {Wang, Oliver and ...},
  booktitle = {Proceedings of ...},
  year      = {2026}
}
```

- Use `@inproceedings` for conferences, `@article` for journals, `@misc` for arXiv preprints
- For arXiv: include `eprint`, `archivePrefix`, `primaryClass` fields
- Never fabricate BibTeX entries — every entry must be verified via Semantic Scholar API

### Citation Style

- Use `\cite{}` for parenthetical citations: "... as shown in prior work \cite{smith2024method}."
- Use `\citet{}` when the author is the subject: "Smith et al. \citet{smith2024method} showed that..."
- Group related citations: `\cite{a2024,b2025,c2025}`
- Minimum citation target: 30 references for a full paper

## Compilation

### Primary Command

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error {main_tex}
```

### Common Errors and Fixes

| Error | Fix |
|-------|-----|
| `Undefined control sequence` | Check for missing `\usepackage{}` or typo in command name |
| `Citation undefined` | Run `bibtex` then `latexmk` again, or check `.bib` key matches `\cite{}` |
| `Missing $ inserted` | Wrap math in `$...$` or `\(...\)` |
| `Overfull \hbox` | Reword, add `\allowbreak`, or use `\sloppy` locally |
| `File not found` | Check path in `\includegraphics` or `\input`, ensure file exists |
| `Missing package` | Tell the user to install via `tlmgr install {package}` |

### Cleanup

After successful compilation, the following files are generated and can be ignored: `.aux`, `.bbl`, `.blg`, `.fdb_latexmk`, `.fls`, `.log`, `.out`, `.synctex.gz`

## Venue-Specific Guidelines

### NeurIPS
- Format: single-column, 9 pages (main content), unlimited appendix
- Template: `neurips_20XX.sty`
- Anonymous submission (no author names in review version)
- Checklist required (`checklist.tex`)

### ICML
- Format: two-column, 8 pages (main content), unlimited appendix
- Template: `icml20XX.sty`
- Anonymous submission

### ICLR
- Format: single-column, no strict page limit (typically 8-10 pages), unlimited appendix
- Template: OpenReview ICLR template
- Anonymous submission

### CVPR / ECCV
- Format: two-column, 8 pages (main content), unlimited supplementary
- Template: `cvpr.sty` / `eccv.cls`
- Anonymous submission
- Supplementary material as separate PDF

### ACL / EMNLP
- Format: two-column, 8 pages (long) or 4 pages (short), unlimited appendix
- Template: ACL style files
- Anonymous submission

### General Rules
- Always check the venue's official formatting instructions
- Respect page limits strictly — do not exceed main content page limit
- Include the official checklist if required
- Follow the venue's citation style (natbib, biblatex, etc.)
- For anonymous submission: no author names, no acknowledgments, no identifying URLs

## Quality Standards

### Writing Quality
- Active voice preferred over passive
- Define acronyms on first use
- Consistent notation throughout (define all symbols in a notation table or upon first use)
- No orphan sentences (single-sentence paragraphs)
- Each paragraph should have a clear topic sentence
- Transitions between sections should be explicit

### Technical Quality
- Every claim must be supported by evidence (experiment, citation, or formal argument)
- Clearly separate contributions from prior work
- State assumptions explicitly
- Discuss limitations honestly
- Ablation studies should isolate individual contributions

### Figure/Table Quality
- Every figure/table must be referenced in the text
- Captions should be self-contained (reader should understand the figure without reading the main text)
- Use consistent color schemes across figures
- Font size in figures should be readable (minimum 8pt after scaling)
- Tables should highlight best results (bold) and include error bars/std where applicable
