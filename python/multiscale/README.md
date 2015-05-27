# Multiscale-Model support for Liver Modelling

Key components are the **ModelCreator** for setting up cell, sinusoidal unit and liver models,
the **odesim** simulator, to run and setup simulations and the **MultiscaleSite**, the database
backend and management layer.
The simulator package provides tools and helpers for managing and running simulations.
Simulations can either be defined and run without database backend, or managed
via the intermediate database backend,

## ModelCreator
The ModelCreator creates SBML models for simulation.

## ODESim
The package provides support for the creation of simulation series based
on sampling parameters from distributions.
The necessary functions for model simulatons are provided, i.e. numerical ODE integration based on RoadRunner.
Multiple solver and types of simulations will be supported in the future (constraint-based models).

## MultiscaleSite
Provides a django database backend for managing the simulations.

* analysis/plots
=> generation of derived results. For instance gennerate plots for single simulations,
 or task based results.

 TODO: manage set of tasks in a super class.
 => generation of additional model results, i.e. analysis which spans multiple tasks.

 TODO: refactor
 => the analysis should not be part of the database/django backend.
 The database functionality has to be restricted to the actual database management functionality.

 Important: Clear split of functionality. I.e. database functionality in django, SBML model creation,
 and annotation in modelcreator.
 Everything with simulation setup & performing simulations in the simulator.

 TODO: finish the roundtrip for the demo model & galactose flow & pressure models
 TODO: model creator => hierarchical models.
 Generate blueprint models &

