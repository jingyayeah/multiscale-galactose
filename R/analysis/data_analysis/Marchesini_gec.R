################################################################
## Calculate the GEC values from Marchesini Raw data
################################################################
# GEC curves from Marchesini
#
# author: Matthias Koenig
# date: 2014-11-17
################################################################

# load data
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

raw <- read.csv(file.path(ma.settings$dir.expdata, "raw_data", "marchesini", "Koenig_core.csv"), sep="\t")
head(raw)

# make copy and remove unnecessary columns
data <- raw
data$date <- NULL
data$birth <- NULL
rownames(data)<- 1:nrow(data)

# calculate the dose based on bodyweight and 
# injected dose of 500mg/kg (bodyweight)
data$dose <- 0.5 * data$bodyweight # [g]

head(data)
summary(data)

calculate_GEC_from_raw <- function(p){
  # time and absorbance matrix
  t.mat <- as.matrix(data[, paste('t', 1:6, sep="")])
  k.mat <- as.matrix(data[, paste('k', 1:6, sep="")])
  
  # find the indeces for first and last value
  first <- rep(NA, nrow(data))
  last <- rep(NA, nrow(data))
  for (k in 1:nrow(data)){
    inds <- which(! is.na(t.mat[k, ]) & !is.na(k.mat[k, ]))  
    first[k] <- inds[1]
    last[k] <- inds[length(inds)]  
  }
  p$first <- first
  p$last <- last
  
  # now calculate data
  k_loss = 0.1           # 10 % urinary loss
  p$U <- k_loss * p$dose # [g] urinary loss
  
  for (k in 1:nrow(data)){
    p$tf[k] <- t.mat[k, first[k]]   # [min] first time point
    p$kf[k] <- k.mat[k, first[k]]   # [uv] first absorbance
    p$tl[k] <- t.mat[k, last[k]]    # [min] first time point
    p$kl[k] <- k.mat[k, last[k]]    # [uv] first absorbance
  }
  p$cf <- p$kf * p$L     # [mg/dl] first concentration
  p$cl <- p$kl * p$L     # [mg/dl] first concentration
  
  # differences between first and last
  p$t_delta <- p$tl - p$tf # [min]
  p$c_delta <- p$cl - p$cf # [mg/dl]
  
  # calculate slope for decrease
  p$m <- p$c_delta/p$t_delta # [mg/dl/min]
  
  # time intercept with abcissa
  p$ta <- -p$cf/p$m + p$tf   # [min]
  
  # removal Q
  p$Q <- (p$dose - p$U)/(p$ta + 7)  # [g/min]
  
  # GEC (unit conversion)
  Mgal = 180   # [g/mol] molecular weight galactose
  p$GEC <- p$Q/Mgal * 1000
  
  return(p)
}

pdata <- calculate_GEC_from_raw(data)
head(pdata)

########################################
# Create plot
########################################
library(ggplot2)

# plot GEC depending on type
g <- ggplot(pdata, aes(age, GEC, color=status))
p <- g + geom_point() + facet_grid(.~status)
p

# create value matrix
p <- ggplot() + geom_point(aes(x=pdata$age, y=pdata$GEC, color=pdata$status)) + xlim(0,100) + ylim(0,5) + xlab("G2 age [years]") +
  ylab("G2 GEC [mmole/min]") 
p

gec_data.all <- load_classification_data(name='GEC_classification')
head(gec_data)

gec_data <- gec_data.all[gec_data.all$status=="healthy", ]

g.info <- gender.cols()

p <- ggplot() + geom_point(aes(x=pdata$age, y=pdata$GEC, color=pdata$status)) + geom_point(aes(x=gec_data$age, y=gec_data$GEC, size=1.2, alpha=0.9)) + xlim(0,100) + ylim(0,5) + xlab("G2 age [years]") +
  ylab("G2 GEC [mmole/min]")
p


# get the first time, value & concentration



# get the last time, dose & concentration