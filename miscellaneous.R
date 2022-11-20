
# get the stem of a file (basename of a file without the ext)
# e.g. data/foo.csv -> foo
file_stem <- function(path) {
  tools::file_path_sans_ext(basename(path))
}


# It’s useful as a way of providing a default value in case the output of
# another function is NULL:
# http://adv-r.had.co.nz/Functions.html#special-calls
`%||%` <- function(lhs, rhs) if (!is.null(lhs)) lhs else rhs

# safely compare two numeric (floating) vectors, taken from dplyr::near
near <- function (x, y, tol = .Machine$double.eps^0.5) {
  abs(x - y) < tol
}

# a practical cut
my_cut <- function(x, ..., include.lowest = TRUE, right = FALSE) {
  cut(x, ..., include.lowest = include.lowest, right = right)
}

# taken from adv-r 1st ed http://adv-r.had.co.nz/Functions.html#return-values
in_dir <- function(dir, code) {
  old = setwd(dir)
  on.exit(setwd(old))
  force(code)
}
# Non-overwriting download operation
download_file <- function(url, destfile, ...) {
  if (!file.exists(destfile)) {
    download.file(url, destfile, ...)
  } else {
    warning('File already exists. Download operation skipped.', call.=FALSE)
  }
}


# grep returns value
grepv <- function(pattern, x, ...) {
  grep(pattern = pattern, x = x, value = TRUE, ...)
}

# base select, for use in pipeOp
bselect = `[.data.frame`

# makes tidy names
make_names <- function(names) {
  names = gsub("[ ]{2,}", " ", names) # rm two or more white spaces anywhere
  patt = "[[:punct:] ]+"
  names = gsub(patt, "_", trimws(tolower(names)))
  names = gsub(patt, "_", names)
  gsub("(^_+)|(_+$)", "", names)
}


# rearrange columns in a data.frame
colreorder <- function(x, col = NULL) {
  stopifnot(inherits(x, "data.frame"))
  cols = seq_len(ncol(x))
  col = switch(class(col),
               "character" = match(col, names(x)),
               "numeric" = if (all(col %in% cols)) col else stop(call. = FALSE)
  )
  x[, c(col, cols[-col])]
}


# reshaping -----------
reshape_wide <- function(data, ...) {
  reshape(data, ..., direction = 'wide')
}

reshape_long <- function(data, ...) {
  reshape(data, ..., direction = 'long')
}

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
