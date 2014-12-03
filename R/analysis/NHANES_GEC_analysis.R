rm(list = ls())
library('MultiscaleAnalysis')
library('methods')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))

# Load the NHANES dataset with the GEC data
# Load the NHANES & quantile data
dir_nhanes <- file.path(ma.settings$dir.base, 'results', 'nhanes')
load(file=file.path(dir_nhanes, 'nhanes_GEC_quantiles.Rdata'))

# Load the raw data
load(file=file.path(dir_nhanes, 'nhanes_volLiver.Rdata'))
load(file=file.path(dir_nhanes, 'nhanes_flowLiver.Rdata'))
load(file=file.path(dir_nhanes, 'nhanes_GEC.Rdata'))
load(file=file.path(dir_nhanes, 'nhanes_GECkg.Rdata'))
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_GEC.Rdata'))

# reduce the nhanes dataset to the interesting parts
colnames(volLiver.q)
nhanes$volLiver <- volLiver.q[, '50%']
nhanes$volLiverkg <- nhanes$volLiver/nhanes$bodyweight
nhanes$flowLiver <- flowLiver.q[, '50%']
nhanes$flowLiverkg <- nhanes$flowLiver/nhanes$bodyweight
nhanes$GEC <- GEC.q[, '50%']
nhanes$GECkg <- nhanes$GEC/nhanes$bodyweight


for (k in 1:5){
  nhanes[[sprintf('volLiverkg_sample_%d', k)]] <- nhanes[[sprintf('volLiver_sample_%d', k)]]/nhanes$bodyweight
  nhanes[[sprintf('flowLiverkg_sample_%d', k)]] <- nhanes[[sprintf('flowLiver_sample_%d', k)]]/nhanes$bodyweight
  nhanes[[sprintf('GECkg_sample_%d', k)]] <- nhanes[[sprintf('GEC_sample_%d', k)]]/nhanes$bodyweight
}
# nhanes <- nhanes[, c('SEQN', 'ethnicity', 'sex', 'age', 'bodyweight', 'height', 'BSA',
#                    'volLiver', 'flowLiver', 'GEC',
#                    'volLiverkg', 'flowLiverkg', 'GECkg',
#                    'volLiver_sample', 'flowLiver_sample', 'GEC_sample',
#                    'volLiverkg_sample', 'flowLiverkg_sample', 'GECkg_sample']
head(nhanes)

################################################################################
# dataset <- 'GEC_age'
# dataset <- 'GECkg_age'

# dataset <- 'volLiver_age'
# dataset <- 'volLiverkg_age'
dataset <- 'volLiver_bodyweight'
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
    file <- file.path(ma.settings$dir.base, 'results', sprintf('%s_%s_regression.png', yname, xname))
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
## load respective data ##
fname <- file.path(ma.settings$dir.base, "results", "correlations", sprintf("%s_%s.Rdata", yname, xname))
print(fname)
load(file=fname)
head(data)

# data processing (change names, remove NAs, create factors)
names(data)[names(data) == 'gender'] <- 'sex'
data <- na.omit(data)
data$study <- as.factor(data$study)
data$sex <- as.factor(data$sex)
data$dtype <- as.factor(data$dtype)

# weighting of data points in regression
data$weights <- 1 
data$weights[data$dtype=='population'] = 0.1 # data from population studies is less weighted (not used in regression)
data$weights[data$study=="cat2010"] = 0.1    # indirect measured data (flow via cardiac output), is weighted less
data$weights[data$study=="sim1997"] = 0.1    # indirect measured data (flow via cardiac output), is weighted less
data$weights[data$study=="ircp2001"] = 10    # the very few data points for flow in children are weighted more
table(data$weights)

# reduce data tp the individual points (no population data used)
data <- data[data$dtype=="individual", ]

# prepare subsets
df.names <- c('all', 'male', 'female')
df.all <- data
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
  
  # empty plot
  plot(d[, xname], d[, yname], type='n',
       main=sprintf('%s', df.names[k]), xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, font.lab=2, cex.lab=1.0)
  
  # mean nhanes of Monte Carlo or experimental data
  points(nhanes.d[[xname]], nhanes.d[[yname]], col="black", bg="black", pch=21, cex=0.2)
  # plot individual samples
  for (k in 1:5){
    name <- sprintf('%s_sample_%d', yname, k)
    if (name %in% colnames(nhanes))
      points(nhanes.d[[xname]], nhanes.d[[name]], col="red", bg="red", pch=21, cex=0.2)
  }
  
  # plot experimental data points
  inds.in <- which(d$dtype == 'individual')
  #points(d[inds.in, xname], d[inds.in, yname], col='blue', bg='blue', pch=21)
  points(d[inds.in, xname], d[inds.in, yname], col=rgb(1,1,1), bg=rgb(0,0,1, 0.5), pch=21, cex=0.5)
  
  legend('bottomright', bty="n", cex=0.8, legend=c('NHANES single prediction','NHANES mean prediction', 'experimental data'), 
         col=c('red', 'black', 'white'), pt.bg=c('red', 'black', 'blue'), pch=c(21,21,21), pt.cex=c(0.5, 0.5, 1)) 
         
  #rug(d[inds.in, xname], side=1, col="black"); rug(d[inds.in, yname], side=2, col="black")
}
par(mfrow=c(1,1))
stopDevPlot()
rm(d,k)

