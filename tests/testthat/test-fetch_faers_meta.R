test_that("fetch_faers_meta works", {
  faers_meta <- fetch_faers_meta()
  expect_is(faers_meta, "tbl_df")

  current_str <- purrr::map_chr(faers_meta, ~class(.x)[[1L]])
  expected_str <- c(
    year = "character",
    period = "character",
    quarter = "character",
    ascii_zip_mb = "numeric",
    xml_zip_mb = "numeric"
  )
  expect_equal(current_str, expected_str)
})



test_that("extract_upload_year works", {
  x_full <- "July - September 2020posted on 17-Nov-2020"
  res_full <- extract_upload_year(x_full)
  expect_equal(res_full, "2020")

  x_short <- "July - September 2020"
  res_short <- extract_upload_year(x_short)
  expect_equal(res_short, "2020")
})


test_that("extract_period works", {
  x <- "July - September 2020posted on 17-Nov-2020"
  res <- extract_period(x)
  expect_equal(res, "July - September")
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
  expect_equal(res_ascii, 64.0)
  expect_equal(res_xml, 121.0)
})


test_that("extract_mb works with decimals", {
  x <- "ASCII\n      (ZIP - 64.2MB)\n     XML\n      (ZIP - 121.45MB)"
  res_ascii <- extract_mb(x)
  res_xml <- extract_mb(x, "xml")
  expect_equal(res_ascii, 64.2)
  expect_equal(res_xml, 121.45)
})
