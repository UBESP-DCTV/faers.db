#' Compose FAERS path
#'
#' This function composes the path where FAERS data will be downloaded
#'
#' @param path (char) The path of the folder where the database
#' will be saved (default: working directory)
#' @param year (int) The year of the data to download (no default)
#' @param quarter (char) The quarter of the data to download
#' ("q1", "q2", "q3" or "q4", default: "q1)
#' @param type (char) The format of the data to download,
#' ("ascii" or "xml", default: "ascii")
#'
#' @return Return the path of the internal folder where FAERS
#' data will be downloaded
#'
#' @examples
#' compose_faers_path(year = 2020)
compose_faers_path <- function(path = getwd(),
                               year,
                               quarter = c("q1", "q2", "q3", "q4"),
                               type = c("ascii", "xml")) {
  quarter <- match.arg(quarter)
  type <- match.arg(type)
  check_year(year)
  if (dir.exists(path)) {
    return(paste0(path, "/faers_raw_data/",
                  year, "/", quarter, "/", type))
  } else {
    stop(paste0("directory '", path, "' not found"))
  }
}
