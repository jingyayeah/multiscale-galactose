################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# Analysis of the galactose elimination simulations with varying
# galactose and varying blood flow
#
# author: Matthias Koenig
# date: 2014-06-11
################################################################
# install.packages('matrixStats')
rm(list=ls())
library(data.table)
library(MultiscaleAnalysis)
library(libSBML)
library(matrixStats)

setwd(ma.settings$dir.results)

###############################################################
# Calculate the clearance parameters 
###############################################################
createClearanceDataFrame <- function(folder, t_peak=2000, t_end=10000){
  # loads the x list for the folder
  source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
         echo=TRUE, local=FALSE)
  
  # steady state values for the ids
  mlist <- createApproximationMatrix(ids=ids, simIds=simIds, points=c(t_end), reverse=FALSE)
  
  # half maximal time, i.e. time to reach half steady state value
  t_half <- rep(NA, length(simIds))
  names(t_half) <- simIds
  Nsim <- length(simIds)
  # interpolate the half maximal time
  for(ks in seq(Nsim)){
    # fit the point
    points <- c( 0.5*mlist$PV__gal[[ks]] )
    data.interp <- approx(x$PV__gal[[ks]][, 2], x$PV__gal[[ks]][, 1], xout=points, method="linear")
    t_half[ks] <- data.interp[[2]] - t_peak
  }
  
  # Clearance parameters for the system #
  #-------------------------------------
  # F = flow_sin              # [µm/sec]
  # c_in = 'PP__gal'[end]     # [mmol/L]
  # c_out = 'PV_gal[end]'          # [mmol/L]
  # R = F*(c_in - c_out)      # [m/sec * mmol/l]
  # ER = (c_in - c_out)/c_in  # [-]
  # CL = R/c_in               # [µm/sec]
  # GE = (c_in - c_out) 
  
  c_in <- as.vector(mlist$PP__gal)   # [mmol/L]
  c_out <- as.vector(mlist$PV__gal)  # [mmol/L]
  FL <- pi*(pars$y_sin^2) * pars$flow_sin  # [µm^3/sec]
  
  parscl <- pars
  parscl$t_half <- as.vector(t_half)
  parscl$FL <- FL
  parscl$c_in <- c_in
  parscl$c_out <- c_out
  
  parscl$R <- FL * (c_in - c_out)
  parscl$ER <- (c_in - c_out)/c_in
  parscl$CL <- FL * (c_in - c_out)/c_in
  parscl$GE <- (c_in - c_out)
  
  # reduce to the values with > 0 PP__gal (NAN)
  parscl <- parscl[parscl$c_in>0.0, ]
  return(parscl)
}

# Galactose challenge, with galactosemias (peal at t0=2000[s], end of simulation
# t=10000[s])
folder <- '2014-08-13_T27'  # GDEF1
parscl <- createClearanceDataFrame(folder, t_peak=2000, t_end=10000)


###########################################################################
# Create the clearance figures
###########################################################################
# combine the clearance data for a set of simulations

folders <- paste('2014-08-13_T', seq(26, 30), sep='')
clearance <- list(length(folders))
for (folder in folders){
  
  df <- createClearanceDataFrame(folder, t_peak=2000, t_end=10000)
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



library('ggplot2')

g <- ggplot(df, aes(c_in, c_in-c_out))
g1 <- g + geom_abline(intercept=0, slope=1, color="gray") + geom_point(aes(color=flow_sin), alpha=1) + geom_smooth() + facet_grid(.~deficiency) + xlab("Galactose (periportal) [mM]") + ylab("Galactose (periportal-perivenious) [mM]") + coord_cartesian(xlim=c(0, 5.75)) + labs(fill="blood flow [m/s]")
plot(g1)

ggplot(df, aes(x=interaction(c_in, c_in), y=c_in-c_out)) + geom_boxplot()
g2 <- g + geom_boxplot()
plot(g2)

svg("/home/mkoenig/tmp/test.svg", width=8, height=4)
plot(g1)
dev.off()

ppi <- 150
# Calculate the height and width (in pixels) for a 4x4-inch image at 300 ppi
png("/home/mkoenig/tmp/test.png", width=8*ppi, height=4*ppi, res=ppi)
plot(g1)
dev.off()


g <- ggplot(df, aes(c_in, ER))
g1 <- g + geom_abline(intercept=1, slope=0, color="gray") + geom_point(aes(color=flow_sin), alpha=1) + geom_smooth() + facet_grid(.~task) + xlab("Galactose (periportal) [mM]") + ylab("Elimination Ratio (ER)") + coord_cartesian(xlim=c(0, 5.75)) + labs(fill="blood flow [m/s]")
plot(g1)
svg("/home/mkoenig/tmp/test2.svg", width=8, height=4)
plot(g1)
dev.off()
ppi <- 150
# Calculate the height and width (in pixels) for a 4x4-inch image at 300 ppi
png("/home/mkoenig/tmp/test2.png", width=8*ppi, height=4*ppi, res=ppi)
plot(g1)
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
