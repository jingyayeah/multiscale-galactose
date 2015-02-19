################################################################################
# NHANES prediction
################################################################################
# Create figures of cohort predictions in combination with experimental 
# data.
#
# author: Matthias Koenig
# date: 2015-02-19
################################################################################

if (!exists('dataset')){
dataset <- 'GEC_age'
# dataset <- 'GECkg_age'

# dataset <- 'volLiver_age'
# dataset <- 'volLiverkg_age'
# dataset <- 'volLiver_bodyweight'
# dataset <- 'volLiver_height'
# dataset <- 'volLiver_BSA'

# dataset <- 'flowLiver_volLiver'
# dataset <- 'flowLiverkg_volLiver'
# dataset <- 'flowLiver_age'
# dataset <- 'flowLiverkg_age'
# dataset <- 'flowLiverkg_bodyweight'
# dataset <- 'perfusion_age'

# dataset <- 'volLiver_flowLiver'
}

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
create_plots = TRUE
startDevPlot <- function(width=2000, height=1000, file=NULL){
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
# load data
data = load_correlation_data(xname=xname, yname=yname)
# reduce to healthy
data <- data[data$status == 'healthy', ]

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
create_plots = T
png.file <- file.path(ma.settings$dir.base, 'results', 'population', sprintf("nhanes_%s_%s.png", yname, xname))
startDevPlot(width=2500, height=1000, file=png.file)
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
  
  # single NHANES prediction (first Nsingle points) 
  Nsingle = 5
  for (k_sample in 1:Nsingle){  
      y <- get(yname)
      if (k==2)
        y <- y[nhanes$sex == 'male', ]
      if (k==3)
        y <- y[nhanes$sex == 'female', ]

      points(nhanes.d[[xname]], y[ ,k_sample], 
             col=rgb(0.6, 0.6, 0.6, 1), bg=rgb(0.6, 0.6, 0.6, 1), pch=21, cex=0.4)
  }
  
  # mean NHANES prediction
  points(nhanes.d[[xname]], nhanes.d[[yname]], col=rgb(0.4, 0.4, 0.4, 1), bg=rgb(0.4, 0.4, 0.4, 1), pch=21, cex=0.4)
  
  # experimental data points
  inds.in <- which(d$dtype == 'individual')
  points(d[inds.in, xname], d[inds.in, yname], col='black', bg=rgb(0,0,1, 0.7), pch=22, cex=1.0)
  
  # legend
  legend('bottomright', bty="n", cex=1.0, legend=c('NHANES single prediction','NHANES mean prediction', 'experimental data'), 
         col=c(rgb(0.6, 0.6, 0.6, 1), rgb(0.4, 0.4, 0.4, 1), 'black'), 
         pt.bg=c(rgb(0.6, 0.6, 0.6, 1), rgb(0.4, 0.4, 0.4, 1), 'blue'), 
         pch=c(21,21,22), pt.cex=c(1, 1, 1))   
}
par(mfrow=c(1,1))
stopDevPlot()
rm(d,k)

