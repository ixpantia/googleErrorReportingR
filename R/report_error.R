#' Report error to Google Error Reporting
#'
#' @param message the error report to be written out to the
#'
#' @return No return, we focus on side effect
#' @export
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
