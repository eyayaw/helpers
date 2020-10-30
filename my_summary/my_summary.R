# summary of numeric (including factor class) columns of a data frame

my_summary <- function(df) {
  df_nonchar <- df[, !vapply(df, typeof, "") %in% "character"]
  summ <- data.frame(summary(df_nonchar), row.names = NULL)

  # test for empty columns
  empty <- vapply(summ, function(x) all(x == ""), NA) # usually the 1st column is empty as a result of class(summary obj) which is "table" to data.frame coercion.
  summ <- summ[, !empty]
  summ <- setNames(summ, c("var_name", "stats"))
  summ <- summ[which(!is.na(summ$stats)), ]

  # stats column's form is "mean.: 34", what we need is mean, 34 separately.
  summ <- tidyr::separate(summ,
    col = stats, sep = ":",
    into = c("stats", "value"),
    extra = "merge"
  )
  # pivot into wide form, using 'stats' column as a key.
  summ <- tidyr::pivot_wider(summ, names_from = stats, values_from = value)
  var_nms <- stringr::str_squish(colnames(summ)) # remove white spaces
  colnames(summ) <- var_nms
  
  # remove white spaces 
  summ <- purrr::modify(summ, stringr::str_squish) 
  
  # when vars in the dataset contain NAs, we may have an
  # additional column in summary call, let's rename it to "missing"
  nas <- "NA's" %in% colnames(summ)
  if (nas) {
    colnames(summ)[colnames(summ) == "NA's"] <- "missing"
  }
  summ
}
