################################################################################
# Load NHANES files & combine for analysis
################################################################################
# Use of the continuus NHANES files (1999-2012).
# The important subset used for analysis consists of the demographic information,
# and the body measurements (BMX and DEMO subsets).
# No filtering is performed here, only merging in the various subsets of data.
# 
# An important point is the complex study sampling design underlying 
# NHANES, which oversamples certain subpopulations (!). 
# Without accounting for the study design certain inferences are not valid.
#
# data downloaded from [http://www.cdc.gov/nchs/nhanes/nhanes_questionnaires.htm]
#
# author: Matthias Koenig
# date:   2014-11-25
################################################################################
rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
library(foreign)

# NHANES (1999-2000)
bmx.A <- read.xport("data/BMX_A.XPT")
demo.A <- read.xport("data/DEMO_A.XPT")
# NHANES (2001-2002)
bmx.B <- read.xport("data/BMX_B.XPT")
demo.B <- read.xport("data/DEMO_B.XPT")
# NHANES (2003-2004)
bmx.C <- read.xport("data/BMX_C.XPT")
demo.C <- read.xport("data/DEMO_C.XPT")
# NHANES (2005-2006)
bmx.D <- read.xport("data/BMX_D.XPT")
demo.D <- read.xport("data/DEMO_D.XPT")
# NHANES (2007-2008)
bmx.E <- read.xport("data/BMX_E.XPT")
demo.E <- read.xport("data/DEMO_E.XPT")
# NHANES (2009-2010)
bmx.F <- read.xport("data/BMX_F.XPT")
demo.F <- read.xport("data/DEMO_F.XPT")
# NHANES (2011-2012)
bmx.G <- read.xport("data/BMX_G.XPT")
demo.G <- read.xport("data/DEMO_G.XPT")

##############################
# Load continous NHANES data #
##############################
info <- data.frame(id=c('A', 'B', 'C', 'D',
                        'E', 'F', 'G'), 
                   period=c('1999-2000', '2001-2002', '2003-2004', '2005-2006',
                            '2007-2008', '2009-2010', '2011-2012'), stringsAsFactors=F) 

# fields of interest from dataset
# demographic variables list
# http://wwwn.cdc.gov/nchs/nhanes/search/variablelist.aspx?Component=Demographics&CycleBeginYear=2001
# Codebook : http://wwwn.cdc.gov/nchs/nhanes/2001-2002/DEMO_B.htm
demo <- data.frame(id=c('SEQN',
                 'RIAGENDR',
                 'RIDAGEYR',
                 'RIDAGEMN',
                 'RIDRETH1'
                 #'RIDRETH2'
                 ), description=c('Respondent sequence number',
                    'Gender of the sample person',
                    'Best age in years of the sample person at time of HH screening. Individuals 85 and over are topcoded at 85 years of age.',
                    'Best age in months.',
                    'Recode of reported race and ethnicity information'
                    # 'Linked NH3 Race and Ethnicity Recode.'
                    ), stringsAsFactors=F)
# body measurements
# Codebook : http://wwwn.cdc.gov/nchs/nhanes/2001-2002/BMX_B.htm
bmx <- data.frame(id=c('SEQN',
                      'BMXWT',
                      'BMIWT',
                      'BMXHT',
                      'BMIHT',
                      'BMXBMI',
                      'BMXWAIST',
                      'BMIWAIST'),
                 description=c('Respondent sequence number',
                               'Weight (kg)',
                               'Weight Comment',
                               'Standing Height (cm)',
                               'Standing Height Comment',
                               'Body Mass Index (kg/m**2)',
                               'Waist Circumference (cm)',
                               'Waist Circumference Comment'), stringsAsFactors=F)
           

# process all the datasets, i.w. combination of the subsets of interest
# from all the continous periods.
library(plyr)
data <- vector("list", nrow(info))
for (k in 1:nrow(info)){
  letter <- info$id[k]
  print(letter)
  
  # read and merge
  demo.file <- paste("data/DEMO_", letter, ".XPT", sep="")
  print(demo.file)
  demo.data <- read.xport(demo.file)
  bmx.file <- paste("data/BMX_", letter, ".XPT", sep="")
  print(bmx.file)
  bmx.data <- read.xport(bmx.file)
  res <- merge(bmx.data, demo.data , by=c('SEQN'))
  
  # Create the subset dataframe consisting of the variables of interest
  selection <- unique(c(demo$id, bmx$id))
  res <- res[, selection]
  
  ## set additional fields ##
  res$nhanes_id <- info$id[k]
  res$nhanes_period <- info$period[k]
  
  ## code the factors ##
  # gender
  res$RIAGENDR <- as.factor(res$RIAGENDR)
  res$RIAGENDR <- revalue(res$RIAGENDR, c("1"="male", 
                                          "2"="female"))
  # ethnicity
  res$RIDRETH1 <- as.factor(res$RIDRETH1)
  res$RIDRETH1 <- revalue(res$RIDRETH1, c("1"="Mexican American",
                                          "2"="Other Hispanic",
                                          "3"="Non-Hispanic White",
                                          "4"="Non-Hispanic Black",
                                          "5"="Other Race - Including Multi-Racial"))
  levels(res$RIDRETH1)
#   res$RIDRETH2 <- as.factor(res$RIDRETH2)
#   res$RIDRETH2 <- revalue(res$RIDRETH2, c("1"="Non-Hispanic White",
#                                           "2"="Non-Hispanic Black",
#                                           "3"="Mexican American",
#                                           "4"="Other Race - Including Multi-Racial",
#                                           "5"="Other Hispanic"))
  # information
  res$BMIWT <- as.factor(res$BMIWT)
  res$BMIHT <- as.factor(res$BMIHT)
  res$BMIWAIST <- as.factor(res$BMIWAIST)
  
  data[[k]] <- res
}

# install.packages('reshape')
library(reshape)
nhanes <- reshape::merge_all(data)
head(nhanes)
save(nhanes, file='data/nhanes.dat')

################################################################################
# Test data loading
rm(list = ls())
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes.dat')
head(nhanes)
################################################################################