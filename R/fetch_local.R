#' List of local FAERS data
#'
#' The function lists the metadata for the FAERS databases currently in the path
#' chosen folder.
#'
#' @param path (chr) The path of the folder containing a subfolder (named
#' "faers_raw_data") with FAERS data inside, sorted by year and quarter.
#'
#' @return A [tibble][tibble::tibble-package] reporting years, path and quarter
#' for local FAERS data.
#' @export
#'
#' @examples
#' fetch_local(".")
fetch_local <- function(path) {
  if (!check_faers_structure(path)) {
    return(invisible(tibble(path = NA, year = NA, quarter = NA, type = NA)))
  }
  list_of_filename <- list.files(paste0(path, "/faers_raw_data"),
                                 recursive = TRUE)
  tibble(path = list_of_filename,
         year = year_from_zipname(list_of_filename),
         quarter = quarter_from_zipname(list_of_filename),
         type = type_from_zipnameV(list_of_filename))
}


year_from_zipname <- function(zipname) {
  zipname %>% stringr::str_sub(-10L, -7L)
}


quarter_from_zipname <- function(zipname) {
  zipname %>% stringr::str_sub(-6L, -5L)
}


type_from_zipname <- function(zipname) {
  if (stringr::str_detect(zipname, "xml")) "xml" else "ascii"
}
type_from_zipnameV <- Vectorize(type_from_zipname)
