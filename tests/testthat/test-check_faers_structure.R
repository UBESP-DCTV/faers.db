skip("Tested locally")
test_that("check_root_folder works", {
  testfolder1 <- glue::glue("{getwd()}/tempfolder")
  dir.create(testfolder1)
  expect_warning(
    check_root_folder(getwd()),
    "I can't find a folder named 'faers_raw_data'."
  )
  fs::file_delete(testfolder1)

  testfolder2 <- glue::glue("{getwd()}/faers_raw_dataA")
  testfolder3 <- glue::glue("{getwd()}/faers_raw_dataB")
  dir.create(testfolder2)
  dir.create(testfolder3)
  expect_warning(check_root_folder(getwd()))
  fs::file_delete(testfolder2)
  fs::file_delete(testfolder3)

  truefolder <- glue::glue("{getwd()}/faers_raw_data")
  dir.create(truefolder)
  expect_equal(check_root_folder(getwd()), TRUE)
  fs::file_delete(truefolder)
})

test_that("check_years_directory works", {
  faersyears <- years_from_faers_html()
  testfolder <- glue::glue("{getwd()}/faers_raw_data/foo")
  dir.create(testfolder, recursive = TRUE)
  expect_warning(
    check_years_directory(getwd(), faersyears),
    glue::glue("The following folders do not match a FAERS year: ",
               ".../faers_raw_data/foo. ",
               "Please remove the folders or change directory path.")
  )
  fs::file_delete(glue::glue("{getwd()}/faers_raw_data"))

  truefolder <- glue::glue("{getwd()}/faers_raw_data/2015")
  dir.create(truefolder, recursive = TRUE)
  expect_equal(check_years_directory(getwd(), faersyears),
               character(0L))
  fs::file_delete(glue::glue("{getwd()}/faers_raw_data"))
})


test_that("check_quarter_every_year works", {
  faersyears <- years_from_faers_html()
  testfolder1 <- glue::glue("{getwd()}/faers_raw_data/2015/q1")
  testfolder2 <- glue::glue("{getwd()}/faers_raw_data/2016/q2")
  dir.create(testfolder1, recursive = TRUE)
  dir.create(testfolder2, recursive = TRUE)
  expect_equal(check_quarter_every_year(getwd(), faersyears), 0L)
  fs::file_delete(glue::glue("{getwd()}/faers_raw_data"))
})


test_that("check_quarter_directory works", {
  year <- 2015L
  testfolder <- glue::glue("{getwd()}/faers_raw_data/{year}/tempfolder")
  dir.create(testfolder, recursive = TRUE)
  expect_warning(
    check_quarter_directory(getwd(), year),
    glue::glue("The following folders do not match a FAERS quarter: ",
               ".../faers_raw_data/2015/tempfolder. ",
               "Please remove the folders or change directory path.")
  )
  fs::file_delete(glue::glue("{getwd()}/faers_raw_data"))

  truefolder <- glue::glue("{getwd()}/faers_raw_data/{year}/q1")
  dir.create(truefolder, recursive = TRUE)
  expect_equal(check_quarter_directory(getwd(), year),
               character(0L))
  fs::file_delete(glue::glue("{getwd()}/faers_raw_data"))
})


test_that("check_files works", {
  testfolder <- glue::glue("{getwd()}/faers_raw_data/2015")
  testfile <- glue::glue("{getwd()}/faers_raw_data/2015/foo.csv")
  dir.create(testfolder, recursive = TRUE)
  file.create(testfile)
  expect_warning(
    check_files(getwd()),
    glue::glue("The following files do not match a FAERS dataset: 2015/",
               "foo.csv.",
               " Please remove the files or change directory path.")
  )
  fs::file_delete(glue::glue("{getwd()}/faers_raw_data"))
})


test_that("all_possible_filenames works", {
  out <- all_possible_filenames()
  expect_equal(all_possible_filenames(),
               out)
})
