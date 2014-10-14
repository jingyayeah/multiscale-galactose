rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

# gender color (all, male, female)
gender.levels <- c('all', 'male', 'female')
gender.cols = c("black", "blue", "red")

##############################################
# Read datasets
##############################################
f_liver_density = 1.08  # [g/ml] conversion between volume and weight

# sex, age, liverVolume
marG2 <- read.csv(file.path(ma.settings$dir.expdata, "Marchesini", "Koenig_G2.csv"), sep="\t")
marG2$gender <- as.character(marG2$sex)
marG2$gender[marG2$gender=='M'] <- 'male'
marG2$gender[marG2$gender=='F'] <- 'female'
marG2$gender[marG2$gender=='A'] <- 'all'

head(marG2)

library(ggplot2)
plot(marG2$age, marG2$GEC, type='n') 
points(marG2$age[marG2$gender=='male'], marG2$GEC[marG2$gender=='male'], col='Blue') 
points(marG2$age[marG2$gender=='female'], marG2$GEC[marG2$gender=='female'], col='Red') 

summary(marG2$type)
plot(marG2$age, marG2$GEC, type='n') 
points(marG2$age[marG2$type=='N'], marG2$GEC[marG2$type=='N'], col='Black') 
points(marG2$age[marG2$type=='E'], marG2$GEC[marG2$type=='E'], col='Red') 
points(marG2$age[marG2$type=='R'], marG2$GEC[marG2$type=='R'], col='Blue') 
points(marG2$age[marG2$gender=='female'], marG2$GEC[marG2$gender=='female'], col='Red') 

plot(marG2$age, marG2$GECkg, type='n') 
points(marG2$age[marG2$type=='E'], marG2$GECkg[marG2$type=='E'], col='Red') 

plot(marG2$age, marG2$weight) 
