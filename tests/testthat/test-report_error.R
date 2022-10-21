message <- format_error_message()

test_that("Error report is being sent to the correct API", {

  res <- report_error(message)
  content <- httr::content(res)

  expect_equal(content$error$message, "Invalid JSON payload received. Unknown name \"\": Root element must be a message.")

})
