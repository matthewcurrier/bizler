#' A period Function
#'
#' This function allows you to turn any date into a fiscal quarter for ks.
#' @param x Do you love cats? Defaults to TRUE.
#' @param with_year Do you love cats? Defaults to FALSE.
#' @keywords fiscal quarter
#' @export
#' @examples
#' ks_fiscal_quarter()

#modification of lubridate qtr function adapted for keysight fiscal qtr
ks_fiscal_quarter <- function (x, with_year = FALSE)
{
  library(lubridate)
  m <- month(x)
  quarters <- c(`1` = 1, `2` = 2, `3` = 2, `4` = 2, `5` = 3,
                `6` = 3, `7` = 3, `8` = 4, `9` = 4, `10` = 4, `11` = 1,
                `12` = 1)
  if (isTRUE(with_year)) {
    q <- unname(quarters[m])
    y <- year(x)
    as.numeric(paste0(y, ".", q))
  }
  else unname(quarters[m])
}
