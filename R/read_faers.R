#' Title
#'
#' @param path  refers to the dataset's path,
#'
#' @return import DB read_* already trasformed
#' @export
#'
#' @examples x <- read_demo("C:/Users/nicola/Desktop/faers data/DEMO20Q3.txt")
#'           x <- read_demo("C:/Users/nicola/Desktop/DRUG20Q3.txt")


read_demo <- function(path) {
  x <- readr::read_delim(path, delim = "$")
  x <- x %>%
    dplyr::mutate(dplyr::across(c("i_f_code", "rept_cod",
                                  "mfr_sndr", "sex", "e_sub", "to_mfr","occp_cod") , as.factor),
                  dplyr::across(c("primaryid", "caseid", "caseversion" ,"age"), as.integer))
  x[[5]] <- lubridate::parse_date_time(x[[5]], orders = c("%Y%m%d", "%Y%m", "%Y"))
  x[[6]] <- lubridate::parse_date_time(x[[6]], orders = c("%Y%m%d", "%Y%m", "%Y"))
  x[[7]] <- lubridate::parse_date_time(x[[7]], orders = c("%Y%m%d", "%Y%m", "%Y"))
  x[[8]] <- lubridate::parse_date_time(x[[8]], orders = c("%Y%m%d", "%Y%m", "%Y"))
  x[[21]] <- lubridate::parse_date_time(x[[21]], orders = c("%Y%m%d", "%Y%m", "%Y"))
  x
}

read_drug <- function(path) {
  x <- readr::read_delim(path, delim = "$",  col_types =
                                              readr::cols(exp_dt = readr::col_double()))
  x <- x %>%
    dplyr::mutate(dplyr::across(c("role_cod",  "dechal", "rechal") , as.factor), #transform to factor
                  dplyr::across(c("primaryid", "caseid", "nda_num", "dose_amt", "drug_seq"),
                                as.integer),
                  dplyr::across("cum_dose_chr", as.numeric))
  x[[15]] <- lubridate::parse_date_time(x[[15]], orders = c("%Y%m%d", "%Y%m", "%Y"))

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
    dplyr::mutate(dplyr::across("outc_cod", as.factor),
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
    dplyr::mutate(dplyr::across("rpsr_cod" , as.factor), #transform to factor
                  dplyr::across(c("primaryid", "caseid"), as.integer))
  x
}

read_ther <- function(path) {
  x <- readr::read_delim(path, delim = "$", col_types =
                           readr::cols(dur = readr::col_double(),
                                       dur_cod =  readr::col_character()))
  x <- x %>%  dplyr::mutate(dplyr::across(c("primaryid", "caseid", "dsg_drug_seq"),
                                          as.integer))
  x[[4]] <- lubridate::parse_date_time(x[[4]], orders = c("%Y%m%d", "%Y%m", "%Y"))
  x[[5]] <- lubridate::parse_date_time(x[[5]], orders = c("%Y%m%d", "%Y%m", "%Y"))
  x
}
