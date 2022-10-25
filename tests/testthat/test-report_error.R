message <- format_error_message()

test_that("Error report is being sent to the correct API", {

  res <- report_error(message)
  content <- httr::content(res)

  expect_true(content$error$code %in% (c("400", "403")))

})
