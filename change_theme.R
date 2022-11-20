# change RStudio theme
change_theme <- function(theme=NULL) {
  themes = sapply(rstudioapi::getThemes(), `[[`, 'name')
  darkThemes = themes[sapply(rstudioapi::getThemes(), `[[`, 'isDark')]
  if (!is.null(theme)) {
    stopifnot("Theme not found." = theme %in% themes)
    rstudioapi::applyTheme(theme)
  } else if (is.null(theme)) {
    # set a dark theme if the current time is after 6 PM
    if (as.integer(format(Sys.time(), "%H")) >= 18L) {
      thm = sample(darkThemes, 1L)
      message(sprintf('Theme {%s} set.', thm))
      rstudioapi::applyTheme(thm)
    } else {
      # set any random theme from available themes
      thm = sample(themes, 1L)
      message(sprintf('Theme {%s} set.', thm))
      rstudioapi::applyTheme(thm)
    }
  }
}
