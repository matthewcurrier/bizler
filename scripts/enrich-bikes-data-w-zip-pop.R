#Taken from https://blog.splitwise.com/2013/09/18/the-2010-us-census-population-by-zip-code-totally-free/
pops <- read.csv("zip-and-pop.csv")
pops$zip <- as.character(pops$zcta)
nyc_bike_crashes$zip <- as.character(nyc_bike_crashes$zip_code)
bikes_lat_lon <- left_join(nyc_bike_crashes, zipcode, "zip")
bikes_lat_lon_pop <- left_join(bikes_lat_lon, pops, c("zip", "zip"))
bikes_lat_lon_pop <- select(bikes_lat_lon_pop, -zip)


devtools::use_data(bikes_lat_lon_pop)
devtools::use_data(pops)
