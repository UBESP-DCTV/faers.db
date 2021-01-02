#' Retrieve qde
#'
#' This function download the FAERS data for a specific year and quarter
#'
#' @param path (char) The path of the folder where the database
#' will be saved (default: working directory)
#' @param year (int) The year of the data to download (no default)
#' @param quarter (char) The quarter of the data to download
#' ("q1", "q2", "q3" or "q4", default: "q1)
#' @param type (char) The format of the data to download,
#' ("ascii" or "xml", default: "ascii")
#'
#' @return Download the selected FAERS data in the chosen folder
#' @export
#'
#' @examples
#' \dontrun{
#'   retrieve_qde(year = 2018, quarter = "q4")
#' }
#'
retrieve_qde <- function(path = getwd(),
                         year,
                         quarter = c("q1", "q2", "q3", "q4"),
                         type = c("ascii", "xml")) {
  quarter <- match.arg(quarter)
  stopifnot(`Data available` = is_year_quarter_available(year, quarter))

  type <- match.arg(type)

  faers_link <- compose_faers_link(year, quarter, type)
  faers_path <- compose_faers_path(path, year, quarter, type)
  create_faers_folders(path, year, quarter, type)
  filename <- paste0("faers_", type, "_", year, quarter, ".zip")
  if (file.exists(paste0(faers_path, "/", filename))) {
    stop(paste0("file ", filename, " already exists"))
  } else {
    if (utils::askYesNo(paste0("The file\n",
                              filename,
                              "\n will be downloaded at the path\n",
                              faers_path,
                              ".\nContinue?"))) {
      cat("start downloading...\n")
      downloader::download(faers_link,
                           paste0(faers_path, "/", filename),
                           mode = "wb")
      cat("\ndone!")
    }
  }
}
