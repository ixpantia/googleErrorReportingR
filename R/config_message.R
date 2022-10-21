#' @importFrom magrittr %>%
NULL
#' Format messages before sending to Google Error Reporting
#'
#' @param message Error message returned by validation
#' @param req Request object used by plumber
#' @param status_code Valid HTTP status code
#'
#' @return formatted message
#' @export
#'
#' @examples
#' \dontrun{
#' your_function_call <- tryCatch(
#'   your_function(),
#'   error = function(e) {
#'     message$message <- as.character(e)
#'     googleErrorReportingR::report_error(message)
#'     message <- config_message(message, req, "401")
#'     stop("Error", call. = FALSE)
#'   })
#' }

config_message <- function(message, req, status_code) {
  token <- req$HTTP_AUTHORIZATION
  message$context$httpRequest$method <- req$REQUEST_METHOD
  message$context$httpRequest$url <- req$SERVER_NAME
  message$context$httpRequest$userAgent <- req$HTTP_USER_AGENT
  message$context$httpRequest$responseStatusCode <- status_code
  message$context$reportLocation$filePath <- req$PATH_INFO
  message$context$reportLocation$functionName <- gsub("/", "_", 
                                                 substring(req$PATH_INFO, 2))
  return(message)
}
