##############################################################################
# Shiny apps have two components:
# * a user-interface script
# * a server script
# The user-interface (ui) script controls the layout and appearance of your app. 
# It is defined in a source script named ui.R.
##############################################################################


install.packages("shiny")
library('shiny')
runExample("01_hello")

library('MultiscaleAnalysis')
setwd(file.path(ma.settings$dir.code, 'shiny'))
library('shiny')
runApp("my_app2", display.mode = "showcase")


# Shiny Galery
system.file("examples", package="shiny")
runExample("02_text")

install.packages(c("maps", "mapproj"))
library(maps)
library(mapproj)
source("census-app/helpers.R")
counties <- readRDS("census-app/data/counties.rds")
percent_map(counties$white, "darkgreen", "% white")
