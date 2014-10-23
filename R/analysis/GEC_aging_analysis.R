################################################################
## GEC in aging
################################################################
# Changes of GEC in aging, with perfusion, ...
# Combine the datasets into the graphs and provide different views 
# depending on gender.
#
# author: Matthias Koenig
# date: 2014-04-17
###############################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))
# gender color (all, male, female)
gender.levels <- c('all', 'male', 'female')
gender.cols = c(rgb(0,0,0, alpha=0.5), rgb(0,0,1, alpha=0.5), rgb(1,0,0, alpha=0.5))
gender.symbols = c(21, 22, 23)

##############################################
# Read datasets
##############################################
f_liver_density = 1.08  # [g/ml] conversion between volume and weight

# sex, age, liverVolume
alt1962 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Altman1962.csv"), sep="\t")
alt1962$gender <- as.character(alt1962$sex)
alt1962$gender[alt1962$gender=='M'] <- 'male'
alt1962$gender[alt1962$gender=='F'] <- 'female'
alt1962$volLiver <- alt1962$liverWeight/f_liver_density * 1000; # [ml]
alt1962$volLiverSd <- NA
head(alt1962)

# age [years], volLiver [ml], BSA [m^2], volLiverPerBSA [ml/m^2]
bac1981 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Bach1981_Tab2.csv"), sep="\t")
bac1981$gender <- as.character(bac1981$sex)
bac1981$gender[bac1981$gender=='U'] <- 'all'
head(bac1981)

# age [years], sex [M,F], liverWeight [g]
boy1933 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Boyd1933_Fig1.csv"), sep="\t")
boy1933$gender <- as.character(boy1933$sex)
boy1933$gender[boy1933$gender=='M'] <- 'male'
boy1933$gender[boy1933$gender=='M'] <- 'female'
boy1933$volLiver <- boy1933$liverWeight/f_liver_density; # [ml]
head(boy1933)

# age [years], sex [M,F], BSA [m^2], liverBloodFlow [ml/min]
bra1945 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Bradley1945.csv"), sep="\t")
bra1945$gender <- as.character(bra1945$sex)
bra1945$gender[bra1945$gender=='M'] <- 'male'
bra1945$gender[bra1945$gender=='F'] <- 'female'
bra1945$flowLiver <- bra1945$liverBloodFlow
head(bra1945)

# weight [kg], liverWeight [kg], liverWeightSd [kg]
del1968.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "DeLand1968_Fig1.csv"), sep="\t")
del1968.fig1$gender <- as.character(del1968.fig1$sex)
del1968.fig1$gender[del1968.fig1$gender=='M'] <- 'male'
del1968.fig1$gender[del1968.fig1$gender=='F'] <- 'female'
del1968.fig1$bodyweight <- del1968.fig1$weight
del1968.fig1$volLiver <- del1968.fig1$liverWeight/f_liver_density * 1000; # [ml]
del1968.fig1$volLiverSd <- del1968.fig1$liverWeightSd/f_liver_density * 1000; # [ml]
del1968.fig1$n <- 10  # n estimated, ~ 10 in every class
head(del1968.fig1)

# height [cm], liverWeight [kg], liverWeightSd [kg]
del1968.fig3 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "DeLand1968_Fig3.csv"), sep="\t")
del1968.fig3$gender <- as.character(del1968.fig3$sex)
del1968.fig3$gender[del1968.fig3$gender=='M'] <- 'male'
del1968.fig3$gender[del1968.fig3$gender=='F'] <- 'female'
del1968.fig3$volLiver <- del1968.fig3$liverWeight/f_liver_density * 1000; # [ml]
del1968.fig3$volLiverSd <- del1968.fig3$liverWeightSd/f_liver_density * 1000; # [ml]
del1968.fig3$n <- 10  # n estimated, ~ 10 in every class
head(del1968.fig3)

# BSA [m^2], liverWeight [kg], liverWeightSd [kg]
del1968.fig4 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "DeLand1968_Fig4.csv"), sep="\t")
del1968.fig4$gender <- as.character(del1968.fig4$sex)
del1968.fig4$gender[del1968.fig4$gender=='M'] <- 'male'
del1968.fig4$gender[del1968.fig4$gender=='F'] <- 'female'
del1968.fig4$volLiver <- del1968.fig4$liverWeight/f_liver_density * 1000; # [ml]
del1968.fig4$volLiverSd <- del1968.fig4$liverWeightSd/f_liver_density * 1000; # [ml]
del1968.fig4$n <- 10  # n estimated, ~ 10 in every class
head(del1968.fig4)

# age [years], bodyweight [kg], GEC [mmol/min], GEC [mmol/min/kg] 
duc1979 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Ducry1979_Tab1.csv"), sep="\t")
duc1979$study <- 'duc1979'
duc1979$gender <- 'all'
head(duc1979)

# age [years], sex [M,F], GECmg [mg/min/kg], GEC [mmol/min/kg] 
# age [years], gender [male, female], GECkg [mmole/min/kg]
duf2005 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Dufour2005_Tab1.csv"), sep="\t")
duf2005$GECkg <- duf2005$GECmg/180
duf2005$gender <- as.character(duf2005$sex)
duf2005$gender[duf2005$gender=='M'] <- 'male'
duf2005$gender[duf2005$gender=='F'] <- 'female'
duf2005$study <- 'duf2005'
duf2005 <- duf2005[duf2005$state=='normal', ]
head(duf2005)

# sex [M,F], height [cm], liverWeight [kg] 
gra2000.tab1 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Grandmaison2000_Tab1.csv"), sep="\t")
gra2000.tab1$gender <- as.character(gra2000.tab1$sex)
gra2000.tab1$gender[gra2000.tab1$gender=='M'] <- 'male'
gra2000.tab1$gender[gra2000.tab1$gender=='F'] <- 'female'
gra2000.tab1$height <- gra2000.tab1$heightMean
gra2000.tab1$volLiver <- gra2000.tab1$liverWeight/f_liver_density * 1000; # [ml]
gra2000.tab1$volLiverSd <- gra2000.tab1$liverWeightSd/f_liver_density * 1000; # [ml]
head(gra2000.tab1)

# sex [M,F], bmi [kg/m^2], liverWeight [kg] 
gra2000.tab2 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Grandmaison2000_Tab2.csv"), sep="\t")
gra2000.tab2$gender <- as.character(gra2000.tab2$sex)
gra2000.tab2$gender[gra2000.tab2$gender=='M'] <- 'male'
gra2000.tab2$gender[gra2000.tab2$gender=='F'] <- 'female'
gra2000.tab2$volLiver <- gra2000.tab2$liverWeight/f_liver_density * 1000; # [ml]
gra2000.tab2$volLiverSd <- gra2000.tab2$liverWeightSd/f_liver_density * 1000; # [ml]
head(gra2000.tab2)

# digitized BSA [m^2], liverVol [ml]
# hei1999 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Heinemann1999.csv"), sep="\t")
# hei1999$gender <- as.character(hei1999$sex)
# hei1999$gender[hei1999$gender=='U'] <- 'all'
# hei1999$volLiver <- hei1999$liverVol
# head(hei1999)
hei1999 <- read.csv(file.path(ma.settings$dir.expdata, "heinemann", "Heinemann1999.csv"), sep="\t")
# remove outliers found by graphical analysis
outliers.1 <- which((hei1999$liverWeight<500) & (hei1999$age>5))
outliers.2 <- which((hei1999$liverWeight>1500) & (hei1999$liverWeight<2000) & (hei1999$age<10))
outliers.3 <- which((hei1999$BSA_DuBois<0.5) & (hei1999$liverWeight/hei1999$bodyweight<20))
outliers <- c(outliers.1, outliers.2, outliers.3)
hei1999 <- hei1999[-outliers, ]

hei1999$study <- 'hei1999'
hei1999$gender <- as.character(hei1999$sex)
hei1999$gender[hei1999$gender=='M'] <- 'male'
hei1999$gender[hei1999$gender=='F'] <- 'female'
hei1999$volLiver <- hei1999$liverWeight/f_liver_density  # [ml]
hei1999$volLiverkg <- hei1999$volLiver/hei1999$bodyweight # [ml/kg]
hei1999$BSA <- hei1999$BSA_DuBois # use the DuBois calculation
head(hei1999)

# age [years], sex [M,F], cardiac_output [L/min], liver blood flow [L/min]
ircp2001.co <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "IRCP2001_CO.csv"), sep="\t")
ircp2001.co$gender <- as.character(ircp2001.co$sex)
ircp2001.co$gender[ircp2001.co$gender=='M'] <- 'male'
ircp2001.co$gender[ircp2001.co$gender=='F'] <- 'female'
ircp2001.co$flowLiver <- ircp2001.co$liverBloodflowEst * 1000    # [ml/min]
head(ircp2001.co)

# age [years], GEC [µmol/min/kg]
lan2011 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Lange2011_Fig1.csv"), sep="\t")
lan2011$study = 'lan2011'
lan2011$gender = 'all'
lan2011$GECmumolkg <- lan2011$GEC
lan2011$GECkg <- lan2011$GEC/1000
lan2011 <- lan2011[lan2011$status=='healthy', ]
head(lan2011)

# age [years], GEC (galactose elimination capacity) [mmol/min], 
# HVI (hepatic volumetric index) [units], volLiver [cm^3]
mar1988 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Marchesini1988_Fig.csv"), sep="\t")
mar1988 <- data.frame(subject=mar1988$subject, 
                      age=mar1988$age,
                      GEC=mar1988$GEC,
                      HVI=mar1988$HVI[order(mar1988$subject)],
                      volLiver=mar1988$volLiver[order(mar1988$subject)])
mar1988$study = 'mar1988'
mar1988$gender = 'all'
head(mar1988)

# age [years], sex [M,F], bodyweight [kg], BSA [kg/m^2], liverVol [ml], height [cm] 
naw1998 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Nawaratne1998_Tab1.csv"), sep="\t")
naw1998$gender <- as.character(naw1998$sex)
naw1998$gender[naw1998$gender=='M'] <- 'male'
naw1998$gender[naw1998$gender=='F'] <- 'female'
naw1998$volLiver <- naw1998$liverVol
naw1998$volLiverkg <- naw1998$volLiver/naw1998$bodyweight # [ml/kg]
head(naw1998)

# sex [M, F], age [years], bodyweight [kg], height [cm], BSA [m^2], flowLiver [ml/min]
sch1945 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Sherlock1945.csv"), sep="\t")
sch1945$gender <- as.character(sch1945$sex)
sch1945$gender[sch1945$gender=='M'] <- 'male'
sch1945$gender[sch1945$gender=='F'] <- 'female'
sch1945$flowLiver <- sch1945$liverBloodflow
sch1945$flowLiverkg <- sch1945$flowLiver/sch1945$bodyweight
head(sch1945)

# sex [m,f], age [years], bodyweight [kg], GEC [mg/min/kg]
sch1986.tab1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Tab1.csv"), sep="\t")
sch1986.tab1$study <- 'sch1986'
sch1986.tab1$gender <- as.character(sch1986.tab1$sex)
sch1986.tab1$gender[sch1986.tab1$gender=='m'] <- 'male'
sch1986.tab1$gender[sch1986.tab1$gender=='f'] <- 'female'
sch1986.tab1$GECmgkg <- sch1986.tab1$GEC
sch1986.tab1$GEC <- sch1986.tab1$GECmgkg * sch1986.tab1$bodyweight/180; # [mg/min/kg -> mmol/min]
sch1986.tab1$GECkg <- sch1986.tab1$GECmgkg/180
head(sch1986.tab1)

# age [years], GEC [mg/min/kg]
sch1986.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Schnegg1986_Fig1.csv"), sep="\t")
sch1986.fig1$study <- 'sch1986'
sch1986.fig1$gender <- 'all'
sch1986.fig1$GECmgkg <- sch1986.fig1$GEC
sch1986.fig1$GECkg   <- sch1986.fig1$GEC/180
head(sch1986.fig1)

# age [years], bodyweight [kg], volLiver [ml], volLiverkg [ml/kg]
swi1978 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Swift1978_Tab1.csv"), sep="\t")
swi1978$study <- 'swi1978'
swi1978$gender <- 'all'
swi1978$age <- 0.5*(swi1978$minAge + swi1978$maxAge)
swi1978 <- swi1978[1:2, ] # remove hospitalized cases
head(swi1978)

# sex [M], age [years], bodyweight [kg], liverWeight [kg]
tom1965 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Thompson1965.csv"), sep="\t")
tom1965$gender <- as.character(tom1965$sex)
tom1965$gender[tom1965$gender=='M'] <- 'male'
tom1965$gender[tom1965$gender=='F'] <- 'female'
tom1965$volLiver <- tom1965$liverWeight/f_liver_density * 1000; # [ml]
tom1965$volLiverSd <- tom1965$liverWeightSd/f_liver_density * 1000; # [ml]
head(tom1965)

# age [years], bodyweight [kg], GEC [mmol/min]
tyg1962 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1962.csv"), sep="\t")
tyg1962$GECkg <- tyg1962$GEC/tyg1962$bodyweight
tyg1962$study = 'tyg1962'
tyg1962$gender = 'all'
tyg1962 <- tyg1962[tyg1962$state=='healthy', ]
head(tyg1962)

# BSA [m^2], liverVol [ml]
ura1995 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Urata1995.csv"), sep="\t")
ura1995$gender <- as.character(ura1995$sex)
ura1995$gender[ura1995$gender=='U'] <- 'all'
ura1995$volLiver <- ura1995$liverVol
head(ura1995)

# BSA [m^2], liverVol [ml]
vau2002.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Vauthey2002_Fig1.csv"), sep="\t")
vau2002.fig1$gender <- as.character(vau2002.fig1$sex)
vau2002.fig1$gender[vau2002.fig1$gender=='U'] <- 'all'
vau2002.fig1$volLiver <- vau2002.fig1$liverVol
head(vau2002.fig1)

# bodyweight [kg], liverVol [ml]
vau2002.fig2 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Vauthey2002_Fig2.csv"), sep="\t")
vau2002.fig2$gender <- as.character(vau2002.fig2$sex)
vau2002.fig2$gender[vau2002.fig2$gender=='U'] <- 'all'
vau2002.fig2$volLiver <- vau2002.fig2$liverVol
head(vau2002.fig2)

# sex [male,female], age [years], weight [kg], GEC [mmol/min], bloodFlowM1 [ml/min], bloodFlowM2 [ml/min],
# flowLiver [ml/min]
win1965 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Winkler1965.csv"), sep="\t")
win1965 <- win1965[!is.na(win1965$GEC), ]
win1965$flowLiver <- 0.5 * (win1965$bloodflowM1 + win1965$bloodflowM2)
win1965$bodyweight <- win1965$weight
win1965$flowLiverkg <- win1965$flowLiver/win1965$bodyweight
win1965$gender <- as.character(win1965$sex)
win1965$study <- 'win1965'
head(win1965)

# gender [male, female], age [years], liver volume [ml]
wyn1989 <- read.csv(file.path(ma.settings$dir.expdata, "wynne", "Wynne1989_corrected.csv"), sep="\t")
wyn1989$volLiver <- wyn1989$livVolume
wyn1989$volLiverkg <- wyn1989$livVolumekg
wyn1989$flowLiver <- wyn1989$livBloodflow
wyn1989$flowLiverkg <- wyn1989$livBloodflowkg
wyn1989$gender <- as.character(wyn1989$sex)
wyn1989$gender[wyn1989$gender=='M'] <- 'male'
wyn1989$gender[wyn1989$gender=='F'] <- 'female'
wyn1989$study <- 'wyn1989'
head(wyn1989)

# age [years], liver bloodflow [ml/min]
wyn1990 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Wynne1990.csv"), sep="\t")
wyn1990$gender <- as.character(wyn1990$sex)
wyn1990$gender[wyn1990$gender=='U'] <- 'all'
wyn1990$flowLiver <- wyn1990$liverBloodflow
head(wyn1990)

# BSA [m^2], liverWeight [g]
yos2003 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Yoshizumi2003.csv"), sep="\t")
yos2003$gender <- as.character(yos2003$sex)
yos2003$gender[yos2003$gender=='U'] <- 'all'
yos2003$volLiver <- yos2003$liverWeight/f_liver_density ; # [ml]
head(yos2003)

# BSA [m^2], liverWeight [g]
yos2003 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Yoshizumi2003.csv"), sep="\t")
yos2003$gender <- as.character(yos2003$sex)
yos2003$gender[yos2003$gender=='U'] <- 'all'
yos2003$volLiver <- yos2003$liverWeight/f_liver_density ; # [ml]
head(yos2003)

# age [years], FHF (functional hepatic flow) [ml/min]
zol1993 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Zoller1993.csv"), sep="\t")
zol1993$gender <- as.character(zol1993$sex)
zol1993$gender[zol1993$gender=='M'] <- 'male'
zol1993$gender[zol1993$gender=='F'] <- 'female'
zol1993$flowLiverkg <- zol1993$liverBloodflowPerBodyweight
head(zol1993)

# age [years], FHF (functional hepatic flow) [ml/min]
zol1999 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Zoli1999.csv"), sep="\t")
zol1999$gender <- as.character(zol1999$sex)
zol1999$gender[zol1999$gender=='U'] <- 'all'
zol1999$flowLiver <- zol1999$FHF
head(zol1999)


############################################################################################
# Linear regression template
############################################################################################
linear_regression <- function(data, xname, yname){
  # do linear regression
  formula <- as.formula(paste(yname, '~', xname))
  m1 <- lm(formula, data=data)
  
  # Create output file with log information
  name = paste(yname, 'vs', xname) 
  log.file <- file.path(ma.settings$dir.results, 'regression', 
                        paste(name, '.txt', sep=""))
  sink.file <- file(log.file, open = "wt")
  sink(sink.file)
  sink(sink.file, type="message")  
  # TODO better logging
  print('### Data ###')
  print(summary(data))
  print('### Linear Regression Model ###')
  print(summary(m1))
  sink(type="message")
  sink()
  return(m1)
}

############################################################################################
# Helper functions
############################################################################################
makeFigureFull <- function(data, m1, xname, yname, create_plots=F){
  xlab <- lab[[xname]]; ylab <- lab[[yname]]
  xlim <- lim[[xname]]; ylim <- lim[[yname]]
  main <- sprintf('%s vs. %s', yname, xname)
  makeFigure(data, m1, main, xname, yname, xlab, ylab, xlim, ylim, create_plots)
}

makeFigure <- function(data, m1, main, xname, yname, 
                                   xlab, ylab, 
                                   xlim, ylim, create_plots=F){
  name = paste(yname, 'vs', xname) 
  if (create_plots == TRUE){
    plot.file <- file.path(ma.settings$dir.results, 'regression', 
                           paste(name, '.png', sep=""))
    print(plot.file)               
    png(filename=plot.file,
        width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
  }
  
  plot(numeric(0), numeric(0), xlim=xlim, ylim=ylim, 
       main=main, xlab=xlab, ylab=ylab)
  # plot the individual gender data
  for (k in 1:length(gender.levels)){
    inds <- which(data$gender == gender.levels[k])
    # better plot
    
    points(data[inds, xname], data[inds, yname], col=gender.cols[k], bg=gender.cols[k], 
           pch=gender.symbols[k], cex=0.8)  
    
  }
  legend("topright",  legend=gender.levels, fill=gender.cols) 
  # legend("topleft",  legend=gender.levels, fill=gender.cols) 
  
  # Plot linear regression information
  if (!is.null(m1)){
    # plot regression line
    abline(m1)
  
    # get the confidence intervals for the betas
    newx <- seq(min(data[[xname]]), max(data[[xname]]), length.out = 100)
    newx.df <- as.data.frame(newx)
    names(newx.df) <- c(xname)
  
    # conf.interval <- predict(m1, interval="confidence") 
    conf.interval <- predict(m1, newdata=newx.df, interval="confidence") 
    lines(newx, conf.interval[,2], lty=2)
    lines(newx, conf.interval[,3], lty=2)
  
    # get prediction intervals
    for (level in c(0.682, 0.95)){
      pred.interval <- predict(m1, newdata=newx.df, interval="prediction", level=level) 
      lines(newx, pred.interval[,2], lty=3, col='blue')
      lines(newx, pred.interval[,3], lty=3, col='blue') 
    }
    
    # residual standard error
    RSE <- sqrt(deviance(m1)/df.residual(m1))
    
    # plot equation
    info <- sprintf('y = %3.4f * x %+3.4f\n RSE = %3.4f\n n = %d', m1$coefficients[2], m1$coefficients[1], RSE, length(m1$residuals))
    text(x=0.5*(xlim[2]+xlim[1]), 
         y=(ylim[1] + 0.05*(ylim[2]-ylim[1])), labels = info)
  }
  if (create_plots==TRUE){ dev.off() }
  # makeQualityFigure(m1, xname, yname, create_plots=T)
}

################################
# Mean & SD data
################################
# Takes mean data and generates individual data points from them.
# Simplified use of mean data to include in fitting procedure.
# n data points are generated 
addRandomizedMeanData <- function(data, newdata){
  xname <- names(data)[3]
  yname <- names(data)[4]
  
  freq <- newdata$n
  sds <- newdata[, paste(yname, 'Sd', sep="")]
  for (k in 1:nrow(newdata)){
    n <- freq[k]
    
    study <- rep(newdata$study[k], n)
    gender <- rep(newdata$gender[k], n)
    
    # replicate the data point n times
    # unsolved issue is how to handle the 
    #       generation (otherwise the variance of the estimation is too small
    # problems with reproduciblity, due to random generation of samples from 
    # distribution
    x <- rep(newdata[k, xname], n)
    assign(xname, x)
    
    y <- rep(newdata[k, yname], n)
    # y <- rnorm(n, mean=newdata[k, xname], sd=sds[k])
    assign(yname, y)
    
    df <- data.frame(study, gender, get(xname), get(yname))
    names(df) <- c('study', 'gender', xname, yname)
    data <- rbind(data, df)
  }
  return(data)
}

# Saves data.frame as csv and R data
saveData <- function(data, dir=NULL){
  if (is.null(dir)){
    dir <- file.path(ma.settings$dir.expdata, "processed")
  }
  xname <- names(data)[3]
  yname <- names(data)[4]
  r_fname <- file.path(dir, sprintf('%s_%s.Rdata', yname, xname))
  csv_fname <- file.path(dir, sprintf('%s_%s.csv', yname, xname))

  print( sprintf('%s vs. %s -> %s', yname, xname, r_fname) )
  print( sprintf('%s vs. %s -> %s', yname, xname, csv_fname) )
  save('data', file=r_fname)
  write.table(file=csv_fname, x=data, na="NA", row.names=FALSE, quote=FALSE,
            sep="\t", col.names=TRUE)
}

############################################
# GEC [mmol/min] vs. age [years]
############################################
xname <- 'age'; yname <- 'GEC'
selection <- c('study', 'gender', xname, yname)
# individual subject data
data <- rbind( mar1988[, selection],
               tyg1962[, selection],
               sch1986.tab1[, selection],
               win1965[, selection],
               duc1979[, selection])
# data$frequency <- 1; data$Sd <- NA    # only count once, no standard deviation
data <- data[complete.cases(data), ]  # remove NA
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# GECkg [mmol/min/kgbw] vs. age [years]
############################################
xname <- 'age'; yname <- 'GECkg'
selection <- c('study', 'gender', xname, yname)
data <- rbind( lan2011[, selection],
               duc1979[, selection],
               tyg1962[, selection],
               sch1986.fig1[, selection], 
               # sch1986.tab1[, c('study', 'gender', 'age', 'GECkg')], # already ploted via sch1986.fig1
               duf2005[, selection])
data <- data[complete.cases(data), ]  # remove NA
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# GEC [mmol/min] vs. volLiver [ml]
############################################
xname <- 'volLiver'; yname <- 'GEC'
selection <- c('study', 'gender', xname, yname)
data <- rbind( mar1988[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# GEC [mmol/min] vs. flowLiver [ml/min]
############################################
xname <- 'flowLiver'; yname <- 'GEC'
selection <- c('study', 'gender', xname, yname)
data <- rbind( win1965[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# volLiver [ml] vs. age [years]
############################################
xname <- 'age'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind( mar1988[, selection],
               wyn1989[, selection],
               naw1998[, selection],
               boy1933[, selection],
               hei1999[, selection])
data <- addRandomizedMeanData(data, tom1965)
data <- addRandomizedMeanData(data, alt1962)
table(data$study)
saveData(data)
m1 <- NULL
makeFigureFull(data, m1, xname, yname)

# mean data from Thompson1965
head(tom1965)
for (k in 1:nrow(tom1965)){
  sex <- tom1965$gender[k]
  col <- gender.cols[which(gender.levels == sex)]
  segments(tom1965$ageMin[k], tom1965$volLiver[k],  
           tom1965$ageMax[k], tom1965$volLiver[k], col=col)
  segments(tom1965$age[k], tom1965$volLiver[k]+tom1965$volLiverSd[k],
           tom1965$age[k], tom1965$volLiver[k]-tom1965$volLiverSd[k], col=col)
}

############################################
# volLiverkg [ml/kg] vs. age [years]
############################################
xname <- 'age'; yname <- 'volLiverkg'
selection <- c('study', 'gender', xname, yname)
data <- rbind(wyn1989[, selection] ,
              naw1998[, selection], 
              hei1999[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# volLiver [ml] vs. BSA [m^2]
############################################
xname <- 'BSA'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind(naw1998[, selection],
              hei1999[, selection],
              ura1995[, selection],
              vau2002.fig1[, selection],
              yos2003[,selection])
data <- addRandomizedMeanData(data, del1968.fig4)
saveData(data)

m1 <- NULL
makeFigureFull(data, m1, xname, yname)

for (k in 1:nrow(del1968.fig4)){
  # horizontal
  sex <- del1968.fig4$gender[k]
  col <- gender.cols[which(gender.levels == sex)]
  segments(del1968.fig4$BSAMin[k], del1968.fig4$volLiver[k],  
           del1968.fig4$BSAMax[k], del1968.fig4$volLiver[k], col=col)
  # vertical
  segments(del1968.fig4$BSA[k], del1968.fig4$volLiver[k]+del1968.fig4$volLiverSd[k],
           del1968.fig4$BSA[k], del1968.fig4$volLiver[k]-del1968.fig4$volLiverSd[k], col=col)
}

############################################
# volLiver [ml] vs. bodyweight [kg]
############################################
xname <- 'bodyweight'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind(naw1998[, selection],
              vau2002.fig2[, selection],
              wyn1989[, selection],
              hei1999[, selection])
data <- addRandomizedMeanData(data, del1968.fig1)
data <- addRandomizedMeanData(data, tom1965)
saveData(data)
m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

for (k in 1:nrow(del1968.fig1)){
  # horizontal
  sex <- del1968.fig1$gender[k]
  col <- gender.cols[which(gender.levels == sex)]
  segments(del1968.fig1$weightMin[k], del1968.fig1$volLiver[k],  
           del1968.fig1$weightMax[k], del1968.fig1$volLiver[k], col=col)
  # vertical
  segments(del1968.fig1$bodyweight[k], del1968.fig1$volLiver[k]+del1968.fig1$volLiverSd[k],
           del1968.fig1$bodyweight[k], del1968.fig1$volLiver[k]-del1968.fig1$volLiverSd[k], col=col)
}
for (k in 1:nrow(tom1965)){
  sex <- tom1965$gender[k]
  col <- gender.cols[which(gender.levels == sex)]
  segments(tom1965$bodyweight[k]-tom1965$bodyweightSd[k], tom1965$volLiver[k],  
           tom1965$bodyweight[k]+tom1965$bodyweightSd[k], tom1965$volLiver[k], col=col)
  segments(tom1965$bodyweight[k], tom1965$volLiver[k]+tom1965$volLiverSd[k],
           tom1965$bodyweight[k], tom1965$volLiver[k]-tom1965$volLiverSd[k], col=col)
}

############################################
# volLiver [ml] vs. height [cm]
############################################
xname <- 'height'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind(naw1998[, selection],
              hei1999[, selection])
data <- addRandomizedMeanData(data, del1968.fig3)
data <- addRandomizedMeanData(data, gra2000.tab1)
saveData(data)

m1 <- NULL
makeFigureFull(data, m1, xname, yname)

for (k in 1:nrow(del1968.fig3)){
  # horizontal
  sex <- del1968.fig3$gender[k]
  col <- gender.cols[which(gender.levels == sex)]
  segments(del1968.fig3$heightMin[k], del1968.fig3$volLiver[k],  
           del1968.fig3$heightMax[k], del1968.fig3$volLiver[k], col=col)
  # vertical
  segments(del1968.fig3$height[k], del1968.fig3$volLiver[k]+del1968.fig3$volLiverSd[k],
           del1968.fig3$height[k], del1968.fig3$volLiver[k]-del1968.fig3$volLiverSd[k], col=col)
}

for (k in 1:nrow(gra2000.tab1)){
  # horizontal
  sex <- gra2000.tab1$gender[k]
  col <- gender.cols[which(gender.levels == sex)]
  segments(gra2000.tab1$heightMin[k], gra2000.tab1$volLiver[k],  
           gra2000.tab1$heightMax[k], gra2000.tab1$volLiver[k], col=col)
  # vertical
  segments(gra2000.tab1$height[k], gra2000.tab1$volLiver[k]+gra2000.tab1$volLiverSd[k],
           gra2000.tab1$height[k], gra2000.tab1$volLiver[k]-gra2000.tab1$volLiverSd[k], col=col)
}

############################################
# volLiver [ml] vs. flowLiver [ml/min]
############################################
xname <- 'flowLiver'
yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind(wyn1989[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiver [ml/min] vs. age [years]
############################################
xname <- 'age'; yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind( win1965[, selection],
               wyn1989[, selection],
               bra1945[, selection],
               zol1999[, selection],
               sch1945[, selection],
               wyn1990[, selection],
               ircp2001.co[, selection])
saveData(data)

m1 <- NULL
makeFigureFull(data, m1, xname, yname)
# grid()

############################################
# flowLiverkg [ml/min/kg] vs. age [years]
############################################
xname <- 'age'; yname <- 'flowLiverkg'
selection <- c('study', 'gender', xname, yname)
data <- rbind( win1965[, selection],
               wyn1989[, selection],
               sch1945[, selection],
               zol1993[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiver [ml/min] vs. bodyweight [kg]
############################################
xname <- 'bodyweight'; yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind( wyn1989[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# perfusion [ml/min/ml] vs. age [years]
############################################
xname <- 'age'; yname <- 'perfusion'
selection <- c('study', 'gender', xname, yname)
data <- rbind( wyn1989[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiver [ml/min] vs. BSA [m^2]
############################################
xname <- 'BSA'
yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind(bra1945[, selection],
              sch1945[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiver [ml/min] vs. volLiver [ml]
############################################
xname <- 'volLiver'
yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname)
data <- rbind(wyn1989[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)
