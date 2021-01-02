#' Title
#'
#' @param faers_url (char) Url of the FAERS repository web page
#' (do not modify the default url unless it is changed by the web page owner)
#'
#' @return A vector with the list of years currently online on the FAERS website
#' @export
#'
#' @examples
#' list_of_faers_years()
list_of_faers_years <- function(faers_url = "https://fis.fda.gov/extensions/FPD-QDE-FAERS/FPD-QDE-FAERS.html") {
  faers_html_code <- xml2::read_html(faers_url)
  nyears <- number_of_faers_years(faers_html_code)
  years <- c(rep(NA, nyears))
  for (i in 1L:nyears) {
    year_css <- compose_year_css(i)
    year_node <- faers_html_code %>%
      rvest::html_node(css = year_css)
    years[i] <- gsub("#collapse", "",
                     xml2::xml_attrs(year_node)[["href"]])
  }
  return(years)
}

# A small function to compose a css selector for a speficic year
# (wondering what a css selector is? Take a look at
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors)
compose_year_css <- function(yearnumber) {
  paste0("#accordion > div:nth-child(",
         yearnumber,
         ") > div.panel-heading > h4 > a")
}
