################################################################
# Peak function for model input
################################################################
# Time dependent function which describes the periportal 
# input concentrations.
# 
# author: Matthias Koenig
# date: 2014-12-18
################################################################

f1 <- function(t, t_peak=5, t_duration=0.5){
  c = numeric(length(t))
  
  c[t<t_peak] <- 0
  c[t>=t_peak& t<t_peak+t_duration] <- 1/t_duration
  c[t>t_peak+t_duration] <- 0
  
  return(c)
}

f2 <- function(t, t_peak=5, t_duration=0.5){
  mu = t_peak + 0.5*t_duration
  sigma = t_duration/2
  c <- 1/(sigma *sqrt(2*pi)) * exp(-(t-mu)^2/(2*sigma^2))
  return(c)
}
f3 <- function(t, t_peak=5, t_duration=0.5){
  mu = t_peak + 0.5*t_duration
  y_peak = 1/t_duration
  sigma = 1/(y_peak*sqrt(2*pi))
  c <- 1/(sigma *sqrt(2*pi)) * exp(-(t-mu)^2/(2*sigma^2))
  return(c)
}


t = seq(from=0, to=10, length.out=800)
y1 <- f1(t)
y2 <- f2(t)
y3 <- f3(t)
plot(t, y1, type='l', lwd=2)
lines(t, y2, col='red', lwd=2)
lines(t, y3, col='darkorange', lwd=2)

