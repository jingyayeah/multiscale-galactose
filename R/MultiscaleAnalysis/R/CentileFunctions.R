#' Calculation of the centiles
#' @export
qCentiles <- function (obj, newdata=NULL, cent = c(0.4, 2, 10, 25, 50, 75, 90, 98, 99.6) ){
  if (!is.gamlss(obj)) 
    stop(paste("This is not an gamlss object", "\n", ""))
  if (is.null(newdata)) 
    stop(paste("The xvar argument is not specified", "\n", ""))
  
  # evalute for prediction
  fname <- obj$family[1]
  qfun <- paste("q", fname, sep = "")
  lpar <- length(obj$parameters)
  centiles <- vector('list', length(cent))
  ii = 0
  for (k in 1:length(cent)) {
    var <- cent[k]
    if (lpar == 1) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata))
    }
    else if (lpar == 2) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata))
    }
    else if (lpar == 3) {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata),
                      nu = predict(obj, what="nu", type="response", newdata=newdata))
    }
    else {
      newcall <- call(qfun, var/100, 
                      mu = predict(obj, what="mu", type="response", newdata=newdata),
                      sigma = predict(obj, what="sigma", type="response", newdata=newdata),
                      nu = predict(obj, what="nu", type="response", newdata=newdata),
                      tau = predict(obj, what="tau", type="response", newdata=newdata))
    }
    ll <- eval(newcall)
    centiles[[k]] <- ll
  }  
  return(centiles)
}

#' Create plots for centiles
#' Make this work generally without depending on the variable name
#' @param model GAMLSS model
#' @export
plotCentiles <- function(model, d, xname, yname, 
                         main, xlab, ylab, xlim, ylim, pcol){
  # calculate centiles
  age.grid <- seq(from=min(d[[xname]]), to=max(d[[xname]]), length.out = 501)
  cent.values <- c(2.5, 10, 25, 50, 75, 90, 97.5) # these should be symmetrical
  cents <- qCentiles(model, newdata=data.frame(age=age.grid), cent=cent.values)
  
  
  # empty plot
  print('empty plot')
  plot(d[[xname]], d[[yname]], type="n", frame.plot=F,
       main=main, xlab=xlab, ylab=ylab, ylim=ylim, xlim=xlim)
  grid()
  
  # plot centile shades
  print('centile shades')
  shade_between_curves <- function(x, yup, ylow, col=rgb(0.1, 0.1, 0.1, alpha=0.1)){
    xvals <- c(x, rev(x))
    yvals <- c(yup, rev(ylow))
    polygon(xvals, yvals, col=col, border=NA)
  }
  for (kc in 1:floor(length(cent.values/2))){
    ylow = cents[[kc]]
    yup = cents[[length(cents)+1-kc]]
    shade_between_curves(age.grid, yup, ylow) 
  }
  
  # plot points
  points(d[[xname]], d[[yname]], col=pcol, pch=20, cex=0.8)
  rug(d[[xname]], side=1, col="black"); rug(d[[yname]], side=2, col="black")
  
  # plot centile lines
  for (kc in 1:length(cent.values)){
    lines(age.grid, cents[[kc]], lwd=0.5, col='black')
  }
  lines(age.grid, cents[[floor(length(cents)/2)+1]], lwd=3, col="black")
  
  # plot the text (centile description)
  for (kc in 1:length(cent.values)){
    yvals <- cents[[kc]]
    ypos <- yvals[length(yvals)]
    xpos <- max(age.grid) + 3
    info <- paste(cent.values[kc])
    print(info)
    text(xpos, ypos, info, cex=0.8)
  }
}