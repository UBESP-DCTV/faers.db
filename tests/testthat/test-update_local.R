skip("Tested locally")
test_that("update_local works", {
  path <- getwd()
  simulate_faers_structure(path)
  expect_message(update_local(path), "No new data to download.")
  fs::dir_delete(glue::glue("{path}/faers_raw_data/2015/q1"))
  expect_warning(
    update_local(path, permission_to_update = FALSE),
    "Permission to download data denied by the user."
  )
  fs::dir_delete(glue::glue("{path}/faers_raw_data"))
})

test_that("permission_update works", {
  expect_equal(permission_update(TRUE), TRUE)
})
