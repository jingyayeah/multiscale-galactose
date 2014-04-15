\name{readPPPVDataForSimulation}
\alias{readPPPVDataForSimulation}
\title{Load the PP and PV data for single simulation by sim name
The timecourse for the data should exists. This can be checked with
via the simulation status in the parameter files.}
\usage{
readPPPVDataForSimulation(dir, simId, withTime = F)
}
\arguments{
  \item{sim}{simulation identifier}

  \item{withTime}{keeps the time column}
}
\value{
PPPV data
}
\description{
Load the PP and PV data for single simulation by sim name
The timecourse for the data should exists. This can be
checked with via the simulation status in the parameter
files.
}

