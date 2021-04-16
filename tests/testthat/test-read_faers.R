
# test faers db from 2014q3 ---------------------------------------


test_that("read_demo works", {
  db_test_path <- system.file("testing-data/faers20/DEMO20Q3-10.txt",
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
    occr_country = "character",
    period = "character"
  )

  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )

})

test_that("read drug works", {
  db_test_path <-  system.file("testing-data/faers20/DRUG20Q3-10.txt",
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
    dose_freq = "character",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read indi works", {
  db_test_path <-  system.file("testing-data/faers20/INDI20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_indi(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    indi_drug_seq = "integer",
    indi_pt = "character",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read outc works", {
  db_test_path <-  system.file("testing-data/faers20/OUTC20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_outc(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    outc_cod = "factor",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read reac works", {
  db_test_path <-  system.file("testing-data/faers20/REAC20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_reac(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    pt = "character",
    drug_rec_act = "character",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read rpsr works", {
  db_test_path <-  system.file("testing-data/faers20/RPSR20Q3-10.txt",
                               package = "faers.db"
  )

  res <- read_rpsr(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    rpsr_cod = "factor",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read ther works", {
  db_test_path <-  system.file("testing-data/faers20/THER20Q3-10.txt",
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
    dur_cod = "character",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})


############## test if date are imported properly #######

test_that("read_demo works", {
  db_test_path <- system.file("testing-data/faers20/DEMO20Q3-1-date.txt",
                              package = "faers.db"
  )
  res <- read_demo(db_test_path)
  expect_is(res, "tbl_df")
  res <- res[, 5L:7L]

  expected_class_names <- c(
    event_dt = "POSIXct",       #yyyy
    mfr_dt = "POSIXct",         #yyyymmdd
    init_fda_dt = "POSIXct"     #yyyymm
  )

  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )

})

test_that("read drug works", {
  db_test_path <-  system.file("testing-data/faers20/DRUG20Q3-1-yyyymmdd.txt",
                               package = "faers.db"
  )

  res <- read_drug(db_test_path)
  expect_is(res, "tbl_df")
  res <- res[, 15L]

  expected_class_names <- c(
    exp_dt = "POSIXct"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read drug works", {
  db_test_path <-  system.file("testing-data/faers20/DRUG20Q3-1-yyyymm.txt",
                               package = "faers.db"
  )

  res <- read_drug(db_test_path)
  expect_is(res, "tbl_df")
  res <- res[, 15L]

  expected_class_names <- c(
    exp_dt = "POSIXct"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read drug works", {
  db_test_path <-  system.file("testing-data/faers20/DRUG20Q3-1-yyyy.txt",
                               package = "faers.db"
  )

  res <- read_drug(db_test_path)
  expect_is(res, "tbl_df")
  res <- res[, 15L]

  expected_class_names <- c(
    exp_dt = "POSIXct"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read ther works", {
  db_test_path <-  system.file("testing-data/faers20/THER20Q3-1-yyyymmdd.txt",
                               package = "faers.db"
  )

  res <- read_ther(db_test_path)
  expect_is(res, "tbl_df")
  res <- res[, 4L]

  expected_class_names <- c(
    start_dt = "POSIXct"

  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read ther works", {
  db_test_path <-  system.file("testing-data/faers20/THER20Q3-1-yyyymm.txt",
                               package = "faers.db"
  )

  res <- read_ther(db_test_path)
  expect_is(res, "tbl_df")
  res <- res[, 4L]

  expected_class_names <- c(
    start_dt = "POSIXct"

  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})

test_that("read ther works", {
  db_test_path <-  system.file("testing-data/faers20/THER20Q3-1-yyyy.txt",
                               package = "faers.db"
  )

  res <- read_ther(db_test_path)
  expect_is(res, "tbl_df")
  res <- res[, 4L]

  expected_class_names <- c(
    start_dt = "POSIXct"

  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})



# test faers db from 12q4 to 13q4 ---------------------------------


test_that("read_demo works", {
  db_test_path <- system.file("testing-data/faers12/demo12q4.txt",
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
    mfr_num = "character",
    mfr_sndr = "factor",
    age = "integer",
    age_cod = "character",
    sex = "factor",
    e_sub = "factor",
    wt = "numeric",
    wt_cod = "character",
    rept_dt = "POSIXct",
    to_mfr = "factor",
    occp_cod = "factor",
    reporter_country = "character",
    occr_country = "character",
    auth_num = "character",
    lit_ref = "character",
    age_grp = "character",
    period = "character"
  )

  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )

})
#check same coloums
test_that("read_demo works", {
  db_test_path12 <- system.file("testing-data/faers12/demo12q4.txt",
                              package = "faers.db"
  )
  db_test_path20 <- system.file("testing-data/faers20/DEMO20Q3-10.txt",
                              package = "faers.db"
  )
  res <- read_demo(db_test_path12)
  res20 <- read_demo(db_test_path20)

  expect_setequal(colnames(res20), colnames(res))
})


test_that("read drug works", {
  db_test_path <-  system.file("testing-data/faers12/drug12q4.txt",
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
    dose_freq = "character",
    period = "character",
    prod_ai = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})
#check same coloums
test_that("read_drug works", {
  db_test_path12 <- system.file("testing-data/faers12/drug12q4.txt",
                                package = "faers.db"
  )
  db_test_path20 <- system.file("testing-data/faers20/DRUG20Q3-10.txt",
                                package = "faers.db"
  )
  res <- read_drug(db_test_path12)
  res20 <- read_drug(db_test_path20)

  expect_setequal(colnames(res20), colnames(res))
})


test_that("read indi works", {
  db_test_path <-  system.file("testing-data/faers12/indi12q4.txt",
                               package = "faers.db"
  )

  res <- read_indi(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    indi_drug_seq = "integer",
    indi_pt = "character",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})
#check same coloums
test_that("read_indi works", {
  db_test_path12 <- system.file("testing-data/faers12/indi12q4.txt",
                                package = "faers.db"
  )
  db_test_path20 <- system.file("testing-data/faers20/INDI20Q3-10.txt",
                                package = "faers.db"
  )
  res <- read_indi(db_test_path12)
  res20 <- read_indi(db_test_path20)

  expect_setequal(colnames(res20), colnames(res))
})


test_that("read outc works", {
  db_test_path <-  system.file("testing-data/faers12/outc12q4.txt",
                               package = "faers.db"
  )

  res <- read_outc(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    outc_cod = "factor",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})
#check same coloums
test_that("read_outc works", {
  db_test_path12 <- system.file("testing-data/faers12/outc12q4.txt",
                                package = "faers.db"
  )
  db_test_path20 <- system.file("testing-data/faers20/OUTC20Q3-10.txt",
                                package = "faers.db"
  )
  res <- read_outc(db_test_path12)
  res20 <- read_outc(db_test_path20)

  expect_setequal(colnames(res20), colnames(res))
})


test_that("read reac works", {
  db_test_path <-  system.file("testing-data/faers12/reac12q4.txt",
                               package = "faers.db"
  )

  res <- read_reac(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    pt = "character",
    drug_rec_act = "character",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})
#check same coloums
test_that("read_reac works", {
  db_test_path12 <- system.file("testing-data/faers12/reac12q4.txt",
                                package = "faers.db"
  )
  db_test_path20 <- system.file("testing-data/faers20/REAC20Q3-10.txt",
                                package = "faers.db"
  )
  res <- read_reac(db_test_path12)
  res20 <- read_reac(db_test_path20)

  expect_setequal(colnames(res20), colnames(res))
})

test_that("read rpsr works", {
  db_test_path <-  system.file("testing-data/faers12/rpsr12q4.txt",
                               package = "faers.db"
  )

  res <- read_rpsr(db_test_path)
  expect_is(res, "tbl_df")

  expected_class_names <- c(
    primaryid = "numeric",
    caseid = "integer",
    rpsr_cod = "factor",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})
#check same coloums
test_that("read_rpsr works", {
  db_test_path12 <- system.file("testing-data/faers12/rpsr12q4.txt",
                                package = "faers.db"
  )
  db_test_path20 <- system.file("testing-data/faers20/RPSR20Q3-10.txt",
                                package = "faers.db"
  )
  res <- read_rpsr(db_test_path12)
  res20 <- read_rpsr(db_test_path20)

  expect_setequal(colnames(res20), colnames(res))
})

test_that("read ther works", {
  db_test_path <-  system.file("testing-data/faers12/ther12q4.txt",
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
    dur_cod = "character",
    period = "character"
  )
  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )
})
#check same coloums
test_that("read_ther works", {
  db_test_path12 <- system.file("testing-data/faers12/ther12q4.txt",
                                package = "faers.db"
  )
  db_test_path20 <- system.file("testing-data/faers20/THER20Q3-10.txt",
                                package = "faers.db"
  )
  res <- read_ther(db_test_path12)
  res20 <- read_ther(db_test_path20)

  expect_setequal(colnames(res20), colnames(res))
})




# read_faers ------------------------------------------------------

test_that("read_faers works", {
  db_test_path <- system.file("testing-data/faers20/DEMO20Q3-10.txt",
                              package = "faers.db"
  )
  res <- read_faers(db_test_path)
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
    occr_country = "character",
    period = "character"
  )

  expect_equal(
    purrr::map_chr(res, ~class(.x)[[1L]]),
    expected_class_names
  )

})
