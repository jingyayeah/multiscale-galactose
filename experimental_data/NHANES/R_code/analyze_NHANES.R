################################################################################
rm(list = ls())
setwd('/home/mkoenig/Desktop/NHANES')
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
