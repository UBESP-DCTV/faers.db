test_that("list_of_faers_data works", {
  available_faers <- list_of_faers_data()
  expect_is(available_faers, "tbl_df")
})



test_that("period2quarter works", {
  q1 <- period2quarter("January - March 2020")
  q2 <- period2quarter("April - June 2020")
  q3 <- period2quarter("July - September 2020")
  q4 <- period2quarter("October - December 2020")

  expect_equal(q1, "q1")
  expect_equal(q2, "q2")
  expect_equal(q3, "q3")
  expect_equal(q4, "q4")
})


test_that("extract_mb works", {
  x <- "ASCII\n      (ZIP - 64MB)\n     XML\n      (ZIP - 121MB)"
  res_ascii <- extract_mb(x)
  res_xml <- extract_mb(x, "xml")
  expect_equal(res_ascii, 64)
  expect_equal(res_xml, 121)
})

test_that("extract_mb works with decimals", {
  x <- "ASCII\n      (ZIP - 64.2MB)\n     XML\n      (ZIP - 121.45MB)"
  res_ascii <- extract_mb(x)
  res_xml <- extract_mb(x, "xml")
  expect_equal(res_ascii, 64.2)
  expect_equal(res_xml, 121.45)
})
