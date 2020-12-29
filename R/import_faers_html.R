#' Import FAERS html
#'
#' Import FAERS html from the FAERS web page
#'
#' @param faers_url (char) Url of the FAERS repository web page
#' (do not modify the default url unless it is changed by the web page owner)
#'
#' @return An XML document
#' @export
#'
#' @examples
#' import_faers_html()
import_faers_html <- function(faers_url = "https://fis.fda.gov/extensions/
                              FPD-QDE-FAERS/FPD-QDE-FAERS.html") {
  return(xml2::read_html(faers_url))
}
