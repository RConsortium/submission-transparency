# sim_utils.R
# ---------------------------------------------------------------------------
# Shared helpers for the simulation studies in this repository.
#
# Design goals (keep this file boring and dependency-free on purpose):
#   * Base R only. No package a reviewer would have to install or trust.
#   * Every function does one obvious thing and is easy to read line-by-line.
#   * The output metrics are the standard ones a statistician uses to judge
#     "how far is the estimate from the truth": bias, empirical SE, average
#     model SE, root mean squared error, and confidence-interval coverage.
#
# Source this file from a topic report with:  source(here::here("R/sim_utils.R"))
# or, if you prefer no dependencies at all:    source("../R/sim_utils.R")
# ---------------------------------------------------------------------------

#' Summarise a vector of estimates against a known truth
#'
#' @param estimate   numeric vector, one estimate per simulated data set
#' @param se         numeric vector of model-reported standard errors (same length)
#' @param truth      the single true parameter value the estimates target
#' @param lower,upper optional numeric vectors of CI bounds per replicate; if
#'                    omitted, a normal-approximation CI is built from estimate +/- 1.96*se
#' @param conf.level nominal coverage of the supplied/constructed interval
#' @return a one-row data.frame of performance metrics
evaluate_estimator <- function(estimate, se, truth,
                               lower = NULL, upper = NULL,
                               conf.level = 0.95) {
  stopifnot(length(estimate) == length(se))
  n_rep <- length(estimate)

  if (is.null(lower) || is.null(upper)) {
    z     <- qnorm(1 - (1 - conf.level) / 2)
    lower <- estimate - z * se
    upper <- estimate + z * se
  }

  covered <- (truth >= lower) & (truth <= upper)

  data.frame(
    n_rep        = n_rep,
    truth        = truth,
    mean_est     = mean(estimate),
    bias         = mean(estimate) - truth,
    rel_bias_pct = 100 * (mean(estimate) - truth) / truth,
    emp_se       = sd(estimate),          # spread of estimates across replicates
    avg_model_se = mean(se),              # what the model *thinks* the SE is
    se_ratio     = mean(se) / sd(estimate), # ~1 means model SE is well calibrated
    rmse         = sqrt(mean((estimate - truth)^2)),
    coverage     = mean(covered),         # should be ~ conf.level if valid
    check.names  = FALSE
  )
}

#' Pretty-print an evaluation table with sensible rounding
#'
#' @param eval_df output of one or more rbind-ed evaluate_estimator() calls
#' @param digits  rounding for numeric columns
print_eval <- function(eval_df, digits = 4) {
  num <- vapply(eval_df, is.numeric, logical(1))
  eval_df[num] <- lapply(eval_df[num], round, digits = digits)
  print(eval_df, row.names = FALSE)
  invisible(eval_df)
}

#' Run a simulation study by repeatedly generating data and fitting a method
#'
#' This is a thin, readable driver. `gen` returns a data set; `fit` takes that
#' data set and returns a named list with at least `estimate` and `se` (and
#' optionally `lower`/`upper`). We collect those across `n_rep` replicates.
#'
#' @param n_rep number of simulated data sets
#' @param gen   function(i) -> data.frame  (i is the replicate index)
#' @param fit   function(data) -> list(estimate=, se=, lower=?, upper=?)
#' @param seed  base RNG seed; replicate i uses seed + i for reproducibility
#' @return data.frame with one row per replicate
run_simulation <- function(n_rep, gen, fit, seed = 2024) {
  out <- vector("list", n_rep)
  for (i in seq_len(n_rep)) {
    set.seed(seed + i)
    res <- fit(gen(i))
    out[[i]] <- data.frame(
      estimate = res$estimate,
      se       = res$se,
      lower    = if (!is.null(res$lower)) res$lower else NA_real_,
      upper    = if (!is.null(res$upper)) res$upper else NA_real_
    )
  }
  do.call(rbind, out)
}
