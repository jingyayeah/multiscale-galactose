################################################################
## GEC in aging
################################################################
# Changes of GEC in aging, with perfusion, ...
# Combine the datasets into the graphs and provide different views 
# depending on gender.
#
# author: Matthias Koenig
# date: 2014-04-17
###############################################################

rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

# gender color (all, male, female)
gender.levels <- c('all', 'male', 'female')
gender.cols = c("black", "blue", "red")

##############################################
# Read datasets
##############################################
# age [years], GEC (galactose elimination capacity) [mmol/min], 
# HVI (hepatic volumetric index) [units], volLiver [cm^3]
mar1988 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Marchesini1988_Fig.csv"), sep="\t")
mar1988 <- data.frame(subject=mar1988$subject, 
                      age=mar1988$age,
                      GEC=mar1988$GEC,
                      HVI=mar1988$HVI[order(mar1988$subject)],
                      volLiver=mar1988$volLiver[order(mar1988$subject)])
mar1988$study = 'mar1988'
mar1988$gender = 'all'
head(mar1988)

# age [years], bodyweight [kg], GEC [mmol/min]
tyg1962 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1962.csv"), sep="\t")
tyg1962$study = 'tyg1962'
tyg1962$gender = 'all'
tyg1962 <- tyg1962[tyg1962$state=='healthy', ]

# sex [m,f], age [years], bodyweight [kg], GEC [mmol/min/kg]
sch1986.tab1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Tab1.csv"), sep="\t")
sch1986.tab1$study <- 'sch1986'
sch1986.tab1$gender <- as.character(sch1986tab$sex)
sch1986.tab1$gender[sch1986.tab1$gender=='m'] <- 'male'
sch1986.tab1$gender[sch1986.tab1$gender=='f'] <- 'female'
sch1986.tab1$GECmgkg <- sch1986.tab1$GEC
sch1986.tab1$GEC <- sch1986.tab1$GECmgkg * sch1986.tab1$bodyweight/180; # [mg/min/kg -> mmol/min]
head(sch1986.tab1)

sch1986.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Fig1.csv"), sep="\t")
sch1986.fig1$study <- 'sch1986'
sch1986.fig1$gender <- 'all'
sch1986.fig1$GECmgkg <- sch1986.fig1$GEC
sch1986.fig1$GECkg   <- sch1986.fig1$GEC/180
head(sch1986.fig1)

##############################################
# Figure template
##############################################
makeFigure <- function(data, main, xname, yname, 
                                   xlab, ylab, 
                                   xlim, ylim){
  plot(numeric(0), numeric(0), xlim=xlim, ylim=ylim, 
       main=main, xlab=xlab, ylab=ylab)
  for (k in 1:length(gender.levels)){
    inds <- which(data$gender == gender.levels[k])
    points(data[inds, xname], data[inds, yname], col=gender.cols[k])  
  }
  legend("topright",  legend=gender.levels, fill=gender.cols)  
}

if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'plot1.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)

  if (create_plots==TRUE){
    dev.off()
  }
}

############################################
# GEC [mmol/min] vs. age [years]
############################################
data <- rbind( mar1988[, c('study', 'gender', 'age', 'GEC')],
               tyg1962[, c('study', 'gender', 'age', 'GEC')],
               sch1986.tab1[, c('study', 'gender', 'age', 'GEC')] )
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

makeFigure(data, main='GEC vs. age', xname='age', yname='GEC',
           xlab='Age [years]', ylab='GEC [mmol/min]', 
           xlim=c(0,90), ylim=c(0,5))

############################################
# GEC [mmol/min/kgbw] vs. age [years]
############################################
data <- rbind( sch1986.fig1[, c('study', 'gender', 'age', 'GECkg')] )
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

makeFigure(data, main='GEC/kg vs. age', xname='age', yname='GECkg',
           xlab='Age [years]', ylab='GEC [mmol/min/kg]', 
           xlim=c(0,90), ylim=c(0,0.07))

############################################
# bodyweight [kg] vs. age [years]
############################################
data <- rbind( tyg1962[, c('study', 'gender', 'bodyweight', 'age')] )
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

makeFigure(data, main='Bodyweight vs. age',xname='age', yname='bodyweight',
           xlab='Age [years]', ylab='Bodyweight [kg]', 
           xlim=c(0,90), ylim=c(40,140))

############################################
# volLiver [ml] vs. age [years]
############################################
data <- rbind( tyg1962[, c('study', 'gender', 'bodyweight', 'age')] )
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

makeFigure(data, main='Bodyweight vs. age',xname='age', yname='bodyweight',
           xlab='Age [years]', ylab='Bodyweight [kg]', 
           xlim=c(0,90), ylim=c(40,140))
