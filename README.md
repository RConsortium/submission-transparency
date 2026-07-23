# Minimal, Transparent Statistical Analyses for Regulatory Submissions

A community-maintained collection of **minimal, readable R analyses** for the
methods that appear in clinical-trial submissions — each paired with a
**simulation study that checks the estimates against a known truth**.

## Why this exists

Two recurring pieces of feedback from FDA statistical reviewers:

1. **Submitted code is sometimes deeply nested.** The code that produces the primary
   and key secondary endpoint results should be *minimal* and rely on *common,
   well-understood R packages*, so a reviewer can read
   it top to bottom.
2. **Reviewers aren't always familiar with a given package's numerical
   behaviour.** So as a community, here for each method we don't just show the code — we **simulate
   data with a known parameter and measure how far the estimate lands from the
   truth** (bias, SE calibration, CI coverage).

Every chapter follows the same shape:

| Part | Question it answers |
|------|--------------------|
| **Minimal analysis** | What is the smallest, most common-package code that produces the estimate a reviewer cares about? |
| **Simulation evidence** | Under a data-generating process where the truth is known, is the estimate unbiased and correctly covered? |

## Topics

| Topic | Status |
|-------|--------|
| Summary statistics | ✅ Full exemplar |
| Analysis of Covariance (ANCOVA) | ✅ Full exemplar |
| Logistic regression | 🟡 Stub — help wanted |
| Mixed Models for Repeated Measures (MMRM) | 🟡 Stub — help wanted |
| Cochran-Mantel-Haenszel (CMH) test | 🟡 Stub — help wanted |
| Survival — Kaplan-Meier / Cox / Tobit | 🟡 Stub — help wanted |
| Multiple imputation — regression / MCMC | 🟡 Stub — help wanted |

## The book

The content is a [Quarto](https://quarto.org) book. Each chapter is a runnable
`.qmd`; the tables you see were produced by the code shown directly above them.

### Render locally

```bash
# 1. Install Quarto: https://quarto.org/docs/get-started/
# 2. Install the R packages used across chapters:
Rscript install.R
# 3. Render the whole book:
quarto render
# ...or preview a single chapter while editing:
quarto preview topics/ancova.qmd
```

The rendered site lands in `_book/`.

### Run just the numbers (no Quarto needed)

The simulation engine is plain base R. You can source and use it directly:

```r
source("R/sim_utils.R")
?run_simulation   # see the roxygen-style header comments in the file
```

## Repository layout

```
├── index.qmd                 # preface
├── _quarto.yml               # book config
├── topics/                   # one .qmd per topic (2 full, 5 stubs)
├── templates/topic-template.qmd   # copy this to add a topic
├── R/sim_utils.R             # base-R simulation + evaluation helpers
├── install.R                 # installs packages used by the book
├── CONTRIBUTING.md           # how to add or improve a topic
└── .github/                  # issue / PR templates, CI workflow
```

## Contributing

New topics, alternative minimal implementations, and stronger simulation studies
are all welcome — this is exactly the kind of thing a community builds best.
Start with a 🟡 stub above and read **[CONTRIBUTING.md](CONTRIBUTING.md)**.

## Disclaimer

These examples are illustrative templates, **not** statistical or regulatory
advice, and **not** a substitute for a study-specific SAP. Choice of estimand,
model, and missing-data strategy must be driven by the trial.

## License

[MIT](LICENSE). Contributions are accepted under the same license.
