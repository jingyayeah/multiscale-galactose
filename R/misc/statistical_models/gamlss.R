######################################################
# Centile estimation with GAMLSS
######################################################
# http://www.gamlss.org/?p=1215
#
# TODO: 
# - calculate confidence intervals (bootstrapping)
#
# author: Matthias Koenig
# date: 2014-10-12
rm(list = ls())

### Show all the colour schemes available
library(RColorBrewer)
display.brewer.all()

# Get example data
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
head(data)

# new data.frame with necessary information
df.all <- data.frame(age=data$RIDAGEYR, sex=data$RIAGENDR, bsa=data$BSA)
df.male <- df.all[df.all$sex == 'male', ]
df.female <- df.all[df.all$sex == 'female', ]

df.names <- c('all', 'male', 'female')
df.cols <- c( rgb(0,0,0,alpha=0.5),
              rgb(0,0,1,alpha=0.5),
              rgb(1,0,0,alpha=0.5) )
names(df.cols) <- df.names 

# show the data
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
fit.all.no <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=NO, data=df.all)

summary(fit.all.no)
plot(fit.all.no)
centiles(fit.all.no,  xvar=df.all$age)
fittedPlot(fit.all.no, x=df.all$age)

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

# Calculation of the centiles
qCentiles <- function (obj, newdata=NULL, cent = c(0.4, 2, 10, 25, 50, 75, 90, 98, 99.6) ){
  if (!is.gamlss(obj)) 
    stop(paste("This is not an gamlss object", "\n", ""))
  if (is.null(newdata)) 
    stop(paste("The xvar argument is not specified", "\n", ""))
  
  # evalute for prediction
  fname <- obj$family[1]
  qfun <- paste("q", fname, sep = "")
  lpar <- length(obj$parameters)
  centiles <- vector('list', length(cent))
  ii = 0
  for (k in 1:length(cent)) {
    var <- cent[k]
    if (lpar == 1) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata))
    }
    else if (lpar == 2) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata))
    }
    else if (lpar == 3) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata),
                      nu = predict(obj, what="nu", type="response", newdata=newdata))
    }
    else {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata),
                      nu = predict(obj, what="nu", type="response", newdata=newdata),
                      tau = predict(obj, what="tau", type="response", newdata=newdata))
    }
    ll <- eval(newcall)
    centiles[[k]] <- ll
  }  
  return(centiles)
}
# Create summary plot for centiles
plotCentiles <- function(d, k){
  # calculate centiles
  age.grid <- seq(from=min(d$age), to=max(d$age), length.out = 501)
  cent.values <- c(2.5, 10, 25, 50, 75, 90, 97.5) # these should be symmetrical
  cents <- qCentiles(fit.final[[k]], newdata=data.frame(age=age.grid), cent=cent.values)
  
  # empty plot
  plot(d$age, d$bsa, type="n", frame.plot=F,
       main=sprintf('NHANES (%s)', df.names[k]),
       xlab='Age [years]',
       ylab=expression(paste("BSA [", m^2, "]", sep="")),
       ylim=c(0.5, 2.5), xlim=c(0,87))
  grid()
  
  # plot centile shades
  shade_between_curves <- function(x, yup, ylow, col=rgb(0.1, 0.1, 0.1, alpha=0.1)){
    xvals <- c(x, rev(x))
    yvals <- c(yup, rev(ylow))
    polygon(xvals, yvals, col=col, border=NA)
  }
  for (kc in 1:floor(length(cent.values/2))){
    ylow = cents[[kc]]
    yup = cents[[length(cents)+1-kc]]
    shade_between_curves(age.grid, yup, ylow) 
  }
  
  # plot points
  points(d$age, d$bsa, col=df.cols[k], pch=20, cex=0.8)
  rug(d$age, side=1, col="grey"); rug(d$bsa, side=2, col="grey")
  
  # plot centile lines
  for (kc in 1:length(cent.values)){
    lines(age.grid, cents[[kc]], lwd=0.5, col='black')
  }
  lines(age.grid, cents[[floor(length(cents)/2)+1]], lwd=3, col="black")
  
  # plot the text (centile description)
  for (kc in 1:length(cent.values)){
    yvals <- cents[[kc]]
    ypos <- yvals[length(yvals)]
    xpos <- max(age.grid) + 3
    info <- paste(cent.values[kc])
    print(info)
    text(xpos, ypos, info, cex=0.8)
  }
}


plotCentiles(d=df.male, k=2)
plotCentiles(d=df.female, k=3)

par(mfrow=c(1,3))
for (k in 1:3){
  if (k ==1){ d <- df.all }
  else if (k ==2){ d <- df.male }
  else if (k ==3){ d <- df.female }
  plotCentiles(d=d, k=k)
}
par(mfrow=c(1,1))
rm(d,k)


