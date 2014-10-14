# Linear regression
# http://ww2.coastal.edu/kingw/statistics/R-tutorials/simplelinear.html
library("MASS")
data(cats)
str(cats)
with(cats, plot(Bwt, Hwt))
title(main="Heart Weight (g) vs. Body Weight (kg)\nof Domestic Cats")

# Plot two variables against each other
with(cats, plot(Hwt ~ Bwt))
# A Pearson product-moment correlation coefficient 
# can be calculated using the cor( ) function... 
with(cats, cor(Bwt, Hwt))
with(cats, cor(Bwt, Hwt))^2  # R^2 
# Pearson's r = .804 indicates a strong positive relationship

with(cats, cor.test(Bwt, Hwt))
with(cats, plot(Bwt, Hwt, type="n", xlab="Body Weight in kg", 
                ylab="Heart Weight in g",
                main="Heart Weight vs. Body Weight of Cats"))

with(cats,points(Bwt[Sex=="F"],Hwt[Sex=="F"],pch=16,col="red"))
with(cats,points(Bwt[Sex=="M"],Hwt[Sex=="M"],pch=17,col="blue"))

# correlation and covariance matrices
rm(cats)
data(cement)
str(cement)
cor(cement)
# covariance matrix
cov(cement)
# visual representation of the correlation matrix
pairs(cement)

# correlations for ranked data
coach1 = c(1,2,3,4,5,6,7,8,9,10)
coach2 = c(4,8,1,5,9,2,10,7,3,6)
cor(coach1, coach2, method="spearman")
cor.test(coach1, coach2, method="spearman")

cor.test(coach1, coach2, method="kendall")

# regression
rm(list=ls())
data(cats)
attach(cats)
lm.out <- lm(Hwt ~ Bwt)
plot(Bwt, Hwt, xlab="Body Weight in kg", 
     ylab="Heart Weight in g",
     main="Heart Weight vs. Body Weight of Cats")
lm.out
summary(lm.out)

# show an ANOVA table
options(show.signif.stars=F)
anova(lm.out)

# With the output saved in a data object, plotting the regression 
# line on a scatterplot is a cinch... 
plot(Hwt ~ Bwt, main="Kitty Cat Plot")
abline(lm.out, col="red")

# a graphic display of how good the model fit is can be achieved as follows... 
par(mfrow=c(2,2))
plot(lm.out)
par(mfrow=c(1,1))

# The first plot is a standard residual plot showing residuals against fitted values. Points that tend towards being outliers are labeled. If any pattern is apparent in the points on this plot, then the linear model may not be the appropriate one. The second plot is a normal quantile plot of the residuals. We like to see our residuals normally distributed. Don't we? The last plot shows residuals vs. leverage. Labeled points on this plot represent cases we may want to investigate as possibly having undue influence on the regression relationship. Case 144 is one perhaps worth taking a look at... 
cats[144,]
lm.out$fitted[144]
lm.out$residuals[144]
#  A commonly used measure of influence is Cook's Distance, which can be visualized for all the cases in the model as follows... 
plot(cooks.distance(lm.out))

# There are a number of ways to procede. One is to look at the regression coefficients without the outlying point in the model... 
lm.without144 = lm(Hwt~Bwt, subset=(Hwt<20.5))
lm.without144
# Another is to use a procedure that is robust in the face of outlying points... 
rlm(Hwt~Bwt)
# Lowess stands for locally weighted scatterplot smoothing. It is a nonparametric method for drawing a smooth curve through a scatterplot.
plot(Hwt ~ Bwt)
lines(lowess(Hwt ~ Bwt), col="red")

# Models
# The nature of the variables--binary, categorial (factors), numerical--will determine the nature of the analysis. For example, if "u" and "v" are factors...
# y ~ u + v
# ...dictates an analysis of variance (without the interaction term). If "u" and "v" are numerical, the same formula would dictate a multiple regression. If "u" is numerical and "v" is a factor, then an analysis of covariance is dictated.
# glm( ) for generalized linear models (covered in another tutorial)
# gam( ) for generalized additive models
# lme( ) and lmer( ) for linear mixed-effects models
# nls( ) and nlme( ) for nonlinear models

state.x77                            # output not shown
str(state.x77)                       # clearly not a data frame!
st = as.data.frame(state.x77)        # so we'll make it one
str(st)
colnames(st)[4] = "Life.Exp"         # no spaces in variable names, please
colnames(st)[6] = "HS.Grad"
st[,9] = st$Population * 1000 / st$Area
colnames(st)[9] = "Density"          # create and name a new column
str(st)
summary(st)
cor(st) # correlation matrix

# We begin by throwing all the predictors into a (linear additive) model...
options(show.signif.stars=F)         # I don't like significance stars!
names(st)                            # for handy reference
model1 = lm(Life.Exp ~ Population + Income + Illiteracy + Murder 
                       + HS.Grad + Frost + Area + Density, data=st)
summary(model1)
# It appears higher populations are related to increased life expectancy and higher murder rates are strongly related to decreased life expectancy. Other than that, we're not seeing much. Another kind of summary of the model can be obtained like this... 
summary.aov(model1)

# The Minimal Adequate Model
# We want to reduce our model to a point where all the remaining predictors are significant, and we want to do this by throwing out one predictor at a time. "Area" will go first. To do this, we could just recast the model without the "Area" variable, but R supplies a handier way... 
model2 = update(model1, .~.-Area)
summary(model2)
# Notice that removing "Area" has cost us very little in terms of R-squared, and the adjusted R-squared actually went up, due to there being fewer predictors.

# The two models can be compared as follows... 
anova(model1, model2)

model3 = update(model2, .~.-Illiteracy)
summary(model3)
# Things are starting to change a bit. R-squared went down again, as it will always do when a predictor is removed, but once more adjusted R-squared increased. "Frost" is also now a significant predictor of life expectancy, and unlike in the bivariate relationship we saw originally, the relationship is now negative.

model4 = update(model3, .~.-Income)
summary(model4)

model5 = update(model4, .~.-Density)
summary(model5)

model6 = update(model5, .~.-Population)
summary(model6)
# We have reached the minimal adequate model.

# Stepwise Regression
# What we did in the previous section can be automated using the step( ) function... 
step(model1, direction="backward")

# Confidence Limits on the Estimated Coefficients
confint(model6)
confint(model6, level=0.95)

# Predictions
# Predictions can be made from a model equation using the predict( ) function...
predict(model6, list(Murder=10.5, HS.Grad=48, Frost=100))

# Beta Coeffieicents
# Beta or standardized coefficients are the slopes we would get if all the variables were on the same scale, which is done by converting them to z-scores before doing the regression. Betas allow a comparison of the relative importance of the predictors, which neither the unstandardized coefficients nor the p-values does. Scaling, or standardizing, the data vectors can be done using the scale( ) function... 
model7 = lm(scale(Life.Exp) ~ scale(Murder) + scale(HS.Grad) + scale(Frost), 
            data=st)
summary(model7)

## Making Predictions From a Model
# To illustrate how predictions are made from a model, I will fit a new model to another data set...

rm(list=ls())                        # clean up (WARNING! this will wipe your workspace!)
data(airquality)                     # see ?airquality for details on these data
na.omit(airquality) -> airquality    # toss cases with missing values
model <- lm(Ozone ~ Solar.R + Wind + Temp + Month, data=airquality)
coef(model)
# (Intercept)      Solar.R         Wind         Temp        Month 
# -58.05383883   0.04959683  -3.31650940   1.87087379  -2.99162786

# The model has been fitted and the regression coefficients displayed. Suppose now we wish to predict for new values: Solar.R=200, Wind=11, Temp=80, Month=6. One way to do it is this...

(prediction <- c(1,200,11,80,6) * coef(model))
sum(prediction)
# [1] 47.10406
# Our predicted value is 47.1. How accurate is it?

# We can get a confidence interval for the predicted value, but first we have to ask an important question. Is the prediction being made for the mean response for cases like this? Or is it being made for a new single case? The difference this makes to the CI is shown below...

### Prediction of mean response for cases like this...
predict(model, list(Solar.R=200,Wind=11,Temp=80,Month=6), interval="conf")
# fit      lwr      upr
# 1 47.10406 41.10419 53.10393
### Prediction for a single new case...

predict(model, list(Solar.R=200,Wind=11,Temp=80,Month=6), interval="pred")
# fit      lwr      upr
# 1 47.10406 5.235759 88.97236

#As you can see, the CI is much wider in the second case. These are 95% CIs. You can set a different confidence level using the "level=" option. The function predict( ) has a somewhat tricky syntax, so here's how it works. The first argument should be the name of the model object. The second argument should be a list of new data values labeled with the variables names. That's all that's really required. The "interval=" option can take values of "none" (the default), "confidence", or "prediction". You need only type enough of it so R knows which one you want. The confidence level is changed with the "level=" option, and not with "conf.level=" as in other R functions.

# confidence intervals for regression plots
area <- c(153750,15860,5800,5545,11970,2000,100)
species <- c(36,34,33,33,21,12,3)
plot(area ~ species)
larea <- log(area)
lsp <- log(species)
plot(lsp ~ larea)
mod1 <- lm(lsp ~ larea)
summary(mod1)

larea
lsp
predict(mod1)
plot(larea, lsp)
abline(mod1)
# The predict() command calculates confidence intervals for the predicted values
a <- predict(mod1, interval="confidence") 
lines(larea, a[,2], lty=2)
lines(larea, a[,3], lty=2)

# New data for prediction
newx <- seq(min(larea), max(larea), 0.1)
a <- predict(mod1, newdata=data.frame(larea=newx), interval="confidence") 
plot(larea,lsp, ylim=c(0,5))
abline(mod1)
lines(newx,a[,2], lty=3)
lines(newx,a[,3], lty=3) 

# The standard errors are slightly larger for prediction intervals rather than confidence interval. Confidence intervals are valid where you have x values in your data set. For possible x values not present in your dataset, you need to use a prediction interval. 
b <- predict(mod1, newdata=data.frame(larea=newx), interval="predict", level=0.95) 
lines(newx,b[,2], lty=3, col='blue')
lines(newx,b[,3], lty=3, col='blue') 
# I'm not quite sure what you mean by the "confidence interval for one specific variable in my model"; if you want confidence intervals on a parameter, then you should use confint. If you want predictions for the changes based only on some of the parameters changing (ignoring the uncertainty due to the other parameters), then you do indeed want to use type="terms".

# prediction and confidence bands
