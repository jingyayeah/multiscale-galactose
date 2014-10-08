# Load prepared NHANES data
rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
head(data)

# General spline fitting
x <- data$RIDAGEYR
y <- data$BMXWT
plot(x, y)
sp.fit <- res <- smooth.spline(x, y, cv=FALSE)
lines(sp.fit, col='blue', lwd = 3)
sp.fit2 <- res <- smooth.spline(x, y, spar=0.7)
lines(sp.fit2, col='orange', lwd = 3)

summary(sp.fit)
str(sp.fit)

##############################################
# Confidence bands for splines via Bootstrap #
##############################################
# calculation via bootstrap, by either resampling the residuals,
# or resampling the data points

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
