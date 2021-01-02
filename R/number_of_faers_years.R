#' Number of FAERS years
#'
#' Retrieve the number of FAERS year currently listed on the FAERS web page
#'
#' @param faers_html An output of the fetch_faers_meta() function
#'
#' @return An integer number
#' @export
#'
#' @examples
#' number_of_faers_years(fetch_faers_meta())
number_of_faers_years <- function(faers_html) {
  number_of_years <-  faers_html %>%
    rvest::xml_node(css = "#accordion") %>%
    xml2::xml_children() %>%
    length()
  return(number_of_years)
}
