################################################################################
# Prediction of volLiver, flowLiver, GEC, GECkg for cohorts
################################################################################
# Predict liver volume, blood flow and metabolic functions for the data consisting
# of gender, age, bodyweight, height
# Based on the individual samples of blood flow an liver the GEC clearance
# is calculated.
#
# author: Matthias Koenig
# date: 2014-12-05
################################################################################

library('MultiscaleAnalysis')
library('methods')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))
source(file.path(ma.settings$dir.code, 'analysis', 'GAMLSS_predict_functions.R'))
source(file.path(ma.settings$dir.code, 'analysis', 'GEC_predict_functions.R'))

##############################################################################
# Create people
##############################################################################
# Create the people data frame used for prediction 
create_people_from_raw <- function(name){
  x <- loadRawData(name)
  people <- with(x, data.frame(study=study, sex=gender, age=age, bodyweight=bodyweight, height=height, BSA=BSA,
                           volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE))
  return(people)
}

# Creat people from the raw data files like 'hei1999'
create_all_people <- function(names){
  df_list <- lapply(names, create_people_from_raw)
  return ( do.call("rbind", df_list) )  
}

##############################################################################
# Predict liver volume & flow for people
##############################################################################
# Predicting liver volume and blod flow
predict_volume_and_flow <- function(people, out_dir, Nsample=1000, Ncores=11){
    # liver.info <- predict_liver_people(people[1:10,], 1000, Ncores=4)
  
    ptm <- proc.time()
    liver.info <- predict_liver_people(people, Nsample, Ncores=Ncores)
    time <- proc.time() - ptm
    print(time)
    
    cat('* Saving data *\n')
    volLiver <- liver.info$volLiver
    flowLiver <- liver.info$flowLiver
    vol_path <- file.path(out_dir, 'volLiver.Rdata')
    flow_path <- file.path(out_dir, 'flowLiver.Rdata')
    cat(vol_path, '\n')
    cat(flow_path, '\n')
    save('volLiver', file=vol_path)
    save('flowLiver', file=flow_path)  
    return(liver.info)
}


