################################################################################
# Predict volLiver, flowLiver, volLiverkg, flowLiverkg, GEC & GECkg
################################################################################
# Use the prediction methods to predict the data.
# TOOD: volLiverkg & flowLiverkg prediction from data
#
# author: Matthias Koenig
# date: 2014-11-20
################################################################################

# TODO: load the methods and functions


##############################################################################
# Predict NHANES
##############################################################################
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
do_nhanes = FALSE
if (do_nhanes == TRUE){

load(file='data/nhanes_data.dat')
nhanes.all <- data
rm(data)
head(nhanes.all)

# create a reduced nhanes dataset
nhanes <- nhanes.all[, c('sex', 'bodyweight', 'age', 'height', 'BSA')]
head(nhanes)

# predict liver volume and blood flow
volLiver <- rep(NA, nrow(nhanes))
flowLiver <- rep(NA, nrow(nhanes))
for (k in seq(1,nrow(nhanes))){
  cat(k, '\n')
  sex <- nhanes$sex[k]
  age <- nhanes$age[k]
  bodyweight <- nhanes$bodyweight[k]
  BSA <- nhanes$BSA[k]
  
  # get the combined distribution for the liver volumes
  f_d1 <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
  # rejection sampling
  rs1 <- f_d.rejection_sample(f_d1$f_d, Nsim=1, interval=c(1, 4000))
  volLiver[k] <- rs1$values[1]
  
  # get the combined distribution for liver blood flow
  f_d2 <- f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver[k])
  # rejection sampling
  rs2 <- f_d.rejection_sample(f_d2$f_d, Nsim=1, interval=c(1, 4000))
  flowLiver[k] <- rs2$values[1]
  
  #cat(sprintf('sex=%s, age=%2.1f [year], bodyweight=%2.1f [kg], BSA=%1.2f [m^2], volLiver=%4.1f [ml], flowLiver=%4.1f [ml/min]', sex, age, bodyweight, BSA, volLiver[k], flowLiver[k]))
}
nhanes$volLiver <- volLiver
nhanes$flowLiver <- flowLiver
head(nhanes)
# save('nhanes', file='nhanes_liverData.Rdata')
}

load(file='nhanes_liverData.Rdata')
head(nhanes)
## Calculate GEC and GECkg for nhanes ##
GEC <- calculate_GEC(nhanes$volLiver, nhanes$flowLiver)
nhanes$GEC <- GEC$GEC
head(nhanes)
nhanes$GECkg <- nhanes$GEC/nhanes$bodyweight
save('nhanes', file='nhanes_liverData_GEC.Rdata')

##  Some control plots
I.male <- (nhanes$sex=='male')
I.female <- (nhanes$sex=='female')

par(mfrow=c(2,2))
plot(nhanes$age[I.male], GEC$GEC[I.male], col='blue', cex=0.3, ylim=c(0,6))
plot(nhanes$age[I.female], GEC$GEC[I.female], col='red', cex=0.3, ylim=c(0,6))
plot(nhanes$age[I.male], GEC$GEC[I.male]/nhanes$bodyweight[I.male], col='blue', cex=0.3, ylim=c(0,0.1))  
plot(nhanes$age[I.female], GEC$GEC[I.female]/nhanes$bodyweight[I.female], col='red', cex=0.3, ylim=c(0,0.1))  
par(mfrow=c(1,1))

m <- models.flowLiver_volLiver$fit.all
df.all <- models.flowLiver_volLiver$df.all
plotCentiles(model=m, d=df.all, xname='volLiver', yname='flowLiver',
             main='Test', xlab='liver volume', ylab='liver bloodflow', xlim=c(0,3000), ylim=c(0,3000), 
             pcol='blue')
points(nhanes$volLiver[nhanes$sex=='female'], nhanes$flowLiver[nhanes$sex=='female'], xlim=c(0,3000), ylim=c(0,2500), col='red', cex=0.2)
points(nhanes$volLiver[nhanes$sex=='male'], nhanes$flowLiver[nhanes$sex=='male'], xlim=c(0,3000), ylim=c(0,2500), col='black', cex=0.2)

plotCentiles(model=m, d=df.all, xname='volLiver', yname='flowLiver',
             main='Test', xlab='liver volume', ylab='liver bloodflow', xlim=c(0,3000), ylim=c(0,3000), 
             pcol='blue')
points(nhanes$volLiver[nhanes$age>18], nhanes$flowLiver[nhanes$age>18], xlim=c(0,3000), ylim=c(0,2500), col='black', cex=0.2)


plot(nhanes$age[nhanes$sex=='female'], nhanes$volLiver[nhanes$sex=='female'], xlim=c(0,100), ylim=c(0,2500), col='red', cex=0.2)
points(nhanes$age[nhanes$sex=='male'], nhanes$volLiver[nhanes$sex=='male'], xlim=c(0,100), ylim=c(0,2500), col='blue', cex=0.2)

plot(nhanes$age[nhanes$sex=='female'], nhanes$flowLiver[nhanes$sex=='female'], xlim=c(0,100), ylim=c(0,2500), col='red', cex=0.2)
points(nhanes$age[nhanes$sex=='male'], nhanes$flowLiver[nhanes$sex=='male'], xlim=c(0,100), ylim=c(0,2500), col='blue', cex=0.2)
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

f_d1 <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)


# predict GEC for full data frame
predict_GEC <- function(df){
  for (k in 1:nrow(df)){
    df[k,] <- predict_GEC_row(df[k,]) 
  }
  return(df)
}

# predict GEC for single row 
predict_GEC_row <- function(row){
  if (is.na(row$sex)){
   row$sex = 'all' 
  }
  
  # predict the liver volume
  if (is.na(row$volLiver.exp)){
    cat('* Predict Liver Volume *\n')
    # get the combined distribution for the liver volumes
    f_d1 <- f_d.volLiver.c(sex=row$sex, age=row$age, bodyweight=row$bodyweight, BSA=row$BSA)
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
    f_d2 <- f_d.flowLiver.c(sex=row$sex, age=row$age, bodyweight=row$bodyweight, volLiver=row$volLiver.pre)
    # rejection sampling
    rs2 <- f_d.rejection_sample(f_d2$f_d, Nsim=1, interval=c(1,4000))
    row$flowLiver.pre <- rs2$values[1]  
  } else {
    row$flowLiver.pre <- row$flowLiver.exp 
  }

  # predict GEC
  cat('* Predict GEC *\n')
  row$GEC.pre <- calculate_GEC(volLiver=row$volLiver.pre, flowLiver=row$flowLiver.pre)$GEC
  
  # predict GECkg
  row$GECkg.pre <- NA
  if (!is.na(row$bodyweight)){
    row$GECkg.pre <- row$GEC.pre/row$bodyweight
  }
  return (row)
}

# prepare one common data frame for prediction
prepare_df <- function(data){
  fields <- c('study', 'gender', 'age', 'bodyweight', 'BSA', 'volLiver', 'flowLiver', 'GEC', 'GECkg')
  index <-  c( 1, 2, 3, 4, 5, 7, 9, 11, 13)
  col.names <- c('study', 'sex', 'age', 'bodyweight', 'BSA', 
                 'volLiver.pre', 'volLiver.exp',
                 'flowLiver.pre', 'flowLiver.exp', 
                 'GEC.pre', 'GEC.exp',
                 'GECkg.pre', 'GECkg.exp')
  data.pre <- data.frame(matrix(NA, ncol=13, nrow=nrow(data)) )
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

## sch1968.fig1 (age, [GECkg])
loadRawData('sch1986.fig1')
sch1968.fig1.p1 <- predict_GEC_for_name('sch1986.fig1')


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

