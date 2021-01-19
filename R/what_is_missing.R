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
  local <- fetch_local(path) %>%
    subset(select = c(year, quarter, type)) %>%
    tidyr::unite(unq, c(year, quarter, type), remove = FALSE)
  online <- dplyr::bind_rows(
    faers_meta %>%
      subset(select = c(year, quarter)) %>%
      tibble::add_column(type = rep("ascii", NROW(faers_meta))) %>%
      tidyr::unite(unq, c(year, quarter, type), remove = FALSE),
    faers_meta %>%
      subset(select = c(year, quarter)) %>%
      tibble::add_column(type = rep("xml", NROW(faers_meta))) %>%
      tidyr::unite(unq, c(year, quarter, type), remove = FALSE)
  )
  out <- online %>%
    dplyr::filter(online[["unq"]] %in% local[["unq"]] == FALSE) %>%
    dplyr::select(-unq)
  message(glue::glue("{NROW(out)} FAERS databases are missing in your folder."))
  invisible(out)
}


# The following function it's just for testing!
# It generates a series of folders and files simulating the correct structure of
# FAERS data folder (sorry for the for loop, but it's a function that will not
# be used anyway...)
simulate_faers_structure <- function(path) {
  faers_meta <- fetch_faers_meta()
  for (i in 1:NROW(faers_meta)) {
    year <- faers_meta[[i, "year"]]
    quarter <- faers_meta[[i, "quarter"]]
    dir.create(glue::glue("{path}/faers_raw_data/{year}/{quarter}"),
                 recursive = TRUE)
    file.create(glue::glue("{path}/faers_raw_data/{year}/{quarter}/",
                           "faers_ascii_{year}{quarter}.zip"))
    file.create(glue::glue("{path}/faers_raw_data/{year}/{quarter}/",
                           "faers_xml_{year}{quarter}.zip"))
  }
}
