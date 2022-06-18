
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

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(googleErrorReportingR)

api_key <- Sys.getenv("API_KEY")

message <- format_error_message()
```

Note that we have a fully formated JSON even message by using the list

``` r
toJSON(message, auto_unbox = TRUE, pretty = TRUE )
#> {
#>   "message": "Error description",
#>   "serviceContext": {
#>     "service": "My Service",
#>     "version": "0.0.1"
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
project_id <- "infraestructura-pruebas"

googleErrorReportingR::report_error(project_id,
                                    api_key,
                                    message)
#> Response [https://clouderrorreporting.googleapis.com/v1beta1/projects/infraestructura-pruebas/events:report?key=AIzaSyAeZ8s971ICl567niaSxvTitfQL4pijoJA]
#>   Date: 2022-06-18 17:58
#>   Status: 200
#>   Content-Type: application/json; charset=UTF-8
#>   Size: 3 B
#> {}
```

### List reports

In our workflow it can be useful to be able to report errors.

    # TODO #12
