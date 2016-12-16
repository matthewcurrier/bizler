#Trying to create a heat map of which days are the worst for bicycle accidents

library(tidyverse)
library(tibble)
library(ggplot2)
library(lubridate)
library(xtable)
library(Hmisc)

bikes <- nyc_bike_crashes %>% mutate(year=format(date, "%Y"),
                                     month=format(date, "%m"),
                                     day=format(date, "%d"))

bikes <- tbl_df(bikes)

bikes2 <- bikes %>%
  filter(number_of_cyclist_killed!=0) %>%
  group_by(borough, zip_code) %>%
  summarize(total_deaths=sum(number_of_cyclist_killed)) %>%
  arrange(desc(total_deaths)) %>%
  ungroup()

dvipng.dvi <- function (object, file, res=600)
{
  if (missing(file)){
    invisible(sys(
      paste("dvipng -T tight", "-D", res, shQuote(object$file)))
    )
  }
  else{
    invisible(sys(
      paste("dvipng -T tight", "-D", res, "-o", file, shQuote(object$file)))
    )
  }
}


dvipng.dvi(dvi.latex(latex(bikes2)))





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
