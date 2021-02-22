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
    return(invisible(tibble::tibble(path = "", year = "",
                                    quarter = "", type = "")))
  }
  list_of_filename <- list.files(paste0(path, "/faers_raw_data"),
                                 recursive = TRUE)
  tibble::tibble(path = list_of_filename,
                 year = year_from_zipname(list_of_filename),
                 quarter = quarter_from_zipname(list_of_filename),
                 type = type_from_zipname_mul(list_of_filename))
}


year_from_zipname <- function(zipname) {
  start_substring <- -10L
  end_substring <- -7L
  stringr::str_sub(zipname, start_substring, end_substring)
}


quarter_from_zipname <- function(zipname) {
  start_substring <- -6L
  end_substring <- -5L
  stringr::str_sub(zipname, start_substring, end_substring)
}


type_from_zipname <- function(zipname) {
  if (stringr::str_detect(zipname, "xml")) "xml" else "ascii"
}


type_from_zipname_mul <- Vectorize(type_from_zipname)
