#' List of FAERS data
#'
#' The function lists the metadata for the FAERS databases currently
#' available to download.
#'
#' @return a [tibble][tibble::tibble-package] reporting years, period,
#' quarter, and dimension for available FAERS data.
#' @export
#'
#' @examples
#' fetch_faers_meta()
fetch_faers_meta <- function() {
  faers_html = current_faers_html()
  yearlist <- list_of_faers_years(faers_html)

  meta_raw <- purrr::imap_dfr(yearlist, ~ {
    year_raw <- faers_html %>%
      rvest::html_node(css = compose_table_css(.x)) %>%
      rvest::html_table(header = FALSE, fill = TRUE) %>%
      dplyr::filter(dplyr::row_number() %% 2L == 1L) %>%
      dplyr::select(c(1L, 2L)) %>%
      tibble::as_tibble()
  })

  meta_raw %>%
    dplyr::transmute(
      upload = extract_up_date(.data[["X1"]]),
      period = extract_period(.data[["X1"]]),
      quarter = period2quarter(.data[["period"]]),
      ascii_zip_mb = extract_mb(.data[["X2"]], "ascii"),
      xml_zip_mb = extract_mb(.data[["X2"]], "xml"),
    )
}


list_of_faers_years <- function(faers_html = current_faers_html()) {

  nyears <- number_of_faers_years(faers_html)

  years <- c(rep(NA, nyears))

  for (i in 1L:nyears) {
    year_css <- compose_year_css(i)

    year_node <- rvest::html_node(faers_html, css = year_css)

    years[i] <- xml2::xml_attrs(year_node)[["href"]] %>%
      stringr::str_remove("#collapse")
  }

  years
}


current_faers_meta_url <- function() {
  "https://fis.fda.gov/extensions/FPD-QDE-FAERS/FPD-QDE-FAERS.html"
}


current_faers_html <- function() {
  xml2::read_html(current_faers_meta_url())
}


# Compose a css selector for a specific table of a year
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors)
compose_table_css <- function(year) {
  glue::glue("#collapse{year} > div > div > table")
}


compose_year_css <- function(yearnumber) {
  glue::glue(
    "#accordion > div:nth-child({yearnumber}) > div.panel-heading > h4 > a"
  )
}


number_of_faers_years <- function(faers_html) {
  faers_html %>%
    rvest::xml_node(css = "#accordion") %>%
    xml2::xml_children() %>%
    length()
}


period2quarter <- function(x) {
  dplyr::case_when(
    stringr::str_detect(x, "^October") ~ "q4",
    stringr::str_detect(x, "^July") ~ "q3",
    stringr::str_detect(x, "^April") ~ "q2",
    stringr::str_detect(x, "^January") ~ "q1",
    TRUE ~ NA_character_

  )
}


extract_up_date <- function(x) {
  stringr::str_extract(x, "\\d{1,2}-\\w+-\\d{4}") %>%
    lubridate::dmy()
}


extract_period <- function(x) {
  stringr::str_remove(x, " \\d.+$")
}


extract_mb <- function(x, type = c("ascii", "xml")) {
  type = match.arg(type)

  starting <- "([^-]+- )"
  if (type == "ascii") {
    starting <- paste0("^", starting)
  }


  ending <- "MB(.|\n)+"
  if (type == "xml") {
    ending <- paste0(ending, "?")
  }

  to_remove <- paste0(starting, "|", ending)

  as.numeric(stringr::str_remove_all(x, to_remove))
}
