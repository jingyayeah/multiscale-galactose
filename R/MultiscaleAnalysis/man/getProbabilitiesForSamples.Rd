\name{getProbabilitiesForSamples}
\alias{getProbabilitiesForSamples}
\title{Calculates probability for sample based ECDFs.}
\usage{
getProbabilitiesForSamples(pars, f.ecdf, name)
}
\arguments{
  \item{pars}{parameter structure}

  \item{p.gen}{distribution generator functions}

  \item{name}{name of parameter}
}
\description{
In which units is it coming out (transformed units) !
Important to keep track of the units ! TODO: the order is
very important TODO: do the fit for unscaled data in basis
units - scaling is generating lots of problems throughout
TODO: generalize to arbitrary distributions of parameters
}

