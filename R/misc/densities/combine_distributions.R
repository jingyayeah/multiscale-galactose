# Combine the correlation information in custom distribution functions
# For something more fancy, try out the distr package. 
# In addition to random number generation, it'll get you the density, 
# distribution, and quantile functions associated with your distribution:
rm(list=ls())
# install.packages('distr')
library(distr)
## For more info, type: vignette("newDistributions")  

# Define full suite of functions (d*, p*, q*, r*) for your distribution
D <- DiscreteDistribution (supp = c(0, 1, 2) , prob = c(0.5, .25, .25))
dD <- d(D)  ## Density function
pD <- p(D)  ## Distribution function
qD <- q(D)  ## Quantile function
rD <- r(D)  ## Random number generation

# Take them for a spin
dD(-1:3)
# [1] 0.00 0.50 0.25 0.25 0.00
pD(-1:3)
# [1] 0.00 0.50 0.75 1.00 1.00
qD(seq(0,1,by=0.1))
# [1] 0 0 0 0 0 0 1 1 2 2 2
rD(20)
# [1] 0 0 2 2 1 0 0 1 0 1 0 2 0 0 0 0 1 2 1 0


# sampling from custom distribution via *inverse transform sampling*.
# Inverse transform sampling is the preferred way if the inverse of the distribution function is known. This is the case for the likelihood in your example since it is a Gaussian distribution and the associated quantile function (=inverse distribution function) is available in R. In general, inverse transform sampling works by sampling from a uniform distribution in the interval [0,1] and use the obtained values as the argument of the quantile function. The resulting values from the quantile function then follow the specified probability distribution.
# necessary to have quantile function and use *inverse transform sampling*


##########################################
# Density curves
##########################################
# Combining the information from different 
# sample from combined probability densities

volLiver.grid=seq(from=0, to=3000, by=10)
f_p1 <- function(x, mean=1500, sd=240){
  return(dnorm(x, mean, sd)) 
}
f_p2 <- function(x, mean=1200, sd=150){
  return(dnorm(x, mean, sd)) 
}
f_p3 <- function(x, mean=1100, sd=150){
  return(dnorm(x, mean, sd)) 
}

# problem: not a probability distribution (normalization to 1)
# still missing
f_pc <- function(x){
  return( f_p1(x) * f_p2(x) * f_p3(x)  ) 
  #return( f_q1(p)*f_q2(p) ) 
}
x <- volLiver.grid
y1 <- f_p1(x=x)
y2 <- f_p2(x=x)
y3 <- f_p3(x=x)
y_pc <- f_pc(x=x)
plot(x, y1/max(y1), col='black', type='l', lty=2, ylim=c(0, 1.0))
points(x, y2/max(y2), col='black', type='l', lty=3)
points(x, y3/max(y3), col='black', type='l', lty=4)
points(x, y_pc/max(y_pc), col='red', type='l', lty=1, lwd=4)
legend('topright', legend=c('info A', 'info B', 'info C', 'combined'), col=c('black', 'black', 'black', 'red'), lty=c(2, 3,4,1))

# normalization via integration over suitable range
A <- integrate(f=f_pc, lower=0, upper=5000)
A
summary(A)
A$value
f_pc_normalized <- function(x, area=A$value) {
  return (f_pc(x)/area)
}
y_pc_norm <- f_pc_normalized(x=x)

# check the integral
B <- integrate(f=f_pc_normalized, lower=500, upper=2000)
B

plot(x, y1, col='black', type='l', lty=2, ylim=c(0, max(y1)*4))
points(x, y2, col='black', type='l', lty=3)
points(x, y3, col='black', type='l', lty=4)
points(x, y_pc_norm, col='red', type='l', lty=1, lwd=4)
legend('topright', legend=c('info A', 'info B', 'info C', 'combined'), col=c('black', 'black', 'black', 'red'), lty=c(2, 3,4,1))

# Sampling from an Arbitrary Density
# http://blog.quantitations.com/tutorial/2012/11/20/sampling-from-an-arbitrary-density/

# Inverse transform sampling
invcdf <- function(u, m) {
  return(sqrt(m^2/(1 - (1 - m^2) * u)))
}
sample1 <- sapply(runif(100), invcdf, m = .5)
plot(density(sample1), main = "Sample Density using invcdf Function")

# The R code below uses some of R’s built-in numerical methods to accomplish the inverse transform sampling technique for any arbitrary pdf that it is given. I’m sure there are some ugly pdfs for which this function wouldn’t work, but it works fine for typical densities.
endsign <- function(f, sign = 1) {
  b <- sign
  while (sign * f(b) < 0) b <- 10 * b
  return(b)
}

samplepdf <- function(n, pdf, ..., spdf.lower = -Inf, spdf.upper = Inf) {
  vpdf <- function(v) sapply(v, pdf, ...)  # vectorize
  cdf <- function(x) integrate(vpdf, spdf.lower, x)$value
  invcdf <- function(u) {
    subcdf <- function(t) cdf(t) - u
    if (spdf.lower == -Inf) 
      spdf.lower <- endsign(subcdf, -1)
    if (spdf.upper == Inf) 
      spdf.upper <- endsign(subcdf)
    return(uniroot(subcdf, c(spdf.lower, spdf.upper))$root)
  }
  sapply(runif(n), invcdf)
}

sample2 <- samplepdf(100, f_pc_normalized)
sample3 <- samplepdf(100, f_pc_normalized, spdf.lower = 500, spdf.upper = 2000)
plot(density(sample2), main = "Sample Density using samplepdf Function")

# Another option for sampling that doesn’t require finding the inverse cdf is rejection sampling.
# http://playingwithr.blogspot.de/2011/06/rejection-sampling.html
sample.x = runif(10000,0,1)
accept = c()
for(i in 1:length(sample.x)){
  U = runif(1, 0, 1)
  if(dunif(sample.x[i], 0, 1)*3*U <= dbeta(sample.x[i], 6, 3)) {
    accept[i] = 'Yes'
  }
  else if(dunif(sample.x[i],0,1)*3*U > dbeta(sample.x[i], 6, 3)) {
    accept[i] = 'No'
  }
}
T = data.frame(sample.x, accept = factor(accept, levels= c('Yes','No')))
head(T)
# plot the results
hist(T[,1][T$accept=='Yes'], breaks = seq(0,1,0.02), freq = FALSE, main = 'Histogram of X', xlab = 'X')
x <- seq(0,1, length.out = 100)
lines(x, dbeta(x,6,3))


# rejection sampling for the given distribution
# plot the distribution function and upper function for rejection sampling
plot(volLiver.grid, f_pc_normalized(volLiver.grid))
points( volLiver.grid, 5*dnorm(volLiver.grid, mean=1200, sd=400))

sample.x = runif(50000,0,3000)
accept = c()
for(i in 1:length(sample.x)){
  U = runif(1, 0, 1)
  if(5*dnorm(sample.x[i], mean=1200, sd=400)*U <= f_pc_normalized(sample.x[i])) {
    accept[i] = 'Yes'
  }
  else if(5*dnorm(sample.x[i], mean=1200, sd=400)*U > f_pc_normalized(sample.x[i])) {
    accept[i] = 'No'
  }
}
T = data.frame(sample.x, accept = factor(accept, levels= c('Yes','No')))
head(T)
summary(T)

# plot the results
hist(T[,1][T$accept=='Yes'], breaks = seq(0,3000,30), freq = FALSE, main = 'Histogram of X', xlab = 'X')
lines(volLiver.grid, f_pc_normalized(volLiver.grid))




######################################
# cummulative distribution functions
######################################

# use the cummulative distribution functions
par(mfrow=c(2,1))
y1 <- pnorm(q=age.grid,mean=50,sd=20)
y2 <- pnorm(q=age.grid, mean=40, sd=10)

# new custom cummulative distribution function
f_cdf <- function(q){
  return(pnorm(q=q,mean=50,sd=20) * pnorm(q=q, mean=40, sd=10))
}
y3 <- f_cdf(q=age.grid) 

plot(age.grid, y1, col='grey', type='l', ylim=c(0, 1.0))
points(age.grid, y2, col='blue', type='l')
points(age.grid, y3, col='red', type='l')
par(mfrow=c(1,1))


###############################
# quantile function 
###############################
# direct combination of partial quantile functions
# via quantile mixture
par(mfrow=c(1,1))
p.grid <- seq(from=0,to=1,length.out = 20)
p.grid

# combined quantile function via quantile mixture,
# !!! looses information instead of information gain !!!
f_q1 <- function(p, mean=50, sd=10){
 return(qnorm(p, mean, sd)) 
}
f_q2 <- function(p, mean=65, sd=5){
  return(qnorm(p, mean, sd)) 
}
f_quantile <- function(p){
  return( 0.5*f_q1(p)+0.5*f_q2(p) ) 
  #return( f_q1(p)*f_q2(p) ) 
}
y1 <- f_q1(p=p.grid)
y2 <- f_q2(p=p.grid)
y3 <- f_quantile(p=p.grid) 

plot(p.grid, y1, col='grey', type='p', ylim=c(0, 120))
points(p.grid, y2, col='blue', type='p')
points(p.grid, y3, col='red', type='p')
par(mfrow=c(1,1))

# sample from the resulting quantile functions
n.sample <- 1000
p_rand <- runif(n.sample,0,1)
yr1 <- f_q1(p_rand)
yr2 <- f_q2(p_rand)
yr3 <- f_quantile(p_rand)
par(mfrow=c(3,1))
hist(yr1, breaks=20, xlim=c(-10, 110), col=rgb(0.5, 0.5, 0.5, 0.25))
hist(yr2, breaks=20, xlim=c(-10, 110), col=rgb(0, 0, 1.0, 0.25))
hist(yr3, breaks=20, xlim=c(-10, 110), col=rgb(1.0, 0, 0, 0.25))
par(mfrow=c(1,1))

r = f_quantile(runif(100,0,1))

hist(r)





# Sampling from custom quantile function via
# *inverse transform sampling*

random_var <- runif(100,0,1)
plot

tmp = f_quantile(runif(100,0,1))
hist(tmp)





