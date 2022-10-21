#' Format Error Message for Google Error Reporting
#'
#' @param message the error message you want in the logs
#' @param service the name of your service
#' @param version the version of the service
#' @param method the http method used for hte call
#' @param url hte unique resource identifier that was called
#' @param user_agent the user agente identifier
#' @param referrer the referrer to the service
#' @param response_status_code http response code
#' @param remote_ip remote ip
#' @param user_id user id
#' @param filepath filepath of the code where the error originates
#' @param line_number line number where the error originates
#' @param function_name function name where the error originates
#'
#' @return message object, a list to be formated as JSON in the error report body
#' @export
#' 
#' @examples
#' \dontrun{
#' message <- format_error_message()
#'
#' message$serviceContext$service <- "A demo service"
#' message$serviceContext$version <- "v0.3.4"
#' }

format_error_message <- function(
              message = "Error description",
              service = "My Service",
              version = "0.0.1",
              method = "GET",
              url = "https://example.com",
              user_agent = "",
              referrer = "",
              response_status_code = "500",
              remote_ip = "192.178.0.0.1",
              user_id = "UserID",
              filepath = "/",
              line_number = 0,
              function_name = "my_function"
              ) {

  error_message <- list()

  error_message$message <- message

  error_message$serviceContext$service <- service
  error_message$serviceContext$version <- version

  error_message$context$httpRequest$method <- method
  error_message$context$httpRequest$url <- url
  error_message$context$httpRequest$userAgent <- user_agent
  error_message$context$httpRequest$referrer <- referrer
  error_message$context$httpRequest$responseStatusCode <- response_status_code
  error_message$context$httpRequest$remoteIp <- remote_ip

  error_message$context$user <- user_id

  error_message$context$reportLocation$filePath <- filepath
  error_message$context$reportLocation$lineNumber <- line_number
  error_message$context$reportLocation$functionName <- function_name

  return(error_message)

}
