rmd_boilerplate <- function(input,
                            title = "Insert your title here",
                            date = Sys.Date(),
                            author = "Eyayaw Beze",
                            output = "pdf_document",
                            more_text = "") {
  if (!grepl("[.][Rr]?md$", input)) {
    input <- paste0(input, ".Rmd")
  }
  date <- sprintf(r"{"`r format.Date('%s', '%%B %%d, %%Y')`"}", date)
  metadata <- paste0(
    "---\n",
    "title: ", title, "\n",
    "author: ", author, "\n",
    "date: ", date, "\n",
    "output: ", output, "\n",
    "---", "\n",
    "\n\n",
    more_text,"\n\n",
    "```{r setup, include=FALSE}
    knitr::opts_chunk$set(echo = TRUE)
    ```"
  )
  if (!file.exists(input)) {
    message("The metadata has been written to `", input, "` successfully.")
    writeLines(metadata, input)
  } else {
    stop(
      sprintf("'%s` already exists.\nGive another file name.", input),
      call. = FALSE)
  }
  rstudioapi::navigateToFile(input)
}
