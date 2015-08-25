################################################################
## Global settings for GE curves
################################################################
# Here the simulations tasks & folders are defined.
# I.e. the latest information which GE curves to use.
#
# author: Matthias Koenig
# date: 2015-02-12
################################################################

#' Returns the current model version
#' 
#' @export
model_version <- function(){
  version = 107
  return(version)
}

#' Definition of GE curves for age dependency.
#' Depends on model. Update this folder when model is updated.
#' 
#' @export
get_age_GE_folders <- function(){
  version <- model_version()
  if (version==106){
    fs <- list( 
      # VERSION 106
      normal20 = '2015-02-12_T27',  # GEC ~ f_flow, gal (20 years)
      normal60 = '2015-02-12_T28',  # GEC ~ f_flow, gal (60 years)
      normal100 = '2015-02-12_T29'  # GEC ~ f_flow, gal (100 years)
    )  
  }
  if (version==107){
    fs <- list( 
      # VERSION 107
      normal20 = '2015-02-13_T35',  # GEC ~ f_flow, gal (20 years)
      normal60 = '2015-02-13_T36',  # GEC ~ f_flow, gal (60 years)
      normal100 = '2015-02-13_T37'  # GEC ~ f_flow, gal (100 years)
    )  
  }
  return(fs)
}

#' Definition of GE curves for Vmax dependency.
#' 
#' @export
get_vmax_GE_folders <- function(){
  fs <- list(
  )
  return(fs)
}

#' Preprocess set of data.frame of GE folders.
#' 
#' @export
integrate_GE_folders <- function(df_folders, 
                                  factors=c('f_flow', "gal_challenge"),
                                  force=FALSE,
                                  t_end=10000,
                                  f_tissue=0.85,
                                  vol_liver=1500){
  parscl <- list()
  dfs <- list()
  for (name in names(df_folders)){
    cat(name, '\n')
    # preprocess raw data
    processed <- preprocess_task(folder=df_folders[[name]], force=FALSE)
    # additional parameters in data frame
    parscl[[name]] <- extend_with_galactose_clearance(processed=processed, t_end=t_end)
    # perform integration over the sinusoidal units
    dfs[[name]] <- ddply(parscl[[name]], factors, 
                       f_integrate_GE, f_tissue=f_tissue, vol_liver=vol_liver)
  }
  return(list(parscl=parscl, 
              dfs=dfs))
}