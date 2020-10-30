# strings -----------------------------------------------------------------

  # if no match---NULL return NA
  nomatch_na <- function(x) {
    if (length(x) == 0L) NA else x
  }

  nomatch_na <- Vectorize(nomatch_na, SIMPLIFY = FALSE) # vectorize it over x


#' `nomatch` takes either `NULL` or `NA`, following `base-r`'s and `stringr`'s return value for no match, respectively. In case of the former, we leave it *asis* because `base-r` returns `NULL` for no match.

str_match <- function(string, pattern, nomatch = NULL, invert = FALSE, ...) {
  .match <- regmatches(x = string,
                       m = regexec(pattern, string, ...),
                       invert = invert)
  # check nomatch arg
  nomatch <- eval(substitute(substitute(nm), list(nm = nomatch)))
  if (!is.character(nomatch)) {
    nomatch <- deparse1(nomatch)
  }
  choices <- c("NULL", "NA")
  ii <- match(toupper(nomatch), choices)
  if (is.na(ii))
    stop("'nomatch' should be either “NULL” or “NA”.", call. = FALSE)
  nomatch <- choices[ii]

  if (nomatch == "NA")
    .match <- nomatch_na(.match)
  do.call("rbind", .match)
}

#' Motivation from R-devel
#' [**Pattern Matching and Replacement**](https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html)

str_match_all <- function(string, pattern, invert = FALSE, ...) {
  .match <- regmatches(x = string, m = gregexpr(pattern, string, ...))
  .match <- lapply(.match,
                 function(s) regmatches(s, regexec(pattern, s, ...), invert = invert))
  lapply(.match, do.call, what = "rbind")
  }


str_extract <- function(string, pattern, ...) {
  regmatches(string, regexpr(pattern, string, perl = TRUE, ...))
}

str_extract_all <- function(string, pattern, ...) {
  regmatches(string, gregexpr(pattern, string, perl = TRUE, ...))
}


str_replace <- function(string, pattern, replacement, ...) {
  sub(pattern, replacement, string, ...)
}

str_replace_all <- function(string, pattern, replacement, ...) {
  gsub(pattern, replacement, string, ...)
}

str_remove <- function(string, pattern, ...) {
  str_replace(string, pattern, "", ...)
}

str_remove_all <- function(string, pattern, ...) {
  str_replace_all(string, pattern, "", ...)
}

str_sub <- function(string, start = 1L, end = nchar(string)) {
  str_sub_one <- function(x, s, e) {
    if (s < 0) s <- nchar(x) + s + 1
    if (e < 0) e <- nchar(x) + e + 1
    if (s > e) {
      warning("`start` is greater than `end` for some string.", call. = FALSE)
    }
    substr(x, s, e)
  }
  lt <- length(string)
  ls <- length(start)
  le <- length(end)

  if (all(c(lt, ls, le) == 1L)) {
    return(str_sub_one(string, start, end))
  }

  n <- max(lt, ls, le)
  if (lt && lt < n) {
    string <- rep_len(string, length.out = n) # as in `substring()`
  }
  mapply(str_sub_one, x = string, s = start, e = end, USE.NAMES = FALSE)
}
