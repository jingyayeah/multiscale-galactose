################################################################################
# Centile estimation of NHANES with GAMLSS
################################################################################
# http://www.gamlss.org/?p=1215
# Fitting statistical model to the NHANES data.
# These models are linked and used for prediction.
#
# TODO: calculation of confidence intervals (bootstrapping)
# TODO: proper model selection, i.e. estimation of degree of freedoms for 
#       regression splines based on cross validation/optimization
#
# author: Matthias Koenig
# date: 14-10-2014
################################################################################
rm(list = ls())

# Load data
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
head(data)

## Analysis data.frame
# new data.frame with necessary information,
# age, sex, BSA
df.all <- data.frame(age=data$RIDAGEYR, sex=data$RIAGENDR, bsa=data$BSA)
df.male <- df.all[df.all$sex == 'male', ]
df.female <- df.all[df.all$sex == 'female', ]

df.names <- c('all', 'male', 'female')
df.cols <- c( rgb(0,0,0,alpha=0.5),
              rgb(0,0,1,alpha=0.5),
              rgb(1,0,0,alpha=0.5) )
names(df.cols) <- df.names 
head(df.all)

## plot data
par(mfrow=c(1,3))
for (k in 1:3){
  if (k==1){ d <- df.all }
  else if (k==2){ d <- df.male }
  else if (k==3){ d <- df.female }
  
  plot(d$age, d$bsa, col=df.cols[k], 
       main=sprintf('NHANES (%s)', df.names[k]),
       xlab='Age [years]',
       ylab=expression(paste("BSA [", m^2, "]", sep="")),
       ylim=c(0.5, 2.5))
  rug(d$age, side=1, col="grey"); rug(d$bsa, side=2, col="grey")
}
par(mfrow=c(1,1))
rm(d,k)

#######################################################
# GAMLSS - Model fitting
#######################################################
# model fitting via cubic splines
# TODO: model selection & model evaluation

library('gamlss')
# simple model with normal distributed link function
fit.all.no <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=NO, data=df.all)

summary(fit.all.no)
plot(fit.all.no)
centiles(fit.all.no,  xvar=df.all$age)
fittedPlot(fit.all.no, x=df.all$age)

# using LMS based link distribution (BCCG - Box-Cox, Cole and Green)
fit.all.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df.all)
fit.all.bccg.1 <- gamlss(bsa ~ cs(age,6), 
                       sigma.formula= ~cs(age,3), nu.formula= ~cs(age,3), 
                       family=BCCG, data=df.all)

summary(fit.all.bccg)
plot(fit.all.bccg)
centiles(fit.all.bccg,  xvar=df.all$age)
fittedPlot(fit.all.bccg, x=df.all$age)
summary(fit.all.bccg.1)
plot(fit.all.bccg.1)
centiles(fit.all.bccg.1,  xvar=df.all$age)
fittedPlot(fit.all.bccg.1, x=df.all$age)

# final models after selection
fit.all.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df.all)
centiles(fit.all.bccg,  xvar=df.all$age)

fit.male.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df.male)
centiles(fit.male.bccg,  xvar=df.male$age)

fit.female.bccg <- gamlss(bsa ~ cs(age,9), sigma.formula= ~cs(age,3), family=BCCG, data=df.female)
centiles(fit.female.bccg,  xvar=df.female$age)

fit.final <- list(fit.all.bccg, fit.male.bccg, fit.female.bccg) 

##########################
#     Centile Plot       
##########################
# TODO: confidence intervals

centiles.pred

library('MultiscaleAnalysis')
k=2
plotCentiles(model=fit.final[[k]], d=df.male, 
             main=sprintf('NHANES (%s)', df.names[k]),
             xlab='Age [years]', 
             ylab=expression(paste("Body surface area (BSA) [", m^2, "]", sep="")),
             xlim=c(0,87), ylim=c(0.5, 2.5), pcol=df.cols[k])
k=3
plotCentiles(model=fit.final[[k]], d=df.female,
             main=sprintf('NHANES (%s)', df.names[k]),
             xlab='Age [years]', 
             ylab=expression(paste("Body surface area (BSA) [", m^2, "]", sep="")),
             xlim=c(0,87), ylim=c(0.5, 2.5), pcol=df.cols[k])

# Create figures
create_plots = TRUE
if (create_plots == TRUE){
  plot.file <- file.path(ma.settings$dir.results, 'regression', 'NHANES_BSA_regression.png')
  print(plot.file)
  png(filename=plot.file,
      width = 2000, height = 1000, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(1,3))
for (k in 1:3){
  if (k ==1){ d <- df.all }
  else if (k ==2){ d <- df.male }
  else if (k ==3){ d <- df.female }
  plotCentiles(d=d, k=k)
}
par(mfrow=c(1,1))
if (create_plots == TRUE){
 dev.off() 
}

rm(d,k)