test_that("read_demo works", {
  db_test_path <- system.file("testing-data/DEMO20Q3-10.txt",
    package = "faers.db"
  )
  res <- read_demo(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "integer",
    caseid = "integer",
    caseversion = "integer",
    i_f_code = "factor",
    event_dt = "POSIXct",
    mfr_dt = "POSIXct",
    init_fda_dt = "POSIXct",
    fda_dt = "POSIXct",
    rept_cod = "factor",
    auth_num = "logical",
    mfr_num = "character",
    mfr_sndr = "factor",
    lit_ref = "logical",
    age = "integer",
    age_cod = "character",
    age_grp = "character",
    sex = "factor",
    e_sub = "factor",
    wt = "numeric",
    wt_cod = "character",
    rept_dt = "POSIXct",
    to_mfr = "factor",
    occp_cod = "factor",
    reporter_country = "character",
    occr_country = "character"
  )

  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1]]),
    expected_class_names
  )

})
