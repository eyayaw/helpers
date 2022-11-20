# summary of numeric (including factor class) columns of a data frame
my_summary <- function(df) {

  df_nonchar <- df[, !sapply(df, typeof) %in% "character"]
  summ <- data.frame(summary(df_nonchar), row.names = NULL)

  # test for empty columns usually the 1st column is empty as a result of class
  # (summary obj) which is "table" to data.frame coercion.
  empty <- sapply(summ, function(x) all(x == ""))
  summ <- summ[, !empty]
  summ <- setNames(summ, c("var_name", "stats"))
  summ <- summ[which(!is.na(summ$stats)), ]

  # just in case if there are multiple :'s, we need to split only at the first match
  summ$stats <- sub(":", "-;-", summ$stats)
  summ <- data.frame(summ[1], do.call(rbind, strsplit(summ$stats, "-;-")))
  names(summ)[-1] <- c("stats", "value")

  # pivot into wide form, using 'stats' column as a key.
  summ <- reshape(summ,
    direction = "wide",
    idvar = "var_name",
    timevar = "stats",
    v.names = "value"
  )

  var_nms <- strsplit(colnames(summ)[-1], "value\\.")
  var_nms <- vapply(var_nms, function(x) x[[2]], NA_character_)
  var_nms <- gsub("\\s+$", "", var_nms) # remove white spaces
  names(summ)[-1] <- var_nms
  rownames(summ) <- NULL

  # remove white spaces
  summ <- as.data.frame(sapply(summ, function(x) gsub("\\s+$", "", x)))

  # when vars in the dataset contain NAs, we may have two additional columns in
  # summary call
  nas <- "NA's" %in% colnames(summ)
  if (any(nas)) {
    colnames(summ)[colnames(summ) == "NA's"] <- "missing"
  }
  summ
}
