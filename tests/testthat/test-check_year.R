test_that("check_year works", {

  expect_true(check_year(2013))

  expect_message(
    expect_false(check_year(2012)),
    "is too far in the past"
  )

  next_year <- lubridate::year(Sys.Date()) + 1L
  expect_message(
    expect_false(check_year(next_year)),
    "is in the future"
  )
})
