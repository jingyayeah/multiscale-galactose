################################################################################
# Heinemann1999
################################################################################
# Basic analyis of the data
# 
# author: Matthias Koenig
# date: 15-10-2014
################################################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd("/home/mkoenig/multiscale-galactose/experimental_data")
hei1999 <- read.csv(file.path(ma.settings$dir.expdata, "heinemann", "Heinemann1999.csv"), sep="\t")
head(hei1999)

##########################
# Outliers
##########################
# outliers found by graphical analysis
outliers.1 <- which((hei1999$liverWeight<500) & (hei1999$age>5))
outliers.2 <- which((hei1999$liverWeight>1500) & (hei1999$liverWeight<2000) & (hei1999$age<10))
outliers.3 <- which((hei1999$BSA_DuBois<0.5) & (hei1999$liverWeight/hei1999$bodyweight<20))
outliers <- c(outliers.1, outliers.2, outliers.3)

##########################
# Plot helpers
##########################
colors <- rep('gray', nrow(hei1999))
split(colors, hei1999$sex)<- c(rgb(1,0,0, alpha=0.5), rgb(0,0,1, alpha=0.5))
symbols <- rep(1, nrow(hei1999))
split(symbols, hei1999$sex)<- c(19, 25)

create_plots = T
startDevPlot <- function(name, width=1500, height=1000, file=NULL){
    if (is.null(file)){
        file <- sprintf('%s.png', name)
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

startDevPlot(name='heinemann/Heinemann1999_Fig1', height=1000, width=1500)
par(mfrow=c(2,3))
plot(liverWeight~age, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Age [years]', ylab='Liver weight [g]',
     xlim=c(0,100), ylim=c(0,4000) )
points(liverWeight~age, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~height, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Height [cm]', ylab='Liver weight [g]',
     xlim=c(0,220), ylim=c(0,4000) )
points(liverWeight~height, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~bodyweight, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Body weight [kg]', ylab='Liver weight [g]',
     xlim=c(0,130), ylim=c(0,4000) )
points(liverWeight~bodyweight, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~BSA_DuBois, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Body surface area [m^2]', ylab='Liver weight [g]',
     xlim=c(0,3), ylim=c(0,4000) )
points(liverWeight~BSA_DuBois, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~BMI, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='BMI (Body mass index) [kg/m^2]', ylab='Liver weight [g]',
     xlim=c(0,40), ylim=c(0,4000) )
points(liverWeight~BMI, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
abline(v=30, col='grey', lwd=1.0)
abline(v=25, col='grey', lwd=1.0)
abline(v=18.5, col='grey', lwd=1.0)
grid()

plot(liverWeight/bodyweight~BSA_DuBois, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Body surface area [m^2]', ylab='Liver weight per body weight [g/kg]',
     xlim=c(0,3), ylim=c(0,100) )
points(liverWeight/bodyweight~BSA_DuBois, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()
par(mfrow=c(1,1))
stopDevPlot()


# Figure 2
startDevPlot(name='heinemann/Heinemann1999_Fig2', height=1000, width=1000)
plot(BMI~age, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='age [years]', ylab='BMI (Body mass index) [kg/m^2]', 
     xlim=c(0,100), ylim=c(0,40) )
points(BMI~age, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
abline(h=30, col='grey', lwd=1.0)
abline(h=25, col='grey', lwd=1.0)
abline(h=18.5, col='grey', lwd=1.0)
stopDevPlot()


#################################################
# Modeling
#################################################


