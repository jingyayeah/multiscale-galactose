################################################################
## Creates GE curves for prediction
################################################################
# Creates the spline fit curves of GE depending on perfusion
# (and GE)
#
# author: Matthias Koenig
# date: 2015-02-13
################################################################

rm(list=ls())
library('MultiscaleAnalysis')
library('libSBML')
setwd(ma.settings$dir.base)
do_plot = FALSE

# Preprocess raw data and integrate over the sinusoidal units
factors <- c('f_flow', "gal_challenge")
fs <- get_age_GE_folders()
tmp <- integrate_GE_folders(df_folders=fs, factors=factors) 
parscl <- tmp$parscl
dfs <- tmp$dfs
rm(tmp)

# In the plots the individual data points for the simulated 
# steady state galactose levels and flows
gal_levels <- as.numeric(levels(as.factor(dfs[[1]]$gal_challenge )))
gal_levels
f_levels <- as.numeric(levels(as.factor(dfs[[1]]$f_flow)))
f_levels

# Create the subset for interpolation/fitting
GE_dfs <- lapply(dfs, subset_GE)
names(GE_dfs) <- names(dfs)

# Akima interpolation
library(akima)
library(rgl)

# interpp points:
data = as.list(GE_dfs[[1]])
names(data) <- c("x", "y", "z") # gal, P, GE
head(data)

rgl.spheres(data$x, data$z, data$y, 0.05, color="red")
rgl.bbox()

# bivariate linear interpolation
# interp:
akima.li <- interp(data$x, data$y, data$z,
                   xo=seq(min(data$x), max(data$x), length = 100),
                   yo=seq(min(data$y), max(data$y), length = 100))
# interp surface:
rgl.surface(akima.li$x, akima.li$y, akima.li$z, color="green",alpha=c(0.5))

# interpp:
# i.e. interpolation of new data
akima.p <- interpp(data$x, data$y, data$z,
                   runif(200,min(data$x),max(data$x)),
                   runif(200,min(data$y),max(data$y)))
# interpp points:
rgl.points(akima.p$x,akima.p$z, akima.p$y,size=5,color="yellow")

# bivariate cubic spline interpolation
# interp:
akima.si <- interp(data$x, data$y, data$z,
                   xo=seq(min(data$x), max(data$x), length = 100),
                   yo=seq(min(data$y), max(data$y), length = 100),
                   linear = FALSE, extrap = TRUE)

interp.new
akima.si <- with(data, interp(x,2*y,z, linear=FALSE, extrap=TRUE))
str(akima.si)
akima.si$z

test <- interp(rnorm(10),rnorm(10),rnorm(10), linear=FALSE, extrap=TRUE)
str(test)

# interp surface:
with(test, rgl.surface(x, y, z, color="blue", alpha=c(0.5)))
# interpp:
akima.sp <- interpp(data$x, data$y, data$z,
                    runif(200,min(data$x),max(data$x)),
                    runif(200,min(data$y),max(data$y)),
                    linear = FALSE, extrap = TRUE)
# interpp points:
rgl.points(akima.sp$x,akima.sp$z, akima.sp$y,size=4,color="yellow")




# Apply multivariate spline fitting to the response curves.
# For the different ages different 2D splines are fitted. 
# An age dependent interpolation is performed to calculate the response
# according to age.

# f(P, ci, age) = f(perfusion, galactose, age)
# via fage(P, ci)



ages <- as.numeric(gsub("normal", "", names(dfs)))
models <- fit_GE_models(GE_dfs)
lapply(models, summary)


m <- crs(GE~P+gal, 
         # lambda=c(5, 5),
         # degree=c(3,3),
         basis="tensor",
         data=GE_dfs[[1]]) 
plot_GE_model(m, GE_dfs[[1]])

P = seq(from=0.1, to=2.0, by=0.1) 
gal = rep(8, length(P))
predict(m, newdata=data.frame(P, gal))
plot(P, predict(m, newdata=data.frame(P, gal)))
points(GE_dfs[[1]]$P, GE_dfs[[1]]$GE, col='blue')
plot(m)

# Plot GE response curves
par(mfrow=c(3,3))
for (k in 1:3){
  m <- models[[k]]
  df <- GE_dfs[[k]]
  plot_GE_model(m, df)
}
for (k in 1:3){
  m <- models[[k]]
  df <- GE_dfs[[k]]
  p <- predict(m, newdata=df)
  plot(df$GE, (p-df$GE)/df$GE*100)  
}
for (k in 1:3){
  m <- models[[k]]
  df <- GE_dfs[[k]]
  p <- predict(m, newdata=df)
  plot(df$gal, (p-df$GE)/df$GE*100)  
}
par(mfrow=c(1,1))


# Get the response function
f1 <- create_GE_function(models, ages)
test <- f1(P=1, gal=8, age=NA)
test[1]
test <- f1(P=1, gal=8, age=20)
test[1]
test <- f1(P=1, gal=8, age=80)
test[1]
test <- f1(P=1, gal=8, age=100)
test[1]

test <- f1(P=2, gal=2, age=20)
test[1]
test <- f1(P=2, gal=2, age=100)
test[1]

test <- f1(P=c(0.1, 0.2, 0.3), gal=rep(2,3), age=100)
test

P = seq(from=0.1, to=2.4, by=0.1) 
gal = rep(8, length(P))
plot(P, f1(P, gal, age=20))
points(GE_dfs[[1]]$P, GE_dfs[[1]]$GE, col='blue')




## Prediction of data
num.eval=50
x1.seq <- seq(min(x1),max(x1),length=num.eval)
x2.seq <- seq(min(x2),max(x2),length=num.eval)
x.grid <- expand.grid(x1.seq,x2.seq)
newdata <- data.frame(x1=x.grid[,1],x2=x.grid[,2])

y0.mat <- matrix(predict(model,newdata=newdata),num.eval,num.eval)
y0 <- predict(model,newdata=newdata)




# TODO: necessary to calculate the various GE curves
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)
calculate_GEC_curves(folder, force=FALSE, B=10)

##########################################
# CRS spline fitting
##########################################
library('crs')

## Estimate a model with specified degree, segments, and bandwidth
x1 <- d$gal
x2 <- d$P
y <- d$GE
model <- crs(y~x1+x2,degree=c(5,5),
             segments=c(1,1),
             lambda=0.1,
             cv="none",
             kernel=TRUE)

model <- crs(y~x1+x2)
summary(model)

## Prediction of data
num.eval=50
x1.seq <- seq(min(x1),max(x1),length=num.eval)
x2.seq <- seq(min(x2),max(x2),length=num.eval)
x.grid <- expand.grid(x1.seq,x2.seq)
newdata <- data.frame(x1=x.grid[,1],x2=x.grid[,2])

y0.mat <- matrix(predict(model,newdata=newdata),num.eval,num.eval)
y0 <- predict(model,newdata=newdata)

dnew <- data.frame(gal=x.grid[,1], P=x.grid[,2], GE=y0)
head(dnew)
library(lattice)
p <- wireframe(GE ~ gal * P, data=dnew)
npanel <- c(4, 2)
rotx <- c(-50, -80)
rotz <- seq(30, 300, length = npanel[1]+1)
update(p[rep(1, prod(npanel))], layout = npanel,
       panel = function(..., screen) {
         panel.wireframe(..., screen = list(z = rotz[current.column()],
                                            x = rotx[current.row()]))
       })
summary(dnew)

par(new=FALSE)
pmat = persp(x=x1.seq,y=x2.seq, z=y0.mat,
      xlab="x1",ylab="x2",zlab="y",
      ticktype="detailed",      
      border="gray",
      theta=45,phi=45)
# check the difference between model and prediction
points(trans3d(x1, x2, y, pmat))

y1 <- predict(model,newdata=data.frame(x1, x2))
par(mfrow=c(2,1))
plot(y, y-y1)
plot(y, y1)
par(mfrow=c(1,1))



persp(x=x1.seq,y=x2.seq, z=y0.mat-0.2,
      xlab="x1",ylab="x2",zlab="y",
      ticktype="detailed",      
      border="gray",
      theta=45,phi=45, new=FALSE)


##########################################
# MGCV gam - spline fitting
##########################################
library(mgcv)

# test data
N = 20
x <- seq(0, 2.5, length.out=N)
y <- seq(0, 8.0, length.out=N)
x = rep(x, each=N)
y = rep(y, N)
dnew <- data.frame(P=x, gal=y)


# Now proper spline fitting

## isotropic thin plate spline smoother
b <- gam(GE~s(P, gal), data=d)
dnew$z <- predict(b, newdata=dnew)

## tensor product smoother
b <- gam(GE~te(PE, gal))
dnew$z <- predict(b,newdata=dnew)

## pure regression splines
b <- gam(GE~s(P, gal, k=10), data=d)
dnew$z <- predict(b, newdata=dnew)

library(lattice)
p <- wireframe(z ~ x * y, data=dnew)
npanel <- c(4, 2)
rotx <- c(-50, -80)
rotz <- seq(30, 300, length = npanel[1]+1)
update(p[rep(1, prod(npanel))], layout = npanel,
               panel = function(..., screen) {
                 panel.wireframe(..., screen = list(z = rotz[current.column()],
                                                    x = rotx[current.row()]))
})
          
## variant tensor product smoother
b <- gam(Y~t2(X[,1],X[,2]))
predict(b,newdata=list(X=W))

# ... these would all result in penalized regression spline fits with
# smoothing parameters estimated (by GCV, by default). If you don't want
# penalization then use, e.g. s(X[,1],X[,2],fx=TRUE) to get pure
# regression spline (`k' argument to s, te and t2 controls spline basis
# dimension --- see docs).



#' Create the GEC functions from the given GEC task data.
#' The functions have to be calculated based on the subsets.
#'
#'@export
GEC_functions <- function(){
  # Load the GEC data points
  load(file=GEC_curve_file(task))
  d.mean <- GEC_curves$d.mean
  d.se <- GEC_curves$d.se
  
  # create spline fits
  Qvol <- d.mean$Q_per_vol_units     # perfusion [ml/min/ml]
  Rvol <- d.mean$R_per_vol_units     # GEC clearance [mmol/min/ml]
  Rvol.se <- d.se$R_per_vol_units    # GEC standard error (bootstrap) [mmol/min/ml]
  f <- splinefun(Qvol, Rvol)
  f.se <- splinefun(Qvol, Rvol.se)  
  
  return(list(f=f, f.se=f.se, d.mean=d.mean, d.se=d.se))
}

#' Plot single GEC function.
#' 
#' @export
plot_GEC_function <- function(GEC_f){
  f <- GEC_f$f
  f.se <- GEC_f$f.se
  d.mean <- GEC_f$d.mean
  d.se <- GEC_f$d.se
  
  x <- d.mean$Q_per_vol_units
  y <- d.mean$R_per_vol_units
  y.se <- d.se$R_per_vol_units
  
  plot(x, y, type='n',main='Galactose clearance ~ perfusion', 
       xlab='Liver perfusion [ml/min/ml]', ylab='GEC per volume tissue [mmol/min/ml]', font=1, font.lab=2, ylim=c(0,1.5*max(y)))
  
  x.grid <- seq(from=0, to=max(x), length.out=100)
  fx <- f(x.grid)
  fx.se <- f.se(x.grid)
  
  xp <- c(x.grid, rev(x.grid))
  yp <- c(fx+2*fx.se, rev(fx-2*fx.se))
  polygon(xp,yp, col = rgb(0,0,0, 0.3), border = NA)
  # lines(x, y+2*y.se, col=rgb(0,0,0, 0.8))
  # lines(x, y-2*y.se, col=rgb(0,0,0, 0.8))
  points(x, y, pch=21, col='black', bg=rgb(0,0,0, 0.8))
  # lines(x, y, col='black', lwd=2)
  # add spline functions
  
  lines(x.grid, fx, col='blue', lwd=2)
  lines(x.grid, fx+2*fx.se, col='black')
  lines(x.grid, fx-2*fx.se, col='black')
  
  legend('topleft', legend=c('mean GEC (Ns=1000 sinusoidal units)', '+-2SE (bootstrap, Nb=1000)',
                             'GEC spline function'), 
         lty=c(1, 1, 1), col=c('black', rgb(0,0,0,0.8), 'blue'), lwd=c(2,1,2))
}











###########################################################################
# DEPRECIATED

#' Bootstrap of the calculation function.
#' The number of samples in the bootstrap corresponds to the available samples.
#' @export
f_integrate_GEC_bootstrap <- function(dset, funct, B=1000){
  # bootstraping the function on the given dataset
  dset.mean <- f_integrate_GEC(dset)
  
  # calculate for bootstrap samples
  N <- nrow(dset)
  dset.boot <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=B))
  names(dset.boot) <- names(dset.mean)
  
  for (k in seq(1,B)){
    # create the sample by replacement
    # these are the indices of the rows to take from the orignal dataframe
    inds <- sample(seq(1,N), size=N, replace=TRUE)
    
    # create the bootstrap data.frame
    df.boot <- dset[inds, ]
    # calculate the values for the bootstrap df
    dset.boot[k, ] <- f_integrate_GEC(df.boot)[1, ]
  }
  # now the function can be applied on the bootstrap set
  dset.funct <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=1))
  names(dset.funct) <- names(dset.mean)
  for (i in seq(1,ncol(dset.mean))){
    dset.funct[1,i] <- funct(dset.boot[,i])
  }
  return(dset.funct)
}


#' Calculate GE curves with bootstrap
#' 
#' Integrates over the available simulations and calculates the individual
#' GEC for the combinations of provided factors.
#' Folders have the format: 
#' 
#' @export
calculate_GEC_curves <- function(folder, t_peak=2000, t_end=10000, 
                                 factors=c('f_flow', "gal_challenge", "N_fen", 'scale_f'),
                                 # factors=c('f_flow', "N_fen", 'scale_f'),
                                 force=FALSE, B=1000){
  # Test if folder exists
  fname <- file.path(ma.settings$dir.results, folder)
  if (!file.exists(fname)){
    stop(sprintf('Folder does not exist: %s', fname)) 
  }
  
  # Process the integration time curves
  processed <- preprocess_task(folder=folder, force=force) 
  
  # Calculate the galactose clearance parameters
  parscl <- extend_with_galactose_clearance(processed=processed, t_peak, t_end=t_end)
  
  # Perform analysis split by factors.
  # Generates the necessary data points for the interpolation of the GEC
  # curves and creates an estimate of error via bootstrap.
  cat('Calculate mean GEC\n')
  d.mean <- ddply(parscl, factors, f_integrate_GEC)
  cat('Calculate se GEC (bootstrap)\n')
  d.se <- ddply(parscl, factors, f_integrate_GEC_bootstrap, funct=sd, B=B)
  
  # save the GEC curves 
  GEC_curves <- list(d.mean=d.mean, d.se=d.se)
  GEC.file <- GEC_curve_file(processed$info[['task']])
  cat(GEC.file, '\n')
  save('parscl', 'GEC_curves', file=GEC.file)  
  
  return( list(parscl=parscl, GEC_curves=GEC_curves, GEC.file=GEC.file) )
}


################################################################
## Galactose Clearance & Elimination Curves (Expression Changes)
################################################################


###########################################################################
# Control plots for GEC curves
###########################################################################
# ???
plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

p1 <- ggplot(parscl, aes(flow_sin, R, colour=c_out)) + geom_point() +facet_grid(f_flow ~ N_fen)
p2 <- ggplot(parscl, aes(flow_sin, CL, colour=c_out)) + geom_point() +facet_grid(f_flow ~ N_fen)
p3 <- ggplot(parscl, aes(flow_sin, ER, colour=c_out)) + geom_point() + facet_grid(f_flow ~ N_fen)
multiplot(p1, p2, p3, cols=3)

# Plot the generated GEC curves
head(d2)
p1 <- ggplot(d2, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p2 <- ggplot(d2, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p3 <- ggplot(d2, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ N_fen)
multiplot(p1, p2, p3, cols=3)
d2
