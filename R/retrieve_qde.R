#' Retrieve qde
#'
#' This function download the FAERS data for a specific year and quarter
#'
#' @param year The year of the data to download
#' @param quarter The quarter of the data to download
#' @param type The format of the data to download, ascii or xml
#'
#' @return The function download the selected data in the working directory
#' @export
#'
#' @examples
#' retrieve_qde(year = "2018", quarter = "q1", type = "ascii")
#'
retrieve_qde <- function(year = format(Sys.Date(), "%Y"),
                         quarter = c("q1", "q2", "q3", "q4"),
                         type = c("ascii", "xml")) {
  # Path of the online data
  sourcedir <- paste0("https://fis.fda.gov/content/Exports/faers_",
                      type, "_", year, quarter, ".zip")

  # Create the directory for the downloaded zip folder
  destdir <- paste0("faers_raw_data/",
                    year, "/", quarter)
  dir.create(destdir, recursive = T)

  # Create the path of the zipped folder
  filepath <- paste0(getwd(), "/", destdir, "/", year, quarter, ".zip")

  # Download the the zipped folder
  downloader::download(sourcedir, filepath, mode = "wb")

  # Unzip the folder
  utils::unzip(zipfile = filepath,
               exdir = paste0(getwd(), "/", destdir))

  # Keep only the data files, delete pdf and zip files
  fileslist <- list.files(paste0(getwd(), "/", destdir),
                          recursive = T)
  path_fileslist <- paste0(getwd(), "/", destdir, "/", fileslist)
  path_pdffiles <- path_fileslist[grepl(".pdf", fileslist) == T]
  unlink(path_pdffiles)
  path_zipfiles <- path_fileslist[grepl(".zip", fileslist) == T]
  unlink(path_zipfiles)
}
