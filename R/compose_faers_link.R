#' Compose FAERS link
#'
#' This function compose the download link for FAERS data
#'
#' @param year (int) The year of the data to download (no default)
#' @param quarter (char) The quarter of the data to download
#' ("q1", "q2", "q3" or "q4", default: "q1)
#' @param type (char) The format of the data to download,
#' ("ascii" or "xml", default: "ascii")
#'
#' @return Return the link to download FAERS data
#' @export
#'
#' @examples
#' compose_faers_link(2018, "q1", "ascii")
compose_faers_link <- function(year,
                               quarter = c("q1", "q2", "q3", "q4"),
                               type = c("ascii", "xml")) {
  quarter <- match.arg(quarter)
  type <- match.arg(type)
  checkyear(year)
  return(paste0("https://fis.fda.gov/content/Exports/faers_",
                type, "_", year, quarter, ".zip"))
}
