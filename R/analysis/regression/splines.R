# Load prepared NHANES data
rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
head(data)

# General spline fitting
x <- data$RIDAGEYR
y <- data$BMXWT
plot(x, y)
rug(x, side=1, col="grey"); rug(y, side=2, col="grey")

# spline fit
fit.sp.1 <- res <- smooth.spline(x, y, cv=FALSE)
lines(fit.sp.1, col='blue', lwd = 3)
fit.sp.2 <- res <- smooth.spline(x, y, spar=0.7)
lines(fit.sp.2, col='orange', lwd = 3)
summary(sp.fit)
str(sp.fit)

# kernel smoothing & local linear regression
grid.x <- seq(from=min(x), to=max(x), length.out=length(x)) 
library(np)
# fit.ks <- npreg(y~x); lines(grid.x, predict(fit.ks, exdat=grid.x), col="red", lwd=3, lty=2)
fit.ll <- npreg(y~x, regtype="ll"); lines(grid.x, predict(fit.ks, exdat=grid.x), col="green", lwd=3, lty=2)


# generalized additive models
# prior weights on the data
require(mgcv)
inds.male <- which(data$RIAGENDR=='male')
inds.female <- which(data$RIAGENDR=='female')
fit.gam <- gam(y ~ s(x))
plot(fit.gam,scale=0,se=2,shade=TRUE,resid=TRUE,pages=1)

# GAM uses Penalized thin plate regression splines as default
fit.gam <- gam(y ~ s(x, k=9))
fit.gam <- gam(y ~ s(x, fx=TRUE, k=9), family=gaussian())
# plot(fit.gam,scale=0,se=2,shade=TRUE,resid=TRUE,pages=1)
gam.check(fit.gam, k.rep=1000)

fit.gam.male <- gam(y ~ s(x), subset=inds.male)
fit.gam.female <- gam(y ~ s(x), subset=inds.female)
plot(fit.gam,scale=0,se=2,shade=TRUE,pages=1)
plot(fit.gam,scale=0,se=2,shade=TRUE,resid=TRUE,pages=1)
plot(fit.gam.male,scale=0,se=2,shade=TRUE,resid=TRUE,pages=1)
lines(fit.gam.female,scale=0,se=2,shade=TRUE,resid=TRUE,pages=1)

## Confidence interval for comparison...
# directly from the fit
plot(x, y, col='grey')
pred <- predict(fit.gam, newdata=data.frame(x=grid.x), se=TRUE)
lines(grid.x, pred$fit, col="blue", lwd=2)
u.ci <- (pred$fit + 2*pred$se.fit)
l.ci <- (pred$fit - 2*pred$se.fit)
lines(grid.x, u.ci, col="blue",lwd=2); lines(grid.x, l.ci, col="blue",lwd=2)

# alternatively via bootstrapping


## Prediction intervals
# http://stackoverflow.com/questions/18909234/coding-a-prediction-interval-from-a-generalized-additive-model-with-a-very-large

# Use the design matrix
design.mat <- predict(fit.gam, newdata=data.frame(x=grid.x), type="lpmatrix")
predvar <- diag(design.mat %*% vcov(fit.gam) %*% t(design.mat))
SE <- sqrt(predvar) 
SE2 <- sqrt(predvar+fit.gam$sig2) 
tfrac <- qt(0.975, fit.gam$df.residual)
interval = tfrac*SE2

# better do estimate the SE via fitting of the residuals
# The mean curves/predictors should not be affected too much, but for 
# simulation the correct values should be taken.
# TODO: estimate the residuals 

plot(x,y,pch=19,cex=.5) ## and original data
lines(grid.x, pred$fit, col='blue', lwd=2)
lines(grid.x, pred$fit + interval, col='red', lwd=2)
lines(grid.x, pred$fit - interval, col='red', lwd=2)

# additional confidence interval
lines(grid.x, u.ci, col="green",lwd=2); 
lines(grid.x, l.ci, col="green",lwd=2)

## Prediction interval example for Gamma GAM
# good example, but not clear what is happening
# https://stat.ethz.ch/pipermail/r-help/2011-April/275632.html

# simulate the model
yp <- predict(fit.gam, newdata=data.frame(x=grid.x))
ysim <- rnorm(mean=yp,sd=SE2,n=length(yp)) 
points(grid.x, ysim, col='red')


##############################################
# Confidence bands for splines via Bootstrap #
##############################################
# calculation via bootstrap, by either resampling the residuals,
# or resampling the data points
# Be careful with the local variance

# Define the resampler for bootstrap based on the dataset
sp.frame <- data.frame(x=x, y=y)
sp.resampler <- function() {
  n <- nrow(sp.frame)
  resample.rows <- sample(1:n, size=n, replace=TRUE)
  return(sp.frame[resample.rows,])
}

# Create the estimator for the dataset
sp.spline.estimator <- function(data, m=100, df=9){
  # Fit spline to data, with cross-validation to pick lambda
  fit <- smooth.spline(x=data[,1],y=data[,2],cv=FALSE, df=df)
  # Set up a grid of m evenly-spaced points on which to evaluate the spline
  eval.grid <- seq(from=min(sp.frame[,1]),to=max(sp.frame[,1]),length.out=m)
  # Slightly inefficient to re-define the same grid every time we call this,
  # but not a big overhead
  # Do the prediction and return the predicted values
  return(predict(fit,x=eval.grid)$y) # We only want the predicted values
}

# Put resampler and estimator together to get confidence intervals
sp.spline.cis <- function(B, alpha, m=100) {
  spline.main <- sp.spline.estimator(sp.frame,m=m)
  # Draw B boottrap samples, fit the spline to each
  spline.boots <- replicate(B, sp.spline.estimator(sp.resampler(),m=m))
  
  # Result has m rows and B columns
  cis.lower <- 2*spline.main - apply(spline.boots,1,quantile, probs=1-alpha/2)
  cis.upper <- 2*spline.main - apply(spline.boots,1,quantile, probs=alpha/2)
  return(list(main.curve=spline.main, lower.ci=cis.lower,upper.ci=cis.upper,
              x=seq(from=min(sp.frame[,1]),to=max(sp.frame[,1]),length.out=m)))
}

sp.cis <- sp.spline.cis(B=1000,alpha=0.05)
summary(sp.cis)
str(sp.cis)
# Data with bootstrapped pointwise confidence band for the
# smoothing spline. The 95% confidence limits around the main spline
# estimate are based on 1000 bootstrap re-samplings of the data points
# in the scatter plot
plot(x, y, xlab="Age [years]",
     ylab="Bodyweight [kg]", col='grey')
lines(x=sp.cis$x,y=sp.cis$main.curve, col='blue', lwd=3)
lines(x=sp.cis$x,y=sp.cis$lower.ci,  col='orange', lwd=2)
lines(x=sp.cis$x,y=sp.cis$upper.ci,  col='orange', lwd=2) 


# How to get prediction intervals for splines ?
# What are the degree of freedom: the desired equivalent number of degrees of freedom (trace of smoother matrix)
# The x vector should contain at least four distinct values. ‘Distinct’ here is controlled by tol: values which are regarded as the same are replaced by the first of their values and the corresponding y and w are pooled accordingly.

# The prediction interval should be based on the local standard deviation of the residuals
# 




# Actually it looks like there might be a more parametric way to calculate confidence intervals using the jackknife residuals. This code comes from the S+ help page for smooth.spline
# http://stackoverflow.com/questions/23852505/how-to-get-confidence-interval-for-smooth-spline
sp.fit  <- smooth.spline(x, y, df = 9)
plot(x, y)
lines(sp.fit$x, sp.fit$y, col='red', lwd=3)

sp.res <- (sp.fit$yin - sp.fit$y)/(1-sp.fit$lev)      # jackknife residuals
sigma <- sqrt(var(sp.res))                            # estimate sd

upper <- sp.fit$y + 2.0*sigma*sqrt(sp.fit$lev)   # upper 95% conf. band
lower <- sp.fit$y - 2.0*sigma*sqrt(sp.fit$lev)   # lower 95% conf. band
matplot(sp.fit$x, cbind(upper, sp.fit$y, lower), type="plp", pch=".")

plot(sp.fit$x, sp.fit$yin - sp.fit$y)
length(x)
length(sp.fit$y)
plot(sp.fit$x, sp.fit$yin)

sp.fit$fit$nk

library(splines)
fit6 <- lm( y~ns(x, 9) )
fit6
summary(fit6)
####################################################################
lm.fit1 <- lm(y ~ log(x) + x + I(x^2)) 
lm.fit1
summary(lm.fit1)
lines(lm.fit1$, col='red', lwd=3)
curve(predict(lm.fit1, data.frame(x=x),type="resp"),add=TRUE)
sp.fit2 <- res <- smooth.spline(x, y, spar=0.7)
lines(sp.fit2, col='orange', lwd = 3)

# problems with linear models is the very different local behavior.
plot(x, y)
lm.fit2 <- lm(y ~ x + I(x^2) + I(x^3)) 
curve(predict(lm.fit2, data.frame(x=x),type="resp"),add=TRUE, col='red', lwd=3) 

# Spline is the best solution
# do a bootstrap for the evaluation
sp.fit2 <- res <- smooth.spline(x, y, df = 9)
lines(sp.fit2, col='orange', lwd = 3)

#############################################################
# Simulation of random variables

income <- rnorm(n,mean=predict(income.model,x),sd=sigma)
capture.probabilities <- predict(observation.model,x)
observed.income <- sample(income,size=b,prob=capture.probabilities)

# repeating simulations with replicate
# replicate(n, expr)
x <- runif(100, min=0, max=10)
x <- x[order(x)]
x
beta0 <- 1
beta1 <- 2
sigma <- 0.5
output <- replicate(100, rnorm(length(x),beta0+beta1*x,sigma))
# will replicate, 1000 times, sampling from the predictive distribution of a Gaussian
# linear regression model. Conceptually, this is equivalent to doing something like
str(output)
matplot(output)

# Simulation of the geyser data
library(MASS)
data(geyser)
str(geyser)
with(geyser, plot(duration, waiting))
fit.ols <- lm(waiting~duration, data=geyser)
fit.ols

abline(fit.ols, col='blue')

# Well, OLS is usually presented as part of a probability model for the response
# conditional on the input, with Gaussian and homoskedastic noise. In this case, the
# probability model is waiting = beta0 + beta1*duration + epsilon, with epsilon ~N(0,sigma^2).
rgeyser <- function() {
  n <- nrow(geyser)
  # use the residual standard error
  sigma <- summary(fit.ols)$sigma
  new.waiting <- rnorm(n, mean=fitted(fit.ols), sd=sigma)
  new.geyser <- data.frame(duration=geyser$duration,
                           waiting=new.waiting)
  return(new.geyser)
}

# A useful principle for model checking is that if we do some exploratory data
# analyses of the real data, doing the same analyses to realizations of the model should
# give roughly the same results.
plot(density(geyser$waiting),xlab="waiting",main="",sub="")
lines(density(rgeyser()$waiting),lty=2)

with(rgeyser(), plot(duration, waiting))
plot(density(geyser$duration),xlab="duration",main="",sub="")
# One of the problems is heteroskedasiticity
plot(geyser$duration,geyser$waiting,xlab="duration",ylab="waiting")
abline(fit.ols)
points(rgeyser(),pch=20,cex=0.5)

plot(geyser$duration, fit.ols$residuals)

## Bootstrap ##
library(MASS)
data(geyser)
geyser.lm <- lm(waiting~duration, data=geyser)
summary(geyser.lm)
# First step in bootstrapping is to build the simulator,
# which just means sampling rows from the data frame
resample.geyser <- function(){
 sample.rows <- sample(1:nrow(geyser), replace=TRUE)
 return(sample.rows)
}

# estimator 
est.waiting.on.duration <- function(subset, data=geyser){
 fit <- lm(waiting ~ duration, data=data, subset=subset)
 return(coefficients(fit))
}

# Bootstrapped confidence intervals
geyser.lm.cis <- function(B,alpha) {
  tboot <- replicate(B,
                     est.waiting.on.duration(resample.geyser()))
  low.quantiles <- apply(tboot,1,quantile,probs=alpha/2)
  high.quantiles <- apply(tboot,1,quantile,probs=1-alpha/2)
  low.cis <- 2*coefficients(geyser.lm) - high.quantiles
  high.cis <- 2*coefficients(geyser.lm) - low.quantiles
  cis <- rbind(low.cis,high.cis)
  rownames(cis) <- as.character(c(alpha/2,1-alpha/2))
  return(cis)
}
signif(geyser.lm.cis(B=1e4, alpha=0.05),3)

# Bootstrapping of kernel smoothing
# The functional is a whole curve, resulting in confidence bands
install.packages('np')
library(np)
npr.waiting.on.duration <- function(subset, data=geyser, tol=0.1, ftol=0.1){
 bw <- npregbw(waiting ~ duration, data=data, subset=subset, tol=tol, ftol=ftol)
 fit <- npreg(bw)
 return(fit)
}
geyser.npr <- npr.waiting.on.duration(1:nrow(geyser))
plot(geyser.npr)

# do the bootstrap on the kernal smoothing
evaluation.points <- seq(from=0.8,to=5.5,length.out=200)
evaluation.points <- data.frame(duration=evaluation.points)
eval.npr <- function(npr) {
  return(predict(npr,newdata=evaluation.points))
}
main.curve <- eval.npr(geyser.npr)
npr.cis <- function(B,alpha) {
  tboot <- replicate(B,
                     eval.npr(npr.waiting.on.duration(resample.geyser())))
  low.quantiles <- apply(tboot,1,quantile,probs=alpha/2)
  high.quantiles <- apply(tboot,1,quantile,probs=1-alpha/2)
  low.cis <- 2*main.curve - high.quantiles
  high.cis <- 2*main.curve - low.quantiles
  cis <- rbind(low.cis,high.cis)
  return(list(cis=cis,tboot=t(tboot)))
}

geyser.npr.cis <- npr.cis(B=800, alpha=0.05)
plot(0, type='n', xlim=c(0.8, 5.5), ylim=c(0,100), 
     xlab="Duration (min)", ylab="Waiting (min)")
for (i in 1:800) {
 lines(evaluation.points$duration, geyser.npr.cis$tboot[i,], lwd=0.1, col='grey') 
}
lines(evaluation.points$duration,geyser.npr.cis$cis[1,])
lines(evaluation.points$duration,geyser.npr.cis$cis[2,])
lines(evaluation.points$duration,main.curve)
rug(geyser$duration,side=1)
points(geyser$duration,geyser$waiting)

# Handling heteroskedasicty
x <- rnorm(100, 0, 3)
y = 3 - 2*x + rnorm(100, 0, sapply(x, function(x){1+0.5*x^2}))
plot(x, y)
abline(a=3, b=-2, col="grey")
fit.ols <- lm(y ~ x)
abline(fit.ols, lty=2)
# using weighted linear regression
fit.wls <- lm(y~x, weights=1/(1+0.5*x^2))
abline(fit.wls, lty=3)

plot(x, residuals(fit.ols))
plot(x, (residuals(fit.ols))^2)

ols.heterosked.example <- function(n){
  y = 3 - 2*x + rnorm(100, 0, sapply(x, function(x){1+0.5*x^2}))
  fit.ols <- lm(y ~ x)
  # return errors
  return(fit.ols$coefficients - c(3,2))
}
ols.heterosked.error.stats <- function(n, m=10000){
 ols.errors.raw <- t(replicate(m, ols.heterosked.example(n)))
 # transpose gives a matrix with named columns
 intercept.sd <- sd(ols.errors.raw[, "(Intercept)"])
 slope.sd <- sd(ols.errors.raw[, "x"])
 return(list(intercept.sd=intercept.sd, slope.sd=slope.sd))
}
ols.heterosked.error.stats(100)

# Using iterative approach to estimate local variance
plot(x, residuals(fit.ols)^2, ylab="squared residuals")
curve(1+x^2/2, col="grey", add=TRUE)
# fit the residuals variance via kernel smoothing
require(np)
var1 <- npreg(residuals(fit.ols)^2 ~ x)
grid.x <- seq(from=min(x), to=max(x), length.out=300)
lines(grid.x, predict(var1, exdat=grid.x))
# weighted fit with the estimated variance
fit.wls1 <- lm(y~x,weights=1/fitted(var1))
plot(x,y)
abline(a=3,b=-2,col="grey")
abline(fit.ols,lty=2)
abline(fit.wls1,lty=3)

plot(x,(residuals(fit.ols))^2,ylab="squared residuals")
points(x,(residuals(fit.wls1))^2,pch=15)
lines(grid.x,predict(var1,exdat=grid.x))
var2 <- npreg(residuals(fit.wls1)^2 ~ x)
curve((1+x^2/2)^2,col="grey",add=TRUE)
lines(grid.x,predict(var2,exdat=grid.x),lty=3)

# automatize the iterative approach
iterative.wls <- function(x,y,tol=0.01,max.iter=100) {
  iteration <- 1
  old.coefs <- NA
  regression <- lm(y~x)
  coefs <- coefficients(regression)
  while (is.na(old.coefs) ||
           ((max(coefs - old.coefs) > tol) && (iteration < max.iter))) {
    variance <- npreg(residuals(regression)^2 ~ x)
    old.coefs <- coefs
    iteration <- iteration+1
    regression <- lm(y~x,weights=1/fitted(variance))
    coefs <- coefficients(regression)
  }
  return(list(regression=regression,variance=variance,iterations=iteration))
}
iterative.wls(x,y)

# Real data - heteroskedastic
library(MASS)
data(geyser)

fit.ols <- lm(waiting ~ duration, data=geyser)
plot(geyser$duration, residuals(fit.ols)^2, cex=0.5, pch=16,
     main="Squared residuals and variance estimates versus geyser duration",
     xlab="Duration [min]",
     ylab=expression("Squared residuals of linear model "(min^2)))
# kernel smoothing with data driven bandwidth selection
library(np)
geyser.var <- npreg(residuals(fit.ols)^2 ~ geyser$duration)
duration.order <- order(geyser$duration)
lines(geyser$duration[duration.order], fitted(geyser.var)[duration.order])
abline(h=summary(fit.ols)$sigma^2, lty="dashed")
legend("topleft", 
       legend=c("data", "kernel variance", "homoskedastic (OLS)"),
       lty=c(-1,1,2), pch=c(16,-1,-1))

# comparison with simulations from homskedastic model
plot(geyser.var)
abline(h=summary(fit.ols)$sigma^2, lty=2)
duration.grid <- seq(from=min(geyser$duration), to=max(geyser$duration), length.out=300)
one.var.func <- function(){
 fit <- lm(waiting ~ duration, data=rgeyser())
 var.func <- npreg(residuals(fit)^2 ~ geyser$duration)
 lines(duration.grid, predict(var.func, exdat=duration.grid), col="grey")
}
invisible(replicate(10, one.var.func()))

# Bootstrap under heteroskedasticity has to take the conditional variance
# depending on x into account !
# Especially important under bootstrapping the residuals [see 7.4]


## Linear additive models ##
housing <- na.omit(read.csv("http://www.stat.cmu.edu/~cshalizi/uADA/13/hw/01/calif_penn_2011.csv"))
calif <- housing[housing$STATEFP==6,]
str(housing)
# fit a linear model for the log price
calif.lm <- lm(log(Median_house_value) ~ Median_household_income + Mean_household_income + POPULATION + Total_units + Vacant_units + Owners + Median_rooms + Mean_household_size_owners + Mean_household_size_renters + LATITUDE + LONGITUDE, data = calif)
print(summary(calif.lm), signif.stars=FALSE, digits=3)

# quick and dirty calculation of prediction limits
# because there are two (independent) sources of nois, we need to 
# combine the standard deviations by "adding in quadrature"
predlims <- function(preds, sigma){
  prediction.sd <- sqrt(preds$se.fit^2 + sigma^2)
  upper <- preds$fit + 2*prediction.sd
  lower <- preds$fit - 2*prediction.sd
  lims <- cbind(lower=lower, upper=upper) 
  return(lims)
}

preds.lm <- predict(calif.lm,se.fit=TRUE)
predlims.lm <- predlims(preds.lm, sigma=summary(calif.lm)$sigma)
plot(calif$Median_house_value, exp(preds.lm$fit),type="n",
     xlab="Actual price ($)",ylab="Predicted ($)", main="Linear model")
segments(calif$Median_house_value, exp(predlims.lm[,"lower"]),
         calif$Median_house_value, exp(predlims.lm[,"upper"]), col="grey")
abline(a=0,b=1,lty="dashed")
points(calif$Median_house_value,exp(preds.lm$fit),pch=16,cex=0.1)

require(mgcv)
system.time(calif.gam <- gam(log(Median_house_value)
                             ~ s(Median_household_income) + s(Mean_household_income) + s(POPULATION)
                             + s(Total_units) + s(Vacant_units) + s(Owners) + s(Median_rooms)
                             + s(Mean_household_size_owners) + s(Mean_household_size_renters)
                             + s(LATITUDE) + s(LONGITUDE), data=calif))

calif.gam2 <- gam(log(Median_house_value)
                  ~ s(Median_household_income) + s(Mean_household_income) + s(POPULATION)
                  + s(Total_units) + s(Vacant_units) + s(Owners) + s(Median_rooms)
                  + s(Mean_household_size_owners) + s(Mean_household_size_renters)
                  + s(LONGITUDE,LATITUDE), data=calif)

preds.gam <- predict(calif.gam,se.fit=TRUE)
predlims.gam <- predlims(preds.gam,sigma=sqrt(calif.gam$sig2))
plot(calif$Median_house_value,exp(preds.gam$fit),type="n",
     xlab="Actual price ($)",ylab="Predicted ($)", main="First additive model")
segments(calif$Median_house_value,exp(predlims.gam[,"lower"]),
         calif$Median_house_value,exp(predlims.gam[,"upper"]), col="grey")
abline(a=0,b=1,lty="dashed")
points(calif$Median_house_value,exp(preds.gam$fit),pch=16,cex=0.1)

plot(calif.gam,scale=0,se=2,shade=TRUE,pages=1)
plot(calif.gam2,scale=0,se=2,shade=TRUE,resid=TRUE,pages=1)
