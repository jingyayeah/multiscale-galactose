\name{readPPPVData}
\alias{readPPPVData}
\title{Read all PP__ and PV__ components in a list structure.
Parameter data pars has to be available in environment. For all simulations
the csv ode solutions are loaded and the necessary components extracted.}
\usage{
readPPPVData(pars, dir, max_index = -1)
}
\arguments{
  \item{max_index}{maximal index until which data is read}
}
\value{
list of PPPV data matrices
}
\description{
Read all PP__ and PV__ components in a list structure.
Parameter data pars has to be available in environment. For
all simulations the csv ode solutions are loaded and the
necessary components extracted.
}

