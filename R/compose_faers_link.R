#' Compose FAERS link
#'
#' This function compose the download link for FAERS data
#'
#' @param year (int) The year of the data to download.
#' @param quarter (char, default: "q1") The quarter of the data
#'   to download between "q1", "q2", "q3" or "q4".
#' @param type (char, default: "ascii") The format of the data to
#'   download between "ascii" or "xml",
#'
#' @return (chr) the link to download selected FAERS `.zip` data.
#'
#' @examples
#' compose_faers_link(2018, "q1", "ascii")
compose_faers_link <- function(year,
                               quarter = c("q1", "q2", "q3", "q4"),
                               type = c("ascii", "xml")
) {
  quarter <- match.arg(quarter)
  stopifnot(`Data available` = is_year_quarter_available(year, quarter))

  type <- match.arg(type)

  glue::glue(
    "https://fis.fda.gov/content/Exports/faers_{type}_{year}{quarter}.zip"
  )
}
