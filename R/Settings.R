################################################################
## Settings 
################################################################
# Global settings for the project. Especially set the global path
# to code and results which will be reused from all the other 
# R files.
#
# author: Matthias Koenig
# date: 2014-04-15

# 1. Place R scripts in a package (a very good idea anyway if you are distributing code to others).
# 2. Place a configuration file in the package that contains info such as paths to data directories.
# 3. Customize the configuration file after installing the package (if necessary). 

################################################################
# ! These settings should not be set anywhere else !
# ! import them if you use them !

# Set this as base folder, where the project was checked out to 
dir.base <- '/home/mkoenig/multiscale-galactose'
dir.code    <- file.path(dir.base, 'R')
dir.expdata <- file.path(dir.base, 'experimental_data')

# This is the folder where all the result files are (i.e. finished simulations)
dir.results <- '/home/mkoenig/multiscale-galactose-results'
