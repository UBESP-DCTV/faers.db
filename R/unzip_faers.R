unzip_faers <- function(
    base_dir,
    faers_raw_dir = "faers_raw_data",
    faers_unzip_dir = "unzip_file",
    keep_txt_only = TRUE
) {
  unzip_path <- file.path(base_dir, faers_unzip_dir)
  usethis::ui_todo("Unzip FAERS...")
  file.path(base_dir, faers_raw_dir) |>
    fs::dir_ls(recurse = TRUE, type = "file", regexp = "\\.zip") |>
    purrr::walk(\(x) {
      unzip(x, exdir = unzip_path)
  }, .progress = TRUE)
  usethis::ui_done("FAERS unzipped!")

  if (keep_txt_only) {
    usethis::ui_todo("Removing non-txt files...")
    file.path(unzip_path, "ascii") |>
      fs::dir_ls(
        recurse = TRUE,
        type = "file",
        regexp = "\\.txt$",
        invert = TRUE
      ) |>
      fs::file_delete()
    usethis::ui_done("Non-txt files removed!")
  }

  invisible(TRUE)
}
