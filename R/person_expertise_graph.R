#' create a graph of people and their expertise
#' 
#' @param person_expertise a `data.frame` with people in column 1
#'   and expertise in column 2. Other columns are ignored
#'   
#' @returns an `igraph` instance
#' 
#' @author seandavi@gmail.com
#' 
#' @family visualization, graph
#' 
#' @examples 
#' 
#' dssrc = dssrc_dataframe()
#' 
#' person_expertise = dssrc |> 
#'   dplyr::select(fullName, `expertise-all`) |> 
#'   dplyr::arrange(fullName, `expertise-all`) |> 
#'   dplyr::mutate(`expertise-all`=tolower(`expertise-all`)) |> 
#'   dplyr::mutate(`expertise-all` = gsub('\\(.*\\)', '', `expertise-all`)) |>
#'   tidyr::separate_longer_delim(`expertise-all`, ', ') |> 
#'   unique()
#' 
#' g = person_expertise_graph(person_expertise)
#' 
#' if(require(visNetwork)) {
#'   visNetwork::visIgraph(h,layout='layout_with_graphopt',charge=0.25)
#' }
#' 
#' @export
person_expertise_graph <- function(person_expertise) {
  person_expertise <- tidyr::drop_na(person_expertise)
  person_expertise$color = rgb(0,0,1,0.1)
  person_expertise$label.cex = 0.2
  people = unique(person_expertise[[1]])
  expertise = unique(person_expertise[[2]])
  vertices = data.frame(
    nodes = c(people, expertise),
    color = c(rep(rgb(0,0,1,0.25),length(people)), rep(rgb(1,0,0,0.25),length(expertise)))
  )
  g = igraph::graph_from_data_frame(person_expertise, directed = FALSE, vertices=vertices)
  igraph::vertex_attr(g, 'size') = igraph::degree(g)
  g
}