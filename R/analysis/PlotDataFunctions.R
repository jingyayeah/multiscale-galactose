# Plot all data curves and mean curve #
library('matrixStats')


# data contains for one compound the data 
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

