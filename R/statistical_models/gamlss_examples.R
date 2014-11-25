# GAMLSS examples
# Stasinopoulos, D Mikis, and Robert A Rigby. "Generalized additive models for location scale and shape (GAMLSS) in R." Journal of Statistical Software 23.7 (2007): 1-46.

##########################################
# 3.2 lice data
##########################################
# Here we fit four discrete distributions the Poisson (PO), the negative binomial type I (NBI),
# the Poisson inverse Gaussian (PIG) and the Sichel (SICHEL). Note that we are using the frequencies
# as weights. More on how to use the weights argument correctly can be found in
# Stasinopoulos et al. (2006, Section 3.2.1).
rm(list=ls())
library('gamlss')
library('gamlss.dist')
data("lice")
head(lice)
with(lice, plot(head, freq))

# The argument method=mixed(10,50)
# used here, for the Sichel distribution, is for speeding the convergence. It instructs gamlss()
# to use the RS() algorithm for the rst 10 iterations (to stabilize the tting process) and then
# (if it has not converged yet) to switch to the CG() algorithm and continue with up to 50
# iterations.
# The argument trace=FALSE in the gamlss() function is used to suppress the output at each iteration
mPO <- gamlss(head ~ 1, data = lice, family = PO, weights = freq, trace = FALSE)
mNBI <- gamlss(head ~ 1, data = lice, family = NBI, weights = freq, trace = FALSE)
mPIG <- gamlss(head ~ 1, data = lice, family = PIG, weights = freq, trace = FALSE)
mSI <- gamlss(head ~ 1, data = lice, family = SICHEL, weights = freq, method = mixed(10, 50), trace = FALSE)
AIC(mPO, mNBI, mPIG, mSI)
# df       AIC
# mSI   3  4646.210
# mNBI  2  4653.687
# mPIG  2  4756.271
# mPO   1 29174.823
# From the AIC we conclude that the Sichel model is explaining the data best. The summary
# of the final fitted model is shown below
summary(mSI)

# Hence the fitted SICHEL model for the head lice data is given by y ~ SICHEL(mu^; sigma^; nu^) where
# mu^ = exp(1.927) = 6.869 and sigma^ = exp(4.863) = 129.4 and nu^ = 0.0007871 almost identical to
# zero. The profile global deviance plot for the parameter nu is shown in Figure 1. The figure is
# created using the code prof.dev(mSI, which="nu", min=-.12, max=.1, step=.01) which
# also produces a 95% confidence interval for nu as (-0.08532; 0.08867).
prof.dev(mSI, which="nu", min=-.12, max=.1, step=.01)

# Figure 2 shows a plot of the fitted SICHEL model created by the following R commands. Note
# that starting from the already fitted model, mSI using the argument start.from=mSI speeds
# the process
mSI <- histDist(lice$head, "SICHEL", freq = lice$freq, xmax = 10,
                main = "Sichel distribution", start.from = mSI, xlim = c(0, 8.75),
                trace = FALSE)

##########################################
# 3.4 CD4 data
##########################################
# First we compare the model using the Akaike Information criterion (AIC) which has penalty
# k = 2 for each parameter in the model, (the default value in the function GAIC()). Next we
# compare the models using Schwatz Bayesian Criterion (SBC) which uses penalty k = log(n).
library("gamlss.dist")
data("CD4")
plot(cd4 ~ age, data = CD4)

con <- gamlss.control(trace = FALSE)
m1 <- gamlss(cd4 ~ age, sigma.fo = ~1, data = CD4, control = con)
m2 <- gamlss(cd4 ~ poly(age, 2), sigma.fo = ~1, data = CD4, control = con)
m3 <- gamlss(cd4 ~ poly(age, 3), sigma.fo = ~1, data = CD4, control = con)
m4 <- gamlss(cd4 ~ poly(age, 4), sigma.fo = ~1, data = CD4, control = con)
m5 <- gamlss(cd4 ~ poly(age, 5), sigma.fo = ~1, data = CD4, control = con)
m6 <- gamlss(cd4 ~ poly(age, 6), sigma.fo = ~1, data = CD4, control = con)
m7 <- gamlss(cd4 ~ poly(age, 7), sigma.fo = ~1, data = CD4, control = con)
m8 <- gamlss(cd4 ~ poly(age, 8), sigma.fo = ~1, data = CD4, control = con)

# Akaike information criterion
# The Akaike information criterion (AIC) is a measure of the relative quality of a statistical model for a given set of data. As such, AIC provides a means for model selection.
# AIC deals with the trade-off between the goodness of fit of the model and the complexity of the model. It is founded on information theory: it offers a relative estimate of the information lost when a given model is used to represent the process that generates the data.
# Given a set of candidate models for data, the preferred model is the one with the minimum AIC value

GAIC(m1, m2, m3, m4, m5, m7, m8)
# Schwatz Bayesian Criterion (SBC), penalty k=log(n)
# often BIC (bayesian information criterion)
GAIC(m1, m2, m3, m4, m5, m7, m8, k = log(length(CD4$age)))

plot(cd4 ~ age, data = CD4)
lines(CD4$age[order(CD4$age)], fitted(m7)[order(CD4$age)], col = "red")
# Unfortunately the tted values for the mean of cd4 shown together with the data
# in Figure 5 look rather unconvincing. The line is too wobbly at the end of the age range,
# trying to be very close to the data. This is a typical behavior of polynomial tting.

# fractional polynomials with one, two and three terms respectively and we choose the
# best using GAIC.
m1f <- gamlss(cd4 ~ fp(age, 1), sigma.fo = ~1, data = CD4, control = con)
m2f <- gamlss(cd4 ~ fp(age, 2), sigma.fo = ~1, data = CD4, control = con)
m3f <- gamlss(cd4 ~ fp(age, 3), sigma.fo = ~1, data = CD4, control = con)
GAIC(m1f, m2f, m3f)
GAIC(m1f, m2f, m3f, k = log(length(CD4$age)))

m3f
m3f$mu.coefSmo

plot(cd4 ~ age, data = CD4)
lines(CD4$age[order(CD4$age)], fitted(m1f)[order(CD4$age)], col = "blue")
lines(CD4$age[order(CD4$age)], fitted(m2f)[order(CD4$age)], col = "green")
lines(CD4$age[order(CD4$age)], fitted(m3f)[order(CD4$age)], col = "red")

# Next we will t piecewise polynomials using the R function bs(). We try dierent degrees of
# freedom (eectively dierent number of knots) and we choose the best model using AIC and
# SBC.
m2b <- gamlss(cd4 ~ bs(age), data = CD4, trace = FALSE)
m3b <- gamlss(cd4 ~ bs(age, df = 3), data = CD4, trace = FALSE)
m4b <- gamlss(cd4 ~ bs(age, df = 4), data = CD4, trace = FALSE)
m5b <- gamlss(cd4 ~ bs(age, df = 5), data = CD4, trace = FALSE)
m6b <- gamlss(cd4 ~ bs(age, df = 6), data = CD4, trace = FALSE)
m7b <- gamlss(cd4 ~ bs(age, df = 7), data = CD4, trace = FALSE)
m8b <- gamlss(cd4 ~ bs(age, df = 8), data = CD4, trace = FALSE)
GAIC(m2b, m3b, m4b, m5b, m6b, m7b, m8b)
GAIC(m2b, m3b, m4b, m5b, m6b, m7b, m8b, k = log(length(CD4$age)))

# We will proceed by fitting smoothing cubic splines to the data. In smoothing splines the
# problem is how to choose a sensible value for the smoothing parameter lambda. The smoothing
# parameter is a function of the effective degrees of freedom, so we will use the following procedure:
# we will use the optim() function in R to nd the model with an the optimal (effective)
# degrees of freedom according to an GAIC

# optimize degree of freedoms based on AIC
fn.AIC <- function(p) {
  AIC(gamlss(cd4 ~ cs(age, df = p[1]), data = CD4, trace = FALSE), k=2)
}
opAIC <- optim(par = c(3), fn.AIC, method = "L-BFGS-B", lower = c(1), upper = c(15))

# optimize degree of freedoms based on BIC
fn.SBC <- function(p) {
  AIC(gamlss(cd4 ~ cs(age, df = p[1]), data = CD4, trace = FALSE), k = log(length(CD4$age)))
}
opSBC <- optim(par = c(3), fn.SBC, method = "L-BFGS-B", lower = c(1), upper = c(15))

opAIC$par
opSBC$par

# According to AIC the best model is the one with degrees of freedom 10.85 ~~ 11. This model
# seems to overfit the data as can been seen in Figure 8, (green continuous line). This is typical
# behaviour of AIC when it is used in this context.
# Note that 11 degrees of freedom in the fit
# refers to the extra degrees of freedom after the constant and the linear part is fitted to the
# model, so the overall degrees of freedom are 13.
maic <- gamlss(cd4 ~ cs(age, df = 10.85), data = CD4, trace = FALSE)
msbc <- gamlss(cd4 ~ cs(age, df = 1.85), data = CD4, trace = FALSE)
plot(cd4 ~ age, data = CD4)
lines(CD4$age[order(CD4$age)], fitted(maic)[order(CD4$age)], col = "blue")
lines(CD4$age[order(CD4$age)], fitted(msbc)[order(CD4$age)], col = "green")

# Given that the smooth cubic spline model for  appears reasonable, we proceed by looking at
# a suitable models for log  (since the default link function for sigma for the normal NO distribution
# We try a smooth cubic splines model for both terms. The following code will
# give us the best choice of degrees of freedom for both mu and sigma according to AIC. Note
# the fit of model m1 is used as the starting values
m1 <- gamlss(cd4 ~ cs(age, df = 10), sigma.fo = ~cs(age, df = 2), data = CD4, trace = FALSE)
fn <- function(p){
  AIC(gamlss(cd4 ~ cs(age, df = p[1]), sigma.fo = ~cs(age, p[2]), 
             data = CD4, trace = FALSE, start.from = m1), k = 2)
}
opAIC <- optim(par = c(8, 3), fn, method = "L-BFGS-B", lower = c(1,1), upper = c(15, 15))

fn <- function(p){
  AIC(gamlss(cd4 ~ cs(age, df = p[1]), sigma.fo = ~cs(age, p[2]), 
             data = CD4, trace = FALSE, start.from = m1), k = log(nrow(CD4)))
}
opSBC <- optim(par = c(8, 3), fn, method = "L-BFGS-B", lower = c(1,1), upper = c(15, 15))

opAIC$par
opSBC$par
m42 <- gamlss(cd4 ~ cs(age, df = 3.72), sigma.fo = ~cs(age, df = 1.81), data = CD4, trace = FALSE)
m31 <- gamlss(cd4 ~ cs(age, df = 2.55), sigma.fo = ~cs(age, df = 1.00), data = CD4, trace = FALSE)

# The next figure shows the ftted values for both the models. The plot is obtained using the command
fittedPlot(m42, m31, x=CD4$age, line.type=TRUE)
# The function fitted.plot() is appropriate when only one explanatory variable is tted to the data.

# The validation generalized deviance function VGD() provides an alternative 
# way of tuning the degrees of freedom in a smoothing situation. It is suitable for
# large sets of data where we can aord to use part of the data for tting the model (training)
# and part for validation.

set.seed(1234)
rSample6040 <- sample(2, length(CD4$cd4), replace = T, prob = c(0.6, 0.4))
fn <- function(p) {
  VGD(cd4 ~ cs(age, df = p[1]), sigma.fo = ~cs(age, df = p[2]), data = CD4, rand = rSample6040)
}
op <- optim(par = c(3, 1), fn, method = "L-BFGS-B", lower = c(1, 1), upper = c(10, 10))
op$par

# The next figure shows a worm plots from the residuals of model m42.
wp(m42, xvar=CD4$age)
# The important point here is that quadratic and cubic shapes in a worm plot indicate the presence
# of skewness and kurtosis respectively in the residuals (within the corresponding range of the
# explanatory variable, i.e., CD4$age). That is, the normal distribution tted so far to the data
# is not appropriate.

library("gamlss.dist")
m42TF <- update(m42, family = TF)
m42PE <- update(m42, family = PE)
m42SEP3 <- update(m42, family = SEP3, method = mixed(30, 100))
m42SHASH <- update(m42, family = SHASH, method = mixed(20, 100))
GAIC(m42, m42TF, m42PE, m42SEP3, m42SHASH)
#               df      AIC
# m42SEP3  11.531173 8690.531
# m42SHASH 11.530125 8703.417
# m42TF    10.531045 8785.149
# m42PE    10.531061 8790.081
# m42       9.529738 8790.437
GAIC(m42, m42TF, m42PE, m42SEP3, m42SHASH, k = log(length(CD4$age)))

##########################################
# 3.4 The third party claim
##########################################
rm(list=ls())
library"(gamlss.dist")
data("LGAclaims")
with(LGAclaims, plot(data.frame(Claims, L_Popdensity, L_KI, L_Accidents, L_Population)))
m0 <- gamlss(Claims ~ factor(SD) + L_Popdensity + L_KI + L_Accidents + L_Population, 
             data = LGAclaims, family = PO)
m1 <- gamlss(Claims ~ factor(SD) + L_Popdensity + L_KI + L_Accidents + L_Population, 
             data = LGAclaims, family = NBI)

# selection of variables
# We shall now use the dropterm() to check if model m1 can be simplied by dropping any of
# the existing terms in mu and the function addterm() to check whether two way interactions of
# the existing terms are needed.
library("MASS")
mD <- dropterm(m1, test = "Chisq")
mD

mA <- addterm(m1, scope = ~(factor(SD) + L_Popdensity + L_KI + L_Accidents + L_Population)^2, 
              test = "Chisq")
mA
# Based on the Chi square tests, no terms can be left out and no two way interaction is needed.
# Since we established that adding or dropping terms in mu is not beneficial there is no point
# using stepGAIC.VR() for modelling the mu parameter with linear terms. Instead we will use
# stepGAIC.CH() trying to establish if smoothing terms are needed in the mu model. The function
# gamlss.scope()|similar to the function gam.scope() in the gam package (Hastie 2006) is
# used here to create the different models to be fitted.
gs <- gamlss.scope(model.frame(Claims ~ factor(SD) + L_Popdensity + L_KI + L_Accidents + L_Population, 
                               data = LGAclaims))
gs
m2 <- stepGAIC.CH(m1, scope = gs, k = 2)
m2$anova
op <- par(mfrow = c(3, 2))

# plotting smoothing additive functions
term.plot(m2, se = T, partial = T)
par(op)

# finding sigma smoothing
m11 <- stepGAIC.VR(m2, scope = ~L_Popdensity + L_KI + L_Accidents + L_Population, 
                   what = "sigma", k = 2)

# The model chosen using AIC appears over complicated. Maybe
# a higher penalty for GAIC would be more appropriate here.
