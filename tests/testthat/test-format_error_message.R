message <- format_error_message()

test_that("messages are configured as expected", {
  expect_equal(message$message, "Error description")
  expect_equal(message$serviceContext$service, "My Service")
  expect_equal(message$serviceContext$version, "0.0.1")
  expect_equal(message$context$httpRequest$method, "GET")
  expect_equal(message$context$httpRequest$url, "https://example.com")
  expect_equal(message$context$httpRequest$userAgent, "")
  expect_equal(message$context$httpRequest$referrer, "")
  expect_equal(message$context$httpRequest$responseStatusCode, "500")
  expect_equal(message$context$httpRequest$remoteIp, "192.178.0.0.1")
  expect_equal(message$context$user, "UserID")
  expect_equal(message$context$reportLocation$filePath, "/")
  expect_equal(message$context$reportLocation$lineNumber, 0)
  expect_equal(message$context$reportLocation$functionName, "my_function")
})

