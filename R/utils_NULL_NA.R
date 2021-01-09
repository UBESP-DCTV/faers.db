#' Default for NULL (or NA) values
#'
#' These two functions assign a default value to a parameter if it was
#' previously set to NULL (or NA)
#'
#' @param x Parameter
#' @param y Chosen default value
#'
#' @return The parameter or the default value
#' @export
#'
#' @examples
#' NULL %NULL% 3 # = 3
#' 5 %NULL% 3 # = 5
`%NULL%` <- function(x, y) {
  if (is.null(x)) y else x
}

`%NA%` <- function(x, y) {
  if (is.na(x)) y else x
}
