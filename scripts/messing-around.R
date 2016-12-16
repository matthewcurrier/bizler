accs4 <- accs3 %>% separate(date, c("year", "month", "day"), sep="-", remove=FALSE)

accs4 <- accs4 %>% group_by(year, month, borough)  %>% summarize(n_killed_injured=sum(number_of_cyclist_killed, number_of_cyclist_injured))

library(ggplot2)
ggplot(accs4, aes(month, n_killed_injured)) + geom_point() + facet_wrap(~borough)
p <- ggplot(accs4, aes(month, n_killed_injured, group=year)) + geom_line() + facet_wrap(~borough)
p+geom_smooth()

library(zipcode)

zipcode$zip <- as.character(zipcode$zip)
accs3$zip_code <- as.character(accs3$zip_code)

accs3.2 <- accs3 %>% separate(date, c("year", "month", "day"), sep="-", remove=FALSE)

accs4 <- accs3.2 %>% group_by(year, month, borough, zip_code) %>% summarize(n_killed_injured=sum(number_of_cyclist_killed, number_of_cyclist_injured)) %>% ungroup()


accs5 <- merge(accs4, zipcode, by.x="zip_code", by.y="zip", all.x = TRUE)

ggplot(subset(accs5, borough=="QUEENS"), aes(year, n_killed_injured)) + geom_line() + facet_wrap(~city)
