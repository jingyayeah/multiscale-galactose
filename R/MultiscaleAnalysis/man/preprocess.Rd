\name{preprocess}
\alias{preprocess}
\title{Preprocess the CSV simulation data for given parameter file.}
\usage{
preprocess(pars, sim.dir, outFile = NULL, sim.indices = NULL,
  col.indices_f = NULL, time = NULL)
}
\arguments{
  \item{parsfile}{Parameter file}

  \item{sim.dir}{directory with simulation data}

  \item{sim.indices}{which simulations to take}

  \item{col.indices_f}{function to get column indices to
  take}
}
\value{
outFile file with the saved data
}
\description{
Preprocess the CSV simulation data for given parameter
file.
}

