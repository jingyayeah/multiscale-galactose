################################################################################
# NHANES prediction 
################################################################################
# Predicts the liver volumes, blood flows and metabolic functions for the
# NHANES cohort. 
#
# author: Matthias Koenig
# date: 2014-11-29
################################################################################
rm(list=ls())
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'GAMLSS_predict_functions.R'))

##############################################################################
# Predict NHANES
##############################################################################
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
nhanes <- data[, c('SEQN', 'sex', 'bodyweight', 'age', 'height', 'BSA')]
nhanes$volLiver <- NA
nhanes$volLiverkg <- NA
rm(data)
head(nhanes)

## predict liver volume and blood flow ##
cat('# parallel #\n')
set.seed(12345)
ptm <- proc.time()
# liver.info <- predict_liver_people(nhanes[1:20,], 1000, Ncores=4)
liver.info <- predict_liver_people(nhanes[1:100], 1000, Ncores=11)
proc.time() - ptm
save('nhanes', 'liver.info', file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_liver.Rdata'))


## Calculate GEC and GECkg for nhanes ##
# GEC <- calculate_GEC(nhanes$volLiver, nhanes$flowLiver)
# nhanes$GEC <- GEC$GEC
# head(nhanes)
# nhanes$GECkg <- nhanes$GEC/nhanes$bodyweight
# save('nhanes', file='nhanes_liverData_GEC.Rdata')


#########################
# head(nhanes)
# plot(nhanes$age, nhanes$flowLiver)
# plot(nhanes$age, nhanes$volLiver, cex=0.3, pch=21)
# 
# plot(liver.info$volLiver[1,], liver.info$flowLiver[1,], xlim=c(0,2000), ylim=c(0,2000), cex=0.2)
# points(liver.info$volLiver[2,], liver.info$flowLiver[2,], xlim=c(0,2000), ylim=c(0,2000), cex=0.2, col='red')
# boxplot(t(liver.info$volLiver))


# still too slow
# ptm <- proc.time()
# f_d1 <- f_d.volLiver.c(sex=nhanes$sex[2], age=nhanes$age[2], bodyweight=nhanes$bodyweight[2],
#                        height=nhanes$height[2], BSA=nhanes$BSA[2])
# proc.time() - ptm
# 
# library(profr)
# p <- profr(
#    f_d.volLiver.c(sex=nhanes$sex[2], age=nhanes$age[2], bodyweight=nhanes$bodyweight[2],
#                  height=nhanes$height[2], BSA=nhanes$BSA[2]),
#    0.01
# )
# plot(p)


# load(file='nhanes_liverData.Rdata')
# head(nhanes)
# 
# ##  Some control plots
# I.male <- (nhanes$sex=='male')
# I.female <- (nhanes$sex=='female')
# 
# par(mfrow=c(2,2))
# plot(nhanes$age[I.male], GEC$GEC[I.male], col='blue', cex=0.3, ylim=c(0,6))
# plot(nhanes$age[I.female], GEC$GEC[I.female], col='red', cex=0.3, ylim=c(0,6))
# plot(nhanes$age[I.male], GEC$GEC[I.male]/nhanes$bodyweight[I.male], col='blue', cex=0.3, ylim=c(0,0.1))  
# plot(nhanes$age[I.female], GEC$GEC[I.female]/nhanes$bodyweight[I.female], col='red', cex=0.3, ylim=c(0,0.1))  
# par(mfrow=c(1,1))
# 
# m <- models.flowLiver_volLiver$fit.all
# df.all <- models.flowLiver_volLiver$df.all
# plotCentiles(model=m, d=df.all, xname='volLiver', yname='flowLiver',
#              main='Test', xlab='liver volume', ylab='liver bloodflow', xlim=c(0,3000), ylim=c(0,3000), 
#              pcol='blue')
# points(nhanes$volLiver[nhanes$sex=='female'], nhanes$flowLiver[nhanes$sex=='female'], xlim=c(0,3000), ylim=c(0,2500), col='red', cex=0.2)
# points(nhanes$volLiver[nhanes$sex=='male'], nhanes$flowLiver[nhanes$sex=='male'], xlim=c(0,3000), ylim=c(0,2500), col='black', cex=0.2)
# 
# plotCentiles(model=m, d=df.all, xname='volLiver', yname='flowLiver',
#              main='Test', xlab='liver volume', ylab='liver bloodflow', xlim=c(0,3000), ylim=c(0,3000), 
#              pcol='blue')
# points(nhanes$volLiver[nhanes$age>18], nhanes$flowLiver[nhanes$age>18], xlim=c(0,3000), ylim=c(0,2500), col='black', cex=0.2)
# 
# 
# plot(nhanes$age[nhanes$sex=='female'], nhanes$volLiver[nhanes$sex=='female'], xlim=c(0,100), ylim=c(0,2500), col='red', cex=0.2)
# points(nhanes$age[nhanes$sex=='male'], nhanes$volLiver[nhanes$sex=='male'], xlim=c(0,100), ylim=c(0,2500), col='blue', cex=0.2)
# 
# plot(nhanes$age[nhanes$sex=='female'], nhanes$flowLiver[nhanes$sex=='female'], xlim=c(0,100), ylim=c(0,2500), col='red', cex=0.2)
# points(nhanes$age[nhanes$sex=='male'], nhanes$flowLiver[nhanes$sex=='male'], xlim=c(0,100), ylim=c(0,2500), col='blue', cex=0.2)
# }