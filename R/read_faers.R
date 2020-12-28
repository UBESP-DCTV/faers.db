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
                            dplyr::across(c("primaryid", "caseid", "caseversion" ,"age"), as.integer)) %>%
    lubridate::parse_date_time(c(event_dt, mfr_dt, init_fda_dt,
                                 fda_dt, rept_dt), c("Ymd", "Ym", "Y"), tz = "UTC")
  x
}

read_drug <- function(path) {
  x <- readr::read_delim(path, delim = "$", , col_types =
                                              readr::cols(exp_dt = readr::col_double()))
  x <- x %>%
    dplyr::mutate(dplyr::across(c("role_cod",  "dechal", "rechal") , as.factor), #transform to factor
                  dplyr::across(c("primaryid", "caseid", "nda_num", "dose_amt", "drug_seq"),
                                as.integer),
                  dplyr::across(c("cum_dose_chr"), as.numeric)) %>%
    lubridate::parse_date_time(exp_dt, c("Ymd", "Ym", "Y"), tz = "UTC")
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
                                          as.integer)) %>%
    lubridate::parse_date_time(c(start_dt, end_dt), c("Ymd", "Ym", "Y"), tz = "UTC")
  x
}
