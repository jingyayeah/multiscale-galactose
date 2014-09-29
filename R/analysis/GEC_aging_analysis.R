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

# age [years], bodyweight [kg], GEC [mmol/min], GEC [mmol/min/kg] 
duc1979 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Ducry1979_Tab1.csv"), sep="\t")
duc1979$study <- 'duc1979'
duc1979$gender <- 'all'
head(duc1979)

# age [years], sex [M,F], GECmg [mg/min/kg], GEC [mmol/min/kg] 
# age [years], gender [male, female], GECkg [mmole/min/kg]
duf2005 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Dufour2005_Tab1.csv"), sep="\t")
duf2005$GECkg <- duf2005$GECmg/180
duf2005$gender <- as.character(duf2005$sex)
duf2005$gender[duf2005$gender=='M'] <- 'male'
duf2005$gender[duf2005$gender=='F'] <- 'female'
duf2005$study <- 'duf2005'
duf2005 <- duf2005[duf2005$state=='normal', ]
head(duf2005)



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

# age [years], GEC [µmol/min/kg]
lan2011 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Lange2011_Fig1.csv"), sep="\t")
lan2011$study = 'lan2011'
lan2011$gender = 'all'
lan2011$GECmumolkg <- lan2011$GEC
lan2011$GECkg <- lan2011$GEC/1000
lan2011 <- lan2011[lan2011$status=='healthy', ]
head(lan2011)


# age [years], bodyweight [kg], GEC [mmol/min]
tyg1962 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1962.csv"), sep="\t")
tyg1962$GECkg <- tyg1962$GEC/tyg1962$bodyweight
tyg1962$study = 'tyg1962'
tyg1962$gender = 'all'
tyg1962 <- tyg1962[tyg1962$state=='healthy', ]
head(tyg1962)

# sex [m,f], age [years], bodyweight [kg], GEC [mg/min/kg]
sch1986.tab1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Tab1.csv"), sep="\t")
head(sch1986.tab1)
sch1986.tab1$study <- 'sch1986'
sch1986.tab1$gender <- as.character(sch1986.tab1$sex)
sch1986.tab1$gender[sch1986.tab1$gender=='m'] <- 'male'
sch1986.tab1$gender[sch1986.tab1$gender=='f'] <- 'female'
sch1986.tab1$GECmgkg <- sch1986.tab1$GEC
sch1986.tab1$GEC <- sch1986.tab1$GECmgkg * sch1986.tab1$bodyweight/180; # [mg/min/kg -> mmol/min]
sch1986.tab1$GECkg <- sch1986.tab1$GECmgkg/180
head(sch1986.tab1)

# age [years], GEC [mg/min/kg]
sch1986.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Fig1.csv"), sep="\t")
sch1986.fig1$study <- 'sch1986'
sch1986.fig1$gender <- 'all'
sch1986.fig1$GECmgkg <- sch1986.fig1$GEC
sch1986.fig1$GECkg   <- sch1986.fig1$GEC/180
head(sch1986.fig1)

# sex [male,female], age [years], weight [kg], GEC [mmol/min], bloodFlowM1 [ml/min], bloodFlowM2 [ml/min],
# flowLiver [ml/min]
win1965 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Winkler1965.csv"), sep="\t")
win1965 <- win1965[!is.na(win1965$GEC), ]
win1965$flowLiver <- 0.5 * (win1965$bloodflowM1 + win1965$bloodflowM2)
win1965$bodyweight <- win1965$weight
win1965$flowLiverkg <- win1965$flowLiver/win1965$bodyweight
win1965$gender <- as.character(win1965$sex)
win1965$study <- 'win1965'
head(win1965)


# gender [male, female], age [years], liver volume [ml]
wyn1989.fig2a <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig2A.csv"), sep="\t")
wyn1989.fig2a$volLiver <- wyn1989.fig2a$volume
wyn1989.fig2a$study <- 'wyn1989'
head(wyn1989.fig2a)

# gender [male, female], age [years], liver volume per bodyweight [ml/kg]
wyn1989.fig2b <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig2B.csv"), sep="\t")
wyn1989.fig2b$volLiverkg <- wyn1989.fig2b$relvolume
wyn1989.fig2b$study <- 'wyn1989'
head(wyn1989.fig2b)

# gender [male, female], age [years], liver blood flow [ml/min]
wyn1989.fig3a <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig3A.csv"), sep="\t")
wyn1989.fig3a$flowLiver <- wyn1989.fig3a$bloodflow
wyn1989.fig3a$study <- 'wyn1989'
head(wyn1989.fig3a)

# gender [male, female], age [years], liver blood flow per bodyweight [ml/min/kg]
wyn1989.fig3b <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig3B.csv"), sep="\t")
wyn1989.fig3b$flowLiverkg <- wyn1989.fig3b$relbloodflow
wyn1989.fig3b$study <- 'wyn1989'
head(wyn1989.fig3b)

# gender [male, female], age [years], perfusion [ml/min/ml]
wyn1989.fig4 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Wynne1989_Fig4.csv"), sep="\t")
wyn1989.fig4$study <- 'wyn1989'
head(wyn1989.fig4)

# age [years], bodyweight [kg], volLiver [ml], volLiverkg [ml/kg]
swi1978 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Swift1978_Tab1.csv"), sep="\t")
swi1978$study <- 'swi1978'
head(swi1978)



############################################################################################
# Linear regression template
############################################################################################
linear_regression <- function(data, xname, yname){
  
  formula <- as.formula(paste(yname, '~', xname))
  print(formula)
  m1 <- lm(formula, data=data)
  
  # Create output file with log information
  name = paste(yname, 'vs', xname) 
  log.file <- file.path(ma.settings$dir.results, 'linear_regression', 
                        paste(name, '.txt', sep=""))
  sink.file <- file(log.file, open = "wt")
  sink(sink.file)
  sink(sink.file, type="message")  
  # TODO better logging
  print('### Data ###')
  print(summary(data))
  print('### Linear Regression Model ###')
  print(summary(m1))
  
  sink(type="message")
  sink()
  
  return(m1)
}

############################################################################################
# Figure template
############################################################################################
makeQualityFigure <- function(m1, xname, yname, create_plots=F){
  name = paste(yname, 'vs', xname) 
  if (create_plots == TRUE){
    plot.file <- file.path(ma.settings$dir.results, 'linear_regression', 
                           paste(name, '_quality.png', sep=""))
    print(plot.file)               
    png(filename=plot.file,
        width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
  }
  
  par(mfrow=c(2,2))
  plot(m1)
  par(mfrow=c(1,1))
  if (create_plots==TRUE){ dev.off() }
}

makeFigure <- function(data, m1, main, xname, yname, 
                                   xlab, ylab, 
                                   xlim, ylim, create_plots=T){
  name = paste(yname, 'vs', xname) 
  if (create_plots == TRUE){
    plot.file <- file.path(ma.settings$dir.results, 'linear_regression', 
                           paste(name, '.png', sep=""))
    print(plot.file)               
    png(filename=plot.file,
        width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
  }
  
  plot(numeric(0), numeric(0), xlim=xlim, ylim=ylim, 
       main=main, xlab=xlab, ylab=ylab)
  for (k in 1:length(gender.levels)){
    inds <- which(data$gender == gender.levels[k])
    points(data[inds, xname], data[inds, yname], col=gender.cols[k])  
  }
  legend("topright",  legend=gender.levels, fill=gender.cols) 
  # legend("topleft",  legend=gender.levels, fill=gender.cols) 
  
  # Plot linear regression information
  if (!is.null(m1)){
    # plot regression line
    abline(m1)
  
    # get the confidence intervals for the betas
    newx <- seq(min(data[[xname]]), max(data[[xname]]), length.out = 100)
    newx.df <- as.data.frame(newx)
    names(newx.df) <- c(xname)
  
    # conf.interval <- predict(m1, interval="confidence") 
    conf.interval <- predict(m1, newdata=newx.df, interval="confidence") 
    lines(newx, conf.interval[,2], lty=2)
    lines(newx, conf.interval[,3], lty=2)
  
    # get prediction intervals
    for (level in c(0.682, 0.95)){
      pred.interval <- predict(m1, newdata=newx.df, interval="prediction", level=level) 
      lines(newx, pred.interval[,2], lty=3, col='blue')
      lines(newx, pred.interval[,3], lty=3, col='blue') 
    }
    
    # residual standard error
    RSE <- sqrt(deviance(m1)/df.residual(m1))
    
    # plot equation
    info <- sprintf('y = %3.4f * x %+3.4f\n RSE = %3.4f', m1$coefficients[2], m1$coefficients[1], RSE)
    text(x=0.5*(xlim[2]+xlim[1]), 
         y=(ylim[1] + 0.05*(ylim[2]-ylim[1])), labels = info)
  }
  if (create_plots==TRUE){ dev.off() }
  # makeQualityFigure(m1, xname, yname, create_plots=T)
}

# Store the linear regression information in data frame
# SE standard error
# RSE residual standard error
# info: id, xname, yname, b0, b1, b0.SE, b1.SE, RSE 
# m1:
id = 1
reg.models = list()
reg.data = list()

############################################################################################
# GEC [mmol/min] vs. age [years]
############################################
xname <- 'age'
yname <- 'GEC'
selection <- c('study', 'gender', xname, yname)
data <- rbind( mar1988[, selection],
               tyg1962[, selection],
               sch1986.tab1[, selection],
               win1965[, selection],
               duc1979[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels
data <- data[complete.cases(data), ]  # remove NA

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='GEC vs. age', xname='age', yname='GEC',
           xlab='Age [years]', ylab='GEC [mmol/min]', 
           xlim=c(0,90), ylim=c(0,5))


############################################
# GECkg [mmol/min/kgbw] vs. age [years]
############################################
xname <- 'age'
yname <- 'GECkg'
selection <- c('study', 'gender', xname, yname)
data <- rbind( lan2011[, selection],
               duc1979[, selection],
               tyg1962[, selection],
               sch1986.fig1[, selection], 
               # sch1986.tab1[, c('study', 'gender', 'age', 'GECkg')], # already ploted via sch1986.fig1
               duf2005[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='GEC/kg vs. age', xname='age', yname='GECkg',
           xlab='Age [years]', ylab='GEC [mmol/min/kg]', 
           xlim=c(0,90), ylim=c(0,0.10))

############################################
# GEC [mmol/min] vs. volLiver [ml]
############################################
xname <- 'volLiver'
yname <- 'GEC'
selection <- c('study', 'gender', xname, yname)
data <- rbind( mar1988[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='GEC vs. volLiver', xname='volLiver', yname='GEC',
           xlab='Volume liver [ml]', ylab='GEC [mmol/min]', 
           xlim=c(600,1800), ylim=c(0, 5))

############################################
# bodyweight [kg] vs. age [years]
############################################
xname <- 'age'
yname <- 'bodyweight'
selection <- c('study', 'gender', xname, yname)
data <- rbind( duc1979[, selection],
               tyg1962[, selection],
               sch1986.tab1[, selection],
               win1965[, selection],
               duc1979[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='Bodyweight vs. age',xname='age', yname='bodyweight',
           xlab='Age [years]', ylab='Bodyweight [kg]', 
           xlim=c(0,90), ylim=c(0,140))

############################################
# volLiver [ml] vs. age [years]
############################################
xname <- 'age'
yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind( mar1988[, selection],
               wyn1989.fig2a[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='Liver volume vs. age',xname='age', yname='volLiver',
           xlab='Age [years]', ylab='Liver volume [ml]', 
           xlim=c(0,90), ylim=c(600,2000))

# mean data from Swift1978
for (k in c(1,2)){
  segments(swi1978$minAge[k], swi1978$volLiver[k],  
         swi1978$maxAge[k], swi1978$volLiver[k])
  segments(0.5*(swi1978$minAge[k] + swi1978$maxAge[k]), swi1978$volLiver[k]+swi1978$volLiverSd[k],
         0.5*(swi1978$minAge[k] + swi1978$maxAge[k]), swi1978$volLiver[k]-swi1978$volLiverSd[k])
}
############################################
# volLiverkg [ml/kg] vs. age [years]
############################################
xname <- 'age'
yname <- 'volLiverkg'
selection <- c('study', 'gender', xname, yname)
data <- rbind(wyn1989.fig2b[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='Liver volume per bodyweight vs. age',xname='age', yname='volLiverkg',
           xlab='Age [years]', ylab='Liver volume per bodyweight [ml/kg]', 
           xlim=c(0,90), ylim=c(10, 35))

# mean data from Swift1978
for (k in c(1,2)){
  segments(swi1978$minAge[k], swi1978$volLiverkg[k],  
           swi1978$maxAge[k], swi1978$volLiverkg[k])
  segments(0.5*(swi1978$minAge[k] + swi1978$maxAge[k]), swi1978$volLiverkg[k]+swi1978$volLiverkgSd[k],
           0.5*(swi1978$minAge[k] + swi1978$maxAge[k]), swi1978$volLiverkg[k]-swi1978$volLiverkgSd[k])
}

############################################
# flowLiver [ml/min] vs. age [years]
############################################
xname <- 'age'
yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind( win1965[, selection],
               wyn1989.fig3a[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='Blood flow vs. age',xname='age', yname='flowLiver',
           xlab='Age [years]', ylab='Blood flow liver [ml/min]', 
           xlim=c(0,90), ylim=c(400,3000))

############################################
# flowLiverkg [ml/min/kg] vs. age [years]
############################################
xname <- 'age'
yname <- 'flowLiverkg'
selection <- c('study', 'gender', xname, yname)
data <- rbind( win1965[, selection],
               wyn1989.fig3b[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='Blood flow per bodyweight vs. age', xname='age', yname='flowLiverkg',
           xlab='Age [years]', ylab='Blood flow liver per bodyweight [ml/min/kg]', 
           xlim=c(0,90), ylim=c(0,40))

############################################
# perfusion [ml/min/ml] vs. age [years]
############################################
xname <- 'age'
yname <- 'perfusion'
selection <- c('study', 'gender', xname, yname)
data <- rbind( wyn1989.fig4[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1, main='Perfusion vs. age', xname='age', yname='perfusion',
           xlab='Age [years]', ylab='Perfusion [ml/min/ml]', 
           xlim=c(0,90), ylim=c(0,2))


############################################
# GEC [mmol/min] vs. flowLiver [ml/min]
############################################
xname <- 'flowLiver'
yname <- 'GEC'
selection <- c('study', 'gender', xname, yname)
data <- rbind( win1965[, selection])
data$gender <- as.factor(data$gender)
levels(data$gender) <- gender.levels

m1 <- linear_regression(data, xname, yname)
reg.models[[id]] = m1
reg.data[[id]] = data
id = id + 1

makeFigure(data, m1,  main='GEC vs. flowLiver', xname='flowLiver', yname='GEC',
           xlab='Blood flow liver [ml/min]', ylab='GEC [mmol/min]', 
           xlim=c(600,3000), ylim=c(0,5))

