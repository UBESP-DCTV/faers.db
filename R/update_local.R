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
#' @param type (chr) The format of the data to download: ascii, xml or both.
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
                         type = c("both", "ascii", "xml"),
                         permission_to_update = NULL) {
  if (!check_faers_structure(path)) return(invisible(FALSE))
  type <- match.arg(type)
  missing_metadata <- missing_data_selection(missing_metadata, type)
  totmb <- sum(missing_metadata[["mb"]])
  typeformessage <- ifelse(type == "both", "ascii and xml", type)
  message(glue::glue("{NROW(missing_metadata)} FAERS databases",
                     " {typeformessage} are missing in your folder",
                     " ({totmb} mb)."))
  if (NROW(missing_metadata) == 0L) {
    message(glue::glue("No new {typeformessage} data to download."))
    return(invisible(FALSE))
  }
  if (permission_update(permission_to_update, path)) {
      mapply(
        function(x, y, z) retrieve_qde(path, year = x, quarter = y, type = z,
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


missing_data_selection <- function(missing_metadata, type) {
  if (type != "both") {
    missing_metadata[which(missing_metadata[["type"]] == type), ]
  } else missing_metadata
}


permission_update <- function(permission, path) {
  if (rlang::is_interactive()) {
    permission <- usethis::ui_yeah(
      glue::glue(
        "You are about to sync the folder
        {path}/faers_raw_data
        with the online FAERS database.

        If your FAERS data exists elsewhere on this computer you should change",
        " the 'path' parameter of this function to point to your existing data."
      )
    )
  }
  permission %NULL% TRUE
}
