# simplify to data.frame --------------------------------------------------

Map_df <- function(..., .f, with.what = "rbind") {
  as.data.frame(do.call(with.what, Map(f = .f, ...)))
}

bind_rows <- function(...) {
  as.data.frame(do.call("rbind", list(...)))
}

bind_cols <- function(...) {
  as.data.frame(do.call("cbind", list(...)))
}
