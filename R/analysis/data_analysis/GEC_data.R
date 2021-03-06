################################################################
## GEC in aging
################################################################
# The glactose elimination capacity changes with age. Other
# typically oberved alterations are reduced GEC in disease.
# Best example is the reduced GEC in cirrhosis.
# Here only data which has age information associated with the GEC

# TODO: check that all the parts are working and generate the 
# correct images.


# author: Matthias Koenig
# date: 2014-04-17
###############################################################

rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

###############################################################
## Marchesini1988 ##
###############################################################
# Units: age [years], GEC (galactose elimination capacity) [mmol/min],
#  HVI (hepatic volumetric index) [units], 
mar1988 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Marchesini1988_Fig.csv"), sep="\t")
# Do the sorting via the subjects ids and create reduced data frame
mar1988 <- data.frame(subject=mar1988$subject, 
                   age=mar1988$age,
                   GEC=mar1988$GEC,
                   HVI=mar1988$HVI[order(mar1988$subject)],
                   volLiver=mar1988$volLiver[order(mar1988$subject)])
summary(mar1988)
head(mar1988)

## Linear Regression ##
lm.fig1 <- lm(mar1988$GEC ~ mar1988$age)
lm.fig2 <- lm(mar1988$HVI ~ mar1988$age)
lm.fig3 <- lm(mar1988$GEC ~ mar1988$HVI)
# plot(lm.fig1) # Evaluation of the fit

## Figures ##
if (create_plots == T){
  png(filename=file.path(ma.settings$dir.results, 'Marchesini1988.png'),
    width = 800, height = 2000, units = "px", bg = "white",  res = 150)
}
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
points(mar1988$age, mar1988$HVI, col=mcol, pch=15)

plot(numeric(0), numeric(0), xlim=c(60,130), ylim=c(1.0,4.0), 
     main="Marchesini1988 - Fig3",
     xlab="Hepatic Volumetric Index [units]", ylab="Galactose Elimintation [mmol/min]")
abline(lm.fig3)
fit.label <- sprintf("y = %2.3f %+2.3f x", coef(lm.fig3)[1], coef(lm.fig3)[2])
text(80,4, labels=fit.label)
points(mar1988$HVI, mar1988$GEC, col=mcol, pch=15)
par(mfrow=c(1,1))
if (create_plots == T){
  dev.off()
}

# Load the table information
# Information reduced to the main age classes (no individual patient information)
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

## Linear Regression ##
sch1986.lm1 <- lm(sch1986.fig1$GEC ~ sch1986.fig1$age)
sch1986.lm2 <- lm(sch1986.fig2$Caf ~ sch1986.fig2$age)
sch1986.lm3 <- lm(sch1986.fig3$AP ~ sch1986.fig3$age)

## Create Figures ##
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
# normal and disease in age
lan2011.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Lange2011_Fig1.csv"), sep="\t")
head(lan2011.fig1)
summary(lan2011.fig1)

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
if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Wynne1989.png'),
      width = 800, height = 1200, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(3,2))

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,2000), 
     main="Wynne1989 - Fig2A",
     xlab="Age [years]", ylab="Liver volume [ml]")
printCategoryPoints(wyn1989.fig2a)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,30), 
     main="Wynne1989 - Fig2B",
     xlab="Age [years]", ylab="Liver volume per unit bodyweight [ml/kgbw]")
printCategoryPoints(wyn1989.fig2b)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,2500), 
     main="Wynne1989 - Fig3A",
     xlab="Age [years]", ylab="Liver blood flow [ml/min]")
printCategoryPoints(wyn1989.fig3a)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,35), 
     main="Wynne1989 - Fig3B",
     xlab="Age [years]", ylab="Blood flow per unit bodyweight [ml/min/kgbw]")
printCategoryPoints(wyn1989.fig3b)

plot(numeric(0), numeric(0), xlim=c(0,95), ylim=c(0,1.7), 
     main="Wynne1989 - Fig4",
     xlab="Age [years]", ylab="Perfusion [ml/min/ml]")
printCategoryPoints(wyn1989.fig4)

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}

###############################################################
## Winkler1965 ##
###############################################################
ccols = c("black", "darkorange")
cpch = c(15, 17)

win1965 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Winkler1965.csv"), sep="\t")
head(win1965)
summary(win1965)

## figure ##
if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Winkler1965.png'),
      width = 800, height = 1200, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(2,1))
plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,5), 
     main="Winkler1965",
     xlab="Age [years]", ylab="Galactose Elimination [mmol/min]")

points(win1965$age, win1965$GEC, col=ccols[1], pch=cpch[1])  
legend("topright",  legend = c('healthy'), fill=ccols[1])


plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,2700), 
     main="Winkler1965",
     xlab="Age [years]", ylab="Hepatic blood flow [ml/min]")

points(win1965$age, 0.5*(win1965$bloodflowM1+win1965$bloodflowM2), col=ccols[1], pch=cpch[1])  
legend("topright",  legend = c('healthy'), fill=ccols[1])

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}





################################################################
## GEC data
################################################################
# General GEC data for model fitting. 
# Especially GEC in cirrhosis

# author: Matthias Koenig
# date: 2014-04-19
###############################################################

rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = TRUE

ccols = c("black", "darkorange")
cpch = c(15, 17)

###############################################################
## Tygstrup1962 ##
###############################################################
tyg1962 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1962.csv"), sep="\t")
head(tyg1962)
summary(tyg1962)

## figure ##
if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Tygstrup1962.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(1,1))

summary(tyg1962)
cats = c('healthy', 'cirrhosis')
ccols = c("black", "darkorange")
cpch = c(15, 17)
plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,5), 
     main="Tygstrup1962",
     xlab="Age [years]", ylab="Galactose Elimination [mmol/min]")

for (k in 1:length(cats)){
  k
  inds <- which(tyg1962$state == cats[k])
  points(tyg1962$age[inds], tyg1962$GEC[inds], col=ccols[k], pch=cpch[k])  
}
legend("topright",  legend = cats, fill=ccols)

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}

###############################################################
## Dufour2005 ##
###############################################################
duf2005 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Dufour2005_Tab1.csv"), sep="\t")
head(duf2005)
summary(duf2005)

## figure ##
cats = c('normal', 'cirrhosis')
ccols = c("black", "darkorange")
cpch = c(15, 17)

if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Dufour2005.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(1,1))
plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,5), 
     main="Dufour2005",
     xlab="Age [years]", ylab="Galactose Elimination Capacity [mmol/min]")

data <- duf2005
for (k in 1:length(cats)){
  k
  inds <- which(data$state == cats[k])
  points(data$age[inds], data$GEC[inds], col=ccols[k], pch=cpch[k])  
}
legend("topright",  legend = cats, fill=ccols)

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}

###############################################################
## Ducry1979 ##
###############################################################
duc1979 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Ducry1979_Tab1.csv"), sep="\t")
head(duc1979)
summary(duc1979)
data <- duc1979

if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Ducry1979.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(1,1))
plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,5), 
     main="Ducry1979",
     xlab="Age [years]", ylab="Galactose Elimination Capacity [mmol/min]")
for (k in 1:length(cats)){
  k
  inds <- which(data$state == cats[k])
  points(data$age[inds], data$GEC[inds], col=ccols[k], pch=cpch[k])  
}
legend("topright",  legend = cats, fill=ccols)

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}

###############################################################
## Tygstrup1957 ##
###############################################################
tyg1957 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1957.csv"), sep="\t")
head(tyg1957)
summary(tyg1957)

## figure ##
if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Tygstrup1957.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(1,1))

cats = c('healthy', 'cirrhosis', 'hepatitis', 'alcohol')
ccols = c("black", "darkorange", 'red', 'blue')
cpch = c(15, 17, 17, 17)
plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,2600), 
     main="Tygstrup1957",
     xlab="Age [years]", ylab="Galactose Blood Clearance [ml/min]")

for (k in 1:length(cats)){
  k
  inds <- which(tyg1957$state == cats[k])
  points(tyg1957$age[inds], tyg1957$galclearance[inds], col=ccols[k], pch=cpch[k])  
}
legend("topright",  legend = cats, fill=ccols)

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}



