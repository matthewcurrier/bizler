df_date_expander <- function(date_col, data){
  stopifnot(is.data.frame(data))
  stopifnot(class(data[[date_col]])=="Date")

  start <- min(data[[date_col]])
  end <- max(data[[date_col]])

  #You should probably check to make sure there already isn't contiguous dates
  tt <- seq(start, end, by = "day")
  tt <- data.frame(tt, stringsAsFactors = FALSE)
  colnames(tt)  <- "date"
  df <- merge(tt, data, by=c("date", date_col), all.x=T)


  return(df)

}
