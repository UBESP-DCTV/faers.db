#' Title
#'
#' @param path  refers to the dataset's path,
#'
#' @return import DB read_* already trasformed
#' @export
#'
#' @examples x <- read_demo("C:/Users/nicol/Desktop/faers data/DEMO20Q3.txt")
#'           x <- read_demo("C:/Users/nicola/Desktop/DRUG20Q3.txt")


read_demo <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%  dplyr::mutate(dplyr::across(c("i_f_code", "rept_cod","mfr_sndr", "sex",
                                            "e_sub", "to_mfr","occp_cod") , as.factor), #transform to factor
                            dplyr::across(c("primaryid", "caseid", "caseversion" ,"age"), as.integer))
  x$event_dt <- lubridate::parse_date_time(x$event_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))
  x$mfr_dt <- lubridate::parse_date_time(x$mfr_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))
  x$init_fda_dt <- lubridate::parse_date_time(x$init_fda_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))
  x$fda_dt <- lubridate::parse_date_time(x$fda_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))
  x$rept_dt <- lubridate::parse_date_time(x$rept_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))
  x
}

read_drug <- function(path) {
  x <- readr::read_delim(path, delim = "$",  col_types =
                                              readr::cols(exp_dt = readr::col_double()))
  x <- x %>%
    dplyr::mutate(dplyr::across(c("role_cod",  "dechal", "rechal") , as.factor), #transform to factor
                  dplyr::across(c("primaryid", "caseid", "nda_num", "dose_amt", "drug_seq"),
                                as.integer),
                  dplyr::across(c("cum_dose_chr"), as.numeric))
  x$exp_dt <- lubridate::parse_date_time(x$exp_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))

  x
}

read_indi <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%
    dplyr::mutate(dplyr::across(c("primaryid", "caseid", "indi_drug_seq"), as.integer))
  x
}

read_outc <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%
    dplyr::mutate(dplyr::across(outc_cod, as.factor),
                  dplyr::across(c("primaryid", "caseid"), as.integer))
  x
}

read_reac <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%
    dplyr::mutate(dplyr::across(c("primaryid", "caseid"), as.integer))
  x
}

read_rpsr <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%
    dplyr::mutate(dplyr::across(c("rpsr_cod") , as.factor), #transform to factor
                  dplyr::across(c("primaryid", "caseid"), as.integer))
  x
}

read_ther <- function(path) {
  x <- readr::read_delim(path, delim = "$", col_types =
                           readr::cols(dur = readr::col_double(),
                                       dur_cod =  readr::col_character()))
  x <- x %>%  dplyr::mutate(dplyr::across(c("primaryid", "caseid", "dsg_drug_seq"),
                                          as.integer))
  x$start_dt <- lubridate::parse_date_time(x$start_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))
  x$end_dt <- lubridate::parse_date_time(x$end_dt, orders = c("%Y%m%d", "%Y%m", "%Y"))
  x
}
