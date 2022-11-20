
# simplify to data.frame --------------------------------------------------
## mimicking purrr's style

bind_rows <- function(.l, ...) {
  as.data.frame(do.call(rbind, .l, ...))
}

bind_cols <- function(.l, ...) {
  as.data.frame(do.call(cbind, .l, ...))
}

map_dfr <- function(l, f, ...) {
  as.data.frame(do.call(rbind, lapply(l, f, ...)))
}

map_dfc <- function(l, f, ...) {
  as.data.frame(do.call(cbind, lapply(l, f, ...)))
}

pmap_dfr <- function(..., f) {
  as.data.frame(do.call(rbind, Map(f, ...)))
}

pmap_dfc <- function(..., f) {
  as.data.frame(do.call(cbind, Map(f, ...)))
}


# reshaping -----------
reshape_wide <- function(data, ...) {
  reshape(data, ..., direction = 'wide')
}

reshape_long <- function(data, ...) {
  reshape(data, ..., direction = 'long')
}
