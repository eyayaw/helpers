
# get the file name of a file (or remove the file extension)
# e.g. foo.01.pdf -> foo.01
file.name <- function(x) gsub("([\\w.]*)([.][[:alpha:]]*)$", "\\1", x)


# lag of a vector -----------------------------------------------------
my_lag <- function(x, n = 1L, lead = FALSE, default = NA) {
  N <- length(x)
  n <- pmin(n, N)
  x_discarded <- rep(default, n)
  if (lead) {
    out <- c(x[-seq_len(n)], x_discarded)
  } else {
    out <- c(x_discarded, x[seq_len(N - n)])
  }
  out
}
