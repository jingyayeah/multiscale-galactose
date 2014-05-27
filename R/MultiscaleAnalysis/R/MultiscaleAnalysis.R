################################################################
## MultiscaleAnalysis Settings
################################################################
# Global settings for the project. Especially set the global path
# to code and results which will be reused from all the other 
# R files.
#
# author: Matthias Koenig
# date: 2014-04-15
################################################################

# Set this as base folder, where the project was checked out to 
dir.base <- '/home/mkoenig/multiscale-galactose'
dir.code    <- file.path(dir.base, 'R')
dir.expdata <- file.path(dir.base, 'experimental_data')

# This is the folder where all the result files are (i.e. finished simulations)
dir.results <- '/home/mkoenig/multiscale-galactose-results'
dir.simdata <- '/home/mkoenig/multiscale-galactose-results'

simulator = "ROADRUNNER" # COPASI
################################################################
#' Available settings for the MultiscaleAnalysis package
#' @export
ma.settings <- list(dir.base=dir.base,
                    dir.code=dir.code,
                    dir.expdata=dir.expdata,
                    dir.simdata=dir.simdata,
                    dir.results=dir.results,
                    simulator=simulator)
################################################################