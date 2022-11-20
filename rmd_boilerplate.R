# generate an minimal rmarkdown boilerplate with some metadata

rmd_boilerplate <- 
function(input, title = "Insert your title here", date = Sys.Date(), author = "Eyayaw Beze",output = "pdf_document",
         more_metadata = "geometry:\n  - left=3cm\n  - right=3cm\n  - top=3cm\n  - bottom=3cm", more_text="") {

  date <- sprintf(r"{"`r format.Date('%s', '%%B %%d, %%Y')`"}", date)
  metadata <- paste0(
    "---\n",
    "title: ", title, "\n",
    "author: ", author, "\n",
    "date: ", date, "\n",
    "output: ", output, "\n",
    "colorlinks: ", "yes", "\n",
    "fontsize: ", "12pt", "\n",
    paste(more_metadata, collapse = "\n"),
    "\n",
    "---", "\n\n\n",
    more_text,"\n\n",
    "```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)
```"
  )

  dir = NULL
  try(dir <- dirname(input))
  if (dir.exists(dir)) {
    if (!grepl("[.][Rr]?md$", input)) {
      input <- paste0(input, ".Rmd") # append a file ext if not provided
    }
    if (!file.exists(input)) {
      message("The metadata has been written to `", input, "` successfully.")
      writeLines(metadata, input)
      rstudioapi::navigateToFile(input)
    } else {
      warning(sprintf("`%s` already exists.\nGive another filename.", input), call. = FALSE)
    }
  } else {
    warning('The directory `', dir, "` does not seem to exist. File hasn't been written", call. = FALSE)
    cat(metadata, sep = "\n")
  }
}
