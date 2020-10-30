my_summ <- function(x, na.rm = FALSE) {
  summ <- function(x, na.rm = na.rm) {
    list(
      Min = min(x, na.rm = na.rm),
      P25 = quantile(x, probs = .25, na.rm = na.rm, names = FALSE),
      Median = median(x, na.rm = na.rm),
      Mean = mean(x, na.rm = na.rm),
      P75 = quantile(x, probs = .75, na.rm = na.rm, names = FALSE),
      Max = max(x, na.rm = na.rm),
      sd = sd(x, na.rm = na.rm),
      N = length(x)
    )
  }
  if (typeof(x) != "list" || typeof(x) %in% c("double", "integer")) {
    out <- unlist(summ(x, na.rm = na.rm))
  } else if (typeof(x) == "list") {
    num_vars <- vapply(x, is.numeric, NA)
    out <- vapply(x[num_vars], summ, vector("list", 8), na.rm = na.rm)
    # get variables in rows, and stats in columns
    out <- t(out)
    # Variable captures the names of the numeric columns of df
    out <- data.frame(Variable = rownames(out), out, row.names = NULL)
  }
  out
}



my_summary <- function(x, na.rm = TRUE) {
  fns <- alist(
    Min = min(x, na.rm = na.rm),
    P25 = quantile(x, probs = .25, na.rm = na.rm, names = FALSE),
    Mean = mean(x, na.rm = na.rm),
    Median = median(x, na.rm = na.rm),
    P75 = quantile(x, probs = .75, na.rm = na.rm, names = FALSE),
    Max = max(x, na.rm = na.rm),
    sd = sd(x, na.rm = na.rm),
    N = length(x)
  )
  if (typeof(x) != "list" || typeof(x) %in% c("double", "integer")) {
    out <- vapply(fns, function(f) eval(f), NA_real_)
  } else if (typeof(x) == "list") {
    num_vars <- vapply(x, is.numeric, NA)
    len <- length(x[num_vars])
    out <- vapply(
      fns, function(f) vapply(x[num_vars], function(x) eval(f), NA_real_),
      double(len)
    )
    out <- data.frame(Variable = rownames(out), out, row.names = NULL)
  }
  out
}
