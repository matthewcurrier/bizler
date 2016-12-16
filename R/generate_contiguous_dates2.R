#Now you'll need to merge this data with an empty zoo object
#find max and min so we can generate a sequence for merging
#From a vector of

generate_contiguous_dates2 <- function(start, end) {
  #verify that it's a df


  tt <- seq.Date(start, end, by = "day")
  tt <- data.frame(tt, stringsAsFactors = FALSE)
  colnames(tt)  <- "date"
  return(tt)

}
