#' List of FAERS data
#'
#' The function lists the databases currently online on the FAERS web page
#'
#' @param faers_url (char) Url of the FAERS repository web page
#' (do not modify the default url unless it is changed by the web page owner)
#'
#' @return A list. Each element of the list is a data frame corresponding of a
#' year of FAERS data. Inside each data frame some information of the data are
#' available (for example: available quarters or dimension of the database)
#' @export
#'
#' @examples
#' list_of_faers_data()
list_of_faers_data <- function(faers_url = "https://fis.fda.gov/extensions/FPD-QDE-FAERS/FPD-QDE-FAERS.html") {
  yearlist <- list_of_faers_years(faers_url)
  faers_html <- import_faers_html(faers_url)
  out <- list()
  for (i in yearlist) {
    year_raw <- faers_html %>%
      rvest::html_node(css = compose_table_css(i)) %>%
      rvest::html_table(header = FALSE, fill = TRUE) %>%
      dplyr::filter(dplyr::row_number() %% 2L == 1L) %>%
      dplyr::select(c(1L, 2L))
    year_fine <- as.data.frame(sub("posted.*", "",
                                   year_raw[, 1L]))
    colnames(year_fine) <- "period"
    year_fine$quarter <- rep("q4", NROW(year_fine))
    year_fine$quarter[year_fine$period == paste0("July - September ",
                                                 i)] <- "q3"
    year_fine$quarter[year_fine$period == paste0("April - June ",
                                                 i)] <- "q2"
    year_fine$quarter[year_fine$period == paste0("January - March ",
                                                 i)] <- "q1"
    year_fine$dimension <- gsub("\n      ", " ",
                                year_raw[, 2L])
    year_fine$dimension <- gsub("\n     ", "   ",
                                year_fine$dimension)
    out[[paste0("year: ", i)]] <- year_fine
  }
  return(out)
}

# A small function to compose a css selector for a speficic table of a year
# (wondering what a css selector is? Take a look at
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors)
compose_table_css <- function(year) {
  paste0("#collapse",
         year,
         " > div > div > table")
}
