library(tidyverse)
library(tibble)
library(ggplot2)

bikes <- nyc_bike_crashes %>% mutate(year=format(date, "%Y"),
                                     month=format(date, "%m"),
                                     day=format(date, "%d"))

bikes <- tbl_df(bikes)

bikes <- bikes %>%
   group_by(year, month, borough) %>%
   summarise(total_cyclists_killed_injured=sum(total_cyclists_killed_injured)) %>%
   ungroup()

date2 <- paste(bikes$year, bikes$month, "1", sep="-")
date2 <- as.Date(date2, "%Y-%m-%d")

bikes$date <- date2

p <- bikes %>% ggplot(aes(x=date, y=total_cyclists_killed_injured, color=borough) ) + geom_line()



p <- p + ylab("Cyclists Killed / Injured") + xlab("Date") + ggtitle("Injuries and fatalites for cylclists in NYC")
p <- p + theme_bw()
p <- p + scale_color_discrete(name ="Borough")
ggsave("overall-trend.png", dpi = 500)
