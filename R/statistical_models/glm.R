# generalized linear models
# http://www.youtube.com/watch?v=P-WYkSZp9lY
require(graphics)
airquality
plot(Ozone ~ Wind, data=airquality)

# fit the linear model
fit.lm <- lm(Ozone ~ Wind, data=airquality)
summary(fit.lm)
abline(fit.lm)

# General linear models (GLM)
# git glm with poisson
plot(log(Ozone) ~ Wind, data=airquality)
plot(Ozone ~ Wind, data=airquality)
fit.poi <- glm(Ozone ~ Wind, data=airquality, family=poisson)
plot(fit.poi)

# log(y) = b + ax
# y = exp(b + ax) = exp(b)*exp(ax)
# In a GLM (with poisson) an individual slope gives an estimate
# of the multiplicative chance in the the response variable
# for a one-unit change in the corresponding explanatory variable (predictor)

# General least square models
library(nlme)
fit.gls <- gls(Ozone ~ Wind, airquality)
# handle the missing values properly
summary(airquality)
fit.gls <- gls(Ozone~Wind, airquality, na.action=na.exclude)
# generate date command
head(airquality)
airquality$Date <- as.Date(paste(1973, airquality$Month, airquality$Day, sep='-'))
library(lattice)
xyplot(Ozone~Date, airquality)
# some temporal trend in data
fit.gls2 <- gls(Ozone~Wind*Date, airquality, na.action=na.exclude)

# check for autocorrelation
air2 <- subset(airquality, complete.cases(Ozone))
fit.gls3 <- gls(Ozone~Wind*Date, air2)

plot(ACF(fit.gls3), form=~Date, alpha=0.05)

# Update the model to handle autocorrelation
fit.gls4<-update(fit.gls3, correlation=corAR1())
# model comparision and checking
install.packages('MuMIn')
library(MuMIn)
AICc(fit.gls3, fit.gls4)
summary(fit.gls4)
