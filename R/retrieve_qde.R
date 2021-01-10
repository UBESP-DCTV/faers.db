#' Retrieve qde
#'
#' This function download the FAERS data for a specific year and quarter
#'
#' @param year (chr) The year of the data to download (no default)
#' @param quarter (chr) The quarter of the data to download
#' ("q1", "q2", "q3" or "q4", default: "q1)
#' @param type (chr) The format of the data to download,
#' ("ascii" or "xml", default: "ascii")
#' @param path (chr) Path of the directory where you want to download the data
#' (default: working directory)
#'
#' @return (lgl) TRUE (invisible) if downloaded was succesful, FALSE otherwise
#' @export
#'
#' @examples
#' \dontrun{
#'   retrieve_qde(year = "2018", quarter = "q4")
#' }
#'
retrieve_qde <- function(year,
                         quarter = c("q1", "q2", "q3", "q4"),
                         type = c("ascii", "xml"),
                         path = getwd(),
                         create_folder = NULL,
                         download_data = NULL) {
  checkyear(year)
  quarter <- match.arg(quarter)
  type <- match.arg(type)
  if (!is_year_quarter_available(year, quarter)) {
    warning(glue::glue("Data of {quarter} of {year} are not available"))
    return(invisible(FALSE))
  }
  download_from <- compose_faers_link(year, quarter, type)
  download_to <- compose_faers_path(year, quarter, type, path)
  create_folder(download_to, create_folder)
  download_file(download_from, download_to, download_data,
                year, quarter, type)
}


checkyear <- function(year) {
  if (!is.character(year)) stop("Year must be character")
  if (as.numeric(year) < 2013L |
      as.numeric(year) > lubridate::year(Sys.Date())) {
    stop("Use a year after 2013 up to the current year")
  }
}


compose_faers_link <- function(year, quarter, type) {
  glue::glue("https://fis.fda.gov/content/Exports/faers_{type}",
             "_{year}{quarter}.zip")
}


compose_faers_path <- function(year, quarter, type, path) {
  if (!dir.exists(path)) stop(glue::glue("Directory {path} not found"))
  glue::glue("{path}/faers_raw_data/{year}/{quarter}/{type}")
}


create_folder <- function(download_to, create_folder) {
  if (!dir.exists(download_to)) {
    if (permission_create_folder(download_to, create_folder)) {
      dir.create(download_to, recursive = TRUE)
    } else stop("Permission to create folder denied by the user")
  }
  download_to
}


permission_create_folder <- function(faerspath, create_folder) {
  if (interactive()) {
    create_folder <- usethis::ui_yeah(glue::glue(
      "The following folders will be created:
      {faerspath}
      do you confirm?"
    ))
  }
  create_folder %NULL% TRUE
}


download_file <- function(download_from, download_to, download_data,
                          year, quarter, type) {
  downloaded <- FALSE
  filename <- glue::glue("{download_to}/faers_{type}_{year}{quarter}.zip")
  if (file.exists(filename)) {
    warning("Data already in the folder, will not download the file")
    return(invisible(downloaded))
  }
  if (permission_download_file(download_to, download_data)) {
    message(glue::glue("Retrieving FAERS {quarter} {year} ({type}): "))
    downloader::download(url = download_from, filename, mode = "wb")
    message("\nDone")
    downloaded <- TRUE
  } else {
    warning("Permission to download file denied by the user")
  }
  invisible(downloaded)
}


permission_download_file <- function(faerspath, download_data) {
  if (interactive()) {
    download_data <- utils::askYesNo(glue::glue("A .zip file will be",
                                                "downloaded at the local path",
                                                "\n{faerspath}\n ",
                                                "do you confirm?"))
  }
  download_data %NULL% TRUE
}
