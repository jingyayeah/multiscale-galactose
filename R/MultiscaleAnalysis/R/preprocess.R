################################################################
# Preprocess Data
################################################################
# Read the timecourse data (CSV) and creates reduced data
# structures consisting of some components of the full
# sinusoidal system.
# All simulation csv have been collected in a common folder.
# Main challenge is the combination of the timecourses based
# the varying timesteps used for simulation.
# Important part is also dimension reduction of the data
# structure.
#
# author: Matthias Koenig
# date: 2014-12-06
################################################################

#' Preprocess the results for given task.
#' 
#' Generates the combined Rdata file for the selected ids.
#' The collection of data files to be preprocessed is defined via
#  the folder variable which encodes the task
#' @export
preprocess_task <- function(folder, ids=preprocess.ids, force=FALSE){
  # folder <- '2014-11-17_T5'
  if (missing(folder))
    stop('Need to specify folder for preprocessing.')

  # create results folder
  dir <- file.path(ma.settings$dir.results, folder)
  dir.create(file.path(dir, 'results'), showWarnings = FALSE)
  
  # process folder 
  tmp <- strsplit(folder, '_')
  date <- tmp[[1]][1]
  task <- tmp[[1]][2]
  modelXML <- list.files(path=file.path(ma.settings$dir.results, folder), pattern='.xml')
  modelId <- substr(modelXML,1,nchar(modelXML)-4)
  rm(tmp, modelXML)  
    
  # read parameter file & extend with SBML information
  parsfile <- file.path(dir, sprintf('%s_%s_parameters.csv', task, modelId))
  cat(parsfile, '\n')
  pars <- loadParameterFile(file=parsfile)
  
  # extend the parameter information with info from SBML file
  ps <- getParameterTypes(pars=pars)
  f.sbml <- file.path(dir, sprintf('%s.xml', modelId))
  model <- loadSBMLModel(f.sbml)
  pars <- extendParameterStructure(pars=pars, fixed_ps=ps$fixed, model=model)
  
  # Preprocess timecourses as Rdata
  simIds = rownames(pars)  
  x.fname <- file.path(dir, 'results', 'x.Rdata')
  cat('Creating data matrix ...\n')
  if (file.exists(x.fname) & force==FALSE){
    load(file=x.fname)
    cat('Preprocessed data exists and is loaded.\n')
  } else {
    dir.simdata <- file.path(ma.settings$dir.results, 'django', 'timecourse', task)
    x <- createPreprocessDataMatrices(ids=ids, out.fname=x.fname, simIds=simIds, modelId=modelId, dir=dir.simdata)
  }
  return(list(task=task, pars=pars, ids=ids, x=x, f.sbml=f.sbml, folder=folder))
}


