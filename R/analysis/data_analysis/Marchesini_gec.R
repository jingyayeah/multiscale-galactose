################################################################
## Calculate the GEC values from Marchesini Raw data
################################################################
# Galactose injection with subsequent calculation of the 
# galactose elimination capacity (GEC) from galactose over 
# time.
#
# author: Matthias Koenig
# date: 2014-01-29
################################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

######################
# Data preparation
######################
raw <- read.csv(file.path(ma.settings$dir.expdata, "raw_data", "marchesini", "Koenig_core.csv"), sep="\t")
head(raw)

# make copy, remove unnecessary columns, canonical sex
data <- raw
data$date <- NULL
data$birth <- NULL
data$sex <- process_sex(data)

# set disease status
data$disease <- 1
data$disease[data$status=='N'] <- 0

# calculate the dose based on bodyweight and 
# injected dose of 500mg/kg (bodyweight)
data$dose <- 0.5 * data$bodyweight # [g]


# Filter data based on status
# E = liver disease (were repeatedly used in studies in cirrhosis/chronic hepatitis/HCC)
# N = controls (with different age; they were used in studies in aging); 
# O=???? (uncertain); 
# R = resection for primary or secondary liver cancer; 
# T=thyroid diseases (both hypo and hyperthyroidism)
# => remove O and T
data <- data[data$status!='O', ]
data <- data[data$status!='T', ]

# renumber
rownames(data)<- 1:nrow(data)

head(data)
summary(data)

######################
# Calculate GEC
######################
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
save('pdata', file=file.path(ma.settings$dir.base, 'results', 'classification', 'GEC_marchesini.Rdata'))
head(pdata)

########################################
# GEC ~ age
########################################
# Load the rest of the classification data
gec_data.all <- load_classification_data(name='GEC_classification')
gec_data <- gec_data.all[gec_data.all$status=="healthy", ]
head(gec_data)


library(ggplot2)

# plot GEC depending on status & age
g <- ggplot(pdata, aes(age, GEC, color=status))
p <- g + geom_point() + facet_grid(.~status)
p

# GEC vs age
p <- ggplot() + geom_point(aes(x=pdata$age, y=pdata$GEC, color=pdata$status)) + xlim(0,100) + ylim(0,5) + xlab("age [years]") +
  ylab("GEC [mmole/min]") 
p
p + geom_point(aes(x=gec_data$age, y=gec_data$GEC, size=1.2, alpha=0.9))

#################################
# Time dependency galactose
#################################
# time and concentration matrix
samples <- 6
t.mat <- as.matrix(pdata[, paste('t', 1:samples, sep="")]) # [min]
k.mat <- as.matrix(pdata[, paste('k', 1:samples, sep="")])
c.mat <- k.mat
colnames(c.mat) <- paste('c', 1:samples, sep="")
for (k in 1:samples){
  c.mat[ ,k] <- c.mat[ ,k]*pdata$L/180*10  # [mg/dl] -> [mM]
}
head(c.mat)


par(mfrow=c(1,2))
for (status in unique(pdata$disease)){
  r = (pdata$disease==status)
  plot(t.mat[r, ], c.mat[r, ], 
       xlab='time [min]', ylab='galactose [mM]',
       xlim = c(0,90), ylim = c(0, 14),
       main=paste("GEC single injection, disease =", status) , pch=21, col="black", bg=rgb(0.5,0.5,0.5,0.5), cex=0.5)
  for (k in 1:nrow(t.mat)){
    if (r[k] == TRUE){
      lines(t.mat[k, ], c.mat[k, ], col=rgb(0,0,0,0.2))
    }
  }
}
par(mfrow=c(1,1))
