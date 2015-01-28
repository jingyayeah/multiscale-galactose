################################################################
# Preprocess File Functions
################################################################
# These are preprocess file functions.
# 
# TODO: what is still used here and what is completely obolete ???
#
# author: Matthias Koenig
# date: 2014-11-11
################################################################

###########################################
# Naming of files.
###########################################
#' Get the xname and yname from the dataset name.
#' 
#'@export
createXYNameFromDatasetName <- function(dataset.name){
  name.parts <- strsplit(dataset.name, '_')
  xname <- name.parts[[1]][2]
  yname <- name.parts[[1]][1]
  return( list(xname=xname, yname=yname) )
}

#' Create dataset name from xname and yname.
#' 
#' Dataset name is the combined name from xname and yname.
#'@export
createDatasetName <- function(xname, yname){
  return( sprintf('%s_%s', xname, yname) )
}

###########################################
# Raw data
###########################################
#' Get raw data directory
#' 
#' @export
getRawDir <- function(){
  dir <- file.path(ma.settings$dir.base, "results", "raw")
}

#' Saves the raw data of single source.
#' 
#' This saves the the experimental datasets after minimal preprocessing
#' and unification.
#' example: saveRawData('duc1979')
#' @export
saveRawData <- function(data, name, dir=getRawDir()){
  
  # save file
  r_fname <- file.path(dir, sprintf('%s.Rdata', name))
  csv_fname <- file.path(dir, sprintf('%s.csv', name))
  cat('Save: ', r_fname, '\n')
  save('data', file=r_fname)
  write.table(file=csv_fname, x=data, na="NA", row.names=FALSE, quote=FALSE,
              sep="\t", col.names=TRUE)
}

#' Load the processed raw data for the given name.
#' 
#' This loads the the experimental datasets.
#' example: loadRawData('duc1979')
#'@export
loadRawData <- function(name, dir=get_raw_dir()){
  r_fname <- file.path(dir, sprintf('%s.Rdata', name))
  cat('Load: ', r_fname, '\n')
  load(file=r_fname)
  return(data)
}

###########################################
# Correlation data
###########################################
#' Get correlation data directory
#' 
#' @export
get_correlation_dir <- function(){
  dir <- file.path(ma.settings$dir.base, "results", "correlations")
}

#' Saves correlation data as csv and Rdata.
#' 
#' @export
save_correlation_data <- function(data, dir=get_correlation_dir()){
  xname <- names(data)[3]
  yname <- names(data)[4]
  r_fname <- file.path(dir, sprintf('%s_%s.Rdata', yname, xname))
  csv_fname <- file.path(dir, sprintf('%s_%s.csv', yname, xname))
  
  cat('Save: ', r_fname, '\n')
  cat('Save: ', csv_fname, '\n')
  save('data', file=r_fname)
  write.table(file=csv_fname, x=data, na="NA", row.names=FALSE, quote=FALSE,
              sep="\t", col.names=TRUE)
}

#' Loads correlation data from Rdata.
#' 
#' @export
load_correlation_data <- function(xname, yname, dir=get_correlation_dir()){
  if (is.null(dir)){
    dir <- get_correlation_dir()
  }
  fname <- file.path(dir, sprintf("%s_%s.Rdata", yname, xname))
  cat('Load :', r_fname, '\n')
  load(file=fname)
  return(data)
}

############################################################################################
# Data manipulation
############################################################################################

#' Create canonical representation of gender/sex.
#' 
#' @export
process_sex <- function(data){
  # convert sex to gender
  if("sex" %in% colnames(data)){
    gender <- as.character(data$sex)
  } else if ("gender" %in% colnames(data) ){
    gender <- as.character(data$gender)
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


#' Perform common processing steps and save the raw data.
#' 
#' Sex/Gender is unified.
#' Set the data type (either individual or population)
#' Raw data is saved.
#' @export
process_data_and_save <- function(data, dtype){
  if (is.na(dtype) | !(dtype %in% c('individual', 'population'))){
    stop('No or wrong datatype for data.')
  }
  # get the name from the variable name
  name <- deparse(substitute(data)) 
  data$sex <- process_sex(data)
  data$dtype <- dtype
  saveRawData(data, name)

  return(data)
}


############################################################################################
# Linear regression template
############################################################################################

#' Create linear regression between xname and yname.
#' 
#' @export
linear_regression <- function(data, xname, yname){
  # do linear regression
  formula <- as.formula(paste(yname, '~', xname))
  m1 <- lm(formula, data=data)
  
  # Create output file with log information
  name = paste(yname, 'vs', xname) 
  log.file <- file.path(ma.settings$dir.base, "results", "correlations", 
                        sprintf('%s_%s.log', yname, xname))
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

#' Figure of correlation data
#' 
#' @export
plot_correlation_data <- function(data, m1, xname, yname, create_plots=F){
  xlab <- lab[[xname]]; ylab <- lab[[yname]]
  xlim <- lim[[xname]]; ylim <- lim[[yname]]
  main <- sprintf('%s vs. %s', yname, xname)
  correlation_plot(data, m1, main, xname, yname, xlab, ylab, xlim, ylim, create_plots)
}

#' Figure of correlation data
#' 
#' @export
correlation_plot <- function(data, m1, main, xname, yname, 
                       xlab, ylab, 
                       xlim, ylim, create_plots=F){
  name = sprintf('%s_%s', yname, xname)
  if (create_plots == TRUE){
    plot.file <- file.path(ma.settings$dir.base, "results", "correlations", 
                           paste(name, '.png', sep=""))
    print(plot.file)               
    png(filename=plot.file,
        width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
  }
  
  plot(numeric(0), numeric(0), xlim=xlim, ylim=ylim, 
       main=main, xlab=xlab, ylab=ylab)
  studies <- levels(as.factor(data$study))
  
  
  g <- gender.cols()
  
  # plot the individual gender data
  for (k in 1:length(g$levels)){
    
    # plot individual studies
    
    for (s in seq_along(studies)){
      cat(g$levels[k], studies[s], '\n')
      inds.in <- which(data$study==studies[s] & data$sex == g$levels[k] & data$dtype == 'individual')
      points(data[inds.in, xname], data[inds.in, yname], col=g$cols[k], bg=g$cols[k], 
             pch=((20+s)%%26), cex=0.8)
      inds.po <- which(data$study==studies[s] & data$sex == g$levels[k] & data$dtype == 'population')
      points(data[inds.po, xname], data[inds.po, yname], col=g$cols[k], 
             pch=((20+s)%%26), cex=0.8)
    }
  }
  legend("topright",  legend=c(g$levels, studies), col=c(g$cols, rep('black', length(studies))), 
         pt.bg=c(g$cols, rep('black', length(studies))),
         pch=c(rep(1, length(g$levels)), ((20+seq_along(studies))%%26) ) )
  # legend("topleft",  legend=g$levels, fill=g$cols) 
  
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

#' Check if Sd or Range for x and y based on which fields are available
#' in the dataset
#' @export
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

#' Add the population data segments to the plot.
#' @export
addPopulationSegments <- function(dat, xname, yname){
  g <- gender.cols()
  types <- getRangeType(dat, xname, yname)    
  for (k in 1:nrow(dat)){
    sex <- dat$gender[k]
    col <- g$cols[which(g$levels == sex)]
    
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


#' Add data from population studies to dataset.
#'  
#' I.e. multiple individuals put together
#' providing n (number subjects), mean (mean value) and Sd (standard deviation)
#' or range (distance to upper/lower limit of group).
#' Add n measurements of mean data.
#' @export
addMeanPopulationData <- function(data, newdata){
  xname <- names(data)[3]
  yname <- names(data)[4]
  
  freq <- newdata$n
  sds <- newdata[, paste(yname, 'Sd', sep="")]
  for (k in 1:nrow(newdata)){
    n <- freq[k]
    study <- rep(newdata$study[k], n)
    sex <- rep(newdata$sex[k], n)
    dtype <- rep(newdata$dtype[k], n)
    
    # replicate mean data point n times
    x <- rep(newdata[k, xname], n)
    assign(xname, x)
    
    y <- rep(newdata[k, yname], n)
    assign(yname, y)
    
    df <- data.frame(study, sex, get(xname), get(yname), dtype)
    names(df) <- c('study', 'sex', xname, yname, 'dtype')
    data <- rbind(data, df)
  }
  return(data)
}

#' Add data from population studies to dataset.
#' Generate randomized data points within the given measurement
#' interval for the data, i.e. use mean and sd/range for x and y 
#' to create n data points. 
#' The data is weighted only a fraction of the individual data in 
#' the regression but the information is provided for the fit curves.
#' @export
addRandomizedPopulationData <- function(data, newdata){
  xname <- names(data)[3]
  yname <- names(data)[4]
  types <- getRangeType(newdata, xname, yname)
  print(types)
  
  for (k in 1:nrow(newdata)){
    n <- newdata$n[k]
    study <- rep(newdata$study[k], n)
    sex <- rep(newdata$sex[k], n)
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
    
    df <- data.frame(study, sex, get(xname), get(yname), dtype)
    names(df) <- c('study', 'sex', xname, yname, 'dtype')
    data <- rbind(data, df)
  }
  return(data)
}


