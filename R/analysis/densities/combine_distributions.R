# Combine the correlation information in custom distribution functions
# For something more fancy, try out the distr package. 
# In addition to random number generation, it'll get you the density, 
# distribution, and quantile functions associated with your distribution:
rm(list=ls())
install.packages('distr')
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


# how to combine to probability functions
# sample from combined probability densities

flow.grid=seq(from=0, to=100, by=1)

par(mfrow=c(1,1))

f_p1 <- function(x, mean=60, sd=20){
  return(dnorm(x, mean, sd)) 
}
f_p2 <- function(x, mean=20, sd=5){
  return(dnorm(x, mean, sd)) 
}
f_pc <- function(x){
  return( f_p1(x) * f_p2(x) ) 
  #return( f_q1(p)*f_q2(p) ) 
}

y1 <- f_p1(x=age.grid)
y2 <- f_p2(x=age.grid)
y3 <- f_pc(x=age.grid)


plot(age.grid, y1/max(y1), col='gray', type='l', ylim=c(0, 1.0))
points(age.grid, y2/max(y2), col='blue', type='l')
points(age.grid, y3/max(y3), col='red', type='l')
par(mfrow=c(1,1))

n <- 1000
yr1 <- rnorm(n, mean=50,sd=20)
yr2 <- rnorm(n, mean=40, sd=10)
yr3 <- yr1*yr2

par(mfrow=c(3,1))
hist(yr1, breaks=20, xlim=c(-10, 110), col=rgb(0.5, 0.5, 0.5, 0.25))
hist(yr2, breaks=20, xlim=c(-10, 110), col=rgb(0, 0, 1.0, 0.25), add=F)
hist(yr3, breaks=20, xlim=c(-10, 110), col=rgb(1.0, 0, 0, 0.25), add=F)
par(mfrow=c(1,1))

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





