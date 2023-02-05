#' Test whether an object with names has specified key
#'
#' Test whether a list, data.frame(columns), or a named
#' vector has a specified key in it.
#'
#' @param l an object with names
#' @param key the name that you want to retrieve
#'
#'
#' @family utilities
#'
#' @keywords Internal
#'
#' @examples
#' l = list(a=1,b=2,c=3)
#' has_key(l, 'b') #TRUE
#' has_key(l, 'not_present') #FALSE
#'
#' @export
has_key <- function(l, key) {
    return(key %in% names(l))
}


#' Get a value from an object with names
#'
#' @param l an object with names
#' @param key the name that you want to retrieve
#' @param default the default value to return if the
#'    key does not exist
#'
#'
#' @family utilities
#'
#' @keywords Internal
#'
#' @examples
#' l = list(a=1,b=2,c=3)
#' safe_get(l,'a')
#' safe_get(l, 'not_present')
#'
#' @export
safe_get <- function(l, key, default=NA) {
    if(has_key(l, key)) {
        res = get(key, l)
        if(is.null(res)) {
            return(default)
        }
        return(get(key, l))
    }
    return(default)
}
