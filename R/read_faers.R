#' Title
#'
#' @param path  refers to the dataset's path,
#'
#' @return import DB read_* already trasformed
#' @export
#'
#' @examples x <- read_demo("C:/Users/nicola/Desktop/DEMO20Q3.txt")
#'           x <- read_demo("C:/Users/nicola/Desktop/DRUG20Q3.txt")


read_demo <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%  dplyr::mutate(across(c("i_f_code", "rept_cod","mfr_sndr", "sex",
                                     "e_sub", "to_mfr","occp_cod") , as.factor), #transform to factor
                            across(c("event_dt","mfr_dt", "init_fda_dt",
                                     "fda_dt", "rept_dt"  ), ymd) ,
                            across(c("primaryid", "caseid", "caseversion" ,"age"), as.integer))
  x
}

read_drug <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%
    dplyr::mutate(across(c("role_cod",  "dechal", "rechal") , as.factor), #transform to factor
                  across(c("primaryid", "caseid", "nda_num", "dose_amt"), as.integer),
                  across(c("cum_dose_chr"), as.numeric)) %>%
    parse_date_time(exp_dt, c("Ymd", "Ym", "Y"))
  x
}
