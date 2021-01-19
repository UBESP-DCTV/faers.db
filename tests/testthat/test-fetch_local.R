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

test_that("year_from_zipname works", {
  path <- "2014/q1/faers_ascii_2014q1.zip"
  expect_equal(
    year_from_zipname(path),
    "2014"
  )
})


test_that("quarter_from_zipname works", {
  path <- "2014/q1/faers_ascii_2014q1.zip"
  expect_equal(
    quarter_from_zipname(path),
    "q1"
  )
})


test_that("type_from_zipname works", {
  path <- "2014/q1/faers_ascii_2014q1.zip"
  expect_equal(
    type_from_zipname(path),
    "ascii"
  )
})
