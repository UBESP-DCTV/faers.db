#' Retrieve qde
#'
#' This function download the FAERS data for a specific year and quarter
#'
#' @param path (chr) Path of the directory where you want to download the data
#' @param year (chr) The year of the data to download
#' @param quarter (chr) The quarter of the data to download
#' ("q1", "q2", "q3" or "q4", default: "q1)
#' @param type (chr) The format of the data to download,
#' ("ascii" or "xml", default: "ascii")
#'
#' @return (lgl) TRUE (invisible) if the download was succesful, FALSE otherwise
#' @export
#'
#' @examples
#' \dontrun{
#'   retrieve_qde(year = "2018", quarter = "q4")
#' }
#' a <- retrieve_qde(year="2016", quarter = "q4", path = "C:/Users/pietr/Documents/Downloads")
#'
retrieve_qde <- function(path,
                         year,
                         quarter = c("q1", "q2", "q3", "q4"),
                         type = c("ascii", "xml"),
                         create_folder = NULL,
                         download_data = NULL) {
  if (!checkpath(path)) return(invisible(FALSE))
  if (!checkyear(year)) return(invisible(FALSE))
  quarter <- match.arg(quarter)
  type <- match.arg(type)
  if (!is_year_quarter_available(year, quarter)) {
    warning(glue::glue("Data of {quarter} of {year} are not available"))
    return(invisible(FALSE))
  }
  download_from <- compose_faers_link(year, quarter, type)
  download_to <- compose_faers_path(year, quarter, path)
  if (permission_create_folder(download_to, create_folder)) {
    create_folder(download_to, create_folder)
  } else {
    warning("Download failed: permission to create folder denied by the user")
    return(invisible(FALSE))
  }
  if (permission_download_file(download_to, download_data,
                               year, quarter, type)) {
    download_file(download_from, download_to, download_data,
                  year, quarter, type)
  } else {
    warning("Download failed: ",
            "file already in folder or ",
            "permission to download file denied by the user")
    return(invisible(FALSE))
  }
  TRUE
}


checkyear <- function(year) {
  if (!is.character(year)) {
    warning("Year must be character")
    return(FALSE)
  }
  if (as.numeric(year) < 2013L |
      as.numeric(year) > lubridate::year(Sys.Date())) {
    warning("Use a year after 2013 up to the current year")
    return(FALSE)
  }
  TRUE
}


checkpath <- function(path) {
  if (!dir.exists(path)) {
    warning(glue::glue("Directory {path} not found"))
    return(FALSE)
  }
  TRUE
}


compose_faers_link <- function(year, quarter, type) {
  glue::glue("https://fis.fda.gov/content/Exports/faers_{type}",
             "_{year}{quarter}.zip")
}


compose_faers_path <- function(year, quarter, path) {
  glue::glue("{path}/faers_raw_data/{year}/{quarter}")
}


create_folder <- function(download_to, create_folder) {
  dir.create(download_to, recursive = TRUE)
  download_to
}


permission_create_folder <- function(faerspath, create_folder) {
  if (!dir.exists(faerspath)) {
    if (interactive()) {
      create_folder <- usethis::ui_yeah(glue::glue(
        "The following folder will be created:
        {faerspath}
        do you confirm?"
      ))
    }
    return(create_folder %NULL% TRUE)
  } else return(TRUE)
}


download_file <- function(download_from, download_to, download_data,
                          year, quarter, type) {
  downloaded <- FALSE
  filename <- glue::glue("{download_to}/faers_{type}_{year}{quarter}.zip")
  message(glue::glue("Retrieving FAERS {quarter} {year} ({type}): "))
  downloader::download(download_from, filename, mode = "wb")
  message("\nDone")
  downloaded <- TRUE
  invisible(downloaded)
}


permission_download_file <- function(faerspath, download_data,
                                     year, quarter, type) {
  if (!file.exists(glue::glue("{faerspath}/faers_",
                              "{type}_{year}{quarter}.zip"))){
    if (interactive()) {
      download_data <- usethis::ui_yeah(glue::glue(
        "A .zip file will be downloaded at the local path
        {faerspath}
        do you confirm?"
      ))
    }
    download_data %NULL% TRUE
  } else return(FALSE)
}
