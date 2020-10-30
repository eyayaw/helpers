start_meeting <- function(course.name) {
  if (!is.character(course.name)) {
    course.name <- eval(substitute(substitute(course.name)), parent.frame())
    if (is.symbol(course.name)) course.name <- as.character(course.name)
  }
  meeting <- read.table("meeting.txt", header = TRUE)
  message("Use password: ", meeting[which(meeting$course_name == course.name), "password"])
  browseURL(meeting[which(meeting$course_name == course.name), "url"])
}
