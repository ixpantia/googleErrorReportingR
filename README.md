
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

# <a><img src="https://storage.googleapis.com/ixplorer/googleErrorReportingR.svg" align="right" width="30%"></a>

[![CRAN
status](https://www.r-pkg.org/badges/version/googleErrorReportingR)](https://cran.r-project.org/package=googleErrorReportingR)
<!-- badges: end -->

# googleErrorReportingR

This is an R wrapper for the Google Cloud Platform Error Reporting API.
It uses the Error Reporting API as defined in the
[projects.events.report](https://cloud.google.com/error-reporting/reference/rest/v1beta1/projects.events/report)
method.

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

You can pass on the `project_id` and `api_key` to the function call
directely, but since we typically use this many time in one code-base we
default to the values in the environmental variables so that instead of:

``` r
report_error(project_id, api_key, message)
```

We can call

``` r
report_error(message)
```

and put the effort in defining the error message at each location in the
code that we want to monitor.

the following is a basic example of usage:

``` r
library(googleErrorReportingR)

message <- format_error_message()

message$serviceContext$service <- "A demo service"
message$serviceContext$version <- "v0.3.4"

googleErrorReportingR::report_error(message)
#> Response [https://clouderrorreporting.googleapis.com/v1beta1/projects/infraestructura-pruebas/events:report?key=AIzaSyBCaoUQLO64yHmHt7CagO39V0IFGA86hMI]
#>   Date: 2022-08-21 01:57
#>   Status: 200
#>   Content-Type: application/json; charset=UTF-8
#>   Size: 3 B
#> {}
```

If your project-id and api_key are set up correctly the message above
will appear in the Google Error Reporting UI as follows:

![Screenshot of the message as listed in the Google Error Reporting
UI](man/figures/google_error_reporting_ui.png)

## Adding details

Note that the message we are sending, once we convert the list to the
json body as required by the API, contains all the information elements
that we can add to the message.

``` r
toJSON(message, auto_unbox = TRUE, pretty = TRUE )
#> {
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

Please read the vignette for further details on how to configure each
and everyone of them.

## Roadmap

We are working on the next version of `googleErrorReportingR` to include
the use of the `list` endpoint.
