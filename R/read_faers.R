#' Read faers data
#'
#' The `read()` functions read FAERS data into a well formatted
#' tibble.
#'
#' @param path (chr) path to the FAERS `.txt` to read.
#'
#' @return a [tibble][tibble::tibble-package] for the FAERS table in `path`.
#'
#' @name read
#' @examples
#'   \dontrun{
#'     demo_db <- read_demo(
#'     path = "path_demo.csv"
#'     )
#'   }
NULL

#' @describeIn read  read DEMO db
#' @export
read_demo <- function(path) {
  readr::read_delim(path, delim = "$",
    col_types = readr::cols(
      auth_num = readr::col_character(),
      lit_ref = readr::col_character()
    )
  ) %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::all_of(c(
          "i_f_code", "rept_cod", "mfr_sndr", "sex", "e_sub", "to_mfr",
          "occp_cod"
        )),
        as.factor
      ),
      dplyr::across(dplyr::all_of(c("caseid", "caseversion", "age")),
        as.integer
      ),
      dplyr::across(dplyr::ends_with("dt"),
        ~lubridate::parse_date_time(.x,
          orders = c("%Y%m%d", "%Y%m", "%Y")
        )
      )
    ) %>%
    mutate(period = period_from_path(path))
}

#' @describeIn read  read DRUG db
#' @export
read_drug <- function(path) {
  readr::read_delim(path, delim = "$",
    col_types = readr::cols(
      exp_dt = readr::col_double(),
      cum_dose_unit = readr::col_character(),
      lot_num = readr::col_character(),
      nda_num = readr::col_double()
    )
  ) %>%
    dplyr::mutate(
      dplyr::across(dplyr::all_of(c("role_cod",  "dechal", "rechal")),
        as.factor
      ),
      dplyr::across(dplyr::all_of(c("caseid", "dose_amt", "drug_seq")),
        as.integer
      ),
      dplyr::across("cum_dose_chr", as.numeric),
      dplyr::across(dplyr::ends_with("dt"),
        ~lubridate::parse_date_time(.x,
          orders = c("%Y%m%d", "%Y%m", "%Y")
        )
      )
    ) %>%
    mutate(period = period_from_path(path))
}

#' @describeIn read  read INDI db
#' @export
read_indi <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across(dplyr::all_of(c("caseid", "indi_drug_seq")),
        as.integer
      )
    ) %>%
    mutate(period = period_from_path(path))
}

#' @describeIn read  read OUTC db
#' @export
read_outc <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across("outc_cod", as.factor),
      dplyr::across(dplyr::all_of("caseid"), as.integer)
    ) %>%
    mutate(period = period_from_path(path))
}

#' @describeIn read  read REAC db
#' @export
read_reac <- function(path) {
  readr::read_delim(path, delim = "$",
    col_types = readr::cols(drug_rec_act = readr::col_character())) %>%
    dplyr::mutate(dplyr::across(dplyr::all_of("caseid"), as.integer))
}

#' @describeIn read  read RPSR db
#' @export
read_rpsr <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across("rpsr_cod", as.factor),
      dplyr::across("caseid", as.integer)
    ) %>%
    mutate(period = period_from_path(path))
}

#' @describeIn read  read THER db
#' @export
read_ther <- function(path) {
  readr::read_delim(path, delim = "$",
    col_types = readr::cols(
      dur = readr::col_double(),
      dur_cod =  readr::col_character()
    )
  ) %>%
    dplyr::mutate(
      dplyr::across(dplyr::all_of(c("caseid", "dsg_drug_seq")),
        as.integer
      ),
      dplyr::across(dplyr::ends_with("dt"),
        ~lubridate::parse_date_time(.x,
          orders = c("%Y%m%d", "%Y%m", "%Y")
        )
      )
    ) %>%
    mutate(period = period_from_path(path))
}


period_from_path <- function(path) {
  start_substring <- -8L
  end_substring <- -5L
  stringr::str_sub(path, start_substring, end_substring)
}
