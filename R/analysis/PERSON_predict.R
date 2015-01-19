rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# GAMLSS models
fit.models <- load_models_for_prediction()

# GEC function to use
GEC_f <- GEC_functions(task='T1')
names(GEC_f)
plot_GEC_function(GEC_f)

# personalized data
gender = 'male'
age = 70
bodyweight = 70
height = 170

person <- data.frame(study='None', sex=gender, age=age, bodyweight=bodyweight, height=height, 
                     BSA=NA, volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE)
print(person)

liver.info <- predict_liver_people(person, Nsample=1000, Ncores=1)
volLiver <- liver.info$volLiver
flowLiver <- liver.info$flowLiver

GEC.info <- calculate_GEC(GEC_f, volLiver, flowLiver)
GEC <- GEC.info$values
GECkg <- GEC/bodyweight
hist(GEC)