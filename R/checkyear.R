#' Check FAERS year
#'
#' This function check if the year selected for FAERS download is fine
#'
#'
#' @param year (int) The year of the data to download (no default)
#'
#' @return If the year is fine returns TRUE, stops
#' (with an error message) otherwise
#' @export
#'
#' @examples
#'checkyear(2018)
#'
checkyear <- function(year) {
  if (year %% 1L != 0L) {
    stop("use an integer for the 'year' argument")
  }
  if (year < 2013L | year > lubridate::year(Sys.Date())) {
    stop("use a year after 2013 up to the current year")
  }
  return(TRUE)
}
