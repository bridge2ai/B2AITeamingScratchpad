#' Get dsSrc data from google sheet
#'
#' The dsSrc dataset is maintained by Julie
#' and contains most of the relevant onboarding
#' information.
#' 
#' @family data_import
#'
#' @author seandavi@gmail.com
#'
#' @examples
#' dssrc = dssrc_dataframe()
#' colnames(dssrc)
#' dplyr::glimpse(dssrc)
#'
#' @import googlesheets4
#' @import dplyr
#'
#' @export
dssrc_dataframe <- function() {
    df = googlesheets4::read_sheet(
        'https://docs.google.com/spreadsheets/d/1hSSzTlXJUrSMNfzvISZDAsmViOU5dWfU48a7xU9_iss/edit?usp=sharing',
        sheet="dsSrc",skip=1
    )
    return(df)
}
