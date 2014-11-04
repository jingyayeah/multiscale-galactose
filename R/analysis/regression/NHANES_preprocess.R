################################################################################
# NHANES - preprocess continous NHANES
################################################################################
# Preprocess the full NHANES dataset generated in (NHANES_load.R).
# The preprocessing consists of filtering the data.rows with NAs in 
# relevant fields and subsetting to normal body mass index (18.5<=BMI<=24.9)
# and ethnicity (Non-Hispanic White).
# Body surface area (BSA) is calculated via formula of DuBois.
#
# author: Matthias Koenig
# date:   14-10-2014
################################################################################

rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')

## Load NHANES data ##
load(file='data/nhanes.dat')
head(nhanes)

## Calculate BSA ##
# Body surface area (BSA) by classic formula of DuBois’s {Moesteller1987}
nhanes$BSA <- 0.007184 * nhanes$BMXHT^0.725 * nhanes$BMXWT^0.425

## Subset of data ##
# i.e. remove extreme BMI values and reduce to 'Non-Hispanic White'
# normal bodyweight people of 'white' ethnicity
# BMI - Weight Status 
#   Below 18.5	Underweight
#   18.5 – 24.9	Normal
#   25.0 – 29.9	Overweight
#   30.0 and Above	Obese
bmi.sel <- (nhanes$BMXBMI >= 18.5) & (nhanes$BMXBMI <= 24.9)
eth.sel <- (nhanes$RIDRETH1 == "Non-Hispanic White")
na.sel <- !is.na(nhanes$RIDAGEYR) & !is.na(nhanes$RIAGENDR) & !is.na(nhanes$BMXBMI) & !is.na(nhanes$BMXWT) & !is.na(nhanes$BMXHT)
sel <- bmi.sel & eth.sel & na.sel
data <- nhanes[sel,]
head(data)
summary(data)

# add columns with unified names
data$age <- data$RIDAGEMN/12    # use age from month if available
data$age[is.na(data$age)] <- data$RIDAGEYR[is.na(data$age)]
data$sex <- data$RIAGENDR
data$bodyweight <- data$BMXWT
data$height <- data$BMXHT
data$ethnicity <- data$RIDRETH1
head(data)

save('data', file='data/nhanes_data.dat')


####################################
## Plotting data                  ##
####################################
library(ggplot2)

# plot height [cm]
g1 <- ggplot(data, aes(age, height))
g1 + geom_point()
g1 + geom_point(aes(color=sex)) + labs(title = "NHANES cohort (18.5 <= BMI < 24.9)") + labs(x='age [year]') + theme_bw()

# plot BSA [cm]
g1 <- ggplot(data, aes(age, bodyweight))
g1 + geom_point()
g1 + geom_point(aes(col=height)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + theme_bw() + facet_grid(.~sex)
g1 + geom_point(aes(color=age)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + labs(x='age [year]') + facet_grid(.~RIAGENDR) + theme_bw() + geom_smooth(method='loess')

####################################
## Prediction models              ##
####################################
## polynomial model ##
x <- nhanes$RIDAGEYR
y <- nhanes$BSA
m1 <- lm(y ~ x + I(x^2))
summary(m1)

## spline model ##
# generates a basis matrix for representing the family of piecewise-cubic splines
library(splines)
fit5 <- lm( y~ns(x, 3) )
fit6 <- lm( y~ns(x, 9) )
summary(fit6)
str(fit6)

## plot the predictions with data ##
plot(x, y)
xx <- 1:90
#lines(xx, predict(fit1, data.frame(x=xx)), col='blue')
#lines(xx, predict(fit2, data.frame(x=xx)), col='green')
#lines(xx, predict(fit3, data.frame(x=xx)), col='red')
#lines(xx, predict(fit4, data.frame(x=xx)), col='purple')
lines(xx, predict(fit5, data.frame(x=xx)), col='orange')
lines(xx, predict(fit6, data.frame(x=xx)), col='grey')
#lines(xx, predict(fit7, data.frame(x=xx)), col='black')


## Loess fit ##
data.f <- data[data$RIAGENDR=='female',] 
data.m <- data[data$RIAGENDR=='male',] 

loess.span <- 0.5
x.predict <- 1:90
# fit female
plot(data.f$RIDAGEYR, data.f$BSA, col='grey')
y.loess <- loess(y ~ x, span=loess.span, data.frame(x=data.f$RIDAGEYR, y=data.f$BSA))
summary(y.loess)
p.predict <- predict(y.loess, data.frame(x=x.predict), interval="predict", se=T)
summary(p.predict)

## Confidence and prediction intervals ##
# This is the bad and sloppy way and relies on the underlying assumptions.
# Use Bootstrapping for confidence intervals and test the distributions of the
# data points relative to the predictions of the model.
lines(x.predict, p.predict$fit, col='blue', lwd=3)
lines(x.predict, p.predict$fit+0.1107, col='blue', lwd=1)
lines(x.predict, p.predict$fit-0.1107, col='blue', lwd=1)
lines(x.predict, p.predict$fit+1.96*0.1107, col='blue', lwd=1)
lines(x.predict, p.predict$fit-1.96*0.1107, col='blue', lwd=1)

# fit male
points(data.m$RIDAGEYR, data.m$BSA, col='brown')
y.loess <- loess(y ~ x, span=loess.span, data.frame(x=data.m$RIDAGEYR, y=data.m$BSA))
p.predict <- predict(y.loess, data.frame(x=x.predict), se=T)
lines(x.predict, p.predict$fit, col='red', lwd=3)
lines(x.predict, p.predict$fit+0.1107, col='red', lwd=1)
lines(x.predict, p.predict$fit-0.1107, col='red', lwd=1)
lines(x.predict, p.predict$fit+1.96*0.1107, col='red', lwd=1)
lines(x.predict, p.predict$fit-1.96*0.1107, col='red', lwd=1)
