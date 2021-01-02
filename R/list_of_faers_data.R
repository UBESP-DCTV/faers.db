#' List of FAERS data
#'
#' The function lists the databases currently online on the FAERS web
#' page
#'
#' @param faers_url (char) Url of the FAERS repository web page
#'   (do not modify the default url unless it is changed by the web page
#'    owner)
#'
#' @return a [tibble][tibble::tibble-package] reporting years, period,
#' quarter, and dimension for available FAERS data.
#' @export
#'
#' @examples
#' list_of_faers_data()
list_of_faers_data <- function(
  faers_url = NULL
) {
  if (is.null(faers_url)) {
    faers_url <- paste0("https://fis.fda.gov/extensions/FPD-QDE-FAERS/",
                        "FPD-QDE-FAERS.html"
    )
  }

  yearlist <- list_of_faers_years(faers_url)
  faers_html <- import_faers_html(faers_url)

  purrr::imap_dfr(yearlist, ~ {

    year_raw <- faers_html %>%
      rvest::html_node(css = compose_table_css(.x)) %>%
      rvest::html_table(header = FALSE, fill = TRUE) %>%
      dplyr::filter(dplyr::row_number() %% 2L == 1L) %>%
      dplyr::select(c(1L, 2L))

    year_raw %>%
      tibble::as_tibble() %>%
      dplyr::transmute(
        year = .x,
        period = .data[["X1"]] %>%
          stringr::str_remove(glue::glue(" {.x}.*$")),
        quarter = period2quarter(.data[["period"]]),
        ascii_zip_mb = extract_mb(.data[["X2"]], "ascii"),
        xml_zip_mb = extract_mb(.data[["X2"]], "xml"),
      )
  })
}

# Compose a css selector for a specific table of a year
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors)
compose_table_css <- function(year) {
  glue::glue("#collapse{year} > div > div > table")
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
