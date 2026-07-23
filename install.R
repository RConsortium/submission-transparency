# install.R
# Installs the R packages used across the book. The philosophy of this project
# is minimal, common dependencies — this list should stay short. Base R and the
# `stats` package (summary statistics, ANCOVA via lm, glm, mantelhaen.test)
# need nothing installed.

pkgs <- c(
  "emmeans",   # least-squares means / adjusted contrasts (ANCOVA, logistic, MMRM)
  "survival",  # Kaplan-Meier, Cox, Tobit (survreg) — ships with R but pinned here
  "mmrm",      # Mixed Models for Repeated Measures
  "mice"       # multiple imputation + Rubin's rules pooling
)

to_install <- setdiff(pkgs, rownames(installed.packages()))
if (length(to_install)) {
  message("Installing: ", paste(to_install, collapse = ", "))
  install.packages(to_install, repos = "https://cloud.r-project.org")
} else {
  message("All book packages already installed.")
}
