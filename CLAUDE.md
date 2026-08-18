# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A series of hands-on workshops on pipeline development and execution using [Nextflow](https://www.nextflow.io/). Each workshop pairs a presentation with a Quarto handbook students follow along in class. This repo currently ships one placeholder workshop (`intro_to_nextflow.qmd`) as a template for the rest of the course — see "Adding a New Workshop" below.

## Source Files

- `index.qmd` — landing page linking to all workshops
- `intro_to_nextflow.qmd` — placeholder/template workshop; duplicate this file's structure for new workshops

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

On every push to `main`, GitHub Actions (`.github/workflows/render-and-deploy.yml`) automatically:
1. Renders the full website (`quarto render`) → uploads to GitHub Pages
2. Prints each workshop HTML to PDF via Puppeteer/Chromium → commits them back to `output/` with `[skip ci]`

PDFs are **not** generated with `quarto render --to pdf`; they are produced by headless Chromium printing the rendered HTML. The `_site/` build directory is gitignored; only the files in `output/` are tracked.

## Workshop Document Conventions

Each workshop `.qmd` follows the same pattern (see `intro_to_nextflow.qmd`):

- YAML front matter uses `theme: cosmo`, `toc: true`, `number-sections: true`, `code-copy: true`, `code-overflow: wrap`, plus an `include-in-header` `@media print` rule that prevents code blocks/callouts from splitting across a page break — this matters because the page is also captured as a PDF by CI.
- Commands the student should type are shown in fenced ```bash blocks prefixed with `$`; any output lines below (without a `$`) are the expected result, not something to type. Preserve this convention when adding or editing exercises.
- Sections use `#`/`##`/`###` headings with automatic numbering (`number-sections: true`), and workshops are written to build on each other where applicable.
- Use `::: {.callout-tip}` / `::: {.callout-note}` / `::: {.callout-warning}` to call out concepts, tips, or common pitfalls without breaking the narrative flow.

## Adding a New Workshop

Adding a workshop touches several files that don't reference each other automatically:
1. Create the new `.qmd` following the front-matter/structure conventions above (duplicate `intro_to_nextflow.qmd` as a starting point).
2. Add a nav entry in `_quarto.yml` under `website.navbar.left`.
3. Add a link/summary to `index.qmd`.
4. Add the HTML→PDF conversion entry (`_site/<name>.html` → `output/<name>.pdf`) and the corresponding `git add` path in `.github/workflows/render-and-deploy.yml`.
5. Update `README.md`'s workshop list.
