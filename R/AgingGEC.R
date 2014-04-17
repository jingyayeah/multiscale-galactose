################################################################
## GEC in aging
################################################################
# author: Matthias Koenig
# date: 2014-04-17

###############################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###############################################################
# Load experimental data 
###############################################################
## Marchesini1988 ##
# Units: age [years], GEC (galactose elimination capacity) [mmol/min],
#  HPI (hepatic volumetric index) [units]
mar1988 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Marchesini1988_Fig.csv"), sep="\t")
# Do the sorting via the subjects ids and create reduced data frame
data <- data.frame(subject=mar1988$subjectGEC, 
                   age=mar1988$ageGEC,
                   GEC=mar1988$GEC,
                   HPI=mar1988$HPI[order(mar1988$subjectHPI)])
mar1988 <- data
rm(data)
summary(mar1988)
head(mar1988)

# Linear Regression of the data sets
lm.fig1 <- lm(mar1988$GEC ~ mar1988$age)
lm.fig2 <- lm(mar1988$HPI ~ mar1988$age)
lm.fig3 <- lm(mar1988$GEC ~ mar1988$HPI)

# Evaluation of the fit
plot(lm.fig1)


# Create the figure with the fit
png(filename=file.path(ma.settings$dir.results, 'Marchesini1988.png'),
    width = 800, height = 2000, units = "px", bg = "white",  res = 150)
par(mfrow=c(3,1))
mcol = 'black';
plot(numeric(0), numeric(0), xlim=c(20,90), ylim=c(0,5), 
     main="Marchesini1988 - Fig1",
     xlab="Age [years]", ylab="Galactose Elimination [mmol/min]")
abline(lm.fig1)
fit.label <- sprintf("y = %2.3f %+2.3f x", coef(lm.fig1)[1], coef(lm.fig1)[2])
text(80,4, labels=fit.label)
points(mar1988$age, mar1988$GEC, col=mcol, pch=15)

plot(numeric(0), numeric(0), xlim=c(20,90), ylim=c(50,140), 
     main="Marchesini1988 - Fig2",
     xlab="Age [years]", ylab="Hepatic Volumetric Index [Units]")
abline(lm.fig2)
fit.label <- sprintf("y = %2.3f %+2.3f x", coef(lm.fig2)[1], coef(lm.fig2)[2])
text(80,140, labels=fit.label)
points(mar1988$age, mar1988$HPI, col=mcol, pch=15)

plot(numeric(0), numeric(0), xlim=c(60,130), ylim=c(1.0,4.0), 
     main="Marchesini1988 - Fig3",
     xlab="Hepatic Volumetric Index [units]", ylab="Galactose Elimintation [mmol/min]")
abline(lm.fig3)
fit.label <- sprintf("y = %2.3f %+2.3f x", coef(lm.fig3)[1], coef(lm.fig3)[2])
text(80,4, labels=fit.label)
points(mar1988$HPI, mar1988$GEC, col=mcol, pch=15)
par(mfrow=c(1,1))
dev.off()



