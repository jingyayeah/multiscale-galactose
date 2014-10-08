################################################################################
# NHANES - analysis of the continous NHANES
#
# Generate the necessary fit curves for subset of NHANES as input for the
# population variation of the predictions.
#
# author: Matthias Koenig
# date:   06-10-2014
################################################################################
## Load full NHANES data ##
rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes.dat')
head(nhanes)

## Prepare NHANES for analysis ##
# Calculate the BSA (body surface area)
nhanes$BSA <- 0.007184 * nhanes$BMXHT^0.725 * nhanes$BMXWT^0.425

# Define subsets for fit curve calculation, 
# i.e. remove extreme BMI values and reduce to 'Non-Hispanic White'
# normal bodyweight people of 'white' ethnicity
#
# BMI - Weight Status
# Below 18.5	Underweight
# 18.5 – 24.9	Normal
# 25.0 – 29.9	Overweight
# 30.0 and Above	Obese
bmi.sel <- (nhanes$BMXBMI >= 18.5) & (nhanes$BMXBMI < 24.9)
eth.sel <- (nhanes$RIDRETH1 == "Non-Hispanic White")
na.sel <- !is.na(nhanes$RIDAGEYR) & !is.na(nhanes$RIAGENDR) & !is.na(nhanes$BMXBMI) & !is.na(nhanes$BMXWT) & !is.na(nhanes$BMXHT)
sel <- bmi.sel & eth.sel & na.sel
count(sel)
data <- nhanes[sel,]
head(data)
summary(data)
save('data', file='data/nhanes_data.dat')



# plot the weight [kg]
library(ggplot2)
g <- ggplot(data, aes(RIDAGEYR, BMXWT))
p <- g + geom_point()
print(p)

# fit a polynomial model to the data
x <- nhanes$RIDAGEYR
y <- nhanes$BMXWT
m1 <- lm(y ~ x + I(x^2))
summary(m1)
plot(x, y)
x1 <- 0:80
y1 <- predict(m1, x1)

# work with a spline fit
# It generates a basis matrix for representing the family of piecewise-cubic splines
library(splines)
fit5 <- lm( y~ns(x, 3) )
fit6 <- lm( y~ns(x, 9) )
summary(fit6)
str(fit6)

tmp <- str(fit6$model$ns)
ns[['knots']]

test <- ns(x,3)
summary(ns(x,3))

xx <- 1:90
#lines(xx, predict(fit1, data.frame(x=xx)), col='blue')
#lines(xx, predict(fit2, data.frame(x=xx)), col='green')
#lines(xx, predict(fit3, data.frame(x=xx)), col='red')
#lines(xx, predict(fit4, data.frame(x=xx)), col='purple')
lines(xx, predict(fit5, data.frame(x=xx)), col='orange')
lines(xx, predict(fit6, data.frame(x=xx)), col='grey')
#lines(xx, predict(fit7, data.frame(x=xx)), col='black')


# confidence intervals with:
# gam() function from mgcv package. It instantly gave a confidence band but I am not sure if it is 90% or 95% CI or something else. It would be great if someone can explain.

plot(x,y)
plot(x, predict(m1, x))
abline(m1, col='red')

plot(x, log(x))
lm.s <- step(lm.1)




# plot height [cm]
g1 <- ggplot(data, aes(RIDAGEYR, BMXHT))
g1 + geom_point()
g1 + geom_point(aes(color=RIAGENDR)) + labs(title = "NHANES cohort (18.5 <= BMI < 24.9)") + labs(x='age [year]') + theme_bw()

# plot BSA [cm]
g1 <- ggplot(data, aes(RIDAGEYR, BSA))
g1 + geom_point()
g1 + geom_point(aes(color=RIAGENDR)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + labs(x='age [year]') + theme_bw() + facet_grid(.~RIAGENDR)
g1 + geom_point(aes(color=RIAGENDR)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + labs(x='age [year]') + facet_grid(.~RIAGENDR) + theme_bw() + geom_smooth(method='loess')


## Fitting the curves ##


# do fit for female data
data.f <- data[data$RIAGENDR=='female',] 
data.m <- data[data$RIAGENDR=='male',] 

loess.span <- 0.5
x.predict <- 1:90

plot(data.f$RIDAGEYR, fdata$BSA, col='grey')
y.loess <- loess(y ~ x, span=loess.span, data.frame(x=data.f$RIDAGEYR, y=data.f$BSA))
summary(y.loess)
# ! confidence intervals for fit curves and prediction intervals for the 
# resulting curves
p.predict <- predict(y.loess, data.frame(x=x.predict), interval="predict", se=T)
str(y.predict)
lines(x.predict, p.predict$fit, col='blue', lwd=3)

lines(x.predict, p.predict$fit+0.1107, col='blue', lwd=1)
lines(x.predict, p.predict$fit-0.1107, col='blue', lwd=1)
lines(x.predict, p.predict$fit+1.96*0.1107, col='blue', lwd=1)
lines(x.predict, p.predict$fit-1.96*0.1107, col='blue', lwd=1)
summary(p.predict)
head(p.predict$se.fit)

points(data.m$RIDAGEYR, data.m$BSA, col='brown')
y.loess <- loess(y ~ x, span=loess.span, data.frame(x=data.m$RIDAGEYR, y=data.m$BSA))
p.predict <- predict(y.loess, data.frame(x=x.predict), se=T)
lines(x.predict, p.predict$fit, col='red', lwd=3)
lines(x.predict, p.predict$fit+0.1107, col='red', lwd=1)
lines(x.predict, p.predict$fit-0.1107, col='red', lwd=1)
lines(x.predict, p.predict$fit+1.96*0.1107, col='red', lwd=1)
lines(x.predict, p.predict$fit-1.96*0.1107, col='red', lwd=1)

#############################################################
## Use of fit functions to calculate derived values.

# Liver volume is calculated based on the the respective fit curves
liverVolume <- function(BSA){
  # The basic mechanism is to calculate the mean values via the fit function
  # and use the residual error of the fit function to generate the distributions
  # of values.
  mean <- -134 + 890* BSA
  rse <- 300
}
# for the calculation of the full data this has to be performed for every formula
nhanes$LIVVOL <- 
  
  # Test Liver volume base on the fit functions
  g2 <- ggplot(data, aes(RIDAGEYR, LIVVOL))
g2 + geom_point(aes(color=RIAGENDR)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + labs(x='age [year]') + facet_grid(.~RIAGENDR) + theme_bw() + geom_smooth(method='loess')
