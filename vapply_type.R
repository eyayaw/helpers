# vapply ------------------------------------------------------------------

# vapply for return value of character(1)
vapply_chr <- function(.x, .f, ..., use.names = TRUE) {
  vapply(X = .x, FUN = .f, FUN.VALUE = NA_character_, ..., USE.NAMES = use.names)
}

# vapply for return value of logical(1)
vapply_lgl <- function(.x, .f, ..., use.names = TRUE) {
  vapply(X = .x, FUN = .f, FUN.VALUE = NA, ..., USE.NAMES = use.names)
}

# vapply for return value of integer(1)
vapply_int <- function(.x, .f, ..., use.names = TRUE) {
  vapply(X = .x, FUN = .f, FUN.VALUE = NA_integer_, ..., USE.NAMES = use.names)
}

# vapply for return value of double(1)
vapply_dbl <- function(.x, .f, ..., use.names = TRUE) {
  vapply(X = .x, FUN = .f, FUN.VALUE = NA_real_, ..., USE.NAMES = use.names)
}

# find the location of a column satisfying a condition
where <- function(x, f) {
  seq_along(x)[vapply(x, f, logical(1))]
}