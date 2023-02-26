.work_descriptor_spreadsheet = "https://docs.google.com/spreadsheets/d/1wmF-ezE8yAAvIrXrpiHsxwmWC9Oee1LJSotVJsFUSL4/edit#gid=989001416"

#' Access the data dictionary associated with Teaming Core Collaboration Tags
#' 
#' Available [here:](`r .work_descriptor_spreadsheet`)
#' 
#' @author seandavi@gmail.com
#' 
#' @import googlesheets4
#' 
#' @family data_import
#' 
#' @returns class `descriptor_terms` data.frame
#' 
#' @examples 
#' dterms = descriptor_terms()
#' 
#' head(dterms)
#' 
#' class(dterms)
#' 
#' 
#' 
#' @export
descriptor_terms <- function() {
  sheet = googlesheets4::read_sheet(.work_descriptor_spreadsheet, sheet="Dictionary")
  class(sheet) = c('descriptor_terms', class(sheet))
  return(sheet)
}


#' convert descriptor terms to igraph object
#' 
#' @param obj a `descriptor_terms` data.frame (usually from \code{\link{descriptor_terms}})
#' 
#' @returns an `igraph` object
#' 
#' @family visualization
#' 
#' @examples 
#' dterms = descriptor_terms()
#' 
#' g = descriptor_terms_as_igraph(dterms)
#' 
#' g
#' 
#' if(require(visNetwork)) {
#'   visNetwork::visIgraph(g)
#' }
#' 
#' 
#' @export
descriptor_terms_as_igraph <- function(obj) {
  if(!is(obj, 'descriptor_terms')) {
    stop(sprintf("Object should be of class 'descriptor_terms', got class '%s'", class(obj)))
  }
  df0 = unique(data.frame(from='root', to = obj[[1]]))
  df1 = unique(data.frame(from=obj[[1]], to=obj[[2]]))
  df2 = unique(data.frame(from=obj[[2]], to=obj[[3]]))
  full_df = dplyr::bind_rows(df0,df1,df2)
  vertices = data.frame(
    unique(c(full_df[[1]],full_df[[2]])),
    color = 'red'
  )
  return(igraph::graph_from_data_frame(full_df, vertices = vertices))
}