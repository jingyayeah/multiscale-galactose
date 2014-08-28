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

# Galactose challenge, with galactosemias (peal at t0=2000[s], end of simulation
# t=10000[s])

# load parameter structure
#folder <- '2014-08-13_T26'  # normal

folder <- '2014-08-27_T1'  # normal flow

source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
       echo=TRUE, local=FALSE)

# The data is split via the f_flow (variation in flow)
head(pars)
library('ggplot2')
ggplot(pars, aes(factor(f_flow), flow_sin)) + geom_boxplot()  

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
max(parscl$c_in)
parscl.max <- parscl[parscl$c_in == max(parscl$c_in), ]
head(parscl.max)

plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

# Calculate the clearance based on the 
f_flow = 0.2
# parscl.max <- parscl[(parscl$c_in==max(parscl$c_in) && parscl$f_flow==f_flow), ]
parscl.max <- parscl[parscl$f_flow==f_flow, ]
head(parscl.max)

# Part of the liver is large vessels. This has to be corrected for.
f_tissue <- 0.80;
Vol_liv <- parscl$Vol_liv[1]
Vol_liv

# total flow samples
test <- list()
test$sum.Q_sinunit <- sum(parscl.max$Q_sinunit)     # [m^3/sec]
test$sum.Vol_sinunit <- sum(parscl.max$Vol_sinunit) # [m^3]
test$sum.R <- sum(parscl.max$R)                     # [mole/sec]

test$Q_sinunit_per_vol <- sum(parscl.max$Q_sinunit)/sum(parscl.max$Vol_sinunit) # [m^3/sec/m^3(liv)] = [ml/sec/ml(liv)]
test$R_per_vol <- sum(parscl.max$R)/sum(parscl.max$Vol_sinunit)                 # [mole/sec/m^3(liv)]

test$Q_sinunit_per_vol_units <- test$Q_sinunit_per_vol*60  # [ml/min/ml(liv)]
test$R_per_vol_units <- test$R_per_vol*60/1000             # [mmole/min/ml(liv)]

test$Q_sinunit_per_liv_units <- test$Q_sinunit_per_vol_units * Vol_liv*1E6     # [ml/min]
test$R_per_liv_units <- test$R_per_vol*60 * Vol_liv*1E3                        # [mmole/min]

test$Q_sinunit_tissue_per_liv_units <- test$Q_sinunit_per_vol_units * Vol_liv*1E6 *f_tissue     # [ml/min]
test$R_tissue_per_liv_units <- test$R_per_vol*60 * Vol_liv*1E3              *f_tissue     # [mmole/min]
test



boxplot(parscl$Q_sinunit/parscl$Vol_sinunit)

names(parscl)
plot(parscl$c_in, parscl$c_out)
plot(parscl$flow_sin, (parscl$c_in - parscl$c_out)/parscl$c_in)





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
