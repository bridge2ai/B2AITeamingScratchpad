#' Helper function for calling orcid API
#'
#' The ORCID REST API does not require any authentication for basic
#' querying. The OpenAPI documentation is available.
#'
#' The API typically works with the ORCID as the base resource. Therefore,
#' an ORCID is required for this function. The path follows the documentation.
#'
#' @param orcid character(1) the required orcid
#' @param works character(1) the rest of the API path after the `orcid` part.
#'
#' @returns an R `list` representation of the REST API json response
#'
#' @examples
#' orcid='0000-0001-7443-925X'
#'
#' orcid_api_call(orcid)
#'
#' @export
orcid_api_call <- function(orcid, path='/works') {
    url = sprintf('https://pub.orcid.org/v3.0/%s%s',orcid, path)

    # TODO: error checking
    resp = httr::GET(url, httr::accept_json())

    return(httr::content(resp))
}
