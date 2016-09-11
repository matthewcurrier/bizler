library(MASS)
library(zoo)
myts <- USAccDeaths

lag(myts, k = 1)

# calculate % difference
newts <- diff(myts, 12)/myts


finalts <- cbind(myts, newts)


df <- yearmon(finalts)

myts <- as.zoo(myts)

# This will take monthly zoo object and aggregate it over
# quarter
x2a <- aggregate(myts, as.Date(as.yearqtr(time(myts))), sum)




dates <- as.POSIXct(c("2015-11-01", "2016-01-01", "2015-04-30",
  "2015-09-01", "2015-12-01"))
as.numeric(as.yearmon(dates) + 2/12)%/%1

# How To Split A Data Set Up
g <- airquality$Month
l <- split(airquality, g)

