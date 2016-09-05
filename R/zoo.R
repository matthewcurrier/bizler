library(MASS)
library(zoo)
myts <- USAccDeaths

lag(myts, k=1)

#calculate % difference
newts <- diff(myts, 12) / myts


finalts <- cbind(myts, newts)


df <- yearmon(finalts)

myts <- as.zoo(myts)

#This will take monthly zoo object and aggregate it over quarter
x2a <- aggregate(myts, as.Date(as.yearqtr(time(myts))), sum)
