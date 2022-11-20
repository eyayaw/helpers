
write_model <- 
function(dep.var, ind.vars, constant_term = "beta_0", error_term = "u") {
  n <- length(ind.vars)
  dep.var <- paste0(dep.var, "_i") # add observation index
  error_term <- paste0(error_term, "_i") # ditto
  eqn <- sprintf("\\beta_{%s} %s_{i}", seq_len(n), ind.vars)
  eqn <- paste(eqn, collapse = " + ")
  eqn <- c(paste0("\\", constant_term, " + "), eqn)
  eqn <- paste(c(dep.var, " = ", eqn, " + ", error_term), collapse = "")
  gsub("\\s+", " ", eqn)
}
