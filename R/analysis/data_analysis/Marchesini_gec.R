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

head(data)
summary(data)



# calculate the dose based on bodyweight and 
# injected dose of 500mg/kg (bodyweight)
data$dose <- 0.5 * data$bodyweight # [g]
head(data)


# create time matrix
t.mat <- as.matrix(data[, paste('t', 1:6, sep="")])
head(t.mat)
k.mat <- as.matrix(data[, paste('k', 1:6, sep="")])
head(k.mat)

k <- 1
t.vec <- t.mat[k, ]
k.vec <- k.mat[k, ]
p <- data[k, ] 

# find the indeces for first and last value
inds <- which(!is.na(t.vec) & !is.na(k.vec))
first <- inds[1]
last <- inds[length(inds)]

# now calculate data
k_loss = 0.1           # 10 % urinary loss
p$U <- k_loss * p$dose # [g] urinary loss
p$tf <- t.vec[first]   # [min] first time point
p$kf <- k.vec[first]   # [uv] first absorbance
p$cf <- p$kf * p$L     # [mg/dl] first concentration

p$tl <- t.vec[last]    # [min] first time point
p$kl <- k.vec[last]    # [uv] first absorbance
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
p$GEC

head(p)




# create value matrix



# get the first time, value & concentration



# get the last time, dose & concentration