rm(list = ls())
library('MultiscaleAnalysis')
# setwd('/home/mkoenig/multiscale-galactose/')
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))

# Load the NHANES dataset
load(file='nhanes_liverData_GEC.Rdata')
head(nhanes)

################################################################################
# dataset <- 'GEC_age'
dataset <- 'GECkg_age'

# dataset <- 'volLiver_age'
# dataset <- 'volLiverkg_age'
# dataset <- 'volLiver_bodyweight'
# dataset <- 'volLiver_height'
#dataset <- 'volLiver_BSA'

# dataset <- 'flowLiver_volLiver'
# dataset <- 'flowLiverkg_volLiver'
# dataset <- 'flowLiver_age'
# dataset <- 'flowLiverkg_age'
# dataset <- 'flowLiverkg_bodyweight'
#dataset <- 'perfusion_age'

# dataset <- 'volLiver_flowLiver'
################################################################################
# Plot helpers
name.parts <- strsplit(dataset, '_')
xname <- name.parts[[1]][2]
yname <- name.parts[[1]][1]
rm(name.parts)
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)

# Plot to file
create_plots = FALSE
startDevPlot <- function(width=2000, height=1000, file=NULL){
  if (is.null(file)){
    file <- file.path(ma.settings$dir.results, 'regression', sprintf('%s_%s_regression.png', yname, xname))
  }
  if (create_plots == T) { 
    print(file)
    png(filename=file, width=width, height=height, 
        units = "px", bg = "white",  res = 150)
  } else { print('No plot files created') }
}
stopDevPlot <- function(){
  if (create_plots == T) { dev.off() }
}

################################################################################
## load data ##
fname <- file.path(ma.settings$dir.expdata, "processed", sprintf("%s_%s.Rdata", yname, xname))
print(fname)
load(file=fname)
head(data)

# data processing
names(data)[names(data) == 'gender'] <- 'sex'
data <- na.omit(data) # remove NA
data$weights <- 1   # population data is weighted 0.25
data$weights[data$dtype=='population'] = 0.1
data$study <- as.factor(data$study)
data$sex <- as.factor(data$sex)
data$dtype <- as.factor(data$dtype)

# prepare subsets
df.names <- c('all', 'male', 'female')
df.all <- data
# reduce data tp the individual data for first analysis
df.all <- df.all[df.all$dtype=="individual", ]

# some preprocessing
if (dataset == 'GEC_age'){
  # problems with non Marchesini data,
  # data far away and very large spread
  df.all <- df.all[df.all$sex=='all',]
}
if (dataset == 'volLiver_BSA'){
  # cutoff based on the NHANES normal range
  df.all <- df.all[df.all$BSA<=2.5,]
}
df.male <- df.all[df.all$sex == 'male', ]
df.female <- df.all[df.all$sex == 'female', ]
rm(data)

#######################################################
# Plot basic data overview
#######################################################
create_plots = F
# sprintf("/home/mkoenig/Desktop/data/TEST_nhanes_%s_%s.png", xname, yname)
startDevPlot(width=2000, height=1000, file=sprintf("/home/mkoenig/Desktop/data/TEST_nhanes_%s_%s.png", yname, xname))
par(mfrow=c(1,3))
for (k in 1:3){
  if (k==1){ 
    d <- df.all 
    nhanes.d <- nhanes
  }
  if (k==2){ 
    d <- df.male 
    nhanes.d <- nhanes[nhanes$sex == 'male', ]
  }
  if (k==3){ 
    d <- df.female 
    nhanes.d <- nhanes[nhanes$sex == 'female', ]
  }
  
  plot(d[, xname], d[, yname], type='n',
       main=sprintf('%s', df.names[k]), xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, font.lab=1.8, cex.lab=2)
  
  inds.po <- which(d$dtype == 'population')
  points(d[inds.po, xname], d[inds.po, yname], col=df.cols.po[k], pch=df.symbols[k])
  inds.in <- which(d$dtype == 'individual')
  points(nhanes.d[[xname]], nhanes.d[[yname]], col="black", bg="black", pch=21, cex=0.25)
  #points(d[inds.in, xname], d[inds.in, yname], col='blue', bg='blue', pch=21)
  points(d[inds.in, xname], d[inds.in, yname], col=rgb(0,0,1, 1), bg=rgb(0,0,1, 1), pch=21)
  
  legend('bottomright', legend=c('NHANES prediction', 'experimental data'), col=c('black', 'blue'), pch=c(21,21)) 
         
  #rug(d[inds.in, xname], side=1, col="black"); rug(d[inds.in, yname], side=2, col="black")
}
par(mfrow=c(1,1))
stopDevPlot()
rm(d,k)
