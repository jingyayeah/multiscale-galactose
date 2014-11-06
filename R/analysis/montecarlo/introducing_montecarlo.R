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