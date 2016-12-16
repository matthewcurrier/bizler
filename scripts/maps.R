library(ggplot2)
library(ggmap)
library(dplyr)

nyc.map = get_map(location = "New York", zoom = 10, color="bw")  ## get MAP data
p <- ggmap(nyc.map)



library(zipcode)
data(zipcode)

bikes$zip <- as.character(bikes$zip_code)
bikes_lat_lon <- bikes %>%
  filter(number_of_cyclist_killed!=0) %>%
  group_by(borough, city, latitude, longitude) %>%
  summarize(total_deaths=sum(number_of_cyclist_killed)) %>%
  arrange(desc(total_deaths)) %>%
  ungroup()

#bikes_lat_lon <- left_join(bikes, zipcode, "zip")
rm(p)
p <- ggmap(nyc.map)
p <- p + geom_point(data=bikes_lat_lon, aes(y=latitude, x=longitude, size=total_deaths) )
p <- p +scale_color_gradient(low = "yellow", high = "red", guide=guide_legend(title = "Bike Fatalities"))
p  + theme(axis.title=element_blank(),
           axis.text=element_blank(),
           axis.ticks=element_blank()) + ggtitle("Bike Fatalities in NYC from 2013-2016")
p

###############################################
#
#
#
#Now make a chart with fatalities and accidents
#
#
#
###############################################
library(ggplot2)
library(ggmap)
library(dplyr)

nyc.map <- get_map(location = "New York", zoom = 10, color="bw")  ## get MAP data
p2 <- ggmap(nyc.map)



library(zipcode)
data(zipcode)

bikes$zip <- as.character(bikes$zip_code)
bikes_lat_lon <- left_join(bikes, zipcode, "zip")
bikes_lat_lon2 <- bikes_lat_lon %>%
  group_by(zip, latitude, longitude) %>%
  summarize(total_accidents=sum(total_cyclists_killed_injured)) %>%
  arrange(desc(total_accidents)) %>%
  ungroup()

rm(p)
p <- ggmap(nyc.map)
p <- p + geom_point(data=bikes_lat_lon2, aes(y=latitude, x=longitude, color=total_accidents) )
p <- p +scale_color_gradient(low = "yellow", high = "red", guide=guide_legend(title = "Bike Accidents"))
p <- p  + theme(axis.title=element_blank(),
           axis.text=element_blank(),
           axis.ticks=element_blank()) + ggtitle("Bike Accidents in NYC from 2013-2016")
p


#same info as above but density plot
rm(p)
nyc.map <- get_map(location = "New York", zoom = 11, color="bw")  ## get MAP data
p3 <- ggmap(nyc.map)
p3 <- p3  +  stat_density_2d(bins=30, geom='polygon', size=2, data=bikes_lat_lon2, aes(x = longitude, y = latitude, alpha=..level.., fill = ..level..))
p3 <- p3  +  scale_fill_gradient(low = "yellow", high = "red", guide=FALSE) +  scale_alpha(range = c(0.02, 0.8), guide = FALSE) +xlab("") + ylab("")

p3  + theme(axis.title=element_blank(),
           axis.text=element_blank(),
           axis.ticks=element_blank()) + ggtitle("Gas Station Density")

#And still another
require(Hmisc)
bikes_lat_lon2$accGroups <- cut2(bikes_lat_lon2$total_accidents, g = 6)

nyc.map <- get_map(location = "Queens, New York", zoom = 11, color="bw")  ## get MAP data
p4 <- ggmap(nyc.map)
p4 <- p4  +  stat_density_2d(geom = "polygon", bins = 30,data=bikes_lat_lon2, aes(x = longitude, y = latitude, alpha=..level.., fill = ..level..))
p4 <- p4 + facet_wrap(~accGroups) + scale_fill_gradient(low = "yellow", high = "red", guide=FALSE) +  scale_alpha(range = c(0.01, 0.9), guide = FALSE) +xlab("") + ylab("")

p4  + theme(axis.title=element_blank(),
           axis.text=element_blank(),
           axis.ticks=element_blank())  + ggtitle("Bike Accidents")





#example from http://stackoverflow.com/questions/32252505/how-to-map-new-york-city-using-map-function-in-r
library(sp)
library(rgdal)
library(rgeos)
library(ggplot2)
library(ggthemes)

url <- "http://www.nyc.gov/html/dcp/download/bytes/nybb_15b.zip"
fil <- basename(url)
if (!file.exists(fil)) download.file(url, fil)

fils <- unzip(fil)

nyc <- readOGR(fils[1], ogrListLayers(fils[1])[1], stringsAsFactors=FALSE)

# base
plot(nyc, lwd=0.5, asp=1)
