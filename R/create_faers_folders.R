#' Create FAERS folder
#'
#' This function creates the set of nested folders where FAERS
#' data will be downloaded; if the folders already exist, no nothing
#'
#' @param path (char) The path of the folder where the database
#' will be saved (default: working directory)
#' @param year (int) The year of the data to download (no default)
#' @param quarter (char) The quarter of the data to download
#' ("q1", "q2", "q3" or "q4", default: "q1)
#' @param type (char) The format of the data to download,
#' ("ascii" or "xml", default: "ascii")
#'
#' @return Creates a set of nested folders
#'
#' @examples
#' create_faers_folders(year = 2018, quarter = "q1", type = "ascii")
create_faers_folders <- function(path = getwd(),
                                 year,
                                 quarter = c("q1", "q2", "q3", "q4"),
                                 type = c("ascii", "xml")) {
  faers_path <- compose_faers_path(path, year, quarter, type)
  if (!dir.exists(faers_path)) {
    if (utils::askYesNo(paste0("The following folders will be created \n",
                              faers_path,
                              ",\ndo you confirm?"))) {
      dir.create(faers_path, recursive = TRUE)
    }
  }
}
