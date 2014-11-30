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


## calculate the quantiles of data and predictions ##
calc_quantiles <- function(data, q.values=c(0.025, 0.25, 0.5, 0.75, 0.975)){
  qdata <- apply(data, 1, quantile, q.values)
  return ( t(qdata) )
}

volLiver.q <- calc_quantiles(volLiver)
flowLiver.q <- calc_quantiles(flowLiver)
GEC.q <- calc_quantiles(GEC)
GECkg.q <- calc_quantiles(GECkg)
colnames(GEC.q)
##

## Create some plots ##
ind.male <- (nhanes$sex == 'male')
ind.female <- (nhanes$sex == 'female')
plot(nhanes$age, GEC.q[,'50%'], cex=0.3, pch=21)
plot(nhanes$bodyweight[ind.male], GEC.q[ind.male,'50%'], cex=0.3, pch=21, col=rgb(1,0,0, 0.5))
x0 <- nhanes$bodyweight[ind.male]
y0 <- GEC.q[ind.male,'25%']
y1 <- GEC.q[ind.male,'75%']
# y0 <- GEC.q[ind.male,'2.5%']
# y1 <- GEC.q[ind.male,'97.5%']
segments(x0=x0, y0=y0, x1=x0, y1=y1, col=rgb(1,0,0, 0.1) )
points(nhanes$bodyweight[ind.female], GEC.q[ind.female,'50%'], cex=0.3, pch=21, col=rgb(0,0,1, 0.5))
x0 <- nhanes$bodyweight[ind.female]
y0 <- GEC.q[ind.female,'25%']
y1 <- GEC.q[ind.female,'75%']
# y0 <- GEC.q[ind.female,'2.5%']
# y1 <- GEC.q[ind.female,'97.5%']
segments(x0=x0, y0=y0, x1=x0, y1=y1, col=rgb(0,0,1, 0.1) )

# flowLiver vs. volLiver
plot(volLiver.q[,'50%'], flowLiver.q[,'50%'], cex=0.3, xlim=c(0,2000), ylim=c(0,2000))
plot(volLiver.q[ind.male,'50%'], flowLiver.q[ind.male,'50%'], col=rgb(0,0,1), cex=nhanes$age[ind.male]/100, xlim=c(0,400), ylim=c(0,400))
points(volLiver.q[ind.female,'50%'], flowLiver.q[ind.female,'50%'], col=rgb(1,0,0), cex=nhanes$age[ind.female]/100)

plot(volLiver[1,], flowLiver[1,], cex=0.3)
points(volLiver.q[1, '50%'], flowLiver.q[1, '50%'], cex=2.0, col='black', bg='black', pch=21)
plot(volLiver.q[ind.male, flowLiver.q, cex=0.3)


plot(volLiver.q[ind.male,'50%'], flowLiver.q[ind.male,'50%'], cex=0.3, pch=21, col=rgb(1,0,0, 0.5))
x0 <- volLiver.q[ind.male,'50%']
y0 <- flowLiver.q[ind.male,'25%']
y1 <- flowLiver.q[ind.male,'75%']
segments(x0=x0, y0=y0, x1=x0, y1=y1, col=rgb(1,0,0, 0.1) )
x0 <- volLiver.q[ind.male,'25%']
x1 <- flowLiver.q[ind.male,'75%']
y0 <- volLiver.q[ind.male,'50%']
segments(x0=x0, y0=y0, x1=x1, y1=y0, col=rgb(1,0,0, 0.1) )



points(nhanes$bodyweight[ind.female], GEC.q[ind.female,'50%'], cex=0.3, pch=21, col=rgb(0,0,1, 0.5))
x0 <- nhanes$bodyweight[ind.female]
y0 <- GEC.q[ind.female,'25%']
y1 <- GEC.q[ind.female,'75%']
# y0 <- GEC.q[ind.female,'2.5%']
# y1 <- GEC.q[ind.female,'97.5%']
segments(x0=x0, y0=y0, x1=x0, y1=y1, col=rgb(0,0,1, 0.1) )


plot(nhanes$bodyweight[ind.male], GECkg.q[ind.male,'50%'], cex=0.3, pch=21, col=rgb(1,0,0, 0.5))
points(nhanes$bodyweight[ind.female], GECkg.q[ind.female,'50%'], cex=0.3, pch=21, col=rgb(0,0,1, 0.5))

plot(nhanes$age[ind.male], GEC.q[ind.male,'50%'], cex=0.3, pch=21, col=rgb(1,0,0, 0.5))
points(nhanes$age[ind.female], GEC.q[ind.female,'50%'], cex=0.3, pch=21, col=rgb(0,0,1, 0.5))

plot(nhanes$age[ind.male], GECkg.q[ind.male,'50%'], cex=0.3, pch=21, col=rgb(1,0,0, 0.5))
points(nhanes$age[ind.female], GECkg.q[ind.female,'50%'], cex=0.3, pch=21, col=rgb(0,0,1, 0.5))


plot(nhanes$age[ind.male], GECkg.q[ind.male,'50%'], cex=0.3, pch=21, col=rgb(1,0,0, 0.5))
points(nhanes$age[ind.female], GECkg.q[ind.female,'50%'], cex=0.3, pch=21, col=rgb(0,0,1, 0.5))



boxplot(t(GEC[1:100, ]), notch=TRUE, col=(rgb(0,0,0,0.2)), range=0, boxwex=0.4, plot=FALSE)

box <- boxplot(t(GEC[1:100, ]), notch=FALSE, col=(rgb(0,0,0,0.2)), range=0, boxwex=0.4, ylim=c(0,5), plot=TRUE)


# adapt the whiskers to [0.025, 0.975]
range <- 1:3000
box <- boxplot(t(GEC[range, ]), notch=FALSE, range=0, ylim=c(0,5), xlim=c(0,100), plot=FALSE, at=nhanes$age[range])
# Calcualte the quantiels
box$stats <- apply(GEC[range, ], 1, quantile, c(0.025, 0.25, 0.5, 0.75, 0.975))
bxp(z=box, notch=FALSE, range=0, xlim=c(0,100), ylim=c(0,5), horizontal=FALSE, boxwex=0.5, lty=1, at=nhanes$age[range], boxfill=rgb(0,0,0,0.1), boxcol=rgb(0,0,0,0.2))


box <- boxplot(t(GEC[range, ]), notch=FALSE, range=0, ylim=c(0,5), xlim=c(0,110), plot=FALSE, at=nhanes$bodyweight[range])
# Calcualte the quantiels
box$stats <- apply(GEC[range, ], 1, quantile, c(0.025, 0.25, 0.5, 0.75, 0.975))
bxp(z=box, notch=FALSE, range=0, xlim=c(0,110), ylim=c(0,5), horizontal=FALSE, boxwex=0.5, lty=1, at=nhanes$bodyweight[range], boxfill=rgb(0,0,0,0.1), boxcol=rgb(0,0,0,0.2))


box <- boxplot(t(GECkg[range, ]), notch=FALSE, range=0, ylim=c(0,0.10), xlim=c(0,110), plot=FALSE, at=nhanes$bodyweight[range])
# Calcualte the quantiels
box$stats <- apply(GECkg[range, ], 1, quantile, c(0.025, 0.25, 0.5, 0.75, 0.975))
bxp(z=box, notch=FALSE, range=0, xlim=c(0,110), ylim=c(0,0.10), horizontal=FALSE, boxwex=0.5, lty=1, at=nhanes$bodyweight[range], boxfill=rgb(0,0,0,0.1), boxcol=rgb(0,0,0,0.2))



######################################
# Create the personalized plot
######################################
GEC_figure <- function(data, person){
  # Histogram
  h <- hist(data, plot=FALSE)
  h.max <- max(h$density)
  # Density
  dens <- density(data)
  d.max <- max(dens$y)
  # Maximum for arranging things
  p.max <- max(h.max, d.max)
  
  
  # empty plot
  plot(numeric(0), numeric(0), type='n', xlim=c(0,5), ylim=c(0, 1.2*p.max), 
     main="GEC reference range [2.5% - 97.5%]",
     xlab="GEC [mmol/min]", ylab="probability", font.lab=2)
  
  qdata <- quantile(data, c(0.025, 0.5, .975))
  
  # person info
  person.info <- with(person, sprintf(' %s\n %1.0f years\n %1.1f kg\n %1.0f cm\n %1.2f m^2', sex, age, bodyweight,height, BSA))
  x.text=0
  if (qdata[2] < 2.5){ x.text = 3.7 }
  text(x=x.text,y=p.max, labels=c(person.info), pos=4, cex=0.9)
  
  # GEC info
  GEC.info <- sprintf('median %1.2f\n [%1.2f - %1.2f]\n ', qdata[2], qdata[1], qdata[3])
  text(x=qdata[2], y=1.08*p.max, labels=c(GEC.info), pos=3, cex=0.9)

  # polygons (red area left & right)
  span = 0.75
  qdata <- quantile(data, c(0.025, .975))
  polygon(x=c(qdata[1]-span, qdata[1], qdata[1], qdata[1]-span), y=c(0, 0,p.max, p.max), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
  polygon(x=c(qdata[2]+span, qdata[2], qdata[2], qdata[2]+span), y=c(0, 0,p.max, p.max), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))

  # histogram & density
  plot(h, xlim=c(0,5), col=rgb(0,0,0, 0.05), border=rgb(0,0,0, 0.5), freq=FALSE, add=TRUE)
  lines(dens, col='black', lwd=2)
  
  # Quantiles
  # qdata <- quantile(GEC[1, ], c(0.025, .25, .50,  .75, .975))
  # qdata <- quantile(data, c(.25,  .75))
  # abline(v=qdata, col='black', lwd=2, lty=1)
  #qdata <- quantile(data, c(0.025, .975))
  # abline(v=qdata, col='red', lwd=2, lty=1)
  # Rugs
  rug(data)
  # Boxplot
  box <- boxplot(data, notch=FALSE, col=(rgb(0,0,0,0.2)), range=0, boxwex=0.1*p.max, horizontal = TRUE, at=c(1.1*p.max), add=TRUE, plot=FALSE)
  box$stats <- matrix(quantile(data, c(0.025, 0.25, 0.5, 0.75, 0.975)), nrow=5, ncol=1)
  bxp(z=box, notch=FALSE, range=0, boxwex=0.1*p.max, ylim=c(0,5), horizontal=TRUE, add=TRUE, at=c(1.1*p.max), lty=1)
}
######################################
# Create the proper prediction for an individual person

for (k in 1:10){
  index <- k
  print(k)
  data <- GEC[index, ]
  person <- with(nhanes[index, ], list(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA))
  GEC_figure(data=data, person)
  Sys.sleep(1)
}


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