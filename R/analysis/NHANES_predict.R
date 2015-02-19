################################################################################
# Liver volume, blood flow & GEC predictions for cohort.
################################################################################
# Predict liver volume, blood flow and metabolic functions for the
# NHANES cohort. Based on the individual samples of blood flow an 
# liver GEC is calculated.
#
# author: Matthias Koenig
# date: 2015-02-18
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

cat('# PREDICT NHANES #\n')

# -------------------------------------
# GAMLSS models
# -------------------------------------
fit.models <- load_models_for_prediction()

# -------------------------------------
# GEC function (f_GE)
# -------------------------------------
file_GE_f <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
load(file=file_GE_f)
# f_GE(gal=8.0, P=1, age=20)

# -------------------------------------
# Predict NHANES cohort
# -------------------------------------
# prepare NHANES people
load(file=file.path(dir.nhanes, 'nhanes_data.Rdata'))
people.nhanes <- data[, c('SEQN', 'sex', 'bodyweight', 'age', 'height', 'BSA')]
people.nhanes$volLiver <- NA
people.nhanes$volLiverkg <- NA
# people.nhanes <- people.nhanes[1:10, ]
save(people.nhanes, file=file.path(dir.nhanes, 'nhanes_people.Rdata'))
rm(data)

# prediction
warning("NHANES prediction takes ~20 minutes")

ptm <- proc.time()
info <- predict_liver_people(people.nhanes, Nsample=1000, sex_split=FALSE, Ncores=11)
time <- proc.time() - ptm
print(time)

# store results
cat('* Saving data *\n')
volLiver <- info$volLiver
flowLiver <- info$flowLiver
vol_path <- file.path(dir.nhanes, 'nhanes_volLiver.Rdata')
flow_path <- file.path(dir.nhanes, 'nhanes_flowLiver.Rdata')
cat(vol_path, '\n')
cat(flow_path, '\n')
save('volLiver', file=vol_path)
save('flowLiver', file=flow_path)  

# predict GEC
GEC = predict_GEC(f_GE,
                  volLiver=volLiver, 
                  flowLiver=flowLiver,
                  age=people.nhanes$age)
save(GEC, file=file.path(dir.nhanes, 'nhanes_GEC.Rdata'))

# -------------------------------------
# Loading and working with dataset
# -------------------------------------
rm(volLiver, flowLiver, GEC)
load(file=file.path(dir.nhanes, 'nhanes_volLiver.Rdata'))
load(file=file.path(dir.nhanes, 'nhanes_flowLiver.Rdata'))
load(file=file.path(dir.nhanes, 'nhanes_GEC.Rdata'))

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
