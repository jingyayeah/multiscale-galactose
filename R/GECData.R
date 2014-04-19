################################################################
## GEC data
################################################################
# author: Matthias Koenig
# date: 2014-04-19

###############################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###############################################################
## Winkler1965 ##
###############################################################
win1965 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Winkler1965.csv"), sep="\t")
head(win1965)
summary(win1965)

## figure ##
create_plots = FALSE
if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Winkler1965.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(2,1))
plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,5), 
     main="Winkler1965",
     xlab="Age [years]", ylab="Galactose Elimination [mmol/min]")

points(win1965$age, win1965$GEC, col=ccols[1], pch=cpch[1])  
legend("topright",  legend = c('healthy'), fill=ccols[1])


plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,5), 
     main="Winkler1965",
     xlab="Age [years]", ylab="Galactose Elimination [mmol/min]")

points(win1965$age, win1965$GEC, col=ccols[1], pch=cpch[1])  
legend("topright",  legend = c('healthy'), fill=ccols[1])


par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}


###############################################################
## Tygstrup1962 ##
###############################################################
tyg1962 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1962.csv"), sep="\t")
head(tyg1962)
summary(tyg1962)

## figure ##
create_plots = FALSE
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
points(win1965$age, win1965$GEC, col="blue", pch=3)  

legend("topright",  legend = cats, fill=ccols)

par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}


###############################################################
## Dafour2005 ##
###############################################################
duf2005 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Dufour2005_Tab1.csv"), sep="\t")
head(duf2005)
summary(duf2005)

## figure ##
cats = c('normal', 'cirrhosis')
ccols = c("black", "darkorange")
cpch = c(15, 17)

create_plots = TRUE
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

create_plots = FALSE
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
create_plots = TRUE
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

