################################################################################
# Reproducing Wynne1989
################################################################################
# 
# author: Matthias Koenig
# date: 15-10-2014
################################################################################

rm(list=ls())
library(MultiscaleAnalysis)
setwd("/home/mkoenig/multiscale-galactose/experimental_data/Wynne")
# name <- 'Wynne1989'
# wyn1989 <- read.csv(file.path(ma.settings$dir.expdata, "Wynne", "Wynne1989.csv"), sep="\t")
name <- 'Wynne1989_corrected'
wyn1989 <- read.csv(file.path(ma.settings$dir.expdata, "Wynne", "Wynne1989_corrected.csv"), sep="\t")
head(wyn1989)
summary(wyn1989)

# symbols and colors
colors <- rep('gray', nrow(wyn1989))
split(colors, wyn1989$sex)<- c('red', 'blue')
symbols <- rep(1, nrow(wyn1989))
split(symbols, wyn1989$sex)<- c(19, 25)

# plot helpers
create_plots = T
startDevPlot <- function(name, width=1500, height=1000, file=NULL){
  if (is.null(file)){
    file <- sprintf('plots/%s.png', name)
  }
  if (create_plots == T) { 
    print(file)
    png(filename=file, width=width, height=height, 
        units = "px", bg = "white",  res = 150)
  }
}
stopDevPlot <- function(){
  if (create_plots == T) { dev.off() }
}

## Create the figures ## 
startDevPlot(paste(name, 'fig2', sep="_"))
par(mfrow=c(1,2))
plot(wyn1989$age, wyn1989$livVolume, col=colors, pch=symbols,
     xlab='Age [years]', ylab='Liver volume [ml]',
     xlim=c(0,95), ylim=c(0,2000) )
grid()
plot(wyn1989$age, wyn1989$livVolumekg, col=colors, pch=symbols,
     xlab='Age [years]', ylab='Liver volume per body weight [ml/kg]',
     xlim=c(0,95), ylim=c(0,30) )
grid()
par(mfrow=c(1,1))
stopDevPlot()

startDevPlot(paste(name, 'fig3', sep="_"))
par(mfrow=c(1,2))
plot(wyn1989$age, wyn1989$livBloodflow, col=colors, pch=symbols,
     xlab='Age [years]', ylab='Liver blood flow [ml/min]',
     xlim=c(0,95), ylim=c(0,2500) )
grid()
plot(wyn1989$age, wyn1989$livBloodflowkg, col=colors, pch=symbols,
     xlab='Age [years]', ylab='Liver blood flow per body weight [ml/min/kg]',
     xlim=c(0,95), ylim=c(0,34) )
grid()
par(mfrow=c(1,1))
stopDevPlot()

startDevPlot(paste(name, 'fig4', sep="_"), width=700)
plot(wyn1989$age, wyn1989$perfusion, col=colors, pch=symbols,
     xlab='Age [years]', ylab='Liver perfusion [ml/min/ml]',
     xlim=c(0,95), ylim=c(0,1.7) )
grid()
stopDevPlot()
