library(tidyr)


#Combine borough and zip code for easier manipulations
mydf <- nyc_bike_crashes %>% unite(groupings, borough, zip_code, sep="^_^")
min_max <- min_max_dates(mydf$date)
mydf <- fill_in_df_dates(mydf, start=min_max$min, end=min_max$max)



df_split_up <- split(mydf, mydf$groupings)





for(i in 1:length(df_split_up)){


#Select only data, groupings, and number_of_cyclist_injured. Working here on trying
#to figure out just one example.
df_split_up[[i]] <- df_split_up[[i]] %>% select(date, groupings, total_cyclists_killed_injured)
#df_split_up[[i]] <- df_split_up[[i]]%>% select(-groupings)
df_split_up[[i]] <- df_split_up[[i]] %>% group_by(date, groupings) %>% summarise(total_accs_for_day=sum(total_cyclists_killed_injured, na.rm=TRUE)) %>% ungroup()

df_split_up[[i]] <- fill_in_df_dates(df_split_up[[i]], start=min_max$min, end=min_max$max)


zoo_split_up <- lapply(df_split_up, as.zoo)


print(head(zoo_split_up[[i]]))
}

test <- zoo_split_up[[1]]

#This seems to work
test2 <-aggregate(test[[1]][1] , as.yearmon, sum)

#Calculate percentage of last year's
zoo_again <- test / lag(test)
