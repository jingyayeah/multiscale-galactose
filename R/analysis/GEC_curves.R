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
f_levels <- as.numeric(levels(as.factor(dfs[[1]]$f_flow)))
gal_levels
f_levels


# Akima interpolation
# Linear or cubic spline interpolation for irregular gridded data
# install.packages('akima')
# install.packages('rgl')
library(akima)
library(rgl)

# create data structure for interpolation
# Create the subset for interpolation/fitting
GE_dfs <- lapply(dfs, subset_GE)
names(GE_dfs) <- names(dfs)

# data structures for bicubic spline
GE_mats <- list()
for (name in names(GE_dfs)){
  print(name)
  df <- GE_dfs[[name]]
  GE_mats[[name]] <- xyz2matrix(df[[1]], df[[2]], df[[3]])
}
str(GE_mats)

# Create the age depenent interpolation functions
f_GE_interpolated <- function(mat){
  force(mat) # !handle the lazy evaluation
  f_GE <- function(gal, P){
    res <- bicubic(mat$xm, mat$ym, mat$zm, x0=gal, y0=P)
    names(res) <- c('gal', 'P', 'GE')
    return(res)
  }
}

# Create the interpolation functions (20, 60, 100 years)
f1 <- f_GE_interpolated(GE_mats[[1]])
f2 <- f_GE_interpolated(GE_mats[[2]])
f3 <- f_GE_interpolated(GE_mats[[3]])
f_GES_age <- list(f1, f2, f3)
names(f_GES_age) <- names(GE_mats)
# test
for (f in f_GES_age){
  print(f(1, 1)$GE)
} 

# Factory for the GE function based on the age interpolation
# functions.
f_GE_factory <- function(f_GES){
  f_GE <- function(gal, P, age){
    GE20 <- f_GES$normal20(gal, P)$GE
    GE60 <- f_GES$normal60(gal, P)$GE
    GE100 <- f_GES$normal100(gal, P)$GE
    # cat('20 :', GE20, '\n')
    # cat('60 :', GE60, '\n')
    # cat('100 :', GE100, '\n')
  
    # age 20 default
    if (is.na(age)){
      return(GE20)
    }
    
    # interpolate between the age
    if (age<=20){
      res <- GE20
    } else if (age>20 & age<=60){
      res <- GE20 + (GE60-GE20) * (age-20)/(60-20)
    } else if (age>60 & age<=100){
      res <- GE60 + (GE100-GE60) * (age-60)/(100-60)
    } else if (age > 100){
      res <- f_GES$normal100(gal, P)
    } 
    return(res)   
  }
}

# Here the prediction function is created
f_GE <- f_GE_factory(f_GES_age)

# Save for reuse
fname <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
save(f_GE, file=fname)


# Create some control plots
# TODO
gal <- seq(from=0, to=8.0, by=0.5)
test20 <- rep(NA, length(gal))
test60 <- rep(NA, length(gal))
test100 <- rep(NA, length(gal))
for (k in 1:length(test20)){
  test20[k] <- f_GE(gal=gal[k], P=1, age=20)  
  test60[k] <- f_GE(gal=gal[k], P=1, age=60)  
  test100[k] <- f_GE(gal=gal[k], P=1, age=100)  
}
plot(gal, test20, bg='black', pch=21)
points(gal, test60, bg='gray', pch=21)
points(gal, test100, bg="red", pch=21)

# Test function for prediction
rm(list=ls())
fname <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
load(file=fname)
f_GE(gal=8.0, P=1, age=20)*1500




