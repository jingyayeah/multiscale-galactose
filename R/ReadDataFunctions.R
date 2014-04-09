##########################################################
# Helper functions to read Data from the CSV            '
##########################################################


# Load the PP and PV data for single simulation by sim name
# The timecourse for the data should exists. This can be checked with
# via the simulation status in the parameter files.
readPPPVDataForSimulation <- function(sim, withTime=F){
  tmp <- read.csv(paste(data.folder, '/', modelId, "_", sim, "_copasi.csv", sep=""))
  # set time as row names and remove the time vector
  row.names(tmp) <- tmp$time
  
  # reduce data to PP__ and PV__ data
  pppv.index <- which(grepl("^PP__", names(tmp)) | grepl("^PV__", names(tmp)) )
  if (withTime==T){
    pppv.index <- which(grepl("^PP__", names(tmp)) | grepl("^PV__", names(tmp)) |  grepl("^time", names(tmp)))
  }
  tmp <- tmp[, pppv.index]
}

# Reads the time vector
readTimeForSimulation <- function(sim){
  tmp <- readPPPVDataForSimulation(row.names(pars)[1], withTime=T)
  time <- tmp$time
}

# Read the data in a list structure
readPPPVData <- function(max_index=-1){
  data <- list()
  if (max_index<1){
    simulations <- row.names(pars)  
  } else {
    simulations <- row.names(pars)[1:max_index]
  }
  Nsim <- length(simulations)
  for (k in seq(1,Nsim)){
    sim <- simulations[[k]]
    print(paste(sim, ' [', k/Nsim*100, ']'))
    status = pars[sim,]$status
    
    if (length(status)==0 || status == 'DONE'){
      data[[sim]] = readPPPVDataForSimulation(sim)
    } else {
      print(paste('simulation -> ', status))
    }
  }
  data
}

# Convert list structure into data matrix
createDataMatrices <- function(datalist, prefixes=c('PV__')){
  time <- readTimeForSimulation(names(pars)[1])
  Ntime = length(time)
  Nsim = length(names(datalist))
  
  mat = list()
  for (prefix in prefixes){
    for (compound in compounds){
      name = paste(prefix, compound, sep="")  
      mat[[name]] <- matrix(, nrow = Ntime, ncol = Nsim)
    
      # copy all the columns
      for(k in seq(1,Nsim)){
        sim <- names(datalist)[k]
        mat[[name]][, k] <- datalist[[sim]][, name]
      }
    }
  }
  mat
}

