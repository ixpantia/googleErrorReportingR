#' Get list of errors from Google Error Reporting
#'
#' @param project_id the project ID of your project on GCP
#' @param api_key an API key with permissions to write to Google Error Reporting
#' @param message the error report to be written out to the
#'
#' @return No return, we focus on side effect
list_errors <- function(project_id,
                         api_key) {

  base_url <- "https://clouderrorreporting.googleapis.com/v1beta1/"
  project_name <- paste0("projects/", project_id)
  endpoint <- "/events?key="

  url <- paste0(base_url, project_name, endpoint, api_key)

  httr::GET(url)
}

