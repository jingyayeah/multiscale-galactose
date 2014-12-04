################################################################################
# NHANES predict plot 
################################################################################
# Predict liver volume, blood flow and metabolic functions for the
# NHANES cohort. 
# Based on the individual samples of blood flow an liver the GEC clearance
# is calculated.
#
# author: Matthias Koenig
# date: 2014-12-01
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
library('methods')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))

# Load the NHANES & quantile data
dir_nhanes <- file.path(ma.settings$dir.base, 'results', 'nhanes')
load(file=file.path(dir_nhanes, 'nhanes_GEC_quantiles.Rdata'))
# Load the raw data
load(file=file.path(dir_nhanes, 'nhanes_volLiver.Rdata'))
load(file=file.path(dir_nhanes, 'nhanes_flowLiver.Rdata'))
load(file=file.path(dir_nhanes, 'nhanes_GEC.Rdata'))
load(file=file.path(dir_nhanes, 'nhanes_GECkg.Rdata'))

############################################################################
# Plot personalized GEC
############################################################################
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

############################################################################
# Plot flowLiver ~ volLiver
############################################################################
scale_density <- function(h, max.value){
  h$density <- max.value/max(h$density) * h$density 
  return(h)
}

# scatterplot of liver volumes & blood flows
vol_flow_figure <- function(vol, flow, data, person){
  # empty plot
  plot(numeric(0), numeric(0), xlim=lim$volLiver, ylim=lim$flowLiver,
       xlab=lab$volLiver, ylab=lab$flowLiver, type='n',
       main="flowLiver ~ volLiver")
  abline(a=0, b=1, col='gray')
  points(vol, flow, pch=21, bg=rgb(0,0,0, 0.1), col="black", cex=1*data/max(data))
  # rugs
  rug(vol, side=1)
  rug(flow, side=2)
  # additional histograms
  max.value=400
  col.hist <- rgb(0,0,0, 0.3); breaks <- 20;
  hx <- hist(vol, plot=FALSE, breaks=breaks)
  hx <- scale_density(hx, max.value=max.value)
  plot(hx, freq=FALSE, col=col.hist, add=TRUE)
  
  hy <- hist(flow, plot=FALSE, breaks=breaks)
  hy <- scale_density(hy, max.value=max.value)
  Nhist = length(hy$density)
  rect(ybottom=hy$breaks[1:Nhist], xleft=0, ytop=hy$breaks[2:(Nhist+1)], xright=hy$density, col=col.hist)
  
  
  # additional boxplot
  # add the means 
  points(mean(vol), mean(flow), bg='blue', col='black', pch=22, cex=2)  
}

vol_model_figure <- function(person){
 # plot the model information underlying the volume prediction
# TODO : generate the plot
  
  
  
}


# full combined plot of the information
full_plot <- function(person, data, vol, flow){
  par(mfrow=c(2,2))
  GEC_figure(data=GEC[index, ], person)
  vol_flow_figure(vol=volLiver[index,], flow=flowLiver[index, ], data=GEC[index, ], person)
  par(mfrow=c(1,1))
}
index <- 1
person <- with(nhanes[index, ], list(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA))
full_plot(person, data=GEC[index, ], vol=volLiver[index, ], flow=flowLiver[index, ])
#




dir <- file.path(ma.settings$dir.base, 'results', 'nhanes', 'plots')
# for (index in 1:nrow(nhanes)) {
for (index in 1:100) {
  fname <- sprintf("%s/NHANES_GEC_range_%04i.png", dir, index)
  cat(fname, '\n')
  png(filename=fname, width=2000, height=1000, units = "px", bg = "white",  res = 150)
  # create figure
  person <- with(nhanes[index, ], list(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA))
  full_plot(person, data=GEC[index, ], vol=volLiver[index, ], flow=flowLiver[index, ]) 
  
  dev.off()
}

############################################################################
# Basic plots of analysis
############################################################################
ind.male <- (nhanes$sex == 'male')
ind.female <- (nhanes$sex == 'female')
down <- '25%'; up <- '75%';  # the intervals to plot

## GEC ~ bodyweight ##
xname <- 'bodyweight'; yname <- 'GEC'
plot(numeric(0), numeric(0), xlab=lab[[xname]], ylab=lab[[yname]], xlim=lim[[xname]], ylim=lim[[yname]])
for (sex in c('male', 'female')){
  inds <- (nhanes$sex == sex)
  points(nhanes[[xname]][inds], GEC.q[inds,'50%'], cex=0.3, pch=21, col=gender.cols[[sex]])
  x0 <- nhanes$bodyweight[inds]
  y0 <- GEC.q[inds, down]
  y1 <- GEC.q[inds, up]
  segments(x0=x0, y0=y0, x1=x0, y1=y1, col=gender.cols_light[[sex]])
}

## flowLiver ~ volLiver ##
xname <- 'volLiver'; yname <- 'flowLiver'
x <- volLiver.q[,'50%']; x <- flowLiver.q[,'50%'];

plot(numeric(0), numeric(0), xlab=lab[[xname]], ylab=lab[[yname]], xlim=lim[[xname]], ylim=lim[[yname]])
for (sex in c('male', 'female')){
  inds <- (nhanes$sex == sex)
  points(volLiver.q[inds,'50%'], flowLiver.q[inds,'50%'], 
         col=gender.cols[[sex]], cex=nhanes$age[inds]/100)
}

plot(volLiver.q[ind.male,'50%'], flowLiver.q[ind.male,'50%'], col=rgb(0,0,1), cex=nhanes$age[ind.male]/100, xlim=c(400, 2000), ylim=c(400, 2000))
points(volLiver.q[ind.female,'50%'], flowLiver.q[ind.female,'50%'], col=rgb(1,0,0), cex=nhanes$age[ind.female]/100)



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
range <- 1:1000
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