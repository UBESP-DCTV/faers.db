#' Update local FAERS data (ascii files only)
#'
#' This function downloads the FAERS ascii data missing in the selected folder.
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
  missing_metadata <- missing_metadata |>
    dplyr::filter(.data[["type"]] == "ascii")
  if (NROW(missing_metadata) == 0L) {
    message("No new ascii data to download.")
    return(invisible(FALSE))
  }
  nmiss <- NROW(missing_metadata)
  mbmiss <- sum(missing_metadata[["mb"]])
  message(
    glue::glue(
      "{nmiss} FAERS ascii databases are missing in your folder ({mbmiss} mb)."
    )
  )
  if (permission_update(permission_to_update, path)) {
    mapply(
      function(x, y) {
        retrieve_qde(
          path,
          year = x,
          quarter = y,
          type = "ascii",
          interactive_session = FALSE
        )
      },
      missing_metadata[["year"]],
      missing_metadata[["quarter"]]
    )
    return(invisible(TRUE))
  } else {
    warning("Permission to download data denied by the user.")
    return(invisible(FALSE))
  }
}


permission_update <- function(permission, path) {
  if (rlang::is_interactive()) {
    permission <- usethis::ui_yeah(
      glue::glue(
        "You are about to sync the folder
        {path}/faers_raw_data
        with the online FAERS database.

        If your FAERS data exists elsewhere on this computer, you shold change",
        " the 'path' parameter of this function to point to your existing data.

        Do you agree to proceed using {path}/faers_raw_data?
        "
      )
    )
  }
  permission %NULL% TRUE
}
