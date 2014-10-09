# Tutorial for generalized additive models
# Based on Michael Clark - Getting started with additive models in R

## Introduction
# Generalized linear models include a link function g(.) relating the mean mu
# (estimated fitted values E(y), to the linear predictor X*beta
# g(mu) = X*beta
# The typical linear regression is a generalized linear model with a Gaussian
# distribution and identiy link function.

# Application using R
# install.packages('psych')
rm(list = ls())
d = read.csv("http://www.nd.edu/~mclark19/learn/data/pisasci2006.csv")

library(psych)
describe(d)[-1, 1:9] #univariate

library(car)
scatterplotMatrix(d[,-c(1,3:5)],pch=19,cex=.5,reg.line=F, lwd.smooth=1.25,
                  spread=F,ellipse=T, col=c('gray60','#2957FF','#FF8000'),
                  col.axis='gray50')

library(ggplot2); library(reshape2)
#get data into a form to take advantage of ggplot
dmelt = melt(d, id=c('Country','Overall'),
             measure=c('Interest','Support','Income','Health','Edu','HDI'))
head(dmelt)
str(dmelt)


#leave the smooth off for now
ggplot(aes(x=value,y=Overall), data=dmelt) +
  geom_point(color='#FF8000',alpha=.75) +
  #geom_smooth(se=F) +
  geom_text(aes(label=Country), alpha=.25, size=1,angle=30, hjust=-.2,
            vjust=-.2) + facet_wrap(~variable, scales='free_x')

# use simple gam smoothening
library(mgcv)
ggplot(aes(x=value,y=Overall), data=dmelt) +
  geom_point(color='#FF8000',alpha=.75) +
  geom_smooth(se=F, method='gam', formula=y~s(x), color='#2957FF') +
  geom_text(aes(label=Country), alpha=.25, size=1,angle=30, hjust=-.2,
            vjust=-.2) + facet_wrap(~variable, scales='free_x')

# Single predictor
library(mgcv)
# linear regression as special case
# Family: gaussian 
# Link function: identity 
mod_lm <- gam(Overall ~ Income, data=d)
summary(mod_lm)

# model matrix (consisting of base functions)
# GAM
# cr -> cubic regression splines
mod_gam1 <- gam(Overall ~ s(Income, bs="cr"), data=d)
summary(mod_gam1)
# Family: gaussian
# Link function: identity
# without the smoothing would result in a standard regression model
# edf: effective degree of freedom. In typical OLS this is equivalent to 
# the number of predictors/terms in the model.
?summary.gam
plot(mod_gam1)
# plotting
plot(d$Income, d$Overall)

# Some measures of performance for model comparison
AIC(mod_lm)
AIC(mod_gam1)
summary(mod_lm)$sp.criterion
summary(mod_gam1)$sp.criterion

summary(mod_lm)$r.sq # adjusted R squared
summary(mod_gam1)$r.sq # adjusted R squared

# Anova on models
?anova.gam
anova(mod_lm, mod_gam1, test = "Chisq")

## Multiple predictors ##
# adding health and education indices
mod_lm2 <- gam(Overall ~ Income + Edu + Health, data=d)
summary(mod_lm2)

mod_gam2 <- gam(Overall ~s(Income) + s(Edu) + s(Health), data=d)
summary(mod_gam2)
# removing the health variable
mod_gam2B <- update(mod_gam2, .~. -s(Health) + Health)
summary(mod_gam2B)

plot(mod_gam2, pages=1, residuals=T, pch=19, cex=0.25,
     scheme=1, col='#FF8000', shade=T,shade.col='gray90')

# The following will produce a plot of Income on the scale fo the response
# with the other predictors held at their means
# Note that mod_gam2$model is the data that was used in the modeling process,
# so it will have NAs removed.
testdata = data.frame(Income=seq(.4,1, length=100),
                      Edu=mean(mod_gam2$model$Edu),
                      Health=mean(mod_gam2$model$Health))
fits = predict(mod_gam2, newdata=testdata, type='response', se=T)
predicts = data.frame(testdata, fits)
ggplot(aes(x=Income,y=fit), data=predicts) +
  geom_smooth(aes(ymin = fit - 1.96*se.fit, ymax=fit + 1.96*se.fit),
              fill='gray80', size=1,stat='identity')

# contour plot of two predictors
vis.gam(mod_gam2, type = "response", plot.type = "contour")

# using of tensor product smooth
mod_gam3 <- gam(Overall ~ te(Income, Edu), data = d)
summary(mod_gam3)

vis.gam(mod_gam3, type='response', plot.type='persp',
        phi=30, theta=30,n.grid=500, border=NA)

# model comparison
anova(mod_lm2, mod_gam2, test = "Chisq")

## Other issues ##
##################
# Choice of smoothing function. A number of smoothing functions are available
# in the mgcv package
?smooth.terms

# Diagnostics & Choice of basis dimensions
gam.check(mod_gam2, k.rep=1000)

# in predict.gam:
# It is worth noting that there is an option, type=’lpmatrix’,
# which will return the actual model matrix by which the coefficients
# must be pre-multiplied to get the values of the linear predictor at the
# supplied covariate values. This can be particularly useful towards
# opening the black box as one learns the technique.


# Get Robust standard errors with the sandwich package
