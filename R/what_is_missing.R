#' What is missing in my FAERS folder?
#'
#' This function tells what FAERS datasets are not currently in the selected
#' folder.
#'
#' @param path (chr) The path of the folder containing a subfolder (named
#' "faers_raw_data") with FAERS data inside, sorted by year and quarter.
#' @param faers_meta A [tibble][tibble::tibble-package] with the metadata of
#' of FAERS data currently online (default: all the FAERS data).
#'
#' @return A [tibble][tibble::tibble-package] reporting year, quarter and type
#' of FAERS dataset currently missing in the selected folder (invisible).
#' @export
#'
#' @examples
#' what_is_missing(".")
what_is_missing <- function(path, faers_meta = fetch_faers_meta()) {
  if (!check_faers_structure(path)) {
    return(invisible(tibble(year = "", quarter = "", type = "", mb = 0L)))
  }
  local <- prepare_local_meta(path)
  online <- prepare_online_meta(faers_meta)
  out <- online %>%
    dplyr::filter(!.data[["unq"]] %in% local[["unq"]]) %>%
    dplyr::select(-.data[["unq"]]) %>%
    replace(is.na(.data[["."]]), 0L) %>%
    dplyr::transmute(.data[["year"]], .data[["quarter"]], .data[["type"]],
                     mb = .data[["ascii_zip_mb"]] + .data[["xml_zip_mb"]])
  totmb <- sum(out[["mb"]])
  message(glue::glue("{NROW(out)} FAERS databases are missing in your folder",
                     " ({totmb} mb)."))
  invisible(out)
}


prepare_local_meta <- function(path) {
  fetch_local(path) %>%
    subset(select = c(.data[["year"]], .data[["quarter"]], .data[["type"]])) %>%
    tidyr::unite(.data[["unq"]],
                 c(.data[["year"]], .data[["quarter"]], .data[["type"]]),
                 remove = FALSE)
}


prepare_online_meta <- function(faers_meta) {
  n <- NROW(faers_meta)
  dplyr::bind_rows(
    faers_meta %>%
      subset(select = c(.data[["year"]],
                        .data[["quarter"]],
                        .data[["ascii_zip_mb"]])) %>%
      tibble::add_column(type = rep("ascii", n)) %>%
      tidyr::unite(.data[["unq"]],
                   c(.data[["year"]], .data[["quarter"]], .data[["type"]]),
                   remove = FALSE),
    faers_meta %>%
      subset(select = c(.data[["year"]],
                        .data[["quarter"]],
                        .data[["xml_zip_mb"]])) %>%
      tibble::add_column(type = rep("xml", n)) %>%
      tidyr::unite(.data[["unq"]],
                   c(.data[["year"]], .data[["quarter"]], .data[["type"]]),
                   remove = FALSE)
  )
}
