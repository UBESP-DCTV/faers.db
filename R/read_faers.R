#' Title
#'
#' @param path  refers to the dataset's path
#'
#' @return import DB read_*
#' @export
#'
#' @examples read_demo <- function(path) {
#'  utils::read.csv(path, sep = "$")
#'    }

read_demo <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%  dplyr::mutate(across(c("i_f_code", "rept_cod","mfr_sndr", "sex",
                                     "e_sub", "to_mfr","occp_cod") , as.factor), #transform to factor
                            across(c("event_dt","mfr_dt", "init_fda_dt",
                                     "fda_dt", "rept_dt"  ), ymd) ,
                            across(c("primaryid", "caseid", "caseversion" ,"age"), as.integer))
  x
}

