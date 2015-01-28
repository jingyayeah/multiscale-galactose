################################################################
# Classification Functions
################################################################
# Functions for the classification of GEC in healthy & disease.
# Covers part of the logistic regression approaches and the 
# prediction via the distribution of simulated GEC values.
# 
# author: Matthias Koenig
# date: 2015-01-28
################################################################

################################
# Classification data         
################################
#' Classification directory
#' @export
get_classification_dir <- function(){
  dir <- file.path(ma.settings$dir.base, "results", "classification")
}

#' Saves classification data.
#' @export
save_classification_data <- function(data, name, dir=get_classification_dir()){
  r_fname <- file.path(dir, sprintf('%s.Rdata', name))
  csv_fname <- file.path(dir, sprintf('%s.csv', name))
  
  cat('Save: ', r_fname, '\n')
  cat('Save: ', csv_fname, '\n')
  save('data', file=r_fname)
  write.table(file=csv_fname, x=data, na="NA", row.names=FALSE, quote=FALSE,
              sep="\t", col.names=TRUE)
}


#' Load GEC & GECkg classification data
#' 
#'@export
load_classification_data <- function(name, dir=get_classification_dir()){
  r_fname <- file.path(dir, sprintf('%s.Rdata', name))
  cat('Load: ', r_fname, '\n')
  load(file=r_fname)
  return(data)
}

############################################
# Data Preparation Functions
############################################

#' Read data into standard data frame for prediction.
#' 
#' @export
prepare_data <- function(data, fields){
  df <- data.frame(matrix(NA, ncol=length(fields), nrow=nrow(data)) )
  names(df) <- fields
  for (k in 1:length(fields)){
    name <- fields[k]
    if (name %in% names(data)){
      df[ ,k] <- data[[name]] 
    }
  }
  return(df)
}

#' Prepare data for the GEC prediction.
#' 
#' @export
prepare_GEC_data <- function(name){
  fields <- c('study', 'sex', 'age', 'bodyweight', 'height', 'BSA', 
              'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg', 'GEC', 'GECkg', 'status')
  data <- loadRawData(name)
  df <- prepare_data(data, fields)
}

#' Create one combined data.frame.
#' 
#' @export
classification_data_raw <- function(names){
  # combine raw data
  df.list <- list(length(names))
  for (k in 1:length(names)){
    name <- names[k]
    df <- prepare_GEC_data(name)
    cat(nrow(df), '\n')
    df.list[[k]] <- df
  }
  library('reshape')
  df <- reshape::merge_all(df.list)
  
  # create the classification outcome (liver disease) & check that binary classifier
  df$status <- as.factor(df$status)
  df$disease = as.numeric(df$status != 'healthy')
  
  # resequence the row names
  rownames(df) <- 1:nrow(df)  
  
  return(df)
}
