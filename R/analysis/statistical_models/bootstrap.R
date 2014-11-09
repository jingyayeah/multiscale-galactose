# R Bootstrap examples #
########################
# Here, we will estimate the size of the standard error by applying the bootstrap
# and sampling many samples with replacement from the original sample, each the same size as the
# original sample, computing a point estimate for each, and nding the standard deviation of this
# distribution of bootstrap statistics.
rm(list = ls())
install.packages('Lock5Data')
library(Lock5Data)
data(CommuteAtlanta)
str(CommuteAtlanta)

# point estimate
time.mean <- with(CommuteAtlanta, mean(Time))
# do the samples
B <- 1000  # number of samples
n <- nrow(CommuteAtlanta)
boot.samples <- matrix(sample(CommuteAtlanta$Time, size=B*n, replace=TRUE), B, n)
dim(boot.samples)

# function should be applied to each row
boot.statistics <- apply(boot.samples, 1, mean)

# plot the results
require(ggplot2)
ggplot(data.frame(meanTime=boot.statistics), aes(x=meanTime)) + geom_histogram(binwidth=0.25, aes(y=..density..)) + geom_density(color='red')

# get the standard deviation of the simulated bootstrap
time.se <- sd(boot.statistics)
print(time.se)
# Finally, construct the confidence interval. Here, I round the margin of error up and to one
# decimal place so that it has two signicant digits, and I am being cautious when rounding not to
# make the interval too small.
cis <- time.mean + c(-1, 1) * 2*time.se
print(cis)
# the accuracy of the inference depends on the original sample being representative from the population
# of interest


# Bret Larget
# January 10, 2014
# A quick bootstrap function for a confidence interval for the mean
# x is a single quantitative sample
# B is the desired number of bootstrap samples to take
# binwidth is passed on to geom_histogram()
boot.mean = function(x,B,binwidth=NULL) {
  n = length(x)
  boot.samples = matrix( sample(x,size=n*B,replace=TRUE), B, n)
  boot.statistics = apply(boot.samples,1,mean)
  se = sd(boot.statistics)
  require(ggplot2)
  if ( is.null(binwidth) )
    binwidth = diff(range(boot.statistics))/30
    p = ggplot(data.frame(x=boot.statistics),aes(x=x)) + geom_histogram(aes(y=..density..),binwidth=binwidth) + geom_density(color="red")
    plot(p)
    interval = mean(x) + c(-1,1)*2*se
    print( interval )
  return( list(boot.statistics = boot.statistics, interval=interval, se=se, plot=p) )
}
boot.mean(CommuteAtlanta$Time, B=1000)

# There is a package boot with a function boot() that does the bootstrap for many situations.
library(boot)
my.mean = function(x, indices){
  return (mean( x[indices]) )
}
time.boot = boot(CommuteAtlanta$Time, my.mean, 10000)
head(time.boot)
str(time.boot)
# confidence interval from the boot package
# pPercentile uses percentile, Basic uses the estimated standard eror, BCa also uses percentiles,
# but adjusted to account for bias and skewness

boot.ci(time.boot)

####################################################################################
## Bootstrap on GEC data 
####################################################################################
load(file='/home/mkoenig/Desktop/GEC_curve_T53.Rdata')
head(parscl)

# Multiple plot function
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

# GEC clearance per liver volume
p1 <- ggplot(d2, aes(f_flow, R_per_liv_units)) + geom_point() + geom_line() + facet_grid(~ gal_challenge) 
p2 <- ggplot(d2, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ gal_challenge)
# GEC clearance per volume depending on perfusion
p3 <- ggplot(d2, aes(Q_per_vol_units, R_per_liv_units)) + geom_point() + geom_line()+ facet_grid(~ gal_challenge) + ylim(0, 4)
multiplot(p1, p2, p3, cols=3)


library(plyr)
# Analyse the data split by group (f_flow)
# TODO: f_tissue and Vol_liv have to come from model definition
# TODO: calculate N and SD
f_analyse <- function(x){
  f_tissue <- 0.85;  # [-] correction for non-parenchyma (large vessels, ...)
  N <- length(x$Vol_sinunit)
  
  ## sum over sinusoidal unit samples
  # total volume (sinusoidal unit volume corrected with tissue factor)
  sum.Vol_sinunit <- sum(x$Vol_sinunit)/f_tissue # [m^3]
  # total flow
  sum.Q_sinunit <- sum(x$Q_sinunit) # [m^3/sec]
  # total removal
  sum.R <- sum(x$R) # [mole/sec]
  
  ## normalize to volume 
  Q_per_vol <- sum.Q_sinunit/sum.Vol_sinunit      # [m^3/sec/m^3(liv)] = [ml/sec/ml(liv)]
  R_per_vol <- sum.R/sum.Vol_sinunit              # [mole/sec/m^3(liv)]
  
  ## biological units
  Q_per_vol_units <- Q_per_vol*60                 # [ml/min/ml(liv)]
  R_per_vol_units <- R_per_vol*60/1000            # [mmole/min/ml(liv)]
  
  ## per standard liver
  Vol_liv <- 1.5E-3      # [m^3]
  Q_per_liv_units <- Q_per_vol_units * Vol_liv*1E6     # [ml/min]
  R_per_liv_units <- R_per_vol_units * Vol_liv*1E6     # [mmole/min]
  
  data.frame(N,
             sum.Vol_sinunit, 
             sum.Q_sinunit, sum.R,
             Q_per_vol, R_per_vol,
             Q_per_vol_units, R_per_vol_units,
             Q_per_liv_units, R_per_liv_units)
}

# point estimate for every of the combinations of 'gal_challenge' & 'f_flow'
d2 <- ddply(parscl, c("gal_challenge", 'f_flow'), f_analyse)
head(d2)

# bootstrap calculation of function
f_bootstrap <- function(dset, funct, B=1000){
  # bootstraping the function on the given dataset
  dset.mean <- f_analyse(dset)
  
  # calculate for bootstrap samples
  N <- nrow(dset)
  dset.boot <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=B))
  names(dset.boot) <- names(dset.mean)
  
  for (k in seq(1,B)){
    # create the sample by replacement
    # these are the indices of the rows to take from the orignal dataframe
    inds <- sample(seq(1,n), size=n, replace=TRUE)
    
    # create the bootstrap data.frame
    df.boot <- dset[inds, ]
    # calculate the values for the bootstrap df
    dset.boot[k, ] <- f_analyse(df.boot)[1, ]
  }
  # now the function can be applied on the bootstrap set
  dset.funct <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=1))
  names(dset.funct) <- names(dset.mean)
  for (i in seq(1,ncol(dset.mean))){
    dset.funct[1,i] <- funct(dset.boot[,i])
  }
  return(dset.funct)
}
# Calculate bootstrap sd for confidence intervals
d2.se <- ddply(parscl, c("gal_challenge", 'f_flow'), f_bootstrap, funct=sd, B=1000)



head(d2) # mean values
head(d2.se) # bootstrap SE

# fit the curves
x <- d2$Q_per_vol_units
y1 <- d2$R_per_vol_units
y2 <- d2.se$R_per_vol_units
f1 <- approxfun(x, y1, method = "linear")
f2 <- splinefun(x, y1)
f2.se <- splinefun(x, y2)
plot(x,y1, ylim=c(0,0.003))
curve(f1, from=0, to=3.5, col='red', add=T)
curve(f2, from=0, to=3.5, col='blue', add=T)
curve(f2.se, from=0, to=3.5, col='blue', add=T)

GEC_curves <- list(d2=d2, d2.se=d2.se)
save(GEC_curves, file.path(ma.settings$dir.expdata, 'processed', 'GEC_curve_T53_bootstrap.Rdata'))



########################################
# Figure GEC ~ perfusion
########################################
startDevPlot <- function(width=1000, height=1000, file=NULL){
  if (is.null(file)){
    file <- file.path(ma.settings$dir.expdata, 'processed', 'GEC_curve.png')
  }
  if (create_plots == T) { 
    print(file)
    png(filename=file, width=width, height=height, 
        units = "px", bg = "white",  res = 170)
  } else { print('No plot files created') }
}
stopDevPlot <- function(){
  if (create_plots == T) { dev.off() }
}

create_plots = F
startDevPlot()
plot(d2$Q_per_vol_units, d2$R_per_vol_units, type='n',main='Galactose clearance ~ perfusion', 
     xlab='Liver perfusion [ml/min/ml]', ylab='GEC per volume tissue [mmol/min/ml]', font=1, font.lab=2)
x <- c(d2$Q_per_vol_units, rev(d2$Q_per_vol_units))
y <- c(d2$R_per_vol_units+2*d2.se$R_per_vol_units, rev(d2$R_per_vol_units-2*d2.se$R_per_vol_units))
polygon(x,y, col = rgb(0,0,0, 0.3), border = NA)
lines(d2$Q_per_vol_units, d2$R_per_vol_units+2*d2.se$R_per_vol_units, col=rgb(0,0,0, 0.8))
lines(d2$Q_per_vol_units, d2$R_per_vol_units-2*d2.se$R_per_vol_units, col=rgb(0,0,0, 0.8))
points(d2$Q_per_vol_units, d2$R_per_vol_units, pch=21, col='black', bg=rgb(0,0,0, 0.8))
lines(d2$Q_per_vol_units, d2$R_per_vol_units, col='black', lwd=2)
legend('bottomright', legend=c('mean GEC (Ns=1000 sinusoidal units)', '+-2SE (bootstrap, Nb=1000)'), 
       lty=c(1, 1), col=c('black', rgb(0,0,0,0.8)), lwd=c(2,1))
stopDevPlot()

###################################################################

# get a subset and do the analysis
dset <- parscl[parscl$f_flow==0.5 & parscl$gal_challenge==8,]

# point estimate
dset.mean <- f_analyse(dset)
head(dset)

# calculate for bootstrap samples
B <- 1000  # number of samples
N <- nrow(dset)
dset.boot <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=B))
names(dset.boot) <- names(dset.mean)
for (k in seq(1,B)){
  # create the sample by replacement
  # these are the indices of the rows to take from the orignal dataframe
  inds <- sample(seq(1,n), size=n, replace=TRUE)
  
  # create the bootstrap data.frame
  df.boot <- dset[inds, ]
  # calculate the values for the bootstrap df
  dset.boot[k, ] <- f_analyse(df.boot)[1, ]
}
head(dset.boot)

hist(dset.boot$R_per_vol_units, xlim=c(0, 0.003))
R_per_vol_units.se <- sd(dset.boot$R_per_vol_units)
cis <- dset.mean$R_per_vol_units + c(-1, 1) * 2*R_per_vol_units.se

dset.mean$R_per_vol_units
R_per_vol_units.se
R_per_vol_units.se/dset.mean$R_per_vol_units
cis

# point estimate
time.mean <- with(CommuteAtlanta, mean(Time))

# do the samples
B <- 100  # number of samples
n <- nrow(CommuteAtlanta)
boot.samples <- matrix(sample(CommuteAtlanta$Time, size=B*n, replace=TRUE), B, n)
dim(boot.samples)

# function should be applied to each row
boot.statistics <- apply(boot.samples, 1, mean)

# plot the results
require(ggplot2)
ggplot(data.frame(meanTime=boot.statistics), aes(x=meanTime)) + geom_histogram(binwidth=0.25, aes(y=..density..)) + geom_density(color='red')

# get the standard deviation of the simulated bootstrap
time.se <- sd(boot.statistics)
print(time.se)
# Finally, construct the confidence interval. Here, I round the margin of error up and to one
# decimal place so that it has two signicant digits, and I am being cautious when rounding not to
# make the interval too small.
cis <- time.mean + c(-1, 1) * 2*time.se
print(cis)










