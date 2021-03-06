#' Read faers data
#'
#' The `read_*()` functions read FAERS data into a well formatted
#' tibble.
#'
#' @param path (chr) path to the FAERS `.txt` to read.
#'
#' @return a [tibble][tibble::tibble-package] for the FAERS table in `path`.
#' @export
#'
#' @examples
#'   \dontrun{
#'     demo_path <- system.file(
#'       "testing-data/DEMO20Q3-10.txt",
#'        package = "faers.db"
#'     )
#'     read_demo(demo_path)
#'   }
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
    )
}

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
    )
}

read_indi <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across(dplyr::all_of(c("caseid", "indi_drug_seq")),
        as.integer
      )
    )
}

read_outc <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across("outc_cod", as.factor),
      dplyr::across(dplyr::all_of("caseid"), as.integer)
    )
}

read_reac <- function(path) {
  readr::read_delim(path, delim = "$",
    col_types = readr::cols(drug_rec_act = readr::col_character())) %>%
    dplyr::mutate(dplyr::across(dplyr::all_of("caseid"), as.integer))
}

read_rpsr <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across("rpsr_cod", as.factor),
      dplyr::across("caseid", as.integer)
    )
}

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
    )
}
