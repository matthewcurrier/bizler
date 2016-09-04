library(MASS)
library(zoo)
myts <- USAccDeaths

lag(myts, k=1)

#calculate % difference
newts <- diff(myts, 12) / myts
