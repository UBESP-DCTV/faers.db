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
