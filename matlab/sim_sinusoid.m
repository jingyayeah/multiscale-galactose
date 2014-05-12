%% Model of sinusoidal unit
%
% The model of the sinusoid unit consists of blood flow in the sinusoid, 
% exchange of metabolites with the adjacent space of Disse. Hepatocytes
% are able to exchange metabolites with the space of Disse.
% 
% The subdivision of the blood compartments and space of Disse is smaller 
% than the cells, consequently every single cell has Nf 
% multiple adjacent compartments. The complete layout
% consists of Nc cells and Nb = Nf*Nc adjacent Disse and blood compartments. 
%
% Metabolites in the blood are transported via blood flow (v_blood) and
% diffusion within the sinusoid, via simple diffusion in the Space of
% Disse (the respective diffusion coefficients are denoted with D).
%
% Metabolites x1_ext, ... in the blood compartment have the suffix '*_ext'.
% Metabolites x1_dis, ... in the Disse space have the suffix '*_dis'.
% Nx_ext is the number of external metabolites, Nx_dis the number of 
% metabolites in the Disse space and Nx_in the number of metabolites
% within the cells. 
% An additional [pp] compartment is adjacent to the first periportal blood
% compartment, an additional [pv] compartment is adjacent to the last
% perivenious compartment.

% Time course in the pp or/and pv compartments are model input.
%   
%    -- -- -- -- -- -- -- -- -- -- -- --
% ->|pp|  |  |  |  |  |  |  |  |  |  |pv| -> [diffusion & blood flow] Blood
%    -- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~       
%   <~ |  |  |  |  |  |  |  |  |  |  | ~>    [diffusion & lymph flow] Disse
%       -- -- -- -- -- -- -- -- -- --       
%      |              |              |      
%      |  (cell)      |  (cell)      |      Nc : number of cells
%      |              |              |      Nb : number of blood/disse comps
%       -------------- --------------       Nf : blood comps per cell
%
%
% TODO: negative values for v_blood have to be possible (simulation of 
%       retrograde and anterograde perfusion)
% TODO: flow in the Disse space should be implemented via v_dis (to test 
%       possible effects)
% 
%   Matthias Koenig (2014-04-30)
%   Copyright Matthias Koenig 2014 All Rights Reserved.
% -----------------------------------------------------------------------------

format compact;
clear all; clc; 
install_multiscale_galactose; % set paths

p.resultsFolder = strcat('../../multiscale-galactose-results/', ...
                              datestr(date, 'yyyy-mm-dd'), '/');
if( ~exist(p.resultsFolder, 'file') )
   sprintf('Create results folder: %s\n', p.resultsFolder);
   mkdir(p.resultsFolder);
end

fprintf('***********************************************\n')
fprintf('SINGLE SINUSOID MODEL - HEPATIC METABOLISM\n')
fprintf('***********************************************\n')

% Select differential equations to simulate
% p.name = 'Dilution';
% p.name = 'Test';
p.name = 'Galactose'; 

p.version = 15;
p.Nc = 1;
p.Nf = 1;
p.id = strcat(p.name, '_v', num2str(p.version), '_Nc', num2str(p.Nc), '_Nf', num2str(p.Nf));

% set parameters
p = pars_layout(p);          
p.ext_constant    = false;      % constant blood concentrations
p.with_cells      = true;       % include cell ode
p.with_flow       = true;       % include flow ode
p.with_diffusion  = true;       % include diffusion ode

% which model should be simulated
p.deficiency = 0;

% ODE model for the sinusoids and the cells
p.odesin   = @dydt_sinusoid;
switch(p.name)                                 
    case 'Galactose'
        p.odecell  = @dydt_galactose_metabolism;
        p.parscell = @pars_galactose_metabolism;
        p.pp_fun   = @pp_galactose_metabolism;
    case 'Dilution'
        p.odecell  = @dydt_dilution_curves;
        p.parscell = @pars_dilution_curves;
        p.pp_fun = @pp_dilution_curves;
    case 'Test'
        p.odecell  = @dydt_test_metabolism;
        p.parscell = @pars_test_metabolism;
        p.pp_fun = @pp_test_metabolism;
    otherwise
        error('ODE definition not available');
end
p = init_sinusoid(p);       % Initial conditions and nonnegativities
p.x_ids = create_sbml_ids(p);
print_model_overview(p);

%% Model definition finished
% the model can be used to call different simulations on it

%do_galactose_reference_simulation;
%do_galactosemia_simulations;
do_galactose_timecourse_simulation();
%do_galactose_ss_simulation();

return
