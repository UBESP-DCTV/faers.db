check_root_folder <- function(path) {
  dirlist <- list.dirs(path, recursive = FALSE)
  is_faers_folder <- grepl("faers_raw_data", dirlist)
  if (sum(is_faers_folder) == 0) {
    warning("I can't find a folder named 'faers_raw_data'.")
    return(FALSE)
  }
  if (sum(is_faers_folder) > 1) {
    warning("Too Many folders named 'faers_raw_data' (or similar).")
    return(FALSE)
  }
  TRUE
}
