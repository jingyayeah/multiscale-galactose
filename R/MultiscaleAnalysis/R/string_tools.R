#' Returns string w/o leading whitespace
#' @param x string to strip whitspaces
#' @return stripped string
#' @export
trim.leading <- function (x){
  sub("^\\s+", "", x)
} 

#' Returns string w/o trailing whitespace
#' @param x string to strip whitspaces
#' @return stripped string
#' @export
trim.trailing <- function (x){
  sub("\\s+$", "", x)
} 

#' Returns string w/o leading or trailing whitespace
#' @param x string to strip whitspaces
#' @return stripped string
#' @export
trim <- function (x){
  gsub("^\\s+|\\s+$", "", x)
} 