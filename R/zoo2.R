library(tidyr)
#test <- as.zoo(nyc_bike_crashes)
#test2 <- read.zoo()

#Taken from http://r.789695.n4.nabble.com/building-time-series-zoo-its-from-a-data-frame-td2240349.html
makezoo <- function(df) {
  require(zoo)
  with(df, zoo(total_accs_for_day, date))
}

#Combine borough and zip code for easier manipulations
mydf <- nyc_bike_crashes %>% unite(groupings, borough, zip_code, sep="^_^")

df_split_up <- split(mydf, mydf$groupings)
head(df_split_up[[1]])


#Select only data, groupings, and number_of_cyclist_injured. Working here on trying
#to figure out just one example.
df_split_up2 <- df_split_up[[1]] %>% select(date, groupings, total_cyclists_killed_injured)
df_split_up2 <- df_split_up2 %>% select(-groupings)
df_split_up2 <- df_split_up2 %>% group_by(date) %>% summarise(total_accs_for_day=sum(total_cyclists_killed_injured, na.rm=TRUE)) %>% ungroup()

#Now you'll need to merge this data with an empty zoo object
#find max and min so we can generate a sequence for merging
start <- min(df_split_up2$date)
end <- max(df_split_up2$date)
tt <- seq(start, end, by = "day")

myzoo <- makezoo(df_split_up2)



myzootest <- merge(myzoo, zoo(,tt), fill = 0)


#This seems to work
myzoo2 <-aggregate(myzootest, as.yearmon, sum)

#Calculate percentage of last year's
myzoo2/lag(myzoo2)
#You should be able to compute lags from this point onwards



# This will take monthly zoo object and aggregate it over
# quarter
myzoo2 <- aggregate(myzoo2, as.Date(as.yearqtr(time(myzoo2))), sum)



#Now let's convert to a zoo object
df_as_zoo <- read.zoo(df_split_up2)
