#Trying to create a heat map of which days are the worst for bicycle accidents

library(tidyverse)
library(tibble)
library(ggplot2)
library(lubridate)

bikes <- nyc_bike_crashes %>% mutate(year=format(date, "%Y"),
                                     month=format(date, "%m"),
                                     day=format(date, "%d"))

bikes <- tbl_df(bikes)

bikes2 <- bikes %>%
  group_by(date) %>%
  summarise(total_cyclists_killed_injured=sum(total_cyclists_killed_injured)) %>%
  ungroup()

date2 <- paste(bikes2$year, bikes$month, "1", sep="-")
date2 <- as.Date(date2, "%Y-%m-%d")

bikes2$day_of_week <- weekdays(bikes2$date, abbr = FALSE)
bikes2$month <- format(bikes2$date, "%m")

bikes3 <- bikes2 %>%
  group_by(day_of_week, month) %>%
  summarise(total_cyclists_killed_injured=sum(total_cyclists_killed_injured)) %>%
  ungroup()

#Make Day of Week an ordered factor so heatmap makes sense
bikes3$day_of_week <- as.factor(bikes3$day_of_week)
bikes3$day_of_week <- factor(bikes3$day_of_week, levels = c("Sunday", "Monday", "Tuesday",
                                                            "Wednesday", "Thursday",
                                                            "Friday","Saturday"))



#Visualization
# Now for the plot

b <- ggplot(bikes3, aes(x=day_of_week, y=month, fill = total_cyclists_killed_injured)) +
  geom_tile(colour = "white")  + scale_fill_gradient(low="yellow", high="red", name = "Total Cyclists \nKilled Injured") +
  ggtitle("Calendar Heatmap of Bicycle Injuries in NYC (2012-2016)") +
  ylab("Month") +
  xlab("Day")

b
ggsave("heatmap.png", dpi=500)



P<- ggplot(d, aes(monthweek, weekdayf, fill = dat$norm_count)) +
  geom_tile(colour = "white") + facet_grid(year~monthf) + scale_fill_gradient(low="green", high="red") +
  opts(title = "Time-Series Calendar Heatmap - HeiaHeia.com sick days logged") + xlab("Week of Month") + ylab("") + labs(fill="per user per day")
