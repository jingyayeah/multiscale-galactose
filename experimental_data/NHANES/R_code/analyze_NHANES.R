################################################################################
rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes.dat')
head(nhanes)


# Calculate the BSA (body surface area)
nhanes$BSA <- 0.007184*nhanes$BMXHT^0.725 * nhanes$BMXWT^0.425
# Liver volume
nhanes$LIVVOL <- -134 + 890*nhanes$BSA

# select the normal datapoints, i.e. remove extreme BMI values and reduce to 
# certain ethnicities

# BMI - Weight Status
# Below 18.5	Underweight
# 18.5 – 24.9	Normal
# 25.0 – 29.9	Overweight
# 30.0 and Above	Obese

# normal bodyweight people of 'white' ethnicity
bmi.sel <- (nhanes$BMXBMI >= 18.5) & (nhanes$BMXBMI < 24.9) & !is.na(nhanes$BMXBMI)
eth.sel <- (nhanes$RIDRETH1 == "Non-Hispanic White")
sel <- bmi.sel & eth.sel
count(sel)

data <- nhanes[sel,]
head(data)


# plot the weight [kg]
library(ggplot2)
g <- ggplot(data, aes(RIDAGEYR, BMXWT))
p <- g + geom_point()
print(p)

g + geom_point()
# adding additional layers (smoother loess or lm, ...)
g + geom_point() + geom_smooth(method='loess')

# adding the facets
g + geom_point(color="steelblue", size=4, alpha=1/2) + geom_smooth(method='loess') + facet_grid(RIAGENDR~.)

g + geom_point(aes(color=RIAGENDR)) + labs(title = "NHANES cohort (18.5 <= BMI < 24.9)") + labs(x='age [year]') + theme_bw()

# plot height [cm]
g1 <- ggplot(data, aes(RIDAGEYR, BMXHT))
g1 + geom_point()
g1 + geom_point(aes(color=RIAGENDR)) + labs(title = "NHANES cohort (18.5 <= BMI < 24.9)") + labs(x='age [year]') + theme_bw()

# plot BSA [cm]
g1 <- ggplot(data, aes(RIDAGEYR, BSA))
g1 + geom_point()
g1 + geom_point(aes(color=RIAGENDR)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + labs(x='age [year]') + theme_bw()
g1 + geom_point(aes(color=RIAGENDR)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + labs(x='age [year]') + facet_grid(.~RIAGENDR) + theme_bw() + geom_smooth(method='loess')



# Test Liver volume base on the fit functions
g2 <- ggplot(data, aes(RIDAGEYR, LIVVOL))

g2 + geom_point(aes(color=RIAGENDR)) + labs(title = c("NHANES cohort (18.5 <= BMI < 24.9)\nNon-Hispanic White")) + labs(x='age [year]') + facet_grid(.~RIAGENDR) + theme_bw() + geom_smooth(method='loess')

## Fitting the curves ##
# Do a proper loess fitting to explain the data
period <- 120
x=1:120
y <- sin(2*pi*x/period) + runif(length(x), -1,1)
plot(x,y)
y.loess <- loess(y ~ x, span=0.75, data.frame(x=x, y=y))
summary(y.loess)

y.predict <- predict(y.loess, data.frame(x=x))
lines(x, y.predict)

# use the R optimize function to find the peak
peak <- optimize(function(x, model)
  predict(model, data.frame(x=x)),
  c(min(x),max(x)),
  maximum=TRUE,
  model=y.loess) 
points(peak$maximum,peak$objective, pch=FILLED.CIRCLE<-19)

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

