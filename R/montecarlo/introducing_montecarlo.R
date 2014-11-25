# Monte Carlo Simulations #
rm(list=ls())
# load the package
install.packages('mcsm')
library(mcsm)
demo(Chapter.1)


##########################################
# Chapter 2 - Random Variable Generation
##########################################
# practical techniques to generate random variables from standard and non-
# standard distributions
# Monte-Carlo methods rely on the possibility of producing endless flow of
# random variables for well-known or new distributions.

## basic uniform generator runif ##
runif(100, min=2, max=5)
# quick check of properties via historgramm and estimated autocorrelation function
# (any random variable generator does suffer from residual autocorrelation)
Nsim = 10^4 #number of random numbers
x = runif(Nsim)
x1 = x[-Nsim] #vectors to plot
x2 = x[-1]    #adjacent pairs
par(mfrow=c(1,3))
hist(x)
plot(x1,x2)
acf(x)
par(mfrow=c(1,1))
# runif does not create randomness per se, but a deterministic sequence based
# on a random starting point
set.seed(1)
runif(5)
set.seed(1)
runif(5)

## The inverse transform ##
# probability integral transform, that allows to transform any random variable
# into a uniform random variable.
# Necessary that the cdf exists analytically

Nsim=10^4 #number of random variables
U = runif(Nsim)
X = -log(U) #transforms of uniforms
Y = rexp(Nsim) #exponentials from R
par(mfrow=c(1,2)) #plots
hist(X, freq=F, main="Exp from Uniform", breaks=seq(0,20,by=0.2))
hist(Y, freq=F, main="Exp from R", breaks=seq(0,20,by=0.2))

# if the inverse exists

# Create random numbers from discrete distributions
# generate Poisson random variables from large values of lambda
Nsim=10^4; lambda=100
spread=3*sqrt(lambda)
t = round(seq(max(0,lambda-spread),lambda+spread,1))
prob = ppois(t, lambda)
X = rep(0,Nsim)
for (i in 1:Nsim){
  u=runif(1)
  X[i]=t[1]+sum(prob<u) 
}
hist(X)

# Accept - reject methods
# There are many distributions for which the inverse transform method and even
# general transformations will fail to be able to generate the required random
# variables. For these cases, we must turn to indirect methods; that is, methods
# in which we generate a candidate random variable and only accept it subject
# to passing a test. As we will see, this class of methods is extremely powerful
# and will allow us to simulate from virtually any distribution.
# These so-called Accept{Reject methods only require us to know the functional
# form of the density f of interest (called the target density) up to a
# multiplicative constant. 
# We use a simpler (to simulate) density g, called the
# instrumental or candidate density, to generate the random variable for which
# the simulation is actually done.

optimize(f=function(x){dbeta(x,2.7,6.3)}, interval=c(0,1), maximum=TRUE)$objective

Nsim=2500
a=2.7;b=6.3
M=2.67
u=runif(Nsim,max=M) #uniform over (0,M)
y=runif(Nsim) #generation from g
x=y[u<dbeta(y,a,b)] #accepted subsample
hist(x)

# fixed number of samples
x=NULL
while (length(x)<Nsim){
  y=runif(Nsim*M)
  x=c(x,y[runif(Nsim*M)*M<dbeta(y,a,b)])
}
x = x[1:Nsim]

# more about rejection sampling
##simple rejection sampler for Beta(5.5,5.5), 3.26.13
a <- 5.5; b <- 5.5
m <- a/(a+b); s <- sqrt((a/(a+b))*(b/(a+b))/(a+b+1))
funct1 <- function(x) {dnorm(x, mean=m, sd=s)}
funct2 <- function(x) {dbeta(x, shape1=a, shape2=b)}
plot(funct1, from=0, to=1, col="blue", ylab="")
plot(funct2, from=0, to=1, col="red", add=T)

##M=1.3 (this is trial and error to get a good M)
funct1 <- function(x) {1.3*dnorm(x, mean=m, sd=s)}
funct2 <- function(x) {dbeta(x, shape1=a, shape2=b)}
plot(funct1, from=0, to=1, col="blue", ylab="")
plot(funct2, from=0, to=1, col="red", add=T)

##Doing accept-reject
##substance of code
set.seed(1); nsim <- 1e5
x <- rnorm(n=nsim, mean=m, sd=s)
u <- runif(n=nsim)
ratio <- dbeta(x, shape1=a, shape2=b)/(1.3*dnorm(x, mean=m, sd=s))
ind <- I(u < ratio)
betas <- x[ind==1]
# as a check to make sure we have enough
length(betas) # gives 76836
funct2 <- function(x) {dbeta(x, shape1=a, shape2=b)}
plot(density(betas))
plot(funct2, from=0, to=1, col="red", lty=2, add=T)


## Importance sampling ##
# The original purpose of importance sampling was to sample more
# heavily from regions that are important
1 - pnorm(5)    # gives 2.866516e-07

# Naive method
set.seed(1)
ss <- 100000
x <- rnorm(n=ss)
phat <- sum(x>5)/length(x)
sdphat <- sqrt(phat*(1-phat)/length(x)) # gives 0

# IS method
set.seed(1)
y <- rnorm(n=ss, mean=5)
h <- dnorm(y, mean=0)/dnorm(y, mean=5) * I(y>5)
mean(h) # gives 2.865596e-07
sd(h)/sqrt(length(h)) # gives 2.157211e-09

# using different distributions for weighting in importance sampling
# necessary to normalize
# sample the normal distribution between -1 and 1

uniformIS <- function(nn) {
  sapply(runif(nn,-1,1),
         function(xx) dnorm(xx,0,1)/dunif(xx,-1,1)) }
cauchyIS <- function(nn) {
  sapply(rt(nn,1),
         function(xx) (xx <= 1)*(xx >=-1)*dnorm(xx,0,1)/dt(xx,2)) }
gaussianIS <- function(nn) {
  sapply(rnorm(nn,0,1),
         function(xx) (xx <= 1)*(xx >= -1)) }

nSim <- 1000
uIS <- uniformIS(nSim)
cIS <- cauchyIS(nSim)
gIS <- gaussianIS(nSim)
par(mfrow=c(1,3))
hist(uIS)
hist(cIS)
hist(gIS)
par(mfrow=c(1,1))
mean(uIS)
mean(cIS)
mean(gIS)

# Gibbs sampling and MCMC
