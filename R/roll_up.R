#Return a list of zoo objects
roll_up <- function(zoo_obj) {

  #Make sure it's a zoo object


  list <- list()
  #Roll up by year-month
  list$yearmon <- aggregate(zoo_obj, as.yearmon, sum)
  list$yearqtr <- aggregate(zoo_obj, as.yearqtr, sum)


  return(list)
  #Calculate percentage of last year's
  #zoo_again <- myzoo2 / lag(myzoo2)
}


test <- roll_up(myzoo2)
