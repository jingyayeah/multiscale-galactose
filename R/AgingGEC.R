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
###############################################################
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

# Load the table information
# age [years]  body weight [kg]	body weight [kg] SD	body height [cm]	body height [cm] SD	albumin level [gm/dl]	albumin level [gm/dl] SD	cholesterol level [mmoles/liter]	cholesterol level [mmoles/liter] SD	prothrombin activity [%]	prothrombin activity [%] SD	total bilirubin [µmoles/liter]	total bilirubin [µmoles/liter] SD	volume of the liver [unit]	volume of the liver [unit] SD	GEC [mmoles/min]	GEC [mmoles/min] SD	Volume of distribution [liters]	Volume of distribution [liters] SD	Concentration 0 min [mmoles/liter]	Concentration 0 min [mmoles/liter] SD	Concentration 45 min [mmoles/liter]	Concentration 45 min [mmoles/liter] SD	Galactose elimination/unit of volume [µmoles/minxunit]	Galactose elimination/unit of volume [µmoles/minxunit] SD
# age	bodyweight	bodyweightSD	bodyheight	bodyheightSD	albumin	albuminSD	cholesterol	cholesterolSD	prothrombin	prothrombinSD	bilirubin	bilirubinSD	volLiver	volLiverSD	GEC	GECSD	volDist	volDistSD	gal0	gal0SD	gal45	gal45SD	galVol	galVolSD
mar1988.tab <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Marchesini1988_Tab.csv"), sep="\t")
head(mar1988.tab)

###############################################################
## Schnegg1986 ##
###############################################################
sch1986.tab1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Tab1.csv"), sep="\t")
head(sch1986.tab1)

sch1986.tab3 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Tab3.csv"), sep="\t")
sch1986.tab3

sch1986.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Fig1.csv"), sep="\t")
head(sch1986.fig1)
sch1986.fig2 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Fig2.csv"), sep="\t")
head(sch1986.fig2)
sch1986.fig3 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Fig3.csv"), sep="\t")
head(sch1986.fig3)

# Linear Regression of the data sets
sch1986.lm1 <- lm(sch1986.fig1$GEC ~ sch1986.fig1$age)
sch1986.lm2 <- lm(sch1986.fig2$Caf ~ sch1986.fig2$age)
sch1986.lm3 <- lm(sch1986.fig3$AP ~ sch1986.fig3$age)

# Create the figure with the fit
create_plots=TRUE
if (create_plots==TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Schnegg1986.png'),
    width = 800, height = 2000, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(3,1))
mcol = 'black';

plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,10), 
     main="Schnegg1986 - Fig1",
     xlab="Age [years]", ylab="Galactose Elimination [mg/min/kg]")
abline(sch1986.lm1)
fit.label <- sprintf("y = %2.3f %+2.3f x", coef(sch1986.lm1)[1], coef(sch1986.lm1)[2])
text(60,2, labels=fit.label)
points(sch1986.fig1$age, sch1986.fig1$GEC, col=mcol, pch=15)

plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,2.5), 
     main="Schnegg1986 - Fig2",
     xlab="Age [years]", ylab="Caffeine Clearance [ml/min/kg]")
abline(sch1986.lm2)
fit.label <- sprintf("y = %2.3f %+2.3f x", coef(sch1986.lm2)[1], coef(sch1986.lm2)[2])
text(20,2.2, labels=fit.label)
points(sch1986.fig2$age, sch1986.fig2$Caf, col=mcol, pch=15)

plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0.0,1.2), 
     main="Schngg1986 - Fig3",
     xlab="Age [years]", ylab="Aminopyrine breath test [%dose kg mmol/CO2]")
abline(sch1986.lm3)
fit.label <- sprintf("y = %2.3f %+2.3f x", coef(sch1986.lm3)[1], coef(sch1986.lm3)[2])
text(20,0.2, labels=fit.label)
points(sch1986.fig3$age, sch1986.fig3$AP, col=mcol, pch=15)
par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}

###############################################################
## Lange2011 ##
###############################################################
lan2011.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Lange2011_Fig1.csv"), sep="\t")
head(lan2011.fig1)
summary(lan2011.fig1)

create_plots=TRUE
if (create_plots==TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Lange2011.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)
}

plot(numeric(0), numeric(0), xlim=c(0,18), ylim=c(0,100), 
     main="Lange2011 - Fig1",
     xlab="Age [years]", ylab="Galactose Elimination [µmol/min/kgbw]")
lan2011.healthy = lan2011.fig1[lan2011.fig1$status=="healthy", ]
lan2011.disease = lan2011.fig1[lan2011.fig1$status=="liver disease", ]
points(lan2011.healthy$age, lan2011.healthy$GEC, col=mcol, pch=15)
points(lan2011.disease$age, lan2011.disease$GEC, col="darkorange", pch=17)

if (create_plots==TRUE){
  dev.off()
}

###############################################################
## Wynne1989 ##
###############################################################
wyn1989.fig2a <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig2A.csv"), sep="\t")
wyn1989.fig2b <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig2B.csv"), sep="\t")
wyn1989.fig3a <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig3A.csv"), sep="\t")
wyn1989.fig3b <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig3B.csv"), sep="\t")
wyn1989.fig4 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig4.csv"), sep="\t")

# Plotting function
printCategoryPoints <- function(data, 
                              cats = c("male", "female"),
                              gcols = c(mcol, "darkorange"),
                              gpch = c(15, 17)  ){
  for (k in seq(length(cats))){
    print(cats[k])
    x <- data[data[1] == cats[k], 2]
    y <- data[data[1] == cats[k], 3]
    points(x, y, col=gcols[k], pch=gpch[k])  
  }
}

# Create the data plot
create_plots = TRUE
if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Wynne1989.png'),
      width = 800, height = 1200, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(3,2))

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,2000), 
     main="Wynne1989 - Fig2A",
     xlab="Age [years]", ylab="Liver volume [ml]")
printGenderPoints(wyn1989.fig2a)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,30), 
     main="Wynne1989 - Fig2B",
     xlab="Age [years]", ylab="Liver volume per unit bodyweight [ml/kgbw]")
printGenderPoints(wyn1989.fig2b)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,2500), 
     main="Wynne1989 - Fig3A",
     xlab="Age [years]", ylab="Liver blood flow [ml/min]")
printGenderPoints(wyn1989.fig3a)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,35), 
     main="Wynne1989 - Fig3B",
     xlab="Age [years]", ylab="Blood flow per unit bodyweight [ml/min/kgbw]")
printGenderPoints(wyn1989.fig3b)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,1.7), 
     main="Wynne1989 - Fig4",
     xlab="Age [years]", ylab="Perfusion [ml/min/ml]")
printGenderPoints(wyn1989.fig4)

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}
###############################################################