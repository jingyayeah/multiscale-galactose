\name{f_integrate_GEC}
\alias{f_integrate_GEC}
\title{Calculation of galactose clearance parameters via integration
of multiple sinusoidal units (region of interest).
Important to integrate only over samples from the same underlying distribution.
mean & sd values are the mean and sd between the different sinusoidal
units.
Q_per_vol & R_per_vol are the perfusion of the region of interest and
the corresponding removal of galactose per region of interest.
Be aware of the units !}
\usage{
f_integrate_GEC(x)
}
\arguments{
  \item{x}{Called with extended parameter data.frame
  containing clearance per sinusoidal unit.}
}
\description{
Calculation of galactose clearance parameters via
integration of multiple sinusoidal units (region of
interest). Important to integrate only over samples from
the same underlying distribution. mean & sd values are the
mean and sd between the different sinusoidal units.
Q_per_vol & R_per_vol are the perfusion of the region of
interest and the corresponding removal of galactose per
region of interest. Be aware of the units !
}

