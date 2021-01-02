#' Check FAERS year
#'
#' This function check if the year selected for FAERS download can have
#' data.
#'
#' @param year (int) The year of the data to download.
#'
#' @return (lgl) FAERS can have data for the `year` required?
#'
#' @examples
#' check_year(2013)  # TRUE
#' check_year(2012)  # FALSE
check_year <- function(year) {
  is_after_start <-  year >= 2013L
  if (!is_after_start) {
    message(glue::glue(
      "The year slected ({year}) is too far in the past. ",
      "The first year with FAERS data is 2013."
    ))
  }

  is_available <- year %in% years_from_faers_html()
  current_year <- lubridate::year(Sys.Date())
  if (!is_available) {
    message(glue::glue(
      "The year slected ({year}) is not available.",
      "We are now in {current_year}.",
      "Are you requiring a future year?",
    ))
  }

  is_after_start && is_available
}
