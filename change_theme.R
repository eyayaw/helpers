
# themes <- c("Solarized Dark", "textmate (default)", "Solarized Light", "Dracula")

change_theme <- function(theme = NULL, favorite = FALSE) {
  themes <- c(
    "Solarized Dark",
    "textmate (default)",
    "Solarized Light",
    "Dracula"
  )

  if (favorite && is.null(theme)) {
    rstudioapi::applyTheme("Solarized Dark")
  } else if (!favorite && is.null(theme)) {
    if (as.integer(format(Sys.time(), "%H")) < 18) {
      rstudioapi::applyTheme(sample(themes[-1], 1))
    } else {
      rstudioapi::applyTheme(themes[1])
    }
  } else if (!favorite && !is.null(theme)) {
    rstudioapi::applyTheme(theme)
  }
}
