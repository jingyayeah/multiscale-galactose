################################################################################
# Predict GEC data
################################################################################
# Prediction of individual GEC data from anthropomorphic information.
# Here the methods are applied to datasets which are combinations of 
# antropomorphic information and GEC or GECkg measurements.
#
# author: Matthias Koenig
# date: 2015-02-19
################################################################################
# TODO: compare the availability of additional information, i.e. different 
# subsets of available information.

# Load all the necessary functions for predictions
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# ---------------------------------------------
# Prepare dataset for prediction
# ---------------------------------------------
data = load_classification_data('GEC_prediction')
str(data)
summary(data)
# Reduce to the healthy data and age has to be availble
dp <- data[!is.na(data$age),]
dp <- dp[dp$status %in% c('healthy', 'N'), ]
summary(dp)

# Dataset for prediction of GEC (127)
dp.GEC <- dp[!is.na(dp$GEC), ]
summary(dp.GEC)

# Dataset for prediction of GECkg (181)
dp.GECkg <- dp[!is.na(dp$GECkg), ]
summary(dp.GECkg)

rm(dp, data)

# Dataset for prediction of liver volume
names <- c('mar1988', 
           'wyn1989',
           'naw1998',
           'boy1933',
           'hei1999')
dp.volLiver <- classification_data_raw(names)
dp.volLiver <- dp.volLiver[dp.volLiver$status == "healthy", ]
summary(dp.volLiver)

# Dataset for prediction of liver flow
names <- c('win1965', 
           'wyn1989',
           'bra1945',
           'bra1952',
           'zol1999',
           'she1950',
           'wyn1990',
           'tyg1958')
dp.flowLiver <- classification_data_raw(names)
dp.flowLiver <- dp.flowLiver[dp.flowLiver$status == "healthy", ]
summary(dp.flowLiver)

# ---------------------------------------------
# Prediction of liver volumes & blood flows
# ---------------------------------------------
# GAMLSS models
fit.models <- load_models_for_prediction()
predict_settings <- list(Nsample=2000, Ncores=11, debug=TRUE)

# GEC
liver.GEC <- do.call(predict_liver_people, c( list(people=dp.GEC), predict_settings) )
str(liver.GEC)

# GECkg
liver.GECkg <- do.call(predict_liverkg_people, c( list(people=dp.GECkg), predict_settings) )
str(liver.GECkg)

# volLiver
liver.volLiver <- do.call(predict_liver_people, c( list(people=dp.volLiver), predict_settings) )
str(liver.volLiver)

# flowLiver
liver.flowLiver <- do.call(predict_liver_people, c( list(people=dp.flowLiver), predict_settings) )
str(liver.flowLiver)

# ---------------------------------------------
# Calculation of GEC & GECkg (multiscale-model)
# ---------------------------------------------
# GEC function
file_GE_f <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
load(file=file_GE_f)
library('akima')
f_GE(gal=8.0, P=1, age=20)

GEC.mat <- predict_GEC(f_GE, 
                   volLiver=liver.GEC$volLiver, 
                   flowLiver=liver.GEC$flowLiver,
                   ages=dp.GEC$age)

GECkg.mat <- predict_GECkg(f_GE, 
                       volLiverkg=liver.GECkg$volLiverkg, 
                       flowLiverkg=liver.GECkg$flowLiverkg,
                       ages=dp.GECkg$age)

#-------------------------------------
# Evaluation plots
#-------------------------------------
prediction_plot <- function(name, unit, exp, pred.mat, ages, do_plot=FALSE){
  if (do_plot){
    fname <- file.path(ma.settings$dir.base, 'results', sprintf('Prediction_%s.png', name))
    png(filename=fname, width=2200, height=1000, units = "px", bg = "white",  res = 120)
  }
  
  m <- rowMeans(pred.mat)
  sd <- rowSds(pred.mat)
  value_max <- max(c(max(exp), max(m)))
  
  col='black'
  bg=rgb(1,0,0, 0.5)
  
  # prediction vs. experiment
  par(mfrow=c(1,3))
  plot(exp, m, pch=22, col=col, bg=bg, font.lab=2,
       xlim=c(0,value_max),
       ylim=c(0,value_max),
       xlab=sprintf('%s experiment [%s]', name, unit),
       ylab=sprintf('%s predicted [%s]', name, unit)
  )
  abline(a=0, b=1, col="gray", lwd=2)
  text(x=0.1*value_max, y=0.9*value_max, labels=sprintf('N = %d', length(exp)))
  
  # residuals vs. experiment
  diff = m-exp
  diff_max <- max(abs(diff))                
  plot(exp, diff, pch=22, col=col, bg=bg, font.lab=2,
       xlim=c(0,value_max),
       ylim=c(-diff_max, diff_max),
       xlab=sprintf('%s experiment [%s]', name, unit),
       ylab=sprintf('%s predicted - experiment [%s]', name, unit)
  )
  abline(h=0, col="gray", lwd=2)
  text(x=0.1*value_max, y=0.9*diff_max, labels=sprintf('N = %d', length(exp)))
  
  # residuals vs. age             
  plot(ages, diff, pch=22, col=col, bg=bg, font.lab=2,
       xlim=c(0,100),
       ylim=c(-diff_max, diff_max),
       xlab='age [years]',
       ylab=sprintf('%s predicted - experiment [%s]', name, unit)
  )
  abline(h=0, col="gray", lwd=2)
  text(x=10, y=0.9*diff_max, labels=sprintf('N = %d', length(exp)))
  # add a linear regression
  mreg =lm(diff~ages)
  abline(mreg, col='blue')
  par(mfrow=c(1,1))
  
  if (do_plot){
    dev.off()
  }
}
do_plot=TRUE
prediction_plot('flowLiver', 'ml/min', dp.flowLiver$flowLiver, liver.flowLiver$flowLiver, ages=dp.flowLiver$age, do_plot=do_plot)
prediction_plot('volLiver', 'ml', dp.volLiver$volLiver, liver.volLiver$volLiver, ages=dp.volLiver$age, do_plot=do_plot)
prediction_plot('GEC', 'mmol/min', dp.GEC$GEC, GEC.mat, ages=dp.GEC$age, do_plot=do_plot)
prediction_plot('GECkg', 'mmol/min/kg', dp.GECkg$GECkg, GECkg.mat, ages=dp.GECkg$age, do_plot=do_plot)



##############################################################################
# More sophisticated evaluation of the GEC prediction
##############################################################################

# Create prediction data frame
# the actual calculation of mean, sd and quantiles has to be performed in the
# comparison with experimental data

pred <- dp.GEC
pred$pGEC <- rowMeans(GEC.mat) # mean prediction
pred$pGECSd <- rowSds(GEC.mat) # mean prediction
pred$pvolLiver <- rowMeans(liver.GEC$volLiver) # mean prediction
pred$pvolLiverSd <- rowSds(liver.GEC$volLiver) # mean prediction
pred$pflowLiver <- rowMeans(liver.GEC$flowLiver) # mean prediction
pred$pflowLiverSd <- rowSds(liver.GEC$flowLiver) # mean prediction

predkg <- dp.GECkg
predkg$pGECkg <- rowMeans(GECkg.mat) # mean prediction
predkg$pGECkgSd <- rowSds(GECkg.mat) # mean prediction
predkg$pvolLiverkg <- rowMeans(liver.GECkg$volLiverkg) # mean prediction
predkg$pvolLiverkgSd <- rowSds(liver.GECkg$volLiverkg) # mean prediction
predkg$pflowLiverkg <- rowMeans(liver.GECkg$flowLiverkg) # mean prediction
predkg$pflowLiverkgSd <- rowSds(liver.GECkg$flowLiverkg) # mean prediction

studies <- levels(as.factor(dp$study))
studies
exp_pchs <- rep(22,length(studies))
names(exp_pchs) <- studies
exp_bg <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3), 'magenta')
names(exp_bg) <- studies
exp_bg <- add.alpha(exp_bg, 0.5)
exp_cols <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3), 'magenta')
names(exp_cols) <- studies
exp_cols <- add.alpha(exp_cols, 0.5)

add_exp_legend <- function(loc="topleft", subset){
  legend(loc, legend=gsub("19", "", subset), col=exp_cols[subset], pt.bg=exp_bg[subset], pch=exp_pchs[subset], cex=0.8, bty='n')
}

labels <- list(
  GEC = 'GEC experiment [mmol/min]',
  pGEC = 'GEC predicted [mmol/min]',
  dGEC = 'GEC predicted - experiment [mmol/min]',
  GECkg = 'GECkg experiment [mmol/min/kg]',
  pGECkg = 'GECkg predicted [mmol/min/kg]',
  dGECkg = 'GEC predicted - experiment [mmol/min/kg]',
  
  age = 'Age [years]'
)
limits <- list(
  GEC = c(1,4.5),
  pGEC = c(1,4.5),
  dGEC = c(-2,2),
  GECkg = c(0.015,0.09),
  pGECkg = c(0.015,0.09),
  dGECkg = c(-0.03,0.03),
  age = c(0,100)
)

empty_plot <- function(xname, yname){
  plot(numeric(0), numeric(0), type='n', font.lab=2,
       xlab=labels[[xname]],
       ylab=labels[[yname]],
       xlim=limits[[xname]],
       ylim=limits[[yname]])
}

# Evaluate how many are correct predicted
evaluate_prediction <- function(df, exp_name="GEC", pre_name="pGEC", preSd_name="pGECSd"){
  high <- df[[exp_name]]> df[[pre_name]]+df[[preSd_name]]
  low <- df[[exp_name]]< df[[pre_name]]-df[[preSd_name]]
  out <- high | low
  data.frame(high, low, out)
}
test <- evaluate_prediction(pred, exp_name="volLiver", pre_name="pvolLiver", preSd_name="pvolLiverSd")
count(test)

#------------------------------
# GEC plot
#------------------------------
do_plot=FALSE
if (do_plot){
  fname <- file.path(ma.settings$dir.base, 'results', 'GEC_prediction.png')
  png(filename=fname, width=1800, height=1800, units = "px", bg = "white",  res = 120)
}
par(mfrow=c(2,2))

# GEC predicted ~ GEC experiment
empty_plot("GEC", "pGEC")
abline(a = 0, b=1, col="gray")
for (study in studies){
  d <- pred[pred$study==study, ]
  segments(d$GEC, d$pGEC-d$pGECSd, d$GEC, d$pGEC+d$pGECSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- pred[pred$study==study, ]
  points(d$GEC, d$pGEC,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(prediction$study))
add_exp_legend(subset=subset)

# GEC residues ~ GEC experiment
empty_plot("GEC", "dGEC")
abline(h=0, col="gray")
for (study in studies){
  d <- pred[pred$study==study, ]
  segments(d$GEC, d$pGEC-d$GEC-d$pGECSd, d$GEC, d$pGEC-d$GEC+d$pGECSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- pred[pred$study==study, ]
  points(d$GEC, d$pGEC-d$GEC,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(pred$study))
add_exp_legend("topright", subset=subset)

#------------------------------
# GECkg plot
#------------------------------
# GEC predicted ~ GEC experiment
empty_plot("GECkg", "pGECkg")
abline(a = 0, b=1, col="gray")
for (study in studies){
  d <- predkg[predkg$study==study, ]
  segments(d$GECkg, d$pGECkg-d$pGECkgSd, d$GECkg, d$pGECkg+d$pGECkgSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- predkg[predkg$study==study, ]
  points(d$GECkg, d$pGECkg,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(predkg$study))
add_exp_legend(subset=subset)

# GEC residues ~ GEC experiment
empty_plot("GECkg", "dGECkg")
abline(h=0, col="gray")
for (study in studies){
  d <- predkg[predkg$study==study, ]
  segments(d$GECkg, d$pGECkg-d$GECkg-d$pGECkgSd, d$GECkg, d$pGECkg-d$GECkg+d$pGECkgSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- predkg[predkg$study==study, ]
  points(d$GECkg, d$pGECkg-d$GECkg,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(predkg$study))
add_exp_legend("topright", subset=subset)
par(mfrow=c(1,1))
if (do_plot){
  dev.off()
}