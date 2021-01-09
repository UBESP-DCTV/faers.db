#' Retrieve qde
#'
#' This function download the FAERS data for a specific year and quarter
#'
#' @param year (chr) The year of the data to download (no default)
#' @param quarter (chr) The quarter of the data to download
#' ("q1", "q2", "q3" or "q4", default: "q1)
#' @param type (chr) The format of the data to download,
#' ("ascii" or "xml", default: "ascii")
#' @param path (chr) Path of the directory where you want to download the data
#' (default: working directory)
#'
#' @return Download the selected FAERS data in the chosen folder
#' @export
#'
#' @examples
#' \dontrun{
#'   retrieve_qde(year = 2018, quarter = "q4")
#' }
#'
retrieve_qde <- function(year,
                         quarter = c("q1", "q2", "q3", "q4"),
                         type = c("ascii", "xml"),
                         path = getwd(),
                         create_folder = NULL,
                         download_data = NULL) {
  checkyear(year)
  quarter <- match.arg(quarter)
  type <- match.arg(type)
  if (!is_year_quarter_available(year, quarter)) {
    stop(glue::glue("Data of {quarter} of {year} are not available"))
  }
  download_from <- compose_faers_link(year, quarter, type)
  download_to <- compose_faers_path(year, quarter, type, path)
  create_folder(download_to, create_folder)
  download_file(download_from, download_to, download_data,
                year, quarter, type)
}


checkyear <- function(year) {
  if (!is.character(year)) stop("Year must be character")
  if (as.numeric(year) < 2013L |
      as.numeric(year) > lubridate::year(Sys.Date())) {
    stop("Use a year after 2013 up to the current year")
  }
}


compose_faers_link <- function(year, quarter, type) {
  glue::glue("https://fis.fda.gov/content/Exports/faers_{type}",
             "_{year}{quarter}.zip")
}
