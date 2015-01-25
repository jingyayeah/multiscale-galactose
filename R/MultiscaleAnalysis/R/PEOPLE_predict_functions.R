################################################################################
# Prediction of volLiver, flowLiver, GEC, GECkg for cohorts
################################################################################
# Predict liver volume, blood flow and metabolic functions for the data consisting
# of gender, age, bodyweight, height
# Based on the individual samples of blood flow an liver the GEC clearance
# is calculated.
#
# author: Matthias Koenig
# date: 2014-12-05
################################################################################

#' Raw people folder.
#' @export
dir.raw <- file.path(ma.settings$dir.base, 'results', 'rest')

#' NHANES people folder.
#' @export
dir.nhanes <- file.path(ma.settings$dir.base, 'results', 'nhanes')

##############################################################################
# Create people
##############################################################################
#' Create the people data frame used for prediction 
#' 
#'@export
create_people_from_raw <- function(name){
  x <- loadRawData(name)
  people <- with(x, data.frame(study=study, sex=gender, age=age, bodyweight=bodyweight, height=height, BSA=BSA,
                           volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE))
  return(people)
}

#' Create people from the raw data files like 'hei1999'.
#' 
#'@export
create_all_people <- function(names){
  df_list <- lapply(names, create_people_from_raw)
  return ( do.call("rbind", df_list) )  
}

#' Calculate body surface area (BSA) [m^2] from bodyweight [kg] and height [cm].
#' 
#' Using DuBois formula
#'@export
calculateBSA <- function(bodyweight_kg, height_cm){
  return (0.007184*height_cm^0.725*bodyweight_kg^0.425)
}

##############################################################################
# Predict liver volume & flow for people
##############################################################################
#' Predict liver volume and blod flow.
#' 
#'@export
predict_volume_and_flow <- function(people, out_dir, Nsample=1000, Ncores=11){
    # liver.info <- predict_liver_people(people[1:10,], 1000, Ncores=4)
  
    ptm <- proc.time()
    liver.info <- predict_liver_people(people, Nsample, Ncores=Ncores)
    time <- proc.time() - ptm
    print(time)
    
    cat('* Saving data *\n')
    volLiver <- liver.info$volLiver
    flowLiver <- liver.info$flowLiver
    vol_path <- file.path(out_dir, 'volLiver.Rdata')
    flow_path <- file.path(out_dir, 'flowLiver.Rdata')
    cat(vol_path, '\n')
    cat(flow_path, '\n')
    save('volLiver', file=vol_path)
    save('flowLiver', file=flow_path)  
    return(liver.info)
}

############################################################################
# Plots for individual analysis
############################################################################




#' Plot individual GEC prediction.
#' 
#' @export
individual_GEC_plot <- function(person, data){
  # Histogram
  h <- hist(data, plot=FALSE)
  h.max <- max(h$density)
  # Density
  dens <- density(data)
  d.max <- max(dens$y)
  # Maximum for arranging things
  p.max <- max(h.max, d.max)
  
  # empty plot
  plot(numeric(0), numeric(0), type='n', xlim=c(0,5), ylim=c(0, 1.3*p.max), 
       # main="GEC reference range [2.5% - 97.5%]",
       xlab="GEC [mmol/min]", ylab="probability", font.lab=2)
  
  qdata <- quantile(data, c(0.025, 0.5, .975))
  
  # person info
  
  person.info <- with(person, sprintf(' %s\n %1.0f years\n %1.1f kg\n %1.0f cm\n %1.2f m^2', sex, age, bodyweight,height, BSA))
  x.text=0
  if (qdata[2] < 2.5){ x.text = 3.7 }
  text(x=x.text,y=p.max, labels=c(person.info), pos=4, cex=0.9)
  
  # GEC info
  GEC.info <- sprintf('median %1.2f\n [%1.2f - %1.2f]\n ', qdata[2], qdata[1], qdata[3])
  text(x=qdata[2], y=1.08*p.max, labels=c(GEC.info), pos=3, cex=0.9)
  
  # polygons (red area left & right)
  span = 0.75
  qdata <- quantile(data, c(0.025, .975))
  polygon(x=c(qdata[1]-span, qdata[1], qdata[1], qdata[1]-span), y=c(0, 0,p.max, p.max), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
  polygon(x=c(qdata[2]+span, qdata[2], qdata[2], qdata[2]+span), y=c(0, 0,p.max, p.max), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
  
  # histogram & density
  plot(h, xlim=c(0,5), col=rgb(0,0,0, 0.05), border=rgb(0,0,0, 0.5), freq=FALSE, add=TRUE)
  lines(dens, col='black', lwd=2)
  
  # Quantiles
  # qdata <- quantile(GEC[1, ], c(0.025, .25, .50,  .75, .975))
  # qdata <- quantile(data, c(.25,  .75))
  # abline(v=qdata, col='black', lwd=2, lty=1)
  #qdata <- quantile(data, c(0.025, .975))
  # abline(v=qdata, col='red', lwd=2, lty=1)
  # Rugs
  rug(data)
  # Boxplot
  box <- boxplot(data, notch=FALSE, col=(rgb(0,0,0,0.2)), range=0, boxwex=0.1*p.max, horizontal = TRUE, at=c(1.1*p.max), add=TRUE, plot=FALSE)
  box$stats <- matrix(quantile(data, c(0.025, 0.25, 0.5, 0.75, 0.975)), nrow=5, ncol=1)
  bxp(z=box, notch=FALSE, range=0, boxwex=0.1*p.max, ylim=c(0,5), horizontal=TRUE, add=TRUE, at=c(1.1*p.max), lty=1)
}

############################################################################
# Plot individual GEC box
############################################################################
#' Boxplot of the GEC distribution.
#' 
#'@export
individual_GEC_box <- function(person, data, gec_exp=NA){
  # boundaries for plot
  min.value = min(data)
  max.value = max(data)
  if (!is.na(gec_exp)){
    min.value <- min(gec_exp, min.value)
    max.value <- max(gec_exp, max.value)
  }
  
  # normal ranges
  q <- quantile(data, probs=c(0.025, 0.975, 0.5) )
  #
  # xlim=c(min.value-0.1, max.value+0.1)
  plot(numeric(0), numeric(0), type='n', yaxt='n', xlim=c(min.value-0.2, max.value+0.2), ylim=c(0.7, 1.3), 
       main=sprintf('[%1.2f - %1.2f] mmole/min\n median %1.2f\n ', q[1], q[2], q[3]),
       xlab="GEC [mmole/min]", ylab="", font.lab=2, cex.lab=1.3, cex.main=1.5)
  
  
  
  box <- boxplot(data, notch=FALSE, col=(rgb(0,0,0,0.2)), range=0, horizontal=TRUE, add=TRUE, plot=FALSE)
  box$stats <- matrix(quantile(data, c(0.025, 0.25, 0.5, 0.75, 0.975)), nrow=5, ncol=1)
  bxp(z=box, notch=FALSE, range=0, ylim=c(0,5), horizontal=TRUE, add=TRUE, at=c(1.0), lty=1)
  
  
  # Plot polygons
  span = 0.75
  qdata <- quantile(data, c(0.025, .975))
  polygon(x=c(qdata[1]-span, qdata[1], qdata[1], qdata[1]-span), y=c(0, 0, 2, 2), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
  polygon(x=c(qdata[2]+span, qdata[2], qdata[2], qdata[2]+span), y=c(0, 0, 2, 2), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
  
  # Plot the experimental value
  if (!is.na(gec_exp)){
    col <- 'darkgreen'
    if ((gec_exp < q[1])|(gec_exp > q[2])){
      col <- 'red'
    }
    abline(v = gec_exp, lwd=3, col=col  ) 
  }
  
}

############################################################################
# Plot individual flowLiver ~ volLiver
############################################################################

#' Scale density of given histogram.
#' 
#' @export
scale_density <- function(h, max.value){
  h$density <- max.value/max(h$density) * h$density 
  return(h)
}

#' Scatterplot of liver volumes & blood flows.
#' 
#' @export
individual_vol_flow_plot <- function(person, vol, flow, data){
  # empty plot
  plot(numeric(0), numeric(0), xlim=lim$volLiver, ylim=lim$flowLiver,
       xlab=lab$volLiver, ylab=lab$flowLiver, type='n',
       #main="Simulated reference data",
       font.lab=2)
  abline(a=0, b=1, col='gray')
  points(vol, flow, pch=21, bg=rgb(0,0,0, 0.1), col="black", cex=1*data/max(data))
  # rugs
  rug(vol, side=1)
  rug(flow, side=2)
  # additional histograms
  max.value=400
  col.hist <- rgb(0,0,0, 0.3); breaks <- 20;
  hx <- hist(vol, plot=FALSE, breaks=breaks)
  hx <- scale_density(hx, max.value=max.value)
  plot(hx, freq=FALSE, col=col.hist, add=TRUE)
  
  hy <- hist(flow, plot=FALSE, breaks=breaks)
  hy <- scale_density(hy, max.value=max.value)
  Nhist = length(hy$density)
  rect(ybottom=hy$breaks[1:Nhist], xleft=0, ytop=hy$breaks[2:(Nhist+1)], xright=hy$density, col=col.hist)
  
  # additional boxplot
  # add the means 
  points(mean(vol), mean(flow), bg='blue', col='black', pch=22, cex=2)  
}

#' Full combined plot of the information.
#' 
#' @export
individual_plot <- function(person, vol, flow, data){
  par(mfrow=c(1,2))
  individual_GEC_plot(person=person, data=data)
  individual_vol_flow_plot(person=person, vol=vol, flow=flow, data=data)
  par(mfrow=c(1,1))
}
