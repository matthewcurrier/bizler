library(dplyr)
# Downloaded from https://data.cityofnewyork.us/Public-Safety/NYPD-Motor-Vehicle-Collisions/h9gi-nx95
accs <- read.csv("NYPD_Motor_Vehicle_Collisions.csv", stringsAsFactors = FALSE)

#explore
df1 <- as.data.frame(table(accs$VEHICLE.TYPE.CODE.1))
df2 <- as.data.frame(table(accs$VEHICLE.TYPE.CODE.2))
df3 <- as.data.frame(table(accs$VEHICLE.TYPE.CODE.3))
df4 <- as.data.frame(table(accs$VEHICLE.TYPE.CODE.4))
df5 <- as.data.frame(table(accs$VEHICLE.TYPE.CODE.5))


# Rename column names
colnames(accs) <- tolower(colnames(accs))
colnames(accs) <- gsub("\\.", "_", colnames(accs))

#Select some columns
accs2 <- accs %>% select(unique_key,
                         date,
                         borough,
                         zip_code,
                         number_of_cyclist_killed,
                         number_of_cyclist_injured
                         )

accs3 <- accs2 %>% filter(number_of_cyclist_killed > 0 | number_of_cyclist_injured > 0)

accs3$date   <- as.Date(accs3$date, "%m/%d/%Y")



accs3$borough[accs3$borough==''] <- 'NOT INIDICATED'
accs3 <- accs3 %>% mutate(total_cyclists_killed_injured=(number_of_cyclist_killed +
                                                         number_of_cyclist_injured)
                          )

nyc_bike_crashes <- accs3
