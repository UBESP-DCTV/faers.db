skip("Tested locally")
test_that("retrieve_qde works", {
  expect_warning(
    retrieve_qde(path = ".", year = 2013L),
    "Year must be character"
  )
  expect_warning(
    retrieve_qde(path = ".", year = "2010"),
    "Use a year after 2012 up to the current year"
  )
  expect_error(
    retrieve_qde(path = ".",
                 year = "2017",
                 quarter = "q5")
  )
  expect_warning(
    retrieve_qde(path = ".",
                 year = "2016",
                 quarter = "q2",
                 create_folder = FALSE),
    "Permission to create folder denied by the user"
  )
})


test_that("checkpath works", {
  expect_equal(
    checkpath("."),
    TRUE
  )
})


test_that("checkyear works", {
  result <- checkyear(year = "2020")
  expected <- TRUE
  expect_equal(result, expected)
  expect_warning(
    checkyear(year = 2015L),
    "Year must be character"
  )
  expect_warning(
    checkyear(year = "2011"),
    "Use a year after 2012 up to the current year"
  )
  expect_warning(
    checkyear(year = "5000"),
    "Use a year after 2012 up to the current year"
  )
})


test_that("compose_faers_link works", {
  ok_link <- compose_faers_link(year = 2018L, quarter =  "q1", type = "ascii")
  expected <- paste0(
    "https://fis.fda.gov/content/Exports/",
    "faers_ascii_2018q1.zip"
  )
  expect_equal(ok_link, expected)
  expect_warning(
    compose_faers_link(year = 2012L, quarter =  "q1", type = "ascii"),
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
  expect_equal(permission_create_folder(faerspath = ".",
                                        create_folder = FALSE,
                                        interactive_session = FALSE),
               FALSE)
  expect_equal(permission_create_folder(faerspath = ".",
                                        create_folder = TRUE,
                                        interactive_session = FALSE),
               TRUE)
})

test_that("permission_download_file works", {
  expect_equal(permission_download_file(faerspath = ".",
                                        download_data = FALSE,
                                        interactive_session = FALSE),
               FALSE)
  expect_equal(permission_download_file(faerspath = ".",
                                        download_data = TRUE,
                                        interactive_session = FALSE),
               TRUE)
})
