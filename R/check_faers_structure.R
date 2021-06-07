#' Check the structure of the FAERS folder
#'
#' Check if exists a folder containing the FAERS data and if the structure of
#' the folder is correct.
#'
#' @param path (chr) The path of the folder containing a subfolder (named
#' "faers_raw_data") with FAERS data inside, sorted by year and quarter.
#' @param faersyears (chr) A vector of characters with the list of the years of
#' FAERS data (defaults: all years available).
#'
#' @return (lgl) TRUE (invisible) if the "faers_raw_data" exists and it is
#' structured correctly, FALSE (invisible) otherwise.
#' @export
#'
#' @examples
#' check_faers_structure(".")
check_faers_structure <- function(path, faersyears = years_from_faers_html()) {
  if (!check_root_folder(path)) return(invisible(FALSE))
  if (!check_years_directory(path, faersyears)) {
    print(faers_folder_structure(path))
    return(invisible(FALSE))
  }
  if (!check_quarter_every_year(path, faersyears)) {
    print(faers_folder_structure(path))
    return(invisible(FALSE))
  }
  if (!check_files(path)) {
    print(faers_folder_structure(path))
    return(invisible(FALSE))
  }
  invisible(TRUE)
}


check_root_folder <- function(path) {
  dirlist <- list.dirs(path, recursive = FALSE)
  is_faers_folder <- grepl("faers_raw_data", dirlist)
  if (sum(is_faers_folder) == 0L) {
    warning("I can't find a folder named 'faers_raw_data'.")
    return(FALSE)
  }
  if (sum(is_faers_folder) > 1L) {
    warning("Too Many folders named 'faers_raw_data' (or similar).")
    return(FALSE)
  } else TRUE
}


check_years_directory <- function(path, faers_years) {
  subfolders <- list.dirs(
    paste0(path, "/faers_raw_data"),
    recursive = FALSE, full.names = FALSE
  )
  subfolders_logical <- purrr::map(
    subfolders,
    function(x) stringr::str_detect(faers_years, glue::glue("^{x}$"))
  )
  bad_folders <- subfolders[which(purrr::map(subfolders_logical, sum) == 0L)]
  if (length(bad_folders) > 0L) {
    warning(glue::glue("The following folders do not match a FAERS year: ",
                       ".../faers_raw_data/{toString(bad_folders)}. ",
                       "Please remove the folders or change directory path."))
    return(FALSE)
  } else TRUE
}


faers_folder_structure <- function(path) {
  folders <- list.dirs(path) %>%
    stringr::str_remove(path)
  folders[[1L]] <- "faers_raw_data"
  files <- list.files(path, full.names = TRUE, recursive = TRUE) %>%
    stringr::str_remove(path)
  data.tree::as.Node(data.frame(pathString = c(folders, files)))
}


check_quarter_every_year <- function(path, faers_years) {
  subfolders_logical <- purrr::map(
    faers_years,
    function(x) check_quarter_directory(path = path, year = x)
  )
  sum(!purrr::map(subfolders_logical, sum) > 0L) == 0L
}


check_quarter_directory <- function(path, year) {
  quarterslist <- c("q1", "q2", "q3", "q4")
  subfolders <- list.dirs(
    paste0(path, "/faers_raw_data/", year),
    recursive = FALSE, full.names = FALSE
  )
  subfolders_logical <- purrr::map(
    subfolders,
    function(x) stringr::str_detect(quarterslist, glue::glue("^{x}$"))
  )
  bad_folders <- subfolders[which(purrr::map(subfolders_logical, sum) == 0L)]
  if (length(bad_folders) > 0L) {
    warning(glue::glue("The following folders do not match a FAERS quarter: ",
                       ".../faers_raw_data/{year}/{toString(bad_folders)}. ",
                       "Please remove the folders or change directory path."))
    return(FALSE)
  } else TRUE
}


check_files <- function(path, current_filenames = all_possible_filenames()) {
  filelist <- list.files(glue::glue("{path}/faers_raw_data"),
                         full.names = FALSE, recursive = TRUE)
  files_logical <- filelist %in% current_filenames
  if (sum(!files_logical) > 0L) {
    warning(glue::glue("The following files do not match a FAERS dataset: ",
                       "{toString(filelist[which(!files_logical)])}. ",
                       "Please remove the files or change directory path."))
  }
  length(filelist[which(!files_logical)]) == 0L
}


all_possible_filenames <- function(faersmeta = fetch_faers_meta()) {
  c(paste0(faersmeta[["year"]], "/", faersmeta[["quarter"]], "/faers_ascii_",
           faersmeta[["year"]], faersmeta[["quarter"]], ".zip"),
    paste0(faersmeta[["year"]], "/", faersmeta[["quarter"]], "/faers_xml_",
           faersmeta[["year"]], faersmeta[["quarter"]], ".zip"))
}
