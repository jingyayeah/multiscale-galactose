\name{reduceDimension}
\alias{reduceDimension}
\title{Dimension reduction of timecourse data frames.}
\usage{
reduceDimension(df, eps = 1e-08)
}
\description{
The main idea is to reduce the amount of information
necessary to encode the non-changing components in the
solution. I.e. elements of one component of the integration
solution are reduced to the changing time points. The first
and last element are kept as well as all inner elements,
which are not identical to the previous ones, within a
certain tolerance. The tolerance is here selected in
accordance with the absolute tolerances of the integration
(which is 1E-6).
}

