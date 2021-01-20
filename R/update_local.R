#' Update local FAERS data
#'
#' This function downloads the FAERS data missing in the selected folder.
#'
#' @param path (chr) The path of the folder containing a subfolder (named
#' "faers_raw_data") with FAERS data inside, sorted by year and quarter.
#' @param missing_metadata A [tibble][tibble::tibble-package] reporting year,
#' quarter and type of FAERS dataset currently missing in the selected folder,
#' usually an output of what_is_missing() function
#' (default: what_is_missing(path)).
#' @param permission_to_update (lgl) Only if session is not in interactive mode.
#' TRUE: permission to download files, FALSE: deny permission to download files.
#'
#' @return (lgl) TRUE if the download was successful, FALSE otherwise.
#' @export
#'
#' @examples
#' \dontrun{
#'  update_local(".")
#' }
update_local <- function(path,
                         missing_metadata = what_is_missing(path),
                         permission_to_update = NULL) {
  if (!check_faers_structure(path)) return(invisible(FALSE))
  if (NROW(missing_metadata) == 0L) {
    message("No new data to download.")
    return(invisible(FALSE))
  }
  if (permission_update(permission_to_update)) {
    mapply(
      function(x, y, z) retrieve_qde(getwd(), year = x, quarter = y, type = z,
                                     interactive_session = FALSE),
      missing_metadata[["year"]],
      missing_metadata[["quarter"]],
      missing_metadata[["type"]]
    )
    return(invisible(TRUE))
  } else {
    warning("Permission to download data denied by the user.")
    return(invisible(FALSE))
  }
}


permission_update <- function(permission) {
  if (rlang::is_interactive()) {
    permission <- usethis::ui_yeah(
      glue::glue("Do do want to download the missing FAERS data?")
    )
  }
  permission %NULL% TRUE
}
