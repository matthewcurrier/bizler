library(reshape)
expand.grid.df()


accs5 <- accs3[1:7, -1]

adf <- expand.grid(date=accs5$date,
                   borough=accs5$borough,
                   zip_code=accs5$zip_code,
                   stringsAsFactors = F)

setdiff(colnames(accs5), colnames(adf))
adf$number_of_cyclist_killed <- 0
adf$number_of_cyclist_injured <- 0
adf$total_cyclists_killed_injured <- 0

accs6 <- rbind(accs5, adf)

expand_df <- function(cols, df){




}
