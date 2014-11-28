################################################################################
# Predict volLiver, flowLiver, volLiverkg, flowLiverkg, GEC & GECkg
################################################################################
# Use the prediction methods to predict the data.
# TOOD: volLiverkg & flowLiverkg prediction from data
#
# author: Matthias Koenig
# date: 2014-11-20
################################################################################

# Load all the necessary functions for predictions
rm(list=ls())
library('MultiscaleAnalysis')
library('gamlss')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'GAMLSS_prediction.R'))
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))














# TODO: load the methods and functions
##############################################################################
# GEC curves
##############################################################################
task <- 'T54'
load(file=file.path(ma.settings$dir.expdata, 'processed', paste('GEC_curve_', task,'.Rdata', sep="")))
str(GEC_curves)

# make the GEC fit function
d.mean <- GEC_curves$d2
d.se <- GEC_curves$d2.se

GEC_functions <- function(d.mean, d.se){
  # create spline fits
  x <- d.mean$Q_per_vol_units      # perfusion [ml/min/ml]
  y <- d.mean$R_per_vol_units     # GEC clearance [mmol/min/ml]
  y.se <- d.se$R_per_vol_units  # GEC standard error (bootstrap) [mmol/min/ml]
  f <- splinefun(x, y)
  f.se <- splinefun(x, y.se)  
  
  plot(x,y, ylim=c(0,0.003))
  curve(f, from=0, to=3.5, col='red', add=T)
  curve(f.se, from=0, to=3.5, col='blue', add=T)
  
  return(list(f_GEC=f, f_GEC.se=f.se)) 
}
GEC_f <- GEC_functions(d.mean, d.se)
GEC_f

calculate_GEC <- function(volLiver, flowLiver, f_tissue=0.8){  
  # perfusion
  perfusion <- flowLiver/volLiver # [ml/min/ml]
  # GEC per volume based on perfusion
  GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  # GEC for complete liver
  # GEC curves are for liver tissue. No correction for the large vessel structure
  # has been applied. Here the metabolic capacity of combined sinusoidal units.
  GEC <- GEC_per_vol * f_tissue * volLiver # mmol/min
  return(list(perfusion=perfusion, GEC_per_vol=GEC_per_vol, GEC=GEC, f_tissue=f_tissue))
}

calculate_GECkg <- function(volLiverkg, flowLiverkg, f_tissue=0.8){  
  # perfusion
  perfusion <- flowLiverkg/volLiverkg # [ml/min/ml]
  # GEC per volume based on perfusion
  GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  # GEC for liver per kg
  # GEC curves are for liver tissue. No correction for the large vessel structure
  # has been applied. Here the metabolic capacity of combined sinusoidal units.
  GECkg <- GEC_per_vol * f_tissue * volLiverkg # mmol/min
  return(list(perfusion=perfusion, GEC_per_vol=GEC_per_vol, GECkg=GECkg, f_tissue=f_tissue))
}




########################################################################################
# Predict additional GEC data [mmol/min] & GECkg [mmol/min/kg]
########################################################################################
loadRawData <- function(name, dir=NULL){
  if (is.null(dir)){
    dir <- file.path(ma.settings$dir.expdata, "processed")
    print(dir)
  }
  r_fname <- file.path(dir, sprintf('%s.Rdata', name))
  print(r_fname)
  load(file=r_fname)
  return(data)
}

# predict GEC for full data frame
predict_GEC <- function(df){
  for (k in 1:nrow(df)){
    df[k,] <- predict_GEC_row(df[k,]) 
  }
  return(df)
}

# predict GEC for single row 
# The distributions have to be calculated only once. Than fast rejection sampling
# can be done on the distributions.
predict_GEC_row <- function(row){
  if (is.na(row$sex)){
   row$sex = 'all' 
  }
  
  # predict the liver volume
  if (is.na(row$volLiver.exp)){
    cat('* Predict Liver Volume *\n')
    # get the combined distribution for the liver volumes
    f_d1 <- f_d.volLiver.c(sex=row$sex, age=row$age, bodyweight=row$bodyweight, height=row$height, BSA=row$BSA)
    # rejection sampling
    rs1 <- f_d.rejection_sample(f_d1$f_d, Nsim=1, interval=c(1,4000))
    row$volLiver.pre <- rs1$values[1]  
  } else {
    row$volLiver.pre <- row$volLiver.exp 
  }
  print(row$volLiver.pre)
  
  # predict the liver blood
  if (is.na(row$flowLiver.exp)){
    cat('* Predict Liver Flow *\n')
    # get the combined distribution for liver blood flow
    f_d2 <- f_d.flowLiver.c(sex=row$sex, age=row$age, bodyweight=row$bodyweight, height=row$height, volLiver=row$volLiver.pre)
    # rejection sampling
    rs2 <- f_d.rejection_sample(f_d2$f_d, Nsim=1, interval=c(1,4000))
    row$flowLiver.pre <- rs2$values[1]  
  } else {
    row$flowLiver.pre <- row$flowLiver.exp 
  }

  # predict liver volume per bodyweight
  if (is.na(row$volLiverkg.exp)){
      if ( (!is.na(row$volLiver.pre)) & (!is.na(row$bodyweight))){
        # if bodyweight available use it
        row$volLiverkg.pre <- row$volLiver.pre/row$bodyweight   
      } else {
        cat('* Predict Liver Volume per Bodyweight *\n')
        # get the combined distribution for the liver volumes
        f_d1 <- f_d.volLiverkg.c(sex=row$sex, age=row$age, bodyweight=row$bodyweight, height=row$height, BSA=row$BSA)
      # rejection sampling
      rs1 <- f_d.rejection_sample(f_d1$f_d, Nsim=1, interval=c(1,100))
      row$volLiverkg.pre <- rs1$values[1]  
      }
  } else {
      row$volLiverkg.pre <- row$volLiverkg.exp 
  }
  
  # predict liver bloodflow per bodyweight
  if (is.na(row$volLiverkg.exp)){
      if ( (!is.na(row$flowLiver.pre)) & (!is.na(row$bodyweight))){
          # if bodyweight available use it
          row$flowLiverkg.pre <- row$flowLiver.pre/row$bodyweight   
      } else {
          cat('* Predict Liver Blood flow per Bodyweight *\n')
         
          f_d1 <- f_d.flowLiverkg.c(sex=row$sex, age=row$age, bodyweight=row$bodyweight, height=row$height, BSA=row$BSA, volLiverkg=row$volLiverkg.pre)
          # rejection sampling
          rs1 <- f_d.rejection_sample(f_d1$f_d, Nsim=1, interval=c(1,100))
          row$flowLiverkg.pre <- rs1$values[1]  
      }
  } else {
      row$flowLiverkg.pre <- row$flowLiverkg.exp 
  }
  
  
  # predict GEC
  cat('* Predict GEC *\n')
  row$GEC.pre <- calculate_GEC(volLiver=row$volLiver.pre, flowLiver=row$flowLiver.pre)$GEC
  
  # predict GECkg
  row$GECkg.pre <- NA
  if (!is.na(row$bodyweight)){
    row$GECkg.pre <- row$GEC.pre/row$bodyweight
  } else {
    cat('* Predict GEC *\n')
    row$GECkg.pre <- calculate_GECkg(volLiverkg=row$volLiverkg.pre, flowLiverkg=row$flowLiverkg.pre)$GECkg
    test <- calculate_GECkg(volLiverkg=row$volLiverkg.pre, flowLiverkg=row$flowLiverkg.pre)
    print(test)
  }
  
  return (row)
}

# prepare one common data frame for prediction
prepare_df <- function(data){
  fields <- c('study', 'gender', 'age', 'bodyweight', 'height', 'BSA', 
              'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg', 'GEC', 'GECkg')
  index <-  c( 1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18)
  col.names <- c('study', 'sex', 'age', 'bodyweight', 'height', 'BSA', 
                 'volLiver.pre', 'volLiver.exp',
                 'volLiverkg.pre', 'volLiverkg.exp',
                 'flowLiver.pre', 'flowLiver.exp', 
                 'flowLiverkg.pre', 'flowLiverkg.exp', 
                 'GEC.pre', 'GEC.exp',
                 'GECkg.pre', 'GECkg.exp')
  data.pre <- data.frame(matrix(NA, ncol=18, nrow=nrow(data)) )
  names(data.pre) <- col.names
  for (k in 1:length(fields)){
    field <- fields[k]
    if (field %in% names(data)){
     data.pre[ , index[k]] <- data[[field]] 
    }
  }
  
  return(data.pre)
}

# plot GEC
plot_GEC <- function(df, main, xlim=c(0,7)){
  plot(df$GEC.exp, df$GEC.pre, main=main, xlim=xlim, ylim=xlim, pch=21, col='black', bg=rgb(0, 0, 0, 0.5),
       xlab='GEC experiment [mmol/min]', ylab='GEC predicted [mmol/min]', font.lab=2)
  abline(a=0, b=1, col='black')
  
  plot(df$GEC.exp, df$GEC.pre-df$GEC.exp, main=main, xlim=xlim, ylim=c(-3,3), pch=21, 
     col='black', bg=rgb(0, 0, 0, 0.5),
     xlab='GEC experiment [mmol/min]', ylab='GEC predicted-experiment [mmol/min]', font.lab=2)
  abline(h=0, col='black')
}
plot_GECkg <- function(df, main, xlim=c(0,0.10)){
  plot(df$GECkg.exp, df$GECkg.pre, main=main, xlim=xlim, ylim=xlim, pch=21, col='black', bg=rgb(0, 0, 0, 0.5),
       xlab='GECkg experiment [mmol/min/kg]', ylab='GECkg predicted [mmol/min/kg]', font.lab=2)
  abline(a=0, b=1, col='black')
  
  plot(df$GECkg.exp, df$GECkg.pre-df$GECkg.exp, main=main, xlim=xlim, ylim=c(-0.04,0.04), pch=21, 
       col='black', bg=rgb(0, 0, 0, 0.5),
       xlab='GECkg experiment [mmol/min/kg]', ylab='GEC predicted-experiment [mmol/min/kg]', font.lab=2)
  abline(h=0, col='black')
  par(mfrow=c(1,1))
}
plot_GEC_age <- function(df, main, ylim=c(0,7)){
  plot(df$age, df$GEC.pre, main=main, ylim=ylim, pch=21, col='black', bg=rgb(0, 0, 0, 0.5),
       xlab='age [years]', ylab='GEC predicted [mmol/min]', font.lab=2)
  abline(a=0, b=1, col='black')
  
  plot(df$age, df$GEC.pre-df$GEC.exp, main=main, ylim=c(-3,3), pch=21, 
       col='black', bg=rgb(0, 0, 0, 0.5),
       xlab='age [years]', ylab='GEC predicted-experiment [mmol/min]', font.lab=2)
  abline(h=0, col='black')
}
plot_GECkg_age <- function(df, main, ylim=c(0,0.10)){
  plot(df$age, df$GECkg.pre, main=main, ylim=ylim, pch=21, col='black', bg=rgb(0, 0, 0, 0.5),
       xlab='age [years]', ylab='GECkg predicted [mmol/min/kg]', font.lab=2)
  abline(a=0, b=1, col='black')
  
  plot(df$age, df$GECkg.pre-df$GECkg.exp, main=main, ylim=c(-0.04,0.04), pch=21, 
       col='black', bg=rgb(0, 0, 0, 0.5),
       xlab='age [years]', ylab='GEC predicted-experiment [mmol/min/kg]', font.lab=2)
  abline(h=0, col='black')
  par(mfrow=c(1,1))
}

predict_GEC_for_name <- function(name){
  # name='mar1988'
  name.pre <- paste(name, '.pre', sep='')
  name.p <- paste(name, '.p', sep='')
  assign(name, loadRawData(name))
  assign(name.pre, prepare_df( get(name)) )
  assign(name.p, predict_GEC( get(name.pre)) )
  
  par(mfrow=c(2,2))
  plot_GEC(get(name.p), main=name)
  plot_GECkg(get(name.p), main=name)
  par(mfrow=c(1,1))
  return ( get(name.p) )
}


############################################
# GEC [mmol/min] 
############################################
## mar1988 (age, volLiver, [GEC])
mar1988.p1 <- predict_GEC_for_name('mar1988')
str(mar1988.p1)
## tyg1962 (age, bodyweight, [GEC, GECkg])
tyg1962.p1 <- predict_GEC_for_name('tyg1962')
str(tyg1962.p1)
## sch1986.tab1 (sex, age, bodyweight, [GEC, GECkg])
sch1986.tab1.p1 <- predict_GEC_for_name('sch1986.tab1')
str(sch1986.tab1.p1)
## win1965 (sex, age, bodyweight, BSA, flowLiver, [GEC, GECkg]
# win1965.p1 <- predict_GEC_for_name('win1965')

## duc1979 (sex, age, bodyweight BSA, [GEC, GECkg])
duc1979.p1 <- predict_GEC_for_name('duc1979')
str(duc1979.p1)

## duf2005 (sex, age, [GEC, GECkg])
duf2005.p1 <- predict_GEC_for_name('duf2005')
str(duf2005.p1)

## combine the data frames and show all the predictions
df.list <- list(mar1988.p1, tyg1962.p1, sch1986.tab1.p1, duc1979.p1, duf2005.p1)
library('reshape')
df <- reshape::merge_all(df.list)

par(mfrow=c(2,2))
plot_GEC(df, main='Combined GEC data', xlim=c(0,6))
plot_GECkg(df, main='Combined GECkg data', xlim=c(0,0.08))
par(mfrow=c(1,1))

par(mfrow=c(2,2))
plot_GEC_age(df, main='Combined GEC')
plot_GECkg_age(df, main='Combined GECkg')
par(mfrow=c(1,1))


############################################
# GECkg [mmol/min/kgbw]
############################################
# TODO prediction via volLiverkg & flowLiverkg (without available bodyweight)

loadRawData('lan2011') # age, GECkg 
lan2011.p1 <- predict_GEC_for_name('lan2011')
head(lan2011.p1)
par(mfrow=c(2,2))
plot_GEC(lan2011.p1, main='Combined GEC data', xlim=c(0,6))
plot_GECkg(lan2011.p1, main='Combined GECkg data', xlim=c(0,0.08))
par(mfrow=c(1,1))


## sch1968.fig1 (age, [GECkg])
loadRawData('sch1986.fig1')
sch1968.fig1.p1 <- predict_GEC_for_name('sch1986.fig1')
par(mfrow=c(2,2))
plot_GEC(sch1968.fig1.p1, main='Combined GEC data', xlim=c(0,6))
plot_GECkg(sch1968.fig1.p1, main='Combined GECkg data', xlim=c(0.01,0.07))
par(mfrow=c(1,1))

############################################
# Predict for Heinemann
############################################
# TODO Use the Heinemann liver volume data for prediction.

############################################
# Predict distributons
############################################
# TODO Multiple predictions per data point with different subsets of 
# information.
# mean prediction + inervals for the predictions

