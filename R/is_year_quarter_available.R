#' Check FAERS year
#'
#' This function check if data for the year and quarter selected are
#' available at FAERS to be downloaded.
#'
#' @param .year (num) year for which data are required
#' @param .quarter (chr) quarter for which data are required, between "q1",
#'   "q2", "q3", "q4".
#'
#' @return (lgl) FAERS can have data for the `.year` and `.quarter` required?
#'
#' @examples
#' is_year_quarter_available(2013, "q1")  # TRUE
#' is_year_quarter_available(2012, "q1")  # FALSE
is_year_quarter_available <- function(.year, .quarter) {
  n_data <- fetch_faers_meta() %>%
    dplyr::filter(
      .data[["year"]] == as.character(.year),
      .data[["quarter"]] == .quarter
    ) %>%
    nrow()

  n_data > 0L
}
