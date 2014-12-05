################################################################################
# NHANES - preprocess continous NHANES
################################################################################
# Preprocess the full NHANES dataset generated in (NHANES_load.R).
# The preprocessing consists of filtering the data.rows with NAs in 
# relevant fields and subsetting to normal body mass index (18.5<=BMI<=24.9)
# and ethnicity (Non-Hispanic White).
# Body surface area (BSA) is calculated via formula of DuBois.
#
# author: Matthias Koenig
# date:   2014-11-25
################################################################################
rm(list = ls())

## Load NHANES data ##
setwd('/home/mkoenig/multiscale-galactose/results/')
load(file='nhanes/nhanes.Rdata')
head(nhanes)

# Body surface area (BSA) by classic formula of DuBois’s {Moesteller1987}
nhanes$BSA <- 0.007184 * nhanes$BMXHT^0.725 * nhanes$BMXWT^0.425

## Subset of data ##
# i.e. remove extreme BMI values and reduce to 'Non-Hispanic White'
# normal bodyweight people of 'white' ethnicity
# BMI - Weight Status 
#   Below 18.5	Underweight
#   18.5 – 24.9	Normal
#   25.0 – 29.9	Overweight
#   30.0 and Above	Obese
# bmi.sel <- (nhanes$BMXBMI >= 18.5) & (nhanes$BMXBMI <= 24.9)
bmi.sel <- (nhanes$BMXBMI < 25)
eth.sel <- (nhanes$RIDRETH1 == "Non-Hispanic White")
na.sel <- !is.na(nhanes$RIDAGEYR) & !is.na(nhanes$RIAGENDR) & !is.na(nhanes$BMXBMI) & !is.na(nhanes$BMXWT) & !is.na(nhanes$BMXHT)
sel <- bmi.sel & eth.sel & na.sel
data <- nhanes[sel,]
head(data)
summary(data)


# add columns with unified names
data$age <- data$RIDAGEMN/12    # use age from month if available
data$age[is.na(data$age)] <- data$RIDAGEYR[is.na(data$age)]
data$sex <- data$RIAGENDR
data$bodyweight <- data$BMXWT
data$height <- data$BMXHT
data$ethnicity <- data$RIDRETH1

# save('data', file='nhanes/nhanes_data.Rdata')

# distribute the age of the 85 group on 85 - 100 (cutoff of NHANES)
# set.seed(12345)
# ind_old <- data$age==85
# N_old <- sum(as.integer(ind_old))
# age_old <- sample(85:100, size = N_old, replace=TRUE )
# data[ind_old, 'age'] <- age_old
#hist(data$age[data$age>=85] )

# remove the 85 and 80 years data from NHANES. 
# This data was pooled from older people for anonymization
ind_old1 <- which(data$age==85)
ind_old2 <- which(data$age==80)
data <- data[-c(ind_old1, ind_old2), ]
save('data', file='nhanes/nhanes_data.Rdata')

####################################
## Plotting data                  ##
####################################
library(ggplot2)

# plot height [cm]
g1 <- ggplot(data, aes(age, height))
g1 + geom_point()
g1 + geom_point(aes(color=sex)) + labs(title = "NHANES cohort (18.5 <= BMI < 24.9)") + labs(x='age [year]') + theme_bw()

# plot bodyweight [cm]
g1 <- ggplot(data, aes(age, bodyweight))
g1 + geom_point()
g1 + geom_point(aes(color=sex)) + labs(title = "NHANES cohort (18.5 <= BMI < 24.9)") + labs(x='age [year]') + theme_bw()

