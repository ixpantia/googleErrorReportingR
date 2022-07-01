
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/ixplorer)](https://cran.r-project.org/package=googleErrorReportingR)
<!-- badges: end -->

# googleErrorReportingR

This is an R wrapper for the Google Cloud Platform Error Reporting API.
I uses the Error Reporting API as defined in the
[projects.events.report](https://cloud.google.com/error-reporting/reference/rest/v1beta1/projects.events/report)
method.

Using the Google OAuth 2.0 authentication is on the wishlisht. The
current version only authenticates using an API key so that we can have
a call like:

    report_error(api_key, message)

and have this work consistently.

## Installation

You can install the development version of googleErrorReportingR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ixpantia/googleErrorReportingR")
```

## Usage

Before you start, please set up a file called `.Renviron` that contains
the following line.

    PROJECT_ID=<your gcp project id>
    ERROR_REPORTING_API_KEY=<your api key>

If you are running a session, then restart your R session so that the
environmental variables are read.

This is a basic example which shows you how to solve a common problem:

``` r
library(googleErrorReportingR)

message <- format_error_message()

# set any of the message components to your own value
message$serviceContext$service <- "A demo service"
message$serviceContext$version <- "v0.3.4"
```

Note that we have a fully formated JSON even message by using the list

``` r
toJSON(message, auto_unbox = TRUE, pretty = TRUE )
#> {
#>   "project_id": "my_project",
#>   "message": "Error description",
#>   "serviceContext": {
#>     "service": "A demo service",
#>     "version": "v0.3.4"
#>   },
#>   "context": {
#>     "httpRequest": {
#>       "method": "GET",
#>       "url": "https://example.com",
#>       "userAgent": "",
#>       "referrer": "",
#>       "responseStatusCode": "500",
#>       "remoteIp": "192.178.0.0.1"
#>     },
#>     "user": "UserID",
#>     "reportLocation": {
#>       "filePath": "/",
#>       "lineNumber": 0,
#>       "functionName": "my_function"
#>     }
#>   }
#> }
```

And we can now send the report to our Google project.

``` r
googleErrorReportingR::report_error(message)
```
