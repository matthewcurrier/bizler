#Now you'll need to merge this data with an empty zoo object
#find max and min so we can generate a sequence for merging


generate_contiguous_dates <- function(date_col) {
  #verify that it's a df


  start <- min(date_col)
  end <- max(date_col)

  tt <- seq(start, end, by = "day")
  tt <- data.frame(tt, stringsAsFactors = FALSE)
  colnames(tt)  <- "date"
  return(tt)

}

