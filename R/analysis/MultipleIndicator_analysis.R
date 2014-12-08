################################################################
## Evaluation of Multiple Indicator Dilution Curves (MIDC)
################################################################
# The MIDC single sinusoidal unit data is used for calculation
# of mean and median resulting curves.
#
# TODO: create the plots depending on the galactose challange
# TODO: create plot with experimental data
# 
# author: Matthias Koenig
# date: 2014-12-08
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

t_peak <- 1000              # [s] MID peak start
t_end <- 5000               # [s] simulation time
folder <- '2014-12-08_T7'   # Multiple indicator data
folder.mean <- '2014-12-08_T8'   # Multiple indicator data mean

# Process the integration time curves
info <- process_folder_info(folder)
processed <- preprocess_task(folder=folder, force=FALSE) 

# parameters are already extended with SBML information
head(pars)


#------------------------------------------------------------------------------#
# Definition of compounds in the model and respective colors
compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue')
# compounds = c('rbcM', 'alb', 'suc', 'h2oM')
# ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
pv_compounds = paste('PV__', compounds, sep='')
names(ccolors) <- pv_compounds


library('RColorBrewer')

# Preprocess the parameters for scaling
t.min = t_peak-5
t.max = t_peak+50
t.approx = seq(from=t_peak-5, to=t_peak+50, by=0.2)
preprocess.mat <- createApproximationMatrix(ids=ids, simIds=rownames(pars), points=t.approx, reverse=FALSE)

# some example plots of single time curves
name="PV__alb"
max(preprocess.mat[[name]])
time <- getTimeFromPreprocessMatrix(preprocess.mat)-t_peak
plotCompound(time, preprocess.mat[[name]], name, col=ccolors[name], ylim=c(0,2.1))


###################################################################################
# Dilution curves with experimental data
###################################################################################
# weighted with the actual flow
# rbind.rep <- function(x, times) matrix(x, times, length(x), byrow = TRUE)
# cbind.rep <- function(x, times) matrix(x, length(x), times, byrow = FALSE)
# Q_sinunit = rbind.rep(pars$Q_sinunit, nrow(data))
# tmp = data*Q_sinunit
# rmean2 <- rowMeans(tmp)
# rmean2 <- rmean2/max(rmean2)*10

# calculate the max times
calculateMaxTimes <- function(preprocess.mat, compounds, time.offset){
  Nsim = ncol(preprocess.mat[[1]])
  maxtime <- data.frame(tmp=numeric(Nsim))
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    print(name)
    data <- preprocess.mat[[name]]
    time = as.numeric(rownames(data))
    maxtime[[name]] <- numeric(Nsim)    
    # find the max values for all simulations
    for (k in seq(1, Nsim)){
      maxtime[[name]][k] = time[ which.max(data[,k]) ]- time.offset
    }
  }
  maxtime$tmp <- NULL
  maxtime
}

tmp <- calculateMaxTimes(preprocess.mat, compounds, 10.0)
head(tmp)
summary(tmp)

# Create the boxplots with the mean curves
createFullPlot <- function (maxtime, ccolors, time.offset, scale_f) {
  if (create_plot_files){
    png(filename=paste(ma.settings$dir.results, '/', task, "_MultipleIndicator_with_experimental_data.png", sep=""),
        width = 1400, height = 1400, units = "px", bg = "white",  res = 150)
  }
  par(mfrow=c(2,1))
    boxplot(maxtime, col=ccolors, horizontal=T,  ylim=c(0,20),
            xaxt="n", # suppress the default x axis
            yaxt="n", # suppress the default y axis
            bty="n") # suppress the plotting frame
  
  # Plot curves
  plot(numeric(0), numeric(0), xlim=c(0,20), ylim=c(0,20),
       xlab="time [s]", ylab="10^3 x outflow fraction/ml")
  
  # plot the mean and std for time courses
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    data <- preprocess.mat[[name]]  #+1E-06 fix for logscale
    time <- as.numeric(rownames(data))-time.offset
    
    # plot the mean and std for time courses
    rmean <- rowMeans(data)
    rstd <- rowSds(data)
    lines(time, rmean*scale_f, col=ccolors[kc], lwd=4)
    lines(time, (rmean+rstd)*scale_f, col=ccolors[kc], lwd=1, lty=2)
    lines(time, (rmean-rstd)*scale_f, col=ccolors[kc], lwd=1, lty=2)
  }
  
  ## Add the experimental data from Goresky1983 & 1973 ##
  plotDilutionData(gor1983, compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  plotDilutionData(gor1973[gor1973$condition=="A",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  plotDilutionData(gor1973[gor1973$condition=="B",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  plotDilutionData(gor1973[gor1973$condition=="C",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  legend("topright",  legend = expcompounds, fill=expcolors) 
  par(mfrow=c(1,1))
  if (create_plot_files){
    dev.off()
  }
}

createBoxPlot <- function (maxtime, ccolors, time.offset) {
  # Boxplot of the maxtimes
  if (create_plot_files){
    png(filename=paste(ma.settings$dir.results, '/', task, "_Boxplot_MaxTimes", sep=""),
        width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
  }
  boxplot(maxtime-time.offset, col=ccolors, horizontal=T, xlab="time [s]")
  if (create_plot_files){
    dev.off()
  }
}

# create the plots
create_plot_files = TRUE
compounds = c('rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
time.offset = 10.0  # peak start of input

expcompounds = c('RBC', 'albumin', 'sucrose', 'water')
expcolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)

m1 = max(gor1983$outflow)
m2 = max(gor1973[gor1973$condition=="A",'outflow'])
m3 = max(gor1973[gor1973$condition=="B",'outflow'])
m4 = max(gor1973[gor1973$condition=="C",'outflow'])
scale_f = (m1+m2+m3+m4)/4;
data <-   #+1E-06 fix for logscale

rmean_rbc <- rowMeans(preprocess.mat[['PV__rbcM']])
scale_f <- scale_f/max(rmean_rbc);
scale_f

for (kt in seq(Ntask)){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', version, '_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  load(file=outfileFromParsFile(parsfile))
  # Calculate the max times
  maxtime <- calculateMaxTimes(preprocess.mat, compounds, time.offset) 
  print(summary(maxtime))
  createFullPlot(maxtime, ccolors, time.offset=time.offset, scale_f)
  # createBoxPlot(maxtime, ccolors, time.offset=time.offset)
}