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
people.raw <- create_all_people(c('hei1999', 'cat2010'))
people.raw <- people.raw[1:10, ]
info.raw <- predict_volume_and_flow(people=people.raw, out_dir=dir.raw)
GEC.raw <- predict_GEC(f_GE, 
            volLiver=info.raw$volLiver, 
            flowLiver=info.raw$flowLiver,
            ages=people.raw$age)

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
