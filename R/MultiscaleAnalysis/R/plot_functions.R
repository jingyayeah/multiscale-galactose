################################################################
## Plot helper functions
################################################################
# Functions for easier generation of plots.
#
# author: Matthias Koenig
# date: 2014-11-11
################################################################

#' Start a general plot.
#' 
#' @export
startDevPlot <- function(width=1000, height=1000, file=NULL, create_plots=F, res=150){
  cat(file, '\n')
  if (!is.null(file) & create_plots==TRUE) { 
    png(filename=file, width=width, height=height, 
        units = "px", bg = "white",  res = res)
  } else { print('No plot files created') }
}

#' Stop a general plot
#' @export
stopDevPlot <- function(create_plots=T){
  if (create_plots == T) { dev.off() }
}


#' Multiple plot function
#'
#' ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
#' - cols:   Number of columns in layout
#' - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#'
#' If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
#' then plot 1 will go in the upper left, 2 will go in the upper right, and
#' 3 will go all the way across the bottom.
#'
#' @export
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


#' Data contains for one compound the data.
#' 
#' depreciated ?!
#' @export 
plotTimecourses <- function(data, main, ylim){
  for (ks in seq(1, ncol(data)) ){
    if (ks == 1){
      plot(time, data[,ks], col="gray", main=main, 'l', xlab="time [s]", ylab="c [mM]", ylim=ylim)
    } else {
      lines(time, data[,ks], col="gray")
    }
    
    # plot the mean and variance for time courses
    # rmean <- rowMeans(tmp)
    # rstd <- rowSds(tmp)
    # lines(time, rmean, col=ccolors[kc], lwd=2)
    # lines(time, rmean+rstd, col=ccolors[kc], lwd=2, lty=2)
    # lines(time, rmean-rstd, col=ccolors[kc], lwd=2, lty=2)
  }  
}

#' Plot set of timecourses.
#' 
#' depreciated ?!
#' @export 
plotAllTimecourses <- function(datamat, compounds, ylim){
  par(mfrow=c(1,length(compounds)))
  for (kc in seq(1, length(compounds)) ){
    # name = "PV__rbcM"
    name = paste("PV__", compounds[kc], sep="")
    print(name)
    
    # plot one compound
    tmp <- datamat[[name]]
    for (ks in seq(1, ncol(tmp)) ){
      if (ks == 1){
        plot(time, tmp[,ks], col="gray", 'l', main=name, xlab="time [s]", ylab="c [mM]", ylim=ylim)
      } else {
        lines(time, tmp[,ks], col="gray")
      }
    }
    # plot the mean and variance for time courses
    rmean <- rowMeans(tmp)
    rstd <- rowSds(tmp)
    lines(time, rmean, col=ccolors[kc], lwd=2)
    lines(time, rmean+rstd, col=ccolors[kc], lwd=2, lty=2)
    lines(time, rmean-rstd, col=ccolors[kc], lwd=2, lty=2)
  }
  par(mfrow=c(1,1))
}
