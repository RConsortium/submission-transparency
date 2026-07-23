# Contributing

Thanks for helping build a shared, transparent reference for regulatory
statistical analyses. The bar for a contribution is simple: **minimal code with
common packages, plus a simulation that checks the estimate against a known
truth.**

## Ways to contribute

- **Fill in a stub topic** (see the 🟡 rows in the [README](README.md)).
- **Add an alternative minimal implementation** of an existing topic (e.g. a
  base-R version alongside a package version).
- **Strengthen a simulation** — more realistic data-generating processes, extra
  scenarios (small n, high censoring, non-normality), or a documented failure mode.
- **Fix an error.** If a chapter's numbers or claims are wrong, that's a
  high-priority issue.

## The two rules that define this project

1. **Minimal, common code.** For the estimand-defining analysis, prefer base R.
   Add a package only when it earns its place, and it should be one a reviewer is
   likely to already trust (widely used, well documented, actively maintained).
   No deep nesting or custom wrapper layers around the headline numbers.
2. **Check against a known truth.** Every method must include a simulation that
   generates data from a process with a *known* parameter and reports **bias,
   SE calibration (`se_ratio`), and CI coverage** using the shared helpers in
   [`R/sim_utils.R`](R/sim_utils.R). If the estimator is biased or under-covers,
   **document it** — a known caveat is more valuable than a hidden one.

## How to add a topic

1. Copy [`templates/topic-template.qmd`](templates/topic-template.qmd) to
   `topics/<your-topic>.qmd`.
2. Add it to the `chapters:` list in [`_quarto.yml`](_quarto.yml).
3. Write the **Minimal analysis** and **Simulation evidence** sections. Reuse
   `run_simulation()`, `evaluate_estimator()`, and `print_eval()` from
   `R/sim_utils.R` so every chapter reports the same metrics the same way.
4. If your chapter needs a new package, add it to [`install.R`](install.R).
5. Render locally to confirm it works:
   ```bash
   quarto preview topics/<your-topic>.qmd
   ```
6. Open a pull request.

## Contribution checklist

- [ ] Analysis code is minimal and uses base R / common packages only.
- [ ] There is a simulation with a clearly stated **true** parameter.
- [ ] The chapter reports bias, `se_ratio`, and coverage via `print_eval()`.
- [ ] Any bias / under-coverage / caveat is stated in the text, not hidden.
- [ ] Seeds are fixed and `sessionInfo()` is printed.
- [ ] New packages are added to `install.R`.
- [ ] The chapter renders without error.

## Style

- Comments explain *why*, not *what*. Keep chunks short and readable.
- Prefer clarity over cleverness — a reviewer should follow it on first read.
- Match the tone and structure of the two full exemplars
  (`topics/summary-statistics.qmd`, `topics/ancova.qmd`).

## Reporting issues

Open a GitHub issue using the templates in `.github/ISSUE_TEMPLATE/`. For a
numerical error, include the chapter, the claim, and (ideally) a minimal
reproducible example.

By contributing you agree your work is released under the repository's
[MIT license](LICENSE).
