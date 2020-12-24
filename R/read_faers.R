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
  x <- utils::read.csv(path, sep = "$")
  x <- x %>%  dplyr::mutate_at(c("i_f_code", "rept_cod","mfr_sndr", "sex",
                                 "e_sub", "to_mfr","occp_cod",) , as.factor) #transform to factor
  # init_fda_dt, fda_dt,repr_dt to date
  x
}
