% Test script for simulating the SBML
% Loads the equations from the SBML, creates the ODEs and performs some
% simple simulations.
% Events and varying compartments are currently not supported.
%
%   author: Matthias Koenig (all Copyrights reserved)
%   date: 2014-02-11
file = '/home/mkoenig/multiscale-galactose/matlab/sbml/Galactose_Dilution_v3_Nc1_Nf1.xml'
model = TranslateSBML(file);


