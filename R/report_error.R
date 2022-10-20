#' Report error to Google Error Reporting
#'
#' @param message the error report to be written out to the
#' @param project_id the project id where you want to monitor the error reports
#' @param api_key the google API key with authorisation to write to the Google
#'   Error Reporting API
#'
#' @return No return, we focus on side effect
#' @export
#'
#' @examples
#' \dontrun{
#' report_error(project_id, api_key, message)
#'
#' #If you have set the environmental variables "PROJECT_ID" and 
#' #"ERROR_REPORTING_API_KEY" then you can make shorter calls like so
#' report_error(message)
#' }
report_error <- function(message, project_id = NULL, api_key = NULL) {


  if (is.null(project_id)) {
     project_id <- Sys.getenv("PROJECT_ID")
  }

  if (is.null(api_key)) {
    api_key <- Sys.getenv("ERROR_REPORTING_API_KEY")
  }
  base_url <- "https://clouderrorreporting.googleapis.com/v1beta1/"
  project_name <- paste0("projects/", project_id)
  endpoint <- "/events:report?key="

  url <- paste0(base_url, project_name, endpoint, api_key)

  httr::POST(url, body = jsonlite::toJSON(message, auto_unbox = TRUE))
}
