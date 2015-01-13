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
setwd(ma.settings$dir.base)

# Load data nhanes
dir <- file.path(ma.settings$dir.base, 'results', 'nhanes')
fileset <- c('volLiver', 'flowLiver', 'GEC', 'GECkg', 'GEC_quantiles')
for (name in fileset){
  load(file=file.path(dir, sprintf('%s.Rdata', name)))  
}

# Individual plot
index <- 2
individual_plot(person=people[index, ], vol=volLiver[index, ], flow=flowLiver[index, ],
          data=GEC[index, ])


############################################################################
# Plot prediction information volLiver & flowLiver
############################################################################
plot_fds <- function(f_d.info, interval){
  x <- seq(from=interval[1], to=interval[2], length.out=300)

  # plot the single distributions
  y.max <- 3* max(f_d.info$f_ds[[1]](x))
  plot(numeric(0), numeric(0), xlim=range(x), ylim=c(0, y.max))
  for (k in seq_along(f_d.info$f_ds)){
    
    if ( (f_d.info$pars[[k]])$link == 'None'){
     message(sprintf('Link function not available: %s\n', names(f_d.info$f_ds)[[k]])) 
    } else {
      y <- f_d.info$f_ds[[k]](x)
      # lines(x, y/max(y), col='red')
      lines(x, y, col=(k+1), lty=k, lwd=2)
    }
  }
  # plot the combined distribution
  y <- f_d.info$f_d(x)
  lines(x, y.max*y/max(y), type='l', col='black', lwd=4)
  
#   y <- rep(0, length(x))
#   Nf <- length(f_d.info$f_ds)
#   for (k in seq.int(Nf)){
#     y <- y + f_d.info$f_ds[[k]](x)
#   }
#   y <- y/Nf
#   lines(x, y, type='l', col='black', lwd=4, lty=2)
  
  # legend
  Nf <- length(f_d.info$f_ds)
  legend('topright', legend=names(f_d.info$f_ds), lty=1:Nf, 
         col=2:(Nf+1), cex=0.8, lwd=2)
}

## example ##
fit.models <- load_models_for_prediction()

people.df <- as.data.frame(people)
head(people.df)

par(mfrow=c(2,2))

inds.old <- which(people$age>80)
index <- inds.old[5]

person <- people.df[index, ]
                 
pars.volLiver <- f_d.volLiver.pars(person)
str(pars.volLiver)
f_d1 <- f_d.volLiver.c(pars=pars.volLiver)
plot_fds(f_d1, interval=c(1,3000))

person$volLiver <- which.max(f_d1$f_d(1:3000))
person$volLiver
pars.flowLiver <- f_d.flowLiver.pars(person)
f_d3 <- f_d.flowLiver.c(pars=pars.flowLiver)
plot_fds(f_d3, interval=c(1,3000))

par(mfrow=c(1,1))

pars.flowLiver <- f_d.flowLiver.pars2(person)
f_d3 <- f_d.flowLiver.c(pars=pars.flowLiver)
plot_fds(f_d3, interval=c(1,3000))


pars.volLiverkg <- f_d.volLiverkg.pars(person)
f_d2 <- f_d.volLiverkg.c(pars=pars.volLiverkg)
plot_fds(f_d2, interval=c(1,60))

pars.flowLiverkg <- f_d.flowLiverkg.pars(person)
f_d4 <- f_d.flowLiverkg.c(pars=pars.flowLiverkg)
plot_fds(f_d4, interval=c(1,60))



liver.info <- predict_liver_person.fast(person=person, Nsample=10) 
liver.info


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
# General plots for evaluation of predictions
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