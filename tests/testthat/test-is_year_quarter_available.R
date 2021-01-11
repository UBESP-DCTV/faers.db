test_that("is_year_quarter_available works", {
  q1_2012 <- is_year_quarter_available(2012L, "q1")
  expect_false(q1_2012)

  next_year <- lubridate::year(Sys.Date()) + 1L
  q1_next <- is_year_quarter_available(next_year, "q1")
  expect_false(q1_next)

  q3_2020 <- is_year_quarter_available(2020L, "q3")
  expect_true(q3_2020)
})
