################################################################################
# Liver volume, blood flow & GEC predictions for cohort.
################################################################################
# Predict liver volume, blood flow and metabolic functions for the
# NHANES cohort. 
# Based on the individual samples of blood flow an liver the GEC clearance
# is calculated.
#
# author: Matthias Koenig
# date: 2014-12-05
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

################################
# GAMLSS models
################################
fit.models <- load_models_for_prediction()

################################
# GEC function to use
################################
GEC_f <- GEC_functions(task='T54')
names(GEC_f)
plot_GEC_function(GEC_f)

################################
# Predict RAW people
################################
cat('* PREDICT RAW *\n')
# Predict the information from cohort data used for model generation.
# These cover subsets not available in the NHANES data, namely very young and
# very old persons.
people.raw <- create_all_people(c('hei1999', 'cat2010'))
people.raw <- people.raw[1:10, ]

dir.raw <- file.path(ma.settings$dir.base, 'results', 'rest')

info.raw <- predict_volume_and_flow(people=people.raw, out_dir=dir.raw)
predict_GEC(people.raw, GEC_f=GEC_f, 
            volLiver=info.raw$volLiver, flowLiver=info.raw$flowLiver, 
            out_dir=dir.raw)

################################
# Predict NHANES cohort
################################
cat('* PREDICT NHANES *\n')
# prepare NHANES people
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
people.nhanes <- data[, c('SEQN', 'sex', 'bodyweight', 'age', 'height', 'BSA')]
people.nhanes$volLiver <- NA
people.nhanes$volLiverkg <- NA
people.nhanes <- people.nhanes[1:10, ]
rm(data)
dir.nhanes <- file.path(ma.settings$dir.base, 'results', 'nhanes')
info.nhanes <- predict_volume_and_flow(people=people.nhanes, out_dir=dir.nhanes)

typeof(people.nhanes)

predict_GEC(people.nhanes, GEC_f=GEC_f,
            volLiver=info.nhanes$volLiver, flowLiver=info.nhanes$flowLiver,
            out_dir=dir.nhanes)

# test loading
load(file=file.path(dir.nhanes, 'volLiver.Rdata'))
load(file=file.path(dir.nhanes, 'flowLiver.Rdata'))
load(file=file.path(dir.nhanes, 'GEC.Rdata'))
cat('# Liver Volume #')
head(volLiver[, 1:5])
cat('# Liver Blood Flow #')
head(flowLiver[, 1:5])
cat('# GEC #')
head(GEC[, 1:5])

index <- 1
individual_plot(person=people.nhanes[index, ], 
                vol=volLiver[1, ], flow=flowLiver[1,], 
                data=GEC[1, ])



