# Multiscale-Model Database & Simulator

The simulator package provides tools and helpers for the running of simulations.
The simulations can be defined and run without database backend, or managed
via the intermediate database backend,
i.e. storage of simulations and parameters in the database and subsequent use
for simulations.
Scripts and functions for simulation definitions, automatic integration and storage of results.

# dist
Distribution support.
Defining distributions for sampling of parameters or values.

* grids
Support for parameter sampling. Creation of similar simulation
settings/parameters than the sampling, but based on grids for
parameters.

* models
Example models and helper functions to generate model-specific simulation
definitions.

* integrate/simulate
This is independent of the simulation generation.
A set of simulations is send to the simulator. This should be possible with and
without database backend.
Runs the actual simulations.
Create flexible structure to support simulations via various solvers.

Alternative simulation definitions should be supported.
For instance FBA/constainted based methods.
The simulation backends, like RoadRunner or COPASI will be run via the identical
database backend.
Adaptions to the siulation setup and storage in the database can be possible.

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

