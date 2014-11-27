\name{getProbabilitiesForData}
\alias{getProbabilitiesForData}
\title{Calculates probability for sample based ECDFs.}
\usage{
getProbabilitiesForData(x, f.ecdf, lb = 0, ub = 10 * max(x))
}
\arguments{
  \item{x}{data to calculate probabilities for}

  \item{f.ecdf}{underlying empirical cumulative
  distribution function}
}
\value{
list with fields p (probabilites) and mpoints (used
midpoints)
}
\description{
Uses the given ECDF to get the associated probabilities for
the data points.
}

