% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/preprocess_functions.R
\name{createPreprocessDataMatrices}
\alias{createPreprocessDataMatrices}
\title{Create data matrices.}
\usage{
createPreprocessDataMatrices(ids, out.fname, simIds, modelId, dir)
}
\description{
Main function of preprocessing the csv data from integration.
Creates list of lists for the given ids from the timeseries data.
Perfoms Dimensionality reduction and adds interpolated timepoints
for the events
Creates data matrices for the given ids and selected simulations.
Most of the time if the simulation number is not (>10000) no
restriction of the simulations via simIds is necessary.
}

