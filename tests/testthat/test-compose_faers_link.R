test_that("compose_faers_link works", {
  ok_link <- compose_faers_link(2018L, "q1", "ascii")
  expected <- paste0(
    "https://fis.fda.gov/content/Exports/", "faers_ascii_2018q1.zip"
  )
  expect_equal(ok_link, expected)
  expect_warning(
    compose_faers_link(2012L, "q1", "ascii"),
    "Data not available"
  )
})
