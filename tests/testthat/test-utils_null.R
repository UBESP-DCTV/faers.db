test_that("%NULL% works", {
  expect_equal(
    NULL %NULL% "foo",
    "foo"
  )
  expect_equal(
    1L %NULL% 2L,
    1L
  )
})
