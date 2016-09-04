#adapted from here: http://stackoverflow.com/questions/30678606/quarterly-year-over-year-growth-rate
QuarterOverQuarter<-function (x,periodsPerYear){
  if(NROW(x)<=periodsPerYear){
    stop("too few rows")
  }
  else{
    indexes<-1:(NROW(x)-periodsPerYear)
    return(c(rep(NA,periodsPerYear),(x[indexes+periodsPerYear]-x[indexes])/x[indexes]))
  }
}
