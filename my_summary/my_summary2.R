my_summary <- function(df, na.rm = FALSE, row.names = FALSE) {
  fns <- list(
    Min = function(x) min(x, na.rm = na.rm),
    "1stQ" = function(x) quantile(x, probs = .25, na.rm = na.rm),
    Median = function(x) median(x, na.rm = na.rm),
    Mean = function(x) mean(x, na.rm = na.rm),
    "3rdQ" = function(x) quantile(x, probs = .75, na.rm = na.rm),
    Max = function(x) max(x, na.rm = na.rm),
    sd = function(x) sd(x, na.rm = na.rm),
    N = length
  )
  num_vars <- vapply(df, is.numeric, NA)
  out <- lapply(fns, function(f) vapply(df[num_vars], f, NA_real_))
  out <- do.call(rbind, out)
  out <- as.data.frame(t(out))
  if (!row.names) {
    out$var <- rownames(out) # which are the names of the numeric columns of df 
    out <- out[, c(9, 1:8)] # get the rownames as the first column in `out`
    rownames(out) <- NULL # we have the names in the first column
    }
  out
}
