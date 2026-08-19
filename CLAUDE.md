# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A series of hands-on workshops on pipeline development and execution using [Nextflow](https://www.nextflow.io/). Each workshop pairs a presentation with a Quarto handbook students follow along in class. This repo currently ships the Day 0 (self-paced, pre-workshop) chapters — under `day0_material/`, including `getting_started.qmd` and `tour_of_hazel.qmd` — with the Nextflow-specific Day 1/2 chapters still to come; see "Adding a New Workshop" below.

## Source Files

- `index.qmd` — landing page linking to all workshops
- `day0_material/getting_started.qmd` — Day 0: account setup, logging onto Hazel, and its storage spaces
- `day0_material/tour_of_hazel.qmd` — Day 0: a guided tour of Hazel's filesystems plus a UNIX/shell primer

The site is configured as a Quarto website project via `_quarto.yml`.

## Rendering

Rendering requires [Quarto](https://quarto.org).

```bash
# Render the full website locally
quarto render
```

<!-- TODO: once published, put the GitHub Pages URL here, e.g.:
The live HTML version is published at <https://hurwitzlab.github.io/Nextflow_Crash_Course/>.
-->

## CI/CD

On every push to `main`, GitHub Actions (`.github/workflows/render-and-deploy.yml`) renders the full website (`quarto render`) and uploads it to GitHub Pages. The `_site/` build directory is gitignored.

## Workshop Document Conventions

Each workshop `.qmd` follows the same pattern (see `day0_material/getting_started.qmd` or `day0_material/tour_of_hazel.qmd`):

- YAML front matter uses `theme: cosmo`, `toc: true`, `number-sections: true`, `code-copy: true`, `code-overflow: wrap`, plus an `include-in-header` `@media print` rule that prevents code blocks/callouts from splitting across a page break when the page is printed.
- Commands the student should type are shown in fenced ```bash blocks prefixed with `$`; any output lines below (without a `$`) are the expected result, not something to type. Preserve this convention when adding or editing exercises.
- Sections use `#`/`##`/`###` headings with automatic numbering (`number-sections: true`), and workshops are written to build on each other where applicable.
- Use `::: {.callout-tip}` / `::: {.callout-note}` / `::: {.callout-warning}` to call out concepts, tips, or common pitfalls without breaking the narrative flow.

## Adding a New Workshop

Adding a workshop touches several files that don't reference each other automatically:
1. Create the new `.qmd` following the front-matter/structure conventions above (duplicate `day0_material/getting_started.qmd` as a starting point).
2. Add a nav entry in `_quarto.yml` under `website.navbar.left`.
3. Add a link/summary to `index.qmd`.
4. Update `README.md`'s workshop list.
