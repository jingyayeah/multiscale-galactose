################################################################################
# Liver volume, blood flow & GEC predictions for cohort.
################################################################################
# Predict liver volume, blood flow and metabolic functions for the
# NHANES cohort. 
# Based on the individual samples of blood flow an liver the GEC clearance
# is calculated.
#
# author: Matthias Koenig
# date: 2015-02-18
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

################################
# GAMLSS models
################################
fit.models <- load_models_for_prediction()

################################
# GEC function (f_GE)
################################
file_GE_f <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
load(file=file_GE_f)
f_GE(gal=8.0, P=1, age=20)

################################
# Predict RAW people
################################
cat('* PREDICT RAW *\n')

# Predict liver information & GEC for datasets used in model building
# liver volume
people.raw <- create_all_people(c('mar1988',
                                  'cat2010',
                                  'wyn1989',
                                  'naw1998',
                                  'boy1933',
                                  'hei1999'
))

# people.raw <- create_all_people(c(
#                                   'wyn1989',
#                                   'hei1999'
#                                   ))

               
# store the experimental volumes
summary(people.raw)
people.raw$exp_volLiver <- people.raw$volLiver
people.raw$exp_volLiverkg <- people.raw$volLiverkg
# clear so that volumes are predicted
people.raw$volLiver <- NA
people.raw$volLiverkg <- NA
# reduce to proper subsets
people.volLiver <- people.raw[!is.na(people.raw$exp_volLiver), ]     # 1051 (674)
people.volLiverkg <- people.raw[!is.na(people.raw$exp_volLiverkg), ] # 695 (674)
str(people.volLiver)
str(people.volLiverkg)

# look for the correlations 
with(people.raw, 
     {
       par(mfrow=c(1,3))
       plot(age, bodyweight, cex=2*exp_volLiver/max(exp_volLiver, na.rm=TRUE), 
                      pch=21, bg=rgb(1,0,0,0.5) )
       plot(bodyweight, BSA, cex=2*exp_volLiver/max(exp_volLiver, na.rm=TRUE), 
                      pch=21, bg=rgb(1,0,0,0.5) )
       plot(bodyweight, height, cex=2*exp_volLiver/max(exp_volLiver, na.rm=TRUE), 
                      pch=21, bg=rgb(1,0,0,0.5) )
       par(mfrow=c(1,1))
     }
)

# linear regression
formula <- 'exp_volLiver ~ age + bodyweight + height'
model <- glm(formula, data=people.raw, family="gaussian")  
summary(model)
reg.volLiver <- predict(model, newdata = people.raw, type = "response")

plot(people.raw$exp_volLiver, reg.volLiver, pch=21, bg=rgb(1,0,0,0.5),
     xlim=c(0,3000), ylim=c(0,3000), cex=0.7)
abline(a=0, b=1, col='black', lwd=2) 

# which functions used
f_d.volLiver.pars(people.volLiver[1,], sex_split=FALSE)

info.volLiver <- predict_liver_people(people.volLiver, Nsample=1000, sex_split=FALSE, Ncores=11)
GEC.volLiver <- predict_GEC(f_GE, 
            volLiver=info.volLiver$volLiver, 
            flowLiver=info.volLiver$flowLiver,
            ages=people.volLiver$age)


m.volLiver <- rowMeans(info.volLiver$volLiver)
sd.volLiver <- rowSds(info.volLiver$volLiver)
qlow.volLiver <- rowQuantiles(info.volLiver$volLiver, probs=0.05)
qhigh.volLiver <- rowQuantiles(info.volLiver$volLiver, probs=0.95)
# psize <- 2* people.volLiver$bodyweight/max(people.volLiver$bodyweight)
# psize <- 2* people.volLiver$BSA/max(people.volLiver$BSA, na.rm = TRUE)
# psize[is.na(psize)] <- 0
psize = 0.7

par(mfrow=c(2,2))
plot(people.volLiver$exp_volLiver, m.volLiver, pch=21, bg=rgb(1,0,0,0.5),
     xlim=c(0,3000), ylim=c(0,3000), cex=psize)
abline(a=0, b=1, col='black', lwd=2)
# SD segments
# segments(people.volLiver$exp_volLiver, m.volLiver-sd.volLiver,
#          people.volLiver$exp_volLiver, m.volLiver+sd.volLiver, col=rgb(1,0,0,0.4))
# 95% segments
#segments(people.volLiver$exp_volLiver, qlow.volLiver,
#         people.volLiver$exp_volLiver, qhigh.volLiver, col=rgb(1,0,0,0.4))

plot(people.volLiver$exp_volLiver, m.volLiver-people.volLiver$exp_volLiver, 
     cex=psize, pch=21, bg=rgb(1,0,0,0.5),
     xlim=c(0,3000), ylim=c(-1500,1500))
abline(h=0, col='black', lwd=2)

# Linear regression model
plot(people.raw$exp_volLiver, reg.volLiver, pch=21, bg=rgb(1,0,0,0.5),
     xlim=c(0,3000), ylim=c(0,3000), cex=psize)
abline(a=0, b=1, col='black', lwd=2) 

par(mfrow=c(1,1))


################################
# Predict NHANES cohort
################################
cat('* PREDICT NHANES *\n')
# prepare NHANES people
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
people.nhanes <- data[, c('SEQN', 'sex', 'bodyweight', 'age', 'height', 'BSA')]
people.nhanes$volLiver <- NA
people.nhanes$volLiverkg <- NA
# people.nhanes <- people.nhanes[1:10, ]
rm(data)

info.nhanes <- predict_volume_and_flow(people=people.nhanes, out_dir=dir.nhanes)
GEC = predict_GEC(f_GE,
                  volLiver=info.nhanes$volLiver, 
                  flowLiver=info.nhanes$flowLiver,
                  age=people.nhanes$age)
save(GEC, file=file.path(dir.nhanes, 'GEC.Rdata'))

# -------------------------------------
# Loading and working with dataset
# -------------------------------------
load(file=file.path(dir.nhanes, 'volLiver.Rdata'))
load(file=file.path(dir.nhanes, 'flowLiver.Rdata'))
load(file=file.path(dir.nhanes, 'GEC.Rdata'))

cat('# Liver Volume #')
head(volLiver[, 1:5])
cat('# Liver Blood Flow #')
head(flowLiver[, 1:5])
cat('# GEC #')
head(GEC[, 1:5])

index <- 2
individual_plot(person=people.nhanes[index, ], 
                vol=volLiver[1, ], flow=flowLiver[1,], 
                data=GEC[1, ])
