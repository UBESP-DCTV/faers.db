test_that("retrieve_qde works", {
  expect_warning(
    retrieve_qde(path = getwd(), year = 2013L),
    "Year must be character"
  )
  expect_warning(
    retrieve_qde(path = getwd(), year = "2010"),
    "Use a year after 2013 up to the current year"
  )
  expect_error(
    retrieve_qde(path = getwd(),
                 year = "2017",
                 quarter = "q5")
  )
  expect_warning(
    retrieve_qde(path = getwd(),
                 year = "2016",
                 quarter = "q2",
                 create_folder = FALSE),
    "Permission to create folder denied by the user"
  )
})


test_that("checkpath works", {
  expect_equal(
    checkpath(getwd()),
    TRUE
  )
})


test_that("checkyear works", {
  result <- checkyear("2020")
  expected <- TRUE
  expect_equal(result, expected)
  expect_warning(
    checkyear(2015L),
    "Year must be character"
  )
  expect_warning(
    checkyear("2012"),
    "Use a year after 2013 up to the current year"
  )
  expect_warning(
    checkyear("5000"),
    "Use a year after 2013 up to the current year"
  )
})


test_that("compose_faers_link works", {
  ok_link <- compose_faers_link(2018L, "q1", "ascii")
  expected <- paste0(
    "https://fis.fda.gov/content/Exports/",
    "faers_ascii_2018q1.zip"
  )
  expect_equal(ok_link, expected)
  expect_warning(
    compose_faers_link(2012L, "q1", "ascii"),
    "Data not available"
  )
})


test_that("compose_faers_path works", {
  ok_path <- compose_faers_path(year = 2015L,
                                quarter = "q1",
                                path = "C:")
  expected <- "C:/faers_raw_data/2015/q1"
  expect_equal(ok_path, expected)
})


test_that("permission_create_folder works", {
  expect_equal(permission_create_folder(getwd(), FALSE),
               FALSE)
  expect_equal(permission_create_folder(getwd(), TRUE),
               TRUE)
})

test_that("permission_download_file works", {
  expect_equal(permission_download_file(getwd(), FALSE),
               FALSE)
  expect_equal(permission_download_file(getwd(), TRUE),
               TRUE)
})
