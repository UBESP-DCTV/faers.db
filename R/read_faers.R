#' Title
#'
#' @param path  refers to the file's path
#'
#' @return import DB read_*
#' @export
#'
#' @examples
#' read_demo <- function(path) {
#'  utils::read.csv(path, sep = "$")
#'    }
read_demo <- function(path) {
  utils::read.csv(path, sep = "$")
}
