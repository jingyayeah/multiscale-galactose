################################################################
## MultiscaleAnalysis Settings
################################################################
# Global settings for the project. 
# Here the global path to the information is defined and general
# reused settings through the analysis. 
#
# author: Matthias Koenig
# date: 2014-12-06
################################################################
library('methods')
library('plyr')
library('data.table')
library('matrixStats')
library('gamlss')

# Set this as base folder, where the project was checked out to 
dir.base = '/home/mkoenig/multiscale-galactose'
dir.code    = file.path(dir.base, 'R')
dir.expdata = file.path(dir.base, 'experimental_data')

# This is the folder where all the result files are (i.e. finished simulations)
dir.results = '/home/mkoenig/multiscale-galactose-results'
dir.simdata = '/home/mkoenig/multiscale-galactose-results'

simulator = "ROADRUNNER" # COPASI
################################################################
#' Available settings for the MultiscaleAnalysis package
#' @export
ma.settings = list(dir.base=dir.base,
                    dir.code=dir.code,
                    dir.expdata=dir.expdata,
                    dir.simdata=dir.simdata,
                    dir.results=dir.results,
                    simulator=simulator)


# Timecourses for ids loaded from the full set of data via preprocessing
# The ids have to be part of the dictionary of the available names, which
# is available in the SBML or via the CSV/Rdata.
#   fname = getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[1])
#   ids.dict = names(data)
# In standard analysis only the periportal and perivenious concentrations are used
preprocess.ids = c("PP__alb", "PP__gal", "PP__galM", "PP__h2oM", "PP__rbcM", "PP__suc",
         "PV__alb", "PV__gal", "PV__galM", "PV__h2oM", "PV__rbcM", "PV__suc")

################################################################
# Definition of axis names, limits, colors for data sets.
# Additional data information used for plots and analysis
# main purpose for automatically generating the images
# for the various xname, yname combinations of available data

#' Add an alpha value to a colour
#' @export
add.alpha = function(col, alpha=1){
  if(missing(col))
    stop("Please provide a vector of colours.")
  ncol = apply(sapply(col, col2rgb)/255, 2,
        function(x)
          rgb(x[1], x[2], x[3], alpha=alpha))
  names(ncol) = names(col)
  return(ncol)
}

# different styles for main gender classes
gender.levels = c('all', 'male', 'female')
names(gender.levels) = gender.levels
# symbols
gender.symbols = c(21, 22, 23)
names(gender.symbols) = gender.levels
# colors
gender.cols_base = c(rgb(0,0,0, alpha=1.0), rgb(0,0,1, alpha=1.0), rgb(1,0,0, alpha=1.0))
names(gender.cols_base) = gender.levels
gender.cols = add.alpha(gender.cols_base, 0.5)
gender.cols_light = add.alpha(gender.cols_base, 0.1)


#' Axis labels
#' @export
lab = list(age = "Age [years]",
  bodyweight = "Body weight [kg]",
  height = "Height [cm]",
  BSA = "Body surface area (BSA) [m^2]",
  GEC = "GEC [mmol/min]",
  GECkg = "GEC per bodyweight [mmol/min/kg]",
  volLiver = "Liver volume [ml]",
  volLiverkg = "Liver volume per bodyweight [ml/kg]",
  volLiverBSA = "Liver volume per BSA [ml/m^2]",
  flowLiver = "Liver blood flow [ml/min]",
  flowLiverkg = "Liver blood flow per bodyweight [ml/min/kg]",
  perfusion = "Perfusion [ml/min/ml]"
)

#' Axis limits
#' @export
lim = list(age = c(0, 100),
  bodyweight = c(0, 135),
  height = c(0, 220),
  BSA = c(0, 3.1),
  GEC = c(0, 5.0),
  GECkg = c(0, 0.10),
  volLiver = c(0, 3200),
  volLiverkg = c(0, 90),
  volLiverBSA = c(0, 3200),
  flowLiver = c(0, 2800),
  flowLiverkg = c(0, 90),
  perfusion = c(0, 2)
)
