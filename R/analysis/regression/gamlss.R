# Centile estimation with gamlss
# http://www.gamlss.org/?p=1215
#
# TODO: 
# - fit model
# - calculate confidence intervals
# - calculate prediction intervals
# - plot centiles
#
# author: Matthias Koenig
# date: 2014-10-12
rm(list = ls())

if (!require("RColorBrewer")) {
  install.packages("RColorBrewer")
  library(RColorBrewer)
}
### Show all the colour schemes available
display.brewer.all()

# Get example data
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
head(data)

# new data.frame with necessary information
df <- data.frame(age=data$RIDAGEYR, sex=data$RIAGENDR, bsa=data$BSA)
df$agepower <- df$age^0.3
summary(df)

# The male and female datasets

df.male <- df[df$sex == 'male', ]
df.female <- df[df$sex == 'female', ]

df.names <- c('all', 'male', 'female')
df.cols <- c( rgb(0,0,0,alpha=0.5),
                rgb(0,0,1,alpha=0.5),
                rgb(1,0,0,alpha=0.5) )
names(df.cols) <- df.names 

par(mfrow=c(1,3))
for (k in 1:3){
  if (k ==1){ d <- df }
  else if (k ==2){ d <- df.male }
  else if (k ==3){ d <- df.female }
  
  plot(d$agepower, d$bsa, col=df.cols[k], 
       main=sprintf('NHANES (%s)', df.names[k]),
       xlab='Age [years]',
       ylab=expression(paste("BSA [", m^2, "]", sep="")),
       ylim=c(0.5, 2.5))
  rug(d$age, side=1, col="grey"); rug(d$bsa, side=2, col="grey")
}
par(mfrow=c(1,1))
rm(d,k)

#######################################################
# Fit the model with cubic splines - centile estimation
#######################################################
library('gamlss')
fit.all.no <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=NO, data=df)
summary(fit.all.no)
plot(fit.all.no)
centiles(fit.all.no,  xvar=df$age)
fittedPlot(fit.all.no, x=df$age)

fit.all.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df)
fit.all.bccg.1 <- gamlss(bsa ~ cs(age,6), 
                       sigma.formula= ~cs(age,3), nu.formula= ~cs(age,3), 
                       family=BCCG, data=df)
summary(fit.all.bccg)
plot(fit.all.bccg)
centiles(fit.all.bccg,  xvar=df$age)
fittedPlot(fit.all.bccg, x=df$age)
summary(fit.all.bccg.1)
plot(fit.all.bccg.1)
centiles(fit.all.bccg.1,  xvar=df$age)
fittedPlot(fit.all.bccg.1, x=df$age)

fit.male.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df.male)
centiles(fit.male.bccg,  xvar=df.male$age)

fit.female.bccg <- gamlss(bsa ~ cs(age,9), sigma.formula= ~cs(age,3), family=BCCG, data=df.female)
centiles(fit.female.bccg,  xvar=df.female$age)

fit.final <- list(fit.all.bccg, fit.male.bccg, fit.female.bccg) 

#########################################
# Generate the centile plot
# - confidence intervals
# - different shades for centiles

# Calculation of the centiles for given x-values and 
# fitted gamlss object
qCentiles <- function (obj, newdata=NULL, cent = c(0.4, 2, 10, 25, 50, 75, 90, 98, 99.6) ) 
{
  if (!is.gamlss(obj)) 
    stop(paste("This is not an gamlss object", "\n", ""))
  if (is.null(newdata)) 
    stop(paste("The xvar argument is not specified", "\n", ""))
  
  # evalute for prediction
  fname <- obj$family[1]
  qfun <- paste("q", fname, sep = "")
  lpar <- length(obj$parameters)
  centiles <- vector('list', length(cent))
  ii = 0
  for (k in 1:length(cent)) {
    var <- cent[k]
    if (lpar == 1) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata))
    }
    else if (lpar == 2) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata))
    }
    else if (lpar == 3) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata),
                      nu = predict(obj, what="nu", type="response", newdata=newdata))
    }
    else {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata),
                      nu = predict(obj, what="nu", type="response", newdata=newdata),
                      tau = predict(obj, what="tau", type="response", newdata=newdata))
    }
    ll <- eval(newcall)
    centiles[[k]] <- ll
  }  
  return(centiles)
}


d <- df.male; k <- 2
plot(d$age, d$bsa, col=df.cols[k], 
     main=sprintf('NHANES (%s)', df.names[k]),
     xlab='Age [years]',
     ylab=expression(paste("BSA [", m^2, "]", sep="")),
     ylim=c(0.5, 2.5), pch=20, cex=0.8)
grid()

lines(d$age[order(d$age)], fitted(fit.bccg[[k]])[order(d$age)], col='black', lwd=3)

plot(d$age, d$bsa, type="n", col=df.cols[k], 
     main=sprintf('NHANES (%s)', df.names[k]),
     xlab='Age [years]',
     ylab=expression(paste("BSA [", m^2, "]", sep="")),
     ylim=c(0.5, 2.5), pch=20, cex=0.8)

# get the centiles for
age.grid <- seq(from=min(df$age), to=max(df$age), length.out = 101)
cent.values <- c(2.5, 10, 25, 50, 75, 90, 97.5)
cents <- qCentiles(fit.final[[k]], newdata=data.frame(age=age.grid), cent=cent.values)

plot(d$age, d$bsa, type="n")
for (k in 1:length(cent.values)){
  lines(age.grid, cents[[k]])
}
summary(cents[[1]])
str(cents[[1]])

?predict.gamlss



    
# The function BCCG defines the Box-Cox Cole and Green distribution (Box-Cox normal), a three parameter distribution, for a gamlss.family object to be used in GAMLSS fitting using the function gamlss(). The functions dBCCG, pBCCG, qBCCG and rBCCG define the density, distribution function, quantile function and random generation for the specific parameterization of the Box-Cox Cole and Green distribution.
qBCCG()
centiles(fit.male.bccg, xvar=d$age, cent=cent.values)

# plot centiles & write text next to it




plot(fit.all)
# note that the plot() function does not produce additive term plots [as it does for example in the gam() function of the package mgcv] in R. The function which does this in the gamlss package is term.plot()
term.plot(fit.all, se=TRUE, partial=TRUE)



## Centile estimation using GAMLSS ##
#####################################
# the non parametric approach of quantile regression
# (Koenker, 2005; Koenker and Bassett, 1978)
# ii) the parametric LMS approach of Cole (1988), Cole
# and Green (1992) and its extensions Rigby and
# Stasinopoulos (2004, 2006, 2007).

plot(x.male, y.male, col='grey')

# LMS method : Y ~ BCCG(mu, sigma, v) and Z ~ N(0,1)
# what happens if no formulas for sigma, nu and tau provided ?
# Get the data and plot
fit.male.lms <- gamlss(y.male ~ cs(x.male,6), family=BCCG)
fit.female.lms <- gamlss(y.female ~ cs(x.female,6), family=BCCG)
lines(x.male[x.male.order], fitted(fit.male.lms)[x.male.order], col='red')

# LMST method : Y ~ BCT(mu, sigma, v, t) and Z ~ t
fit.male.bct <- gamlss(y.male ~ cs(x.male,6), family=BCT)
lines(x.male[x.male.order], fitted(fit.male.bct)[x.male.order], col='red', lty=2)

# LMSP method : Y ~ BCT(mu, sigma, v, t) and Z ~ PE(0,1,tau)
# method adopted by WHO
fit.male.bcpe <- gamlss(y.male ~ cs(x.male,6), family=BCPE)
lines(x.male[x.male.order], fitted(fit.male.bcpe)[x.male.order], col='red', lty=3)

centiles(fit.male.lms, xvar=x.male, cent=c(97.5, 90, 75, 50, 25, 10, 2.5))
centiles(fit.female.lms, xvar=x.female )



############################
library('gamlss')
# http://www.gamlss.org/?page_id=1094

# introduction to gamless package
# http://www.book.gamlss.org/GAMLSS-In_R.html

data('abdom')
plot(y ~ x, data = abdom, col = "blue", xlab = "age", ylab = "circumference")
# To fit a normal distribution to the data with the mean of \( Y \) modelled as a cubic polynomial in x, i.e. poly(x,3), use
abd0 <- gamlss(y ~ poly(x,3), data=abdom, family=NO)
summary(abd0)
# alternative formulation via I()
abd00 <- gamlss(y ~ x + I(x^2) + I(x^3), data = abdom, family = NO)
# The summary function (used after convergence of the gamlss() function) has two ways of producing standard errors. The default value is type=“vcov”. This uses the vcov method for gamlss objects which (starting from the fitted beta parameters values given by the gamlss() function) uses a non-linear fitting, with only one iteration to obtain the full Hessian matrix of all the beta parameters in the model (from all the distribution parameters), i.e. \( \beta_{01} \), \( \beta_{11} \), \( \beta_{21} \), \( \beta_{31} \) and \( \beta_{02} \) in the above model. Standard errors are obtained from the observed information matrix (the inverse of the Hessian). The standard errors obtained this way are reliable, since they take into account the information about the interrelationship between the distribution parameters, i.e. \( \mu \) and \( \sigma \) in the above case. On occasions, when the above procedure fails, the standard errors are obtained from type=“qr”, which uses the individual fits of the distribution parameters (used in the gamlss() algorithms) and therefore should be used with caution. %This is The summary() output gives a warning when this happens. The standard errors produced this way do not take into the account the correlation between the estimates of the distribution parameters \( \mu \), \( \sigma \), \( \nu \) and \( \tau, \) [although in the example above the estimates of the distribution parameters \( \mu \) and \( \sigma \) of the normal distribution are asymptotically uncorrelated]. 

# Note also that when smoothing additive terms are involved in the fitting, both methods, that is, “vcov” and “qr”, produce incorrect standard errors, since they are effectively assume that the estimated smoothing terms were fixed at their estimated values. The functions prof.dev() and prof.term() can be used for obtaining more reliable individual parameter confidence intervals.

# Model abd0 is a linear parametric GAMLSS model. In order to fit a semi-parametric model in age using a non-parametric smoothing cubic spline with 3 effective degrees of freedom on top of the constant and linear terms use
abd1 <- gamlss(y ~ cs(x, df=3), data=abdom, family=NO)
plot(abd1)
summary(abd1)

# The total degrees of freedom used for the above model abd1 is six, i.e. 5 for mu the mean, and 1 for the constant scale parameter sigma the standard deviation of the fitted normal distribution model.

# Fitted values of the parameters of the object can be obtained using the fitted() function. For example plot(x, fitted(abd1,“mu”)) will plot the fitted values of mu against x. The constant estimated scale parameter (the standard deviation of the normal in this case) can be obtained: 
fitted(abd1, "sigma")[1]

# where [1] indicates the first value of the vector. The same values can be obtained using the more general function predict():
predict(abd1, what = "sigma", type = "response")[1]

# To model both the mean, mu, and the scale parameter, sigma, as non-parametric smoothing cubic spline functions of x (with a normal distribution for the response \( Y \)) use:
abd2 <- gamlss(y ~ cs(x,3), sigma.formula= ~cs(x,3), data=abdom, family=NO)
plot(abd2)
# ote that the plot() function does not produce additive term plots [as it does for example in the gam() function of the package mgcv] in R. The function which does this in the gamlss package is term.plot()
term.plot(abd2, se=TRUE, partial=TRUE)

# A worm plot of the residuals, see van Buuren and Fredriks (2001), \nocite{vanBuurenFredriks01} can be obtained by using the wp() function:
wp(abd2)
wp(abd2, ylim.all=1.5)

#The default worm plot above is a detrended normal Q-Q plot of the residuals, and indicates a possible inadequacy in modelling the distribution, since some points plotted lie outside the (dotted) confidence bands.

# In model abd2 we fitted a smoothing function for both the \( \mu \) and \( \sigma \) parameter by fixing extra the degrees of freedom for smoothing to be equal to three. This will gives 5 degrees for freedom for both \( \mu \) and \( \sigma \). The function pb() allows the smoothing parameters (and therefore the degrees of freedoms) to be estimated automatically within the GAMLSS algorithm.

# Effective degree of freedom
abd3 <- gamlss(y ~ pb(x), sigma.formula=~pb(x), data=abdom, family=NO)
edfAll(abd3)

# The estimated total degrees of freedom for smoothing are $ 5.679$ and $ 2.0025$ for \( \mu \) and \( \sigma \) respectively. The locally estimated degrees of freedom for \( \mu \) are a bit higher than the fixed degrees of freedom used for models abd1 and abd2. The \( \sigma \) degrees of freedom are almost 2 indicating that we only need a linear model for \( x \), that is the model with sigma.formula = \( \sim \) x.

# If you wish to use loess curves, see \Cleveland and Devlin (1988), instead of cubic or penalised splines use:
abd4 <- gamlss(y ~ lo(~x, span = 0.4), sigma.fo = ~lo(~x, span = 0.4), data = abdom, family = NO)

# If you wish to use a different distribution instead of the normal, use the option family of the function gamlss. For example to fit a t-distribution to the data use:
abd5 <- gamlss(y ~ pb(x), sigma.formula = ~pb(x), data = abdom, family = TF)
# A list of the different continuous distributions implemented in the package gamlss() is given in thereference card. The details of all the distributions currently available in gamlss() are given in the book “The Distribution Toolbox of GAMLSS”. Chapter 4 of the GAMLSS manual, Stasinopoulos et al., (2008), describes how the user can set up their own distribution in gamlss().

# Different models can be compared using their global deviances, \( GD=-2 \hat{\ell} \), (if they are nested) or using a generalised Akaike information criterion, \( GAIC=-2\hat{\ell}+ (k.df) \), where \( \hat{\ell}=\sum_{i=1}^{n} \log f(y_i|\hat{\mu}_i, \hat{\sigma}_i, \hat{\nu}_i,\hat{\tau}_i) \) is the fitted log-likelihood function and \( k \) is a required penalty, e.g. \( k=2 \) for the usual Akaike information criterion or \( k=log(n) \) for the Schwartz Bayesian criterion. The function deviance() provides the global deviance of the model. Note that the GAMLSS global deviance is different from the deviance that is provided by the functions glm() and gam() in \R{}. The global deviance is exactly minus twice the fitted log likelihood function, including all constant terms in the log-likelihood. The glm() deviance is calculated as a deviation from the saturated model and it does not include 'constant' terms (which do not depend on the mean of distribution but depend in scale parameter) in the fitted log likelihood and so cannot be used to compare different distributions. To obtain the generalised Akaike information criterion use the functions AIC() or GAIC(). The functions are identical. For example to compare the models abd1, abd2 and abd3 use:
GAIC(abd1, abd2, abd3, abd4, abd5)

# Try the gamless demo package
install.packages('gamlss.demo')
library(gamlss.demo)
??gamlss.demo
gamlss.demo()




