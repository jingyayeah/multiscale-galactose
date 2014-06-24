################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# Analysis of the galactose elimination simulations with varying
# galactose and varying blood flow
#
# author: Matthias Koenig
# date: 2014-06-11
################################################################
rm(list=ls())
library(data.table)
library(libSBML)
library(matrixStats)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
ma.settings$simulator <- 'ROADRUNNER'

###############################################################
# Calculate the clearance parameters 
###############################################################
# get the last timepoint of the component
getLastTimepoint <- function(mat, name){
  data <- mat[[name]]
  dims <- dim(data)
  res <- data[dims[1],]
}

createClearanceDataFrame <- function(task, pars, parsfile){
  outfile <- outfileFromParsFile(parsfile)
  load(outfile)
  
  c_in <- getLastTimepoint(preprocess.mat, 'PP__gal')
  c_out <- getLastTimepoint(preprocess.mat, 'PV__gal')
  
  # F = flow_sin              # [µm/sec]
  # c_in = 'PP__gal'[end]     # [mmol/l]
  # c_out = 'PV_gal[end]'          # [mmol/l]
  # R = F*(c_in - c_out)      # [m/sec * mmol/l]
  # ER = (c_in - c_out)/c_in  # [-]
  # CL = R/c_in               # [µm/sec]
  # GE = (c_in - c_out) 
  
  parscl <- pars
  parscl$task <- task
  FL <- parscl$flow_sin
  parscl$FL <- FL 
  parscl$c_in <- c_in
  parscl$c_out <- c_out
  
  parscl$R <- FL * (c_in - c_out)
  parscl$ER <- (c_in - c_out)/c_in
  parscl$CL <- FL * (c_in - c_out)/c_in
  parscl$GE <- (c_in - c_out)
  
  parscl <- parscl[parscl$c_in>0.0, ]
}

###########################################################################
# Create the clearance data
# - preprocessing has to be finished at this timepoint
###########################################################################
date = '2014-06-11'
modelId <- paste('GalactoseComplete_v21_Nc20_Nf1')
tasks <- c(1,4)

clearance <- list()
for (k in tasks){
  task <- paste('T', k, sep='')
  sname <- paste(date, '_', task, sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))
  pars <- loadParameterFile(file=parsfile)
  plotParameterHistogramFull(pars)                      
  
  df <- createClearanceDataFrame(task, pars, parsfile)
  clearance[[task]] <- df
}

install.packages('plyr')
library('plyr')

head(clearance[[1]])
# merge the 2 data frames 
df <- rbind.fill(clearance)
summary(df)
df$task <- factor(df$task,
                  levels = c('T1','T2','T3'),
                  labels = c("normal", "GALK Deficiency (H44Y)", "GALK Deficiency (?)"))
summary(df)


library('ggplot2')
qplot(c_in, c_in-c_out, data=df, color=flow_sin, geom=c("point", "smooth"), facets=.~task, 
      xlab='Galactose (periportal) [mM]', ylab='Galactose (periportal-perivenious) [mM]')
# plot the line
g <- ggplot(df, aes(c_in, c_in-c_out))
summary(g)

g1 <- g + geom_abline(intercept=0, slope=1, color="gray") + geom_point(aes(color=flow_sin), alpha=1) + geom_smooth() + facet_grid(.~task) + xlab("Galactose (periportal) [mM]") + ylab("Galactose (periportal-perivenious) [mM]") + coord_cartesian(xlim=c(0, 5.75)) + labs(fill="blood flow [m/s]")
plot(g1)

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
