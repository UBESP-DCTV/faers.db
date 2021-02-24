skip("Tested locally")
test_that("fetch_local works", {
  tdir <- glue::glue("{getwd()}/faers_raw_data/2015/q1")
  dir.create(tdir, recursive = TRUE)
  tfile <- "faers_ascii_2015q1.zip"
  file.create(glue::glue("{tdir}/{tfile}"))
  local_meta <- fetch_local(getwd())
  expect_is(local_meta, "tbl_df")
  current_str <- purrr::map_chr(local_meta, ~class(.x)[[1L]])
  expected_str <- c(path = "character",
                    year = "character",
                    quarter = "character",
                    type = "character")
  expect_equal(current_str, expected_str)
  fs::file_delete(glue::glue("{getwd()}/faers_raw_data"))
})
