skip("Tested locally")
test_that("what_is_missing works", {
  path <- getwd()
  simulate_faers_structure(path)
  fs::dir_delete(glue::glue("{path}/faers_raw_data/2015/q1"))
  missingstuff <- what_is_missing(path)
  expect_is(missingstuff, "tbl_df")
  current_str <- purrr::map_chr(missingstuff, ~class(.x)[[1L]])
  expected_str <- c(
    year = "character",
    quarter = "character",
    type = "character",
    mb = "numeric"
  )
  expect_equal(current_str, expected_str)
  fs::dir_delete(glue::glue("{path}/faers_raw_data"))
})
