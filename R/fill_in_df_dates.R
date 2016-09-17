fill_in_df_dates <- function(df, date_col="date") {

  #Generate some dates and convert to df
  dates <- generate_contiguous_dates(df$date)

  dates_df <- as.data.frame(dates)

  colnames(dates_df) <- "date"

  df2return <- left_join(dates_df, df, by=c("date"=date_col))
  df2return <- df2return[order(df2return[["date"]]), ]

  return(df2return)
  #probably shoult test/assert that df in contiguous

}




