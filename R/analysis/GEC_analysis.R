################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# Analysis of the galactose elimination simulations with varying
# galactose and varying blood flow.
# Calculation of the mean values for the set of simulations
# provided.
# This analysis only the simulations for the normal case. The
# analysis for the GEC simulations is performed analoque.
#
# Clearance is tested via a galactose challenge periportal. 
# For the calculation of the GEC capacity the metabolic capacity
# has to be saturated (i.e in the high galactose range).
#
# author: Matthias Koenig
# date: 2014-08-25
################################################################
# install.packages('matrixStats')

rm(list=ls())
library(data.table)
library(MultiscaleAnalysis)
library(libSBML)
library(matrixStats)
setwd(ma.settings$dir.results)

# Galactose challenge consists of peak ,
# and subsequent time for reaching steady state ()
t_peak <- 2000 # [s]
t_end <- 10000 # [s]

# Dataset for analyis
#folder <- '2014-08-13_T26'  # normal
#folder <- '2014-08-29_T50'   # normal
# folder <- '2014-11-08_T52'   # normal
folder <- '2014-11-08_T53'   # normal

#pars <- loadParameterFile(file='/home/mkoenig/multiscale-galactose-results/2014-08-27_T50/T50.txt')
#pars <- loadParameterFile(file='/home/mkoenig/multiscale-galactose-results/2014-08-29_T50/T50_Galactose_v24_Nc20_galchallenge_parameters.csv')
# pars <- loadParameterFile(file='/home/mkoenig/multiscale-galactose-results/2014-11-08_T52/T52_Galactose_v24_Nc20_galchallenge_parameters.csv')
pars <- loadParameterFile(file='/home/mkoenig/multiscale-galactose-results/2014-11-08_T53/T53_Galactose_v24_Nc20_galchallenge_parameters.csv')
head(pars)
hist(pars$flow_sin)

source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
       echo=TRUE, local=FALSE)

# boxplot to show the distribution of flows
library('ggplot2')
ggplot(pars, aes(factor(f_flow), flow_sin)) + geom_boxplot() + geom_point()
ggplot(pars, aes(factor(gal_challenge), flow_sin)) + geom_boxplot() + geom_point()
mean(pars$flow_sin[pars$f_flow==0.5])
summary(pars$flow_sin[pars$f_flow==0.5])


# Extend the parameters with the SBML parameters and calculated parameters
ps <- getParameterTypes(pars=pars)
f.sbml <- file.path(ma.settings$dir.results, folder, paste(modelId, '.xml', sep=''))
model <- loadSBMLModel(f.sbml)
pars <- extendParameterStructure(pars=pars, fixed_ps=ps$fixed, model=model)
head(pars)

# calculate the clearance parameters:
parscl <- createClearanceDataFrame(t_peak=2000, t_end=10000)

# reduce to the values with > 0 PP__gal (NAN)
parscl <- parscl[parscl$c_in>0.0, ]
summary(parscl)

# get the clearance parameters for the highest gal challenge
# max(parscl$c_in)
# parscl.max <- parscl[parscl$c_in == max(parscl$c_in), ]
# head(parscl.max)



plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

library('ggplot2')
p <- ggplot(parscl, aes(flow_sin, R, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ gal_challenge)

p <- ggplot(parscl, aes(flow_sin, CL, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ gal_challenge)


p <- ggplot(parscl, aes(flow_sin, ER, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ gal_challenge)


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

d2 <- ddply(parscl, c("gal_challenge", 'f_flow'), f_analyse)
head(d2)
# TODO: save the csv
save('d2', 'parscl', file='/home/mkoenig/Desktop/GEC_curve_T53.Rdata')

###########################################################################
# GEC ~ perfusion 
###########################################################################
# Finally the GEC curves are generated. 
# TODO: save the plots
# TODO: get the prediction intervals via bootstrapping from the distribution

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
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
p1 

p2 <- ggplot(d2, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ gal_challenge)
p2 

# GEC clearance per volume depending on perfusion
p3 <- ggplot(d2, aes(Q_per_vol_units, R_per_liv_units)) + geom_point() + geom_line()+ facet_grid(~ gal_challenge) + ylim(0, 4)
p3 

multiplot(p1, p2, p3, cols=3)


# plot results
boxplot(parscl$Q_sinunit/parscl$Vol_sinunit)

names(parscl)
plot(parscl$c_in, parscl$c_out)
plot(parscl$flow_sin, (parscl$c_in - parscl$c_out)/parscl$c_in)

#####################################
# Bootstrap the resulting GEC curve #
#####################################
# what are the expected values based on different samplings from the same underlying distribution.
# Do a bootstrap analysis
head(parscl)
head(d2)







###########################################################################
# Scale to whole-liver
###########################################################################
# The conversion factor via flux and via volume have to be the same.
# They are calculated based on the weighted distributions of the parameters. 
# But they have to be calculated over the distribution of geometries
# N_Q = Q_liv/Q_sinunit;
# N_Vol = N_Q
# N_Vol = f_tissue*Vol_liv/Vol_sinunit  => f_tissue = N_Vol * Vol_sinunit/Vol_liv
# -20% large vessels

# calculate conversion factors
calculateConversionFactors <- function(pars){
  res <- list()
  f_tissue = 0.75;
  
  # varies depending on parameters
  Q_sinunit.wmean <- wt.mean(pars[['Q_sinunit']], pars$p_sample)
  Q_sinunit.wsd <- wt.sd(pars[['Q_sinunit']], pars$p_sample)
  Vol_sinunit.wmean <- wt.mean(pars[['Vol_sinunit']], pars$p_sample)
  Vol_sinunit.wsd <- wt.sd(pars[['Vol_sinunit']], pars$p_sample)
  
  # constant normal value
  Q_liv.wmean <- wt.mean(pars[['Q_liv']], pars$p_sample)
  Q_liv.wsd <- wt.sd(pars[['Q_liv']], pars$p_sample)
  Vol_liv.wmean <- wt.mean(pars[['Vol_liv']], pars$p_sample)
  Vol_liv.wsd <- wt.sd(pars[['Vol_liv']], pars$p_sample)
  N_Vol = f_tissue*Vol_liv.wmean/Vol_sinunit.wmean
  N_Q1 = Q_liv.wmean/Q_sinunit.wmean
  f_flow = N_Q1/N_Vol
  N_Q = N_Q1/f_flow
  
  cat('N_Q: ', N_Q, '\n')
  cat('N_Vol: ', N_Vol, '\n')
  cat('N_Vol/N_Q1: ', N_Vol/N_Q1, '\n')
  cat('N_Vol/N_Q: ',  N_Vol/N_Q, '\n')
  cat('f_flow: ', f_flow, '\n')
  
  res$N_Q <- N_Q
  res$N_Vol <- N_Vol
  res$f_tissue <- f_tissue
  res$f_flow <- f_flow
  res
}
res <- calculateConversionFactors(pars)
names(res)

###########################################################################
# Scale things to whole liver
###########################################################################
# How do changes in liver size and blood flow change the results
# [A] liver size -> different conversion factor with
# N_Vol.new = N_Vol.alt * Vol_liv.new/Vol_liv.ref 
# => parameters are scaled linearly with the liver volume (i.e. smaller or bigger liver
#     with same constitution)

# [B] changes in global blood flow
# N_Q.new = f_tissue * N_Vol.new
# -> new meanstd & variance for local blood flow
# Q_liv.wmean.new = Q_liv.wmean * N_Q.new/N_Q
# i.e. if the blood flow goes down, than the mean velocity through the sinusoids goes down







###########################################################################
# Create the clearance figures
###########################################################################
# combine the clearance data for a set of simulations

folders <- paste('2014-08-13_T', seq(26, 30), sep='')
clearance <- list()
for (folder in folders){
  df <- createClearanceDataFrame(folder, t_peak=2000, t_end=10000)
  head(df)
  clearance[[folder]] <- df
}

# Merge the data frames for the galactosemias
# and create the factors to plot depending on the galactosemia class
# [0] normal
# [1-8] GALK D
# [9-14] GALT D
# [15-23] GALE D
#def_type <- c('normal', rep('GALK DEF')

library('plyr')
df <- rbind.fill(clearance)

def_names = c("[0] normal",
              "[1] GALK Deficiency (H44Y)",
              "[2] GALK Deficiency (R68C)",
              "[3] GALK Deficiency (A198V)",
              "[4] GALK Deficiency (G346S)",
              "[5] GALK Deficiency (G347S)",
              "[6] GALK Deficiency (G349S)",
              "[7] GALK Deficiency (E43A)",
              "[8] GALK Deficiency (E43G)",
              "[9] GALT Deficiency (R201C)",
              "[10] GALT Deficiency (E220K)",
              "[11] GALT Deficiency (R223S)",
              "[12] GALT Deficiency (I278N)",
              "[13] GALT Deficiency (L289F)",
              "[14] GALT Deficiency (E291V)",
              "[15] GALE Deficiency (N34S)",
              "[16] GALE Deficiency (G90E)",
              "[17] GALE Deficiency (V94M)",
              "[18] GALE Deficiency (D103G)",
              "[19] GALE Deficiency (L183P)",
              "[20] GALE Deficiency (K257R)",
              "[21] GALE Deficiency (L313M)",
              "[22] GALE Deficiency (G319E)",
              "[23] GALE Deficiency (R335H)")
df$deficiency <- factor(df$deficiency,
                  levels = seq(0,23),
                  labels = def_names)
head(df)

# install.packages('ggplot2')
# install.packages('mgcv')
library('ggplot2')
library('mgcv')

# c_in - c_out
g <- ggplot(df, aes(c_in, c_in-c_out))
g1 <- g + geom_abline(intercept=0, slope=1, color="gray") + geom_point(aes(color=flow_sin), alpha=1) + geom_smooth() + facet_grid(.~deficiency) + xlab("Galactose (periportal) [mM]") + ylab("Galactose (periportal-perivenious) [mM]") + coord_cartesian(xlim=c(0, 5.75)) + labs(fill="blood flow [m/s]")
plot(g1)
# Calculate the height and width (in pixels) for a 4x4-inch image at 300 ppi
ppi <- 150
png("/home/mkoenig/tmp/cin_cout.png", width=12*ppi, height=4*ppi, res=ppi)
plot(g1)
dev.off()


# ER
g <- ggplot(df, aes(c_in, ER))
g2 <- g + geom_abline(intercept=1, slope=0, color="gray") + geom_point(aes(color=flow_sin), alpha=1) + geom_smooth() + facet_grid(.~deficiency) + xlab("Galactose (periportal) [mM]") + ylab("Elimination Ratio (ER)") + coord_cartesian(xlim=c(0, 5.75)) + labs(fill="blood flow [m/s]")
plot(g2)
png("/home/mkoenig/tmp/ER.png", width=12*ppi, height=4*ppi, res=ppi)
plot(g2)
dev.off()

# FL * (c_in - c_out)
g <- ggplot(df, aes(c_in, FL*(c_in-c_out)))
g3 <- g + geom_abline(intercept=1, slope=0, color="gray") + geom_point(aes(color=flow_sin), alpha=1) + geom_smooth() + facet_grid(.~deficiency) + xlab("Galactose (periportal) [mM]") + ylab("Elimination Ratio (ER)") + coord_cartesian(xlim=c(0, 5.75)) + labs(fill="blood flow [m/s]")
plot(g3)

# t_half
g <- ggplot(df, aes(c_out, t_half))
g4 <- g + geom_abline(intercept=1, slope=0, color="gray") + geom_point(aes(color=flow_sin), alpha=1) + geom_smooth() + facet_grid(.~deficiency) + xlab("Galactose (perivenious) [mM]") + ylab("t_half [s]") + coord_cartesian(xlim=c(0, 5.75)) + labs(fill="blood flow [m/s]")
plot(g4)
png("/home/mkoenig/tmp/t_half.png", width=12*ppi, height=4*ppi, res=ppi)
plot(g4)
dev.off()






g + geom_point(aes(color=drv), size=4, alpha=1) + geom_smooth(method='lm') + labs(title = "MAACS Cohort") + 

g + geom_point(color="steelblue", size=4, alpha=1/2) + geom_smooth(method='lm') + theme_bw()



# create the figure



qplot(c_in, ER, data=df, color=flow_sin, geom=c("point", "smooth"), facets=.~task)

# modifying aesthetics
qplot(displ, hwy, data=mpg, color=drv)

# adding a geom (smoother)
# points and the smoother
qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))

# histograms
qplot(hwy, data=mpg, fill=drv)

# facets (like panels)
qplot(displ, hwy, data=mpg, facets= .~drv)
qplot(hwy, data=mpg, facets= drv~., binwidth=2)








plot(factor(c_in), c_in-c_out, xlim=c(0,6), ylim=c(0,6))
points(factor(c_out), c_in-c_out, xlim=c(0,6), ylim=c(0,6), col="red")
grid()
library('ggplot2')
qplot(flow_sin, c_out, data = , colour = clarity)




ptest <- parscl
# Created Figure
par(mfrow=c(2,2))
  plot(ptest$c_in, ptest$GE, xlab="periportal galactose [mmol/l]", ylab="Galactose Elimination (GE) [mmol/l]")
  plot(ptest$flow_sin, ptest$GE, xlab="sinusoidal blood flow [µm/sec]", ylab="Galactose Elimination (GE) [mmol/l]")
  plot(ptest$FL, ptest$ER, xlab="sinusoidal blood flow [µm/sec]", ylab="Extraction Ratio (ER) [-]")
  plot(ptest$FL, ptest$CL, xlab="sinusoidal blood flow [µm/sec]", ylab="Clearance (CL) [µm/sec]") 
par(mfrow=c(1,1))

plot(ptest$CL)
summary(ptest$CL)


par(mfrow=c(1,2))
plot(ptest$c_in, ptest$GE, xlab="periportal galactose [mmol/l]", ylab="Galactose Elimination (GE) [mmol/l]")
plot(ptest$flow_sin, ptest$GE, xlab="sinusoidal blood flow [µm/sec]", ylab="Galactose Elimination (GE) [mmol/l]")
par(mfrow=c(1,1))

par(mfrow=c(1,2))
plot(ptest$FL, ptest$ER, xlab="sinusoidal blood flow [µm/sec]", ylab="Extraction Ratio (ER) [-]")
plot(ptest$FL, ptest$CL, xlab="sinusoidal blood flow [µm/sec]", ylab="Clearance (CL) [µm/sec]") 
par(mfrow=c(1,1))


plot(ptest$c_in, ptest$GE, xlab="periportal galactose [mmol/l]", ylab="Galactose Elimination (GE) [mmol/l]")
# plot the ones connected which are similar



#install.packages('lattice')
data <- list()
data$x = ptest$c_in
data$y = ptest$flow_sin
data$z = ptest$GE
# data$z = ptest$ER
# data$z <- ptest$CL
zlab <- 'GE'

library(lattice)
wireframe(z ~ x * y, data=data, xlab="PP galactose [mM]", ylab="blood flow",
          zlab="GE")
p <- wireframe(z ~ x * y, data=data, xlab="PP galactose [mM]", ylab="blood flow",zlab=zlab)
npanel <- c(4, 2)
rotx <- c(-50, -80)
rotz <- seq(30, 300, length = npanel[1]+1)
update(p[rep(1, prod(npanel))], layout = npanel,
       panel = function(..., screen) {
         panel.wireframe(..., screen = list(z = rotz[current.column()],
                                            x = rotx[current.row()]))
       })



inds <- which(pars$flow_sin==2e-04)
inds
points(ptest$c_in[inds], ptest$GE[inds], col='blue')
head(pars)

######################################
plot(pars$flow_sin, (c_in-c_out)/c_in)

index = which( abs(pars$flow_sin-200E-6)<1E-10)
index
pars[index, ]
plot(c_in[index], c_in[index]-c_out[index])
plot(pars$flow_sin[index], (c_in[index]-c_out[index])/c_in[index])
summary(pars$flow_sin)


###############################################################
# Experimental data (Schirmer1986) #
# TODO: [mcg/ml] -> [mmole/L]
create_plot_files = T

# load the experimental data Schirmer1986 from csv
folder = "/home/mkoenig/multiscale-galactose/experimental_data/GEC"
names = c("Fig1", "Fig2", "Fig4", "Fig6")

if (create_plot_files == T){
  png(filename=paste("Galactose_Extraction.png", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(2,2))

# Galactose  GE
# [mcg/ml]  [mcg/min/100g]
fig1 <- read.csv(paste(folder, "/", "Schirmer1986_Fig1.csv", sep=""))
plot(fig1$Galactose, fig1$GE, xlab="galactose [mcg/ml]", ylab="GE [mcg/min/100g]", xlim=c(0.0, 700), ylim=c(0.0, 700) )

# per_Galactose  per_GE
# [ml/mcg *1E4]  [100g*min/mcg*1E4]
fig2 <- read.csv(paste(folder, "/", "Schirmer1986_Fig2.csv", sep=""))
plot(fig2$per_Galactose, fig2$per_GE, xlab="1/galactose [ml/mcg*1E4]", ylab="1/GE [100g*min/mcg*1E4]", xlim=c(-20, 50), ylim=c(0.0, 70))

# Vmax_per_FKm  ER
# [-]  [-]
fig4 <- read.csv(paste(folder, "/", "Schirmer1986_Fig4.csv", sep=""))
plot(fig4[,1], fig4[,2], xlab="Vmax/FKm [-]", ylab="ER [-]", xlim=c(0.0, 5.0), ylim=c(0.0, 1.0))

# Flow  Clearance  ER
# [ml/min/100gm]	[-]	[-]
fig6 <- read.csv(paste(folder, "/", "Schirmer1986_Fig6.csv", sep=""))
plot(fig6[,1], fig6[,2], col="blue", xlab="Flow [ml/min/100gm]", ylab="Clearance [-] | ER [-]", xlim=c(0.0, 50), ylim=c(0.0, 1.0) )
points(fig6[,1], fig6[,3], col="red")

par(mfrow=c(1,1))
if (create_plot_files == T){
  dev.off()
}
###############################################################
