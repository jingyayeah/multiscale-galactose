################################################################################
# Centile estimation for other datasets with GAMLSS
################################################################################
# http://www.gamlss.org/?p=1215
# Fitting statistical model todata.
# These models are linked and used for prediction.
#
# author: Matthias Koenig
# date: 14-10-2014
################################################################################
rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/')

## load data ##
# GEC vs. age
load(file=file.path(ma.settings$dir.expdata, "processed", "GEC_age.Rdata"))

names(data)[names(data) == 'gender'] <- 'sex'
head(data)

df.all <- data
df.male <- df.all[df.all$sex == 'male', ]
df.female <- df.all[df.all$sex == 'female', ]
rm(data)

## plot info ##
p.main="GEC vs. age"
xname='age'; xlab='Age [years]'; xlim=c(0,95)
yname='GEC'; ylab="GEC [mmol/min]"; ylim=c(0, 4.0)
df.names <- c('all', 'male', 'female')
df.cols <- c( rgb(0,0,0,alpha=0.5),
              rgb(0,0,1,alpha=0.5),
              rgb(1,0,0,alpha=0.5) )
names(df.cols) <- df.names 
##

# ! filter the bad data !
df.all <- df.all[df.all$sex=='all',]

par(mfrow=c(1,3))
for (k in 1:3){
  if (k==1){ d <- df.all }
  if (k==2){ d <- df.male }
  if (k==3){ d <- df.female }
  
  plot(d[[xname]], d[[yname]], col=df.cols[k], 
       main=sprintf('%s', df.names[k]), xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim)
  rug(d[[xname]], side=1, col="black"); rug(d[[yname]], side=2, col="black")
}
par(mfrow=c(1,1))
rm(d,k)

#######################################################
# GAMLSS - Model fitting
#######################################################
library('MultiscaleAnalysis')
library('gamlss')
# simple model with normal distributed link function
fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,1), family=NO, data=df.all)
# fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
# fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)

# confidence intervals via bootstrapping


plotCentiles(model=fit.all.no, d=df.all, xname='age', yname='GEC',
             main="GEC (all)",
             xlab='Age [years]', 
             ylab=expression(paste("GEC [", mmol/min, "]", sep="")),
             xlim=c(0,95), ylim=c(0, 4.0), pcol='black')

##################




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
