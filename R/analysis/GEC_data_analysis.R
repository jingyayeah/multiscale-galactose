################################################################
## Data analysis & dataset combination for GEC modeling
################################################################
# Loading, preprocessing & combination of datasets for prediction 
# and for fitting of regression models.
# Here the experimental data is prepared to use in models.
#
# author: Matthias Koenig
# date: 2014-11-17
###############################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F
set.seed(12345)

# load field, axis and color information
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))

# Add proper gender column from the datasets.
# Create unifying coding.
getGender <- function(dat){
    # convert sex to gender
    if("sex" %in% colnames(dat)){
        gender <- as.character(dat$sex)
    } else if ("gender" %in% colnames(dat) ){
        gender <- as.character(dat$gender)
    } else {
        warning("Gender information missing")
    }
    gender[gender=='U'] <- 'all'
    gender[gender=='A'] <- 'all'    
    gender[gender=='M'] <- 'male'
    gender[gender=='F'] <- 'female'
    gender[gender=='m'] <- 'male'
    gender[gender=='f'] <- 'female'
 return(gender)
}

# Calculate body surface area (BSA) [m^2] from bodyweight [kg] and height [cm].
calculateBSA <- function(bodyweight_kg, height_cm){
  # DuBois formula
  return (0.007184*height_cm^0.725*bodyweight_kg^0.425)
}
  
  
# Calculate body mass index (BMI) [kg/m^2] from bodyweight [kg] and height [m].
# bodyweight/(height)^2

saveRawData <- function(data, dir=NULL){
  if (is.null(dir)){
    dir <- file.path(ma.settings$dir.expdata, "processed")
  }
  name <- deparse(substitute(data)) 
  print(name)
  r_fname <- file.path(dir, sprintf('%s.Rdata', name))
  csv_fname <- file.path(dir, sprintf('%s.csv', name))
  print(r_fname)
  save('data', file=r_fname)
  write.table(file=csv_fname, x=data, na="NA", row.names=FALSE, quote=FALSE,
              sep="\t", col.names=TRUE)
}

##############################################
# Read datasets
##############################################
f_liver_density = 1.08     # [g/ml] conversion between volume and weight
f_co_fraction = 0.25       # [-] Liver bloodflow as fraction of cardiac output
f_weight_indirect = 0.2    # [-] Weighting of indirect measurments

dtypes <- c('population', 'individual')

# sex, age, liverVolume
alt1962 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Altman1962.csv"), sep="\t")
alt1962$dtype <- 'population'
alt1962$gender <- getGender(alt1962)
alt1962$volLiver <- alt1962$liverWeight/f_liver_density * 1000; # [ml]
alt1962$volLiverSd <- NA
alt1962$ageRange <- 0.5*(alt1962$ageMax-alt1962$ageMin)
saveRawData(alt1962)
head(alt1962)

# age [years], volLiver [ml], BSA [m^2], volLiverPerBSA [ml/m^2]
bac1981 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Bach1981_Tab2.csv"), sep="\t")
bac1981$dtype <- 'population'
bac1981$gender <- getGender(bac1981$sex)
saveRawData(bac1981)
head(bac1981)

# age [years], sex [M,F], liverWeight [g]
boy1933 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Boyd1933_Fig1.csv"), sep="\t")
boy1933$dtype <- 'individual'
boy1933$gender <- getGender(boy1933)
boy1933$volLiver <- boy1933$liverWeight/f_liver_density; # [ml]
saveRawData(boy1933)
head(boy1933)

# age [years], sex [M,F], BSA [m^2], liverBloodFlow [ml/min]
bra1945 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Bradley1945.csv"), sep="\t")
bra1945$dtype <- 'individual'
bra1945$gender <- getGender(bra1945)
bra1945$flowLiver <- bra1945$liverBloodFlow
saveRawData(bra1945)
head(bra1945)

# age [years], sex [U], cardiac_output [L/min]
# liver blood flow estimated via cardiac output
# cat2010 <- read.csv(file.path(ma.settings$dir.expdata, "cardiac_output", "Cattermole2010_Tab2.csv"), sep="\t")
# cat2010$dtype <- 'population'
# cat2010$gender <- getGender(cat2010)
# cat2010$flowLiver <- cat2010$CO * 1000 * f_co_fraction # [ml/min]
# cat2010$flowLiverMin <- cat2010$COMin * 1000 * f_co_fraction # [ml/min]
# cat2010$flowLiverMax <- cat2010$COMax * 1000 * f_co_fraction # [ml/min]
# cat2010$ageRange <- 0.5*(cat2010$ageMax - cat2010$ageMin)
# # cat2010$flowLiverRange <- 0.5*(cat2010$flowLiverMax - cat2010$flowLiverMin)
# cat2010$flowLiverSd <- 0.5*(cat2010$flowLiverMax - cat2010$flowLiverMin)/2 # only estimate!, read from centiles
# cat2010 <- cat2010[complete.cases(cat2010), ]
# saveRawData(cat2010)
# head(cat2010)

# liver blood flow estimated via cardiac output
# age [years], sex [M,F], bodyweight [kg], height [cm], BSA [m^2], cardiac_output [mL/min], cardiac_outputkg [ml/min/kg]
cat2010 <- read.csv(file.path(ma.settings$dir.expdata, "cattermole", "Koenig_Cattermole2009.csv"), sep="\t")
cat2010$dtype <- 'individual'
cat2010$gender <- getGender(cat2010)
cat2010$flowLiver <- cat2010$CO * f_co_fraction # [ml/min]
cat2010$flowLiverkg <- cat2010$COkg * f_co_fraction # [ml/min]
cat2010 <- cat2010[complete.cases(cat2010), ]
saveRawData(cat2010)
head(cat2010)

# weight [kg], liverWeight [kg], liverWeightSd [kg]
del1968.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "DeLand1968_Fig1.csv"), sep="\t")
del1968.fig1$dtype <- 'population'
del1968.fig1$gender <- getGender(del1968.fig1)
del1968.fig1$bodyweight <- del1968.fig1$weight
del1968.fig1$volLiver <- del1968.fig1$liverWeight/f_liver_density * 1000; # [ml]
del1968.fig1$volLiverSd <- del1968.fig1$liverWeightSd/f_liver_density * 1000; # [ml]
del1968.fig1$n <- 10  # n estimated, ~ 10 in every class
del1968.fig1$bodyweightRange <- 0.5*(del1968.fig1$weightMax-del1968.fig1$weightMin)
saveRawData(del1968.fig1)
head(del1968.fig1)

# height [cm], liverWeight [kg], liverWeightSd [kg]
del1968.fig3 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "DeLand1968_Fig3.csv"), sep="\t")
del1968.fig3$dtype <- 'population'
del1968.fig3$gender <- getGender(del1968.fig3)
del1968.fig3$volLiver <- del1968.fig3$liverWeight/f_liver_density * 1000; # [ml]
del1968.fig3$volLiverSd <- del1968.fig3$liverWeightSd/f_liver_density * 1000; # [ml]
del1968.fig3$n <- 10  # n estimated, ~ 10 in every class
del1968.fig3$heightRange <- 0.5*(del1968.fig3$heightMax-del1968.fig3$heightMin)
saveRawData(alt1968.fig3)
head(del1968.fig3)

# BSA [m^2], liverWeight [kg], liverWeightSd [kg]
del1968.fig4 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "DeLand1968_Fig4.csv"), sep="\t")
del1968.fig4$dtype <- 'population'
del1968.fig4$gender <- getGender(del1968.fig4)
del1968.fig4 <- del1968.fig4[complete.cases(del1968.fig4), ] # remove NA in liver weight
del1968.fig4$volLiver <- del1968.fig4$liverWeight/f_liver_density * 1000; # [ml]
del1968.fig4$volLiverSd <- del1968.fig4$liverWeightSd/f_liver_density * 1000; # [ml]
del1968.fig4$n <- 10  # n estimated, ~ 10 in every class
del1968.fig4$BSARange <- 0.5*(del1968.fig4$BSAMax-del1968.fig4$BSAMin)
saveRawData(del1968.fig4)
head(del1968.fig4)

# age [years], bodyweight [kg], GEC [mmol/min], GEC [mmol/min/kg] 
duc1979 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Ducry1979_Tab1.csv"), sep="\t")
duc1979$dtype <- 'individual'
duc1979$gender <- getGender(duc1979)
duc1979$BSA <- calculateBSA(bodyweight_kg=duc1979$bodyweight, height_cm=duc1979$height)
saveRawData(duc1979)
head(duc1979)

# age [years], sex [M,F], GECmg [mg/min/kg], GEC [mmol/min/kg] 
# age [years], gender [male, female], GECkg [mmole/min/kg]
duf2005 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Dufour2005_Tab1.csv"), sep="\t")
duf2005$dtype <- 'individual'
duf2005$gender <- getGender(duf2005)
duf2005$GECkg <- duf2005$GECmg/180
duf2005 <- duf2005[duf2005$state=='normal', ]
duf2005 <- duf2005[!is.na(duf2005$GEC), ] # filter cases without GEC
saveRawData(duf2005)
head(duf2005)

# sex [M,F], height [cm], liverWeight [kg] 
gra2000.tab1 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Grandmaison2000_Tab1.csv"), sep="\t")
gra2000.tab1$dtype <- 'population'
gra2000.tab1$gender <- getGender(gra2000.tab1)
gra2000.tab1$height <- gra2000.tab1$heightMean
gra2000.tab1$heightRange <- 0.5*(gra2000.tab1$heightMax - gra2000.tab1$heightMin)
gra2000.tab1$volLiver <- gra2000.tab1$liverWeight/f_liver_density * 1000; # [ml]
gra2000.tab1$volLiverSd <- gra2000.tab1$liverWeightSd/f_liver_density * 1000; # [ml]
saveRawData(gra2000.tab1)
head(gra2000.tab1)

# sex [M,F], bmi [kg/m^2], liverWeight [kg] 
gra2000.tab2 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Grandmaison2000_Tab2.csv"), sep="\t")
gra2000.tab2$dtype <- 'population'
gra2000.tab2$gender <- getGender(gra2000.tab2)
gra2000.tab2$bmi <- gra2000.tab2$bmiMean
gra2000.tab2$bmiRange <- 0.5*(gra2000.tab2$bmiMax - gra2000.tab2$bmiMin)
gra2000.tab2$volLiver <- gra2000.tab2$liverWeight/f_liver_density * 1000; # [ml]
gra2000.tab2$volLiverSd <- gra2000.tab2$liverWeightSd/f_liver_density * 1000; # [ml]
saveRawData(gra2000.tab2)
head(gra2000.tab2)

# digitized BSA [m^2], liverVol [ml]
# hei1999 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Heinemann1999.csv"), sep="\t")
# hei1999$gender <- as.character(hei1999$sex)
# hei1999$gender[hei1999$gender=='U'] <- 'all'
# hei1999$volLiver <- hei1999$liverVol
# head(hei1999)

# original data
hei1999 <- read.csv(file.path(ma.settings$dir.expdata, "heinemann", "Heinemann1999.csv"), sep="\t")
hei1999$dtype <- 'individual'
hei1999$gender <- getGender(hei1999)
hei1999$volLiver <- hei1999$liverWeight/f_liver_density  # [ml]
hei1999$volLiverkg <- hei1999$volLiver/hei1999$bodyweight # [ml/kg]
hei1999$BSA <- hei1999$BSA_DuBois # use the DuBois calculation
# remove outliers found by graphical analysis
outliers.1 <- which((hei1999$liverWeight<500) & (hei1999$age>5))
outliers.2 <- which((hei1999$liverWeight>1500) & (hei1999$liverWeight<2000) & (hei1999$age<10))
outliers.3 <- which((hei1999$BSA_DuBois<0.5) & (hei1999$liverWeight/hei1999$bodyweight<20))
outliers <- c(outliers.1, outliers.2, outliers.3)
hei1999 <- hei1999[-outliers, ]
rm(outliers.1, outliers.2, outliers.3)
# remove the overweight and obese people, i.e. only BMI <25 
hei1999 <- hei1999[hei1999$BMI<30, ]
saveRawData(hei1999)

# age [years], sex [M,F], cardiac_output [L/min], liver blood flow [L/min]
# liver blood flow estimated via cardia output
ircp2001.co <- read.csv(file.path(ma.settings$dir.expdata, "cardiac_output", "IRCP2001_CO.csv"), sep="\t")
ircp2001.co$dtype <- 'individual'
ircp2001.co$gender <- getGender(ircp2001.co)
ircp2001.co$flowLiver <- ircp2001.co$CO * 1000 * f_co_fraction # [ml/min]
saveRawData(ircp2001.co)
head(ircp2001.co)

# sex [M,F], age [years], livWeight [g]
kay1987 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Kayser1987.csv"), sep="\t")
kay1987$dtype <- 'population'
kay1987$gender <- getGender(kay1987)
kay1987$volLiver <- kay1987$livWeight/f_liver_density  # [ml]
kay1987$volLiverSd <- kay1987$livWeightSd/f_liver_density  # [ml]
kay1987$ageRange <- 0.5*(kay1987$ageMax - kay1987$ageMin)  # [ml]
saveRawData(kay1987)
head(kay1987)

# age [years], GEC [µmol/min/kg]
lan2011 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Lange2011_Fig1.csv"), sep="\t")
lan2011$dtype <- 'individual'
lan2011$gender <- getGender(lan2011)
lan2011$GECmumolkg <- lan2011$GEC
lan2011$GECkg <- lan2011$GECkg/1000
lan2011 <- lan2011[lan2011$status=='healthy', ]
saveRawData(lan2011)
head(lan2011)

# age [years], GEC (galactose elimination capacity) [mmol/min], 
# HVI (hepatic volumetric index) [units], volLiver [cm^3]
mar1988 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Marchesini1988_Fig.csv"), sep="\t")
mar1988 <- data.frame(subject=mar1988$subject, 
                      age=mar1988$age,
                      GEC=mar1988$GEC,
                      HVI=mar1988$HVI[order(mar1988$subject)],
                      volLiver=mar1988$volLiver[order(mar1988$subject)])
mar1988$dtype <- 'individual'
mar1988$study = 'mar1988'
mar1988$gender = 'all'
saveRawData(mar1988)
head(mar1988)

# age [years], sex [M,F], bodyweight [kg], BSA [kg/m^2], liverVol [ml], height [cm] 
naw1998 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Nawaratne1998_Tab1.csv"), sep="\t")
naw1998$dtype <- 'individual'
naw1998$gender <- getGender(naw1998)
naw1998$volLiver <- naw1998$liverVol
naw1998$volLiverkg <- naw1998$volLiver/naw1998$bodyweight # [ml/kg]
saveRawData(naw1998)
head(naw1998)

# sex [M, F], age [years], bodyweight [kg], height [cm], BSA [m^2], flowLiver [ml/min]
sch1945 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Sherlock1945.csv"), sep="\t")
sch1945$dtype <- 'individual'
sch1945$gender <- getGender(sch1945)
sch1945$flowLiver <- sch1945$liverBloodflow
sch1945$flowLiverkg <- sch1945$flowLiver/sch1945$bodyweight
saveRawData(sch1945)
head(sch1945)

# sex [m,f], age [years], bodyweight [kg], GEC [mg/min/kg]
sch1986.tab1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Schnegg1986_Tab1.csv"), sep="\t")
sch1986.tab1$dtype <- 'individual'
sch1986.tab1$gender <- getGender(sch1986.tab1)
sch1986.tab1$GECmgkg <- sch1986.tab1$GEC
sch1986.tab1$GEC <- sch1986.tab1$GECmgkg * sch1986.tab1$bodyweight/180; # [mg/min/kg -> mmol/min]
sch1986.tab1$GECkg <- sch1986.tab1$GECmgkg/180
saveRawData(sch1986.tab1)
head(sch1986.tab1)

# age [years], GEC [mg/min/kg]
sch1986.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Schnegg1986_Fig1.csv"), sep="\t")
sch1986.fig1$dtype <- 'individual'
sch1986.fig1$gender <- getGender(sch1986.fig1)
sch1986.fig1$GECmgkg <- sch1986.fig1$GEC
sch1986.fig1$GECkg   <- sch1986.fig1$GEC/180
saveRawData(sch1986.fig1)
head(sch1986.fig1)

# age [years], bodyweight [kg], volLiver [ml], volLiverkg [ml/kg]
swi1978 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Swift1978_Tab1.csv"), sep="\t")
swi1978$dtype <- 'population'
swi1978$gender <- getGender(swi1978)
swi1978$ageRange <- 0.5*(swi1978$ageMax - swi1978$ageMin)
swi1978 <- swi1978[-3, ] # remove hospitalized cases
saveRawData(swi1978)
head(swi1978)

# bodyweight [kg], COkg [ml/min/kg], CO [ml/min]
sim1997 <- read.csv(file.path(ma.settings$dir.expdata, "cardiac_output", "Simmone1997.csv"), sep="\t")
sim1997$dtype <- 'individual'
sim1997$gender <- getGender(sim1997)
sim1997$flowLiver <- sim1997$CO * f_co_fraction # [ml/min]
sim1997$flowLiverkg <- sim1997$COkg * f_co_fraction # [ml/min]
saveRawData(sim1997)
head(sim1997)

# sex [M], age [years], bodyweight [kg], liverWeight [kg]
tom1965 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Thompson1965.csv"), sep="\t")
tom1965$dtype <- 'population'
tom1965$gender <- getGender(tom1965)
tom1965$volLiver <- tom1965$liverWeight/f_liver_density * 1000; # [ml]
tom1965$volLiverSd <- tom1965$liverWeightSd/f_liver_density * 1000; # [ml]
tom1965$ageRange <- 0.5*(tom1965$ageMax - tom1965$ageMin)
saveRawData(tom1965)
head(tom1965)

# age [years], bodyweight [kg], GEC [mmol/min]
tyg1962 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1962.csv"), sep="\t")
tyg1962$dtype <- 'individual'
tyg1962$gender = getGender(tyg1962)
tyg1962$GECkg <- tyg1962$GEC/tyg1962$bodyweight
tyg1962 <- tyg1962[tyg1962$state=='healthy', ] # filter cirrhosis out
saveRawData(tyg1962)
head(tyg1962)

# BSA [m^2], liverVol [ml]
ura1995 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Urata1995.csv"), sep="\t")
ura1995$dtype <- 'individual'
ura1995$gender <- getGender(ura1995)
ura1995$volLiver <- ura1995$liverVol
saveRawData(ura1995)
head(ura1995)

# BSA [m^2], liverVol [ml]
vau2002.fig1 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Vauthey2002_Fig1.csv"), sep="\t")
vau2002.fig1$dtype <- 'individual'
vau2002.fig1$gender <- getGender(vau2002.fig1)
vau2002.fig1$volLiver <- vau2002.fig1$liverVol
saveRawData(vau2002.fig1)
head(vau2002.fig1)

# bodyweight [kg], liverVol [ml]
vau2002.fig2 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Vauthey2002_Fig2.csv"), sep="\t")
vau2002.fig2$dtype <- 'individual'
vau2002.fig2$gender <- as.character(vau2002.fig2$sex)
vau2002.fig2$gender[vau2002.fig2$gender=='U'] <- 'all'
vau2002.fig2$volLiver <- vau2002.fig2$liverVol
saveRawData(vau2002.fig2)
head(vau2002.fig2)

# sex [male,female], age [years], weight [kg], GEC [mmol/min], bloodFlowM1 [ml/min], bloodFlowM2 [ml/min],
# flowLiver [ml/min]
win1965 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Winkler1965.csv"), sep="\t")
win1965$dtype <- 'individual'
win1965$gender <- getGender(win1965)
win1965$flowLiverkg <- win1965$flowLiver/win1965$bodyweight
win1965$BSA <- calculateBSA(bodyweight_kg=win1965$bodyweight, height_cm=win1965$height)
win1965$GECkg <- win1965$GEC/win1965$bodyweight
win1965 <- win1965[!is.na(win1965$GEC), ] # filter cases without GEC
saveRawData(win1965)
head(win1965)

# gender [male, female], age [years], liver volume [ml], bloodflow, perfusion
wyn1989 <- read.csv(file.path(ma.settings$dir.expdata, "wynne", "Wynne1989_corrected.csv"), sep="\t")
wyn1989$dtype <- 'individual'
wyn1989$gender <- getGender(wyn1989)
wyn1989$volLiver <- wyn1989$livVolume
wyn1989$volLiverkg <- wyn1989$livVolumekg
wyn1989$flowLiver <- wyn1989$livBloodflow
wyn1989$flowLiverkg <- wyn1989$livBloodflowkg
wyn1989$study <- 'wyn1989'
saveRawData(wyn1989)
head(wyn1989)

# age [years], liver bloodflow [ml/min]
wyn1990 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Wynne1990.csv"), sep="\t")
wyn1990$dtype <- 'individual'
wyn1990$gender <- getGender(wyn1990)
wyn1990$flowLiver <- wyn1990$liverBloodflow
saveRawData(wyn1990)
head(wyn1990)

# BSA [m^2], liverWeight [g]
yos2003 <- read.csv(file.path(ma.settings$dir.expdata, "liver_volume", "Yoshizumi2003.csv"), sep="\t")
yos2003$dtype <- 'individual'
yos2003$gender <- getGender(yos2003)
yos2003$volLiver <- yos2003$liverWeight/f_liver_density ; # [ml]
saveRawData(yos2003)
head(yos2003)

# age [years], FHF (functional hepatic flow) [ml/min]
zol1993 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Zoller1993.csv"), sep="\t")
zol1993$dtype <- 'individual'
zol1993$gender <- getGender(zol1993)
zol1993$flowLiverkg <- zol1993$liverBloodflowPerBodyweight
saveRawData(zol1993)
head(zol1993)

# age [years], FHF (functional hepatic flow) [ml/min]
zol1999 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Zoli1999.csv"), sep="\t")
zol1999$dtype <- 'individual'
zol1999$gender <- getGender(zol1999)
zol1999$flowLiver <- zol1999$FHF
saveRawData(zol1999)
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
    
    # better plot
    inds.in <- which(data$gender == gender.levels[k] & data$dtype == 'individual')
    points(data[inds.in, xname], data[inds.in, yname], col=gender.cols[k], bg=gender.cols[k], 
           pch=gender.symbols[k], cex=0.8)
    inds.po <- which(data$gender == gender.levels[k] & data$dtype == 'population')
    points(data[inds.po, xname], data[inds.po, yname], col=gender.cols[k], 
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

# check if Sd or Range for x and y based on which fields are available
# in the dataset
getRangeType <- function(dat, xname, yname){
    xtype <- NULL
    ytype <- NULL
    if (paste(xname, 'Sd', sep="") %in% names(dat)){
        xtype <- 'Sd'   
    } else if (paste(xname, 'Range', sep="") %in% names(dat)){
        xtype <- 'Range'   
    }
    if (paste(yname, 'Sd', sep="") %in% names(dat)){
        ytype <- 'Sd'   
    } else if (paste(yname, 'Range', sep="") %in% names(dat)){
        ytype <- 'Range'   
    }
    return(list(xtype=xtype, ytype=ytype))
}

# Add the population data segments to the plot
addPopulationSegments <- function(dat, xname, yname){
    types <- getRangeType(dat, xname, yname)    
    for (k in 1:nrow(dat)){
        sex <- dat$gender[k]
        col <- gender.cols[which(gender.levels == sex)]
        
        xmean <- dat[k, xname]
        ymean <- dat[k, yname]
        xrange <- dat[k, paste(xname, types$xtype, sep="")]
        yrange <- dat[k, paste(yname, types$ytype, sep="")]
        
        # horizontal
        segments(xmean-xrange, ymean, xmean+xrange, ymean, col=col)
        # vertical
        segments(xmean, ymean-yrange, xmean, ymean+yrange, col=col)
    }
}

################################
# Population data
################################
# Takes data from population studies, i.e. multiple individuals put together
# providing n (number subjects), mean (mean value) and Sd (standard deviation)
# or range (distance to upper/lower limit of group).

# Add n measurements of mean data 
addMeanPopulationData <- function(data, newdata){
  xname <- names(data)[3]
  yname <- names(data)[4]
  
  freq <- newdata$n
  sds <- newdata[, paste(yname, 'Sd', sep="")]
  for (k in 1:nrow(newdata)){
    n <- freq[k]
    study <- rep(newdata$study[k], n)
    gender <- rep(newdata$gender[k], n)
    dtype <- rep(newdata$dtype[k], n)
    
    # replicate mean data point n times
    x <- rep(newdata[k, xname], n)
    assign(xname, x)
    
    y <- rep(newdata[k, yname], n)
    assign(yname, y)
    
    df <- data.frame(study, gender, get(xname), get(yname), dtype)
    names(df) <- c('study', 'gender', xname, yname, 'dtype')
    data <- rbind(data, df)
  }
  return(data)
}

# Generate randomized data points within the given measurement
# interval for the data, i.e. use mean and sd/range for x and y 
# to create n data points. 
# The data is weighted only a fraction of the individual data in 
# the regression but the information is provided for the fit curves.
addRandomizedPopulationData <- function(data, newdata){
    xname <- names(data)[3]
    yname <- names(data)[4]
    types <- getRangeType(newdata, xname, yname)
    print(types)
    
    for (k in 1:nrow(newdata)){
        n <- newdata$n[k]
        study <- rep(newdata$study[k], n)
        gender <- rep(newdata$gender[k], n)
        dtype <- rep(newdata$dtype[k], n)

        # generate x points
        xmean <- newdata[k, xname]
        xrange <- newdata[k, paste(xname, types$xtype, sep="")]
        if (types$xtype == 'Sd'){
            x <- rnorm(n, mean=xmean, sd=xrange)
        } else if (types$xtype == 'Range'){
            x <- runif(n, min=xmean-xrange, max=xmean+xrange)
        }
        x[x<0] <- NA
        assign(xname, x)
        cat(xname, ':', xmean, '+-', xrange, '\n')
        
        # generate y points
        ymean <- newdata[k, yname]
        yrange <- newdata[k, paste(yname, types$ytype, sep="")]
        if (types$ytype == 'Sd'){
            y <- rnorm(n, mean=ymean, sd=yrange)
        } else if (types$ytype == 'Range'){
            y <- runif(n, min=ymean-yrange, max=ymean+yrange)
        }
        y[y<0] <- NA
        assign(yname, y)
        cat(yname, ':', ymean, '+-', yrange, '\n')

        df <- data.frame(study, gender, get(xname), get(yname), dtype)
        names(df) <- c('study', 'gender', xname, yname, 'dtype')
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
########################################################################################

############################################
# GEC [mmol/min] vs. age [years]
############################################
xname <- 'age'; yname <- 'GEC'
selection <- c('study', 'gender', xname, yname, 'dtype')
# individual subject data
data <- rbind( mar1988[, selection],
               tyg1962[, selection],
               sch1986.tab1[, selection],
               # win1965[, selection], # outlier compare to other datasets
               duc1979[, selection],
               duf2005[, selection])

data <- data[complete.cases(data), ]  # remove NA
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# GECkg [mmol/min/kgbw] vs. age [years]
############################################
xname <- 'age'; yname <- 'GECkg'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind( lan2011[, selection],
               duc1979[, selection],
               tyg1962[, selection],
               sch1986.fig1[, selection], 
               # sch1986.tab1[, c('study', 'gender', 'age', 'GECkg')], # already ploted via sch1986.fig1
               # win1965[, selection],  # outlier compare to other datasets
               duf2005[, selection])
data <- data[complete.cases(data), ]  # remove NA
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# GEC [mmol/min] vs. volLiver [ml]
############################################
xname <- 'volLiver'; yname <- 'GEC'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind( mar1988[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# GEC [mmol/min] vs. flowLiver [ml/min]
############################################
#xname <- 'flowLiver'; yname <- 'GEC'
#selection <- c('study', 'gender', xname, yname, 'dtype')
#data <- rbind( win1965[, selection]) # outlier compare to other datasets
#saveData(data)

#m1 <- linear_regression(data, xname, yname)
#makeFigureFull(data, m1, xname, yname)

############################################
# volLiver [ml] vs. age [years]
############################################
xname <- 'age'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind( mar1988[, selection],
               wyn1989[, selection],
               naw1998[, selection],
               boy1933[, selection],
               hei1999[, selection])

# data <- addRandomizedPopulationData(data, alt1962) # no range/Sd for volLiver
# data <- addRandomizedPopulationData(data, tom1965)
# data <- addRandomizedPopulationData(data, kay1987)

saveData(data)
makeFigureFull(data, NULL, xname, yname)
addPopulationSegments(tom1965, xname, yname)
addPopulationSegments(kay1987, xname, yname)

############################################
# volLiver [ml] vs. age [years] and bodyweight [kg]
############################################
x1name <- 'age'; x2name <- 'bodyweight'; yname <- 'volLiver'
selection <- c('study', 'gender', x1name, x2name, yname, 'dtype')
data <- rbind(wyn1989[, selection] ,
              naw1998[, selection], 
              hei1999[, selection])
head(data)
require("rgl")
require("RColorBrewer")
colors <- rep(NA, nrow(data))
colors[data$gender=='male'] <- rgb(0,0,1, alpha=0.5)
colors[data$gender=='female'] <- rgb(1,0,0, alpha=0.5)
plot3d(data$age, data$bodyweight, data$volLiver, 
       col=colors, pch=symbols, size=5) 
data1 <- data[data$gender=="male", ]
data2 <- data[data$gender=="female", ]
plot3d(data1$age, data1$bodyweight, data1$volLiver, 
       pch=symbols, size=5, col='blue') 
plot3d(data2$age, data2$bodyweight, data2$volLiver, 
       pch=symbols, size=5, col='red') 
decorate3d()
# saveData(data)

############################################
# volLiverkg [ml/kg] vs. age [years]
############################################
xname <- 'age'; yname <- 'volLiverkg'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(wyn1989[, selection] ,
              naw1998[, selection], 
              hei1999[, selection])
saveData(data)
makeFigureFull(data, NULL, xname, yname)

############################################
# volLiver [ml] vs. BSA [m^2]
############################################
xname <- 'BSA'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(naw1998[, selection],
              hei1999[, selection],
              ura1995[, selection],
              vau2002.fig1[, selection],
              yos2003[,selection])

# data <- addRandomizedPopulationData(data, del1968.fig4)
saveData(data)
makeFigureFull(data, NULL, xname, yname)
# addPopulationSegments(del1968.fig4, xname, yname)

############################################
# volLiver [ml] vs. bodyweight [kg]
############################################
xname <- 'bodyweight'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(naw1998[, selection],
              vau2002.fig2[, selection],
              wyn1989[, selection],
              hei1999[, selection])
# data <- addRandomizedPopulationData(data, del1968.fig1)
# data <- addRandomizedPopulationData(data, tom1965)
saveData(data)
makeFigureFull(data, NULL, xname, yname)
addPopulationSegments(del1968.fig1, xname, yname)
addPopulationSegments(tom1965, xname, yname)

############################################
# volLiver [ml] vs. height [cm]
############################################
xname <- 'height'; yname <- 'volLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(naw1998[, selection],
              hei1999[, selection])
# data <- addRandomizedPopulationData(data, del1968.fig3)
# data <- addRandomizedPopulationData(data, gra2000.tab1)
saveData(data)

makeFigureFull(data, NULL, xname, yname)
addPopulationSegments(del1968.fig3, xname, yname)
addPopulationSegments(gra2000.tab1, xname, yname)

############################################
# flowLiver [ml/min] vs. age [years]
############################################
xname <- 'age'; yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind( win1965[, selection], 
               wyn1989[, selection],
               bra1945[, selection],
               zol1999[, selection],
               sch1945[, selection],
               wyn1990[, selection],
               cat2010[, selection],     # estimate via cardiac output
               ircp2001.co[, selection]) # estimate via cardiac output

saveData(data)
makeFigureFull(data, NULL, xname, yname)

############################################
# flowLiverkg [ml/min/kg] vs. age [years]
############################################
xname <- 'age'; yname <- 'flowLiverkg'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind( win1965[, selection], 
               wyn1989[, selection],
               sch1945[, selection],
               zol1993[, selection],
               cat2010[, selection]) # estimate via cardiac output
saveData(data)

# m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, NULL, xname, yname)


############################################
# flowLiver [ml/min] vs. bodyweight [kg]
############################################
xname <- 'bodyweight'; yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(wyn1989[, selection],
              sim1997[, selection], # estimate via cardiac output
              cat2010[, selection]) # estimate via cardiac output
saveData(data)
m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiverkg [ml/min] vs. bodyweight [kg]
############################################
xname <- 'bodyweight'; yname <- 'flowLiverkg'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(  wyn1989[, selection],
                sim1997[, selection], # estimate via cardiac output
                cat2010[, selection]) # estimate via cardiac output
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)


############################################
# perfusion [ml/min/ml] vs. age [years]
############################################
xname <- 'age'; yname <- 'perfusion'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind( wyn1989[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiver [ml/min] vs. BSA [m^2]
############################################
xname <- 'BSA'
yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(bra1945[, selection],
              sch1945[, selection],
              cat2010[, selection]) # estimate via cardiac output
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiver [ml/min] vs. volLiver [ml]
############################################
xname <- 'volLiver'
yname <- 'flowLiver'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(wyn1989[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)

############################################
# flowLiverkg [ml/min/kg] vs. volLiver [ml]
############################################
xname <- 'volLiver'
yname <- 'flowLiverkg'
selection <- c('study', 'gender', xname, yname, 'dtype')
data <- rbind(wyn1989[, selection])
saveData(data)

m1 <- linear_regression(data, xname, yname)
makeFigureFull(data, m1, xname, yname)
