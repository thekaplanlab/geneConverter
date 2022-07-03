#' Operator which allows to complete matching operation.
#'
#'
#' @import fastmatch
#'
`%fin%` <- function(x, table) {
  stopifnot(require(fastmatch))
  fmatch(x, table, nomatch = 0L) > 0L
}
