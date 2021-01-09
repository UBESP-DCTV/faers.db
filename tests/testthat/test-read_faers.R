test_that("read_demo works", {
  db_test_path <- system.file("testing-data/DEMO20Q3-10.txt",
    package = "faers.db"
  )
  res <- read_demo(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    caseversion = "integer",
    i_f_code = "factor",
    event_dt = "POSIXct",
    mfr_dt = "POSIXct",
    init_fda_dt = "POSIXct",
    fda_dt = "POSIXct",
    rept_cod = "factor",
    auth_num = "character",
    mfr_num = "character",
    mfr_sndr = "factor",
    lit_ref = "character",
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
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )

})


test_that("read drug works", {
  db_test_path <-  system.file("testing-data/DRUG20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_drug(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    drug_seq = "integer",
    role_cod = "factor",
    drugname = "character",
    prod_ai = "character",
    val_vbm = "numeric",
    route = "character",
    dose_vbm = "character",
    cum_dose_chr = "numeric",
    cum_dose_unit = "character",
    dechal = "factor",
    rechal = "factor",
    lot_num = "character",
    exp_dt = "POSIXct",
    nda_num = "numeric",
    dose_amt = "integer",
    dose_unit = "character",
    dose_form = "character",
    dose_freq = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})



test_that("read indi works", {
  db_test_path <-  system.file("testing-data/INDI20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_indi(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    indi_drug_seq = "integer",
    indi_pt = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})



test_that("read outc works", {
  db_test_path <-  system.file("testing-data/OUTC20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_outc(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    outc_cod = "factor"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read reac works", {
  db_test_path <-  system.file("testing-data/REAC20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_reac(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    pt = "character",
    drug_rec_act = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read rpsr works", {
  db_test_path <-  system.file("testing-data/RPSR20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_rpsr(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    rpsr_cod = "factor"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read ther works", {
  db_test_path <-  system.file("testing-data/THER20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_ther(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    dsg_drug_seq = "integer",
    start_dt = "POSIXct",
    end_dt = "POSIXct",
    dur = "numeric",
    dur_cod = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})
