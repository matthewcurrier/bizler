ks_fiscal_year <- function (x)
{
  library(lubridate)
  m <- month(x)
  y <- year(x)

  if(m %in% c(11, 12)) {y <- y + 1}
  else {y <- y}
  y
}
