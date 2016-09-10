#' A period Function
#'
#' This function allows you to turn any date into a fiscal quarter for ks.
#' @param x A date object.
#' @keywords fiscal quarter
#' @export
#' @examples
#' ks_fiscal_year()
ks_fiscal_year <- function (x)
{
  library(lubridate)
  m <- month(x)
  y <- year(x)

  if(m %in% c(11, 12)) {y <- y + 1}
  else {y <- y}
  y
}
