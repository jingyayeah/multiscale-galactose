\name{extend_with_galactose_clearance}
\alias{extend_with_galactose_clearance}
\title{Calculates clearance information for sinusoidal unit.}
\usage{
extend_with_galactose_clearance(processed, t_peak, t_end)
}
\description{
Here the central calculation of clearance for a sinusoidal
unit based on the periportal and perivenious steady state
concentration differences is performed. For ever sinusoidal
unit the data is calculated. In a first step the timecourse
matrix is approximated for the steady state data point
(tend), which is necessary due to the variable time steps
in the individual integrations. In a second step the actual
clearance parameters are calculated based on the steady
state concentration matrix.
}

