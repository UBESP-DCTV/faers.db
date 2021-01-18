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
  dir.create(path = testfolder2)
  dir.create(path = testfolder3)
  expect_warning(check_root_folder(getwd()))
  fs::file_delete(testfolder2)
  fs::file_delete(testfolder3)

  truefolder <- glue::glue("{getwd()}/faers_raw_data")
  dir.create(path = truefolder)
  expect_equal(check_root_folder(getwd()), TRUE)
  fs::file_delete(truefolder)
})
