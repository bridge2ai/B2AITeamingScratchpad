.extract_external_ids <- function(external_id_list) {
    external_id_recs = external_id_list$`external-id`
    retlist = list()
    for(i in seq_along(external_id_recs)) {
        id_type = external_id_recs[[i]]$`external-id-type`
        if(id_type %in% c('doi', 'pmid', 'pmc')) {
            value = external_id_recs[[i]]$`external-id-value`
            retlist[[id_type]] = ifelse(is.null(value), NA, value)
        }
    }
    return(retlist)
}

#' Extract a simple list from work-summary record
#'
#' This internal helper function extracts the title
#' and external ids (pmid, pmc, and doi) where available.
#'
#' @family orcid
#' @family bibliography
#'
#' @keywords Internal
.extract_simple_details_from_work_record <- function(work) {
    work_summary = work$`work-summary`[[1]]

    retlist = list(title=NA, doi=NA, pmid=NA, pmc = NA, put_code=NA)

    retlist['title'] = safe_get(work_summary$title$title,'value')
    retlist['put_code'] = safe_get(work_summary, 'put-code')

    # We're going to look for these `types` of
    # external records


    # this mess crawls through the external-id records
    # to extract the `type` and the `value`
    if(has_key(work_summary,'external-ids')) {
        external_id_recs = work_summary$`external-ids`
        external_ids = .extract_external_ids(external_id_recs)
        for(i in names(external_ids)) {
            retlist[[i]] = external_ids[[i]]
        }
    }

    retlist = data.frame(retlist)

    return(retlist)
}


#' Fetch raw JSON for ORCID works
#'
#'
#' @family orcid
#' @family bibliography
#'
#' @examples
#' json_response = orcid_works_json('0000-0003-3865-7844')
#'
#' str(json_response)
#'
#' @export
orcid_works_json <- function(orcid) {
    json_resp = orcid_api_call(orcid, path='/works')
    return(json_resp)
}

#' Works from a single ORCID
#'
#' Fetch a (simplified) set of works (publications, etc)
#' from an ORCID.
#'
#' @param orcid character(1) an orcid is required
#'
#' @returns a dataframe (see example)
#'
#' @examples
#' orcid = '0000-0001-5643-4068'
#'
#' df = works_from_orcid(orcid)
#' dim(df)
#' head(df)
#' summary(df)
#'
#' @family orcid
#' @family bibliography
#'
#' @export
works_from_orcid <- function(orcid) {
    json_resp = orcid_api_call(orcid,path='/works')
    works_list = json_resp$group
    if(length(works_list)==0) {
        return(data.frame(title=NULL,doi=NULL,pmid=NULL,pmc=NULL,put_code=NULL,orcid=NULL))
    }
    simple_works = lapply(works_list, .extract_simple_details_from_work_record)
    simple_works_df = data.frame(do.call(rbind, simple_works))
    simple_works_df$orcid = orcid
    return(simple_works_df)
}

#' Get a ORCID `work` detail
#'
#' The ORCID API has the concept of a `work` with its
#' own dedicated API endpoint. This function calls
#' that endpoint and returns a single data.frame
#' row representing that `work`.
#'
#' Additional functionality is available if the
#' `work` record has a bibtex entry. Using the `rbibutils`
#' package, one can convert the citation to bibtex, latex,
#' citations of various styles, and even HTML.
#'
#' @param orcid character(1) an orcid is required
#' @param put_code integer(1) the put-code, an ORCID API internal identifier
#'     for a work
#'
#' @family orcid
#' @family bibliography
#'
#' @examples
#' orcid = '0000-0001-5643-4068'
#' put_code = 89488980
#'
#' df = orcid_work_detail(orcid, put_code)
#' df
#' colnames(df)
#'
#' # the bibtex entry, if available,
#' # can be used for additional manipulation
#' if(require('rbibutils')) {
#'    rref = rbibutils::charToBib(df$citation_value)
#'    print(rref)
#'
#'    # bibtex
#'    print(rref, style = "Bibtex")
#'
#'    # simple citation
#'    print(rref, style = "citation")
#'
#'    # html
#'    print(rref, style = "html")
#'
#'    # latex
#'    print(rref, style = "latex")
#'
#'    # r citation
#'    print(rref, style = "R")
#' }
#'
#' @export
orcid_work_detail <- function(orcid, put_code) {
    retlist = list(
        orcid = orcid,
        put_code = put_code,
        created_at = NA,
        updated_at = NA,
        citation_type = NA,
        citation_value = NA,
        work_type = NA,
        contributors = NA,
        url = NA,
        doi = NA,
        pmid = NA,
        pmc = NA,
        abstract = NA
    )
    json_resp = orcid_api_call(orcid, path=sprintf('/work/%d', as.integer(put_code)))

    base = json_resp
    retlist[['created_at']] = lubridate::as_datetime(base$`created-date`$value/1000)
    retlist[['updated_at']] = lubridate::as_datetime(base$`last-modified-date`$value/1000)
    retlist[['citation_type']] = safe_get(base$citation, 'citation-type')
    retlist[['citation_value']] = safe_get(base$citation, 'citation-value')
    retlist[['url']] = safe_get(base$url,'value')
    retlist[['work_type']] = safe_get(base,'type')
    retlist[['abstract']] = safe_get(base,'short-description')

    if(has_key(base,'external-ids')) {
        external_id_recs = base$`external-ids`
        external_ids = .extract_external_ids(external_id_recs)
        for(i in names(external_ids)) {
            retlist[[i]] = external_ids[[i]]
        }
    }

    return(data.frame(retlist))
}

