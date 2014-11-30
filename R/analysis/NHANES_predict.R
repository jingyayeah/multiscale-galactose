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
library('MultiscaleAnalysis')
library('methods')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'GAMLSS_predict_functions.R'))

##############################################################################
# Predict NHANES liver volume & flow
##############################################################################
do_nhanes = FALSE
if (do_nhanes){
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

liver.info <- predict_liver_people(nhanes, 1000, Ncores=11)
# liver.info <- predict_liver_people(nhanes[1:100], 1000, Ncores=11)

proc.time() - ptm
save('nhanes', 'liver.info', file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_liver.Rdata'))
# due to 
volLiver <- liver.info$volLiver
flowLiver <- liver.info$flowLiver
save('volLiver', file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_volLiver.Rdata'))
save('flowLiver', file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_flowLiver.Rdata'))
}

##############################################################################
# Predict GEC and GECkg
##############################################################################
cat('----------------------------------------------------------\n')
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
nhanes <- data; rm(data)
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_volLiver.Rdata'))
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_flowLiver.Rdata'))
cat('# Liver Volume #')
head(volLiver[, 1:5])
cat('# Liver Blood Flow #')
head(flowLiver[, 1:5])
cat('----------------------------------------------------------\n')

## Calculate GEC and GECkg for nhanes ##
source(file.path(ma.settings$dir.code, 'analysis', 'GEC_predict_functions.R'))
GEC_f <- GEC_functions(task='T54')

GEC <- calculate_GEC(volLiver, flowLiver)
GEC <- GEC$values

m.bodyweight <- matrix(rep(nhanes$bodyweight, ncol(GEC)),
                       nrow=nrow(GEC), ncol=ncol(GEC))
GECkg <- GEC/m.bodyweight
boxplot(t(GEC[1:100, ]), notch=TRUE, col=(rgb(0,0,0,0.2)), range=0, boxwex=0.4)
boxplot(t(GEC[1:100, ]), notch=FALSE, col=(rgb(0,0,0,0.2)), range=0, boxwex=0.4, ylim=c(0,5))

head(nhanes)

# Create the proper prediction for an individual person
index <- 1
data <- GEC[index, ]
person.nhanes <- nhanes[index, ]
person <- with(person.nhanes, list(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA))
info <- with(person, sprintf('(sex=%s, age=%1.0f [years], bodyweight=%1.1f [kg], height=%1.0f [cm], BSA=%1.2f [m^2])', sex, age, bodyweight, height, BSA))
info

# Histogram
h1 <- hist(data, plot=FALSE)
h1.max <- max(h1$density)
# Empty plot
plot(numeric(0), numeric(0), type='n', xlim=c(0,5), ylim=c(0, h1.max+1), 
     main="Personalized GEC reference range",
     sub=info,
     xlab="GEC [mmol/min]", ylab="probability", font.lab=2)
# TODO: add the personal information

# Do the polygons
span = 0.75
qdata <- quantile(data, c(0.025, .975))
# left
polygon(x=c(qdata[1]-span, qdata[1], qdata[1], qdata[1]-span), y=c(0, 0,h1.max+0.25, h1.max+0.25), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
polygon(x=c(qdata[2]+span, qdata[2], qdata[2], qdata[2]+span), y=c(0, 0,h1.max+0.25, h1.max+0.25), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))

# Density
plot(h1, xlim=c(0,5), col=rgb(0,0,0, 0.05), border=rgb(0,0,0, 0.5), freq=FALSE, add=TRUE)
lines(density(GEC[1, ]), col='black', lwd=2)
# quantiles
# qdata <- quantile(GEC[1, ], c(0.025, .25, .50,  .75, .975))
qdata <- quantile(GEC[1, ], c(.25,  .75))
abline(v=qdata, col='black', lwd=2, lty=1)
qdata <- quantile(GEC[1, ], c(0.025, .975))
abline(v=qdata, col='red', lwd=2, lty=1)
# rugs
rug(GEC[1, ])
# boxplot
boxplot(GEC[1, ], notch=FALSE, col=(rgb(0,0,0,0.2)), range=0, boxwex=0.4, ylim=c(0,5), horizontal = TRUE, add=TRUE, at=c(h1.max+0.5))

# legend
# TODO





stat_sum_df <- function(fun, geom="crossbar", ...) {
  stat_summary(fun.data=fun, colour="red", geom=geom, width=0.2, ...)
}

library(ggplot2)
# install.packages('Hmisc')
library(Hmisc)
ggplot(mtcars, aes(factor(cyl), mpg)) + 
  stat_sum_df("median_hilow",conf.int=0.5,fill="white")



# nhanes$GEC <- GEC$GEC
# head(nhanes)
# nhanes$GECkg <- nhanes$GEC/nhanes$bodyweight
# save('nhanes', file='nhanes_liverData_GEC.Rdata')

#########################
# head(nhanes)
# plot(nhanes$age, nhanes$flowLiver)

=======
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