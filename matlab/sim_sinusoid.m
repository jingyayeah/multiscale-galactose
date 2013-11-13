%% Model of sinusoidal unit
%
% Sinusoid model consisting of central blood flow within sinusoid, 
% exchange of metabolites with adjacent space of Disse and hepatocytes
% able to exchange metabolites with the space of Disse.
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
% TODO: architecture must be coupled with arbitrary cell metabolic models
%       for testing 
% TODO: flow in the Disse space should be implemented via v_dis (to test 
%       possible effects)
% TODO: handle various tracer profiles [pp] and [pv], one-time, continuous
%       single/multiple indicator methods.
% 
%   Matthias Koenig (2013-11-13)
%   Copyright Matthias Koenig 2013 All Rights Reserved.
% -----------------------------------------------------------------------------

format compact;
clear all; clc; % close all;
install;    % installation settings (define include folders)

p.resultsFolder = strcat('../../multiscale-galactose-results/', ...
                              datestr(date, 'yyyy-mm-dd'), '/');
if( ~exist(p.resultsFolder, 'file') )
   sprintf('Create results folder: %s\n', p.resultsFolder);
   mkdir(p.resultsFolder);
end

fprintf('***********************************************\n')
fprintf('SINGLE SINUSOID MODEL - HEPATIC METABOLISM\n')
fprintf('***********************************************\n')
% p.id = 'Dilution';
% p.id = 'Test';

p.name = 'Galactose'; 
p.version = 3;
p.Nc = 1;
p.Nf = 5;
p.id = strcat(p.name, '_v', num2str(p.version), '_Nc', num2str(p.Nc), '_Nf', num2str(p.Nf));

% set parameters
p = pars_layout(p, false);          
p.ext_constant    = false;      % constant blood concentrations
p.with_cells      = true;       % include cell ode
p.with_flow       = true;       % include flow ode
p.with_diffusion  = true;       % include diffusion ode

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
print_model_overview(p);

% Model definition finished
% TODO: call different simulation time courses with the defined model
% the model can be used to call different simulations on it
do_simple_simulation();
do_galactosemia_simulations();
do_galactose_peak_simulation();
do_galactose_ss_simulation();


%% Simulate normal state and galactosemias
% set the galactosemia (0 normal , 1:8 GALK, 9:14 GALT, 15:23 GALE)
do_galactosemias = true;
if (do_galactosemias)    
    def_vector = [1:23 0];
else
    def_vector = 0;
end

% simulation timepoints
exact_times = true;
p.tend   = 2E3;  
p.tsteps = 1000;
p.tspan = [0 p.tend];

% do the simulations
for def_item = def_vector    
    p.deficiency = def_item;
    if (p.deficiency == 0)
        fprintf('\tnormal: %i \n', p.deficiency)    
    else 
        fprintf('\tgalactosemia: %i/23 \n', p.deficiency)
    end
    
    tic
    sol = ode15s(p.odesin, p.tspan, p.x0, p.opt, p);
    toc
    if (exact_times)
        t = linspace(p.tstart, p.tend, p.tsteps+1);   
    else
        t = (sol.x)'; 
    end
    x = deval(sol, t);
    
    % set the used pp and pv concentrations
    x(1:p.Nx_out,:) = p.pp_fun(t, p);
    x = x';
    fname = strcat(p.resultsFolder, p.mname, '_D', num2str(p.deficiency))
    save(fname, 'p', 't', 'x');
    createCSV(strcat(fname, '.csv'), t, x, p);
end


% variables and plots
create_named_variables;
% plots_dilution_curves;
plots
return 


%% Complex simulation time courses
fprintf('\n# Simulation time course #\n')
tend = 2E3;

% [gal_pp]  tend def  store
p.c_sim = {
   [0.00012] tend 0  true
   [2.0]     tend 0  true
   [0.00012] tend 0  true
};
p.c_sim

fprintf('\n---------------------------\n')
fprintf('Integrate Solution')
fprintf(' # [sim] \t[gal]\n')
fprintf('---------------------------\n')


for k_sim=1:size(p.c_sim, 1)
    
    % set pp concentrations
    % todo: find way to set the constant pp concentrations
    % overwrite values in the p.x0
    if numel(p.c_sim{k_sim, 1}) == 0
        c_pp = p.x0(1:p.Nx_out);
    else
        c_pp = p.c_sim{k_sim, 1};
    end
    % Use constant concentrations in the outer compartment
    if (p.ext_constant)
       disp('<set constant external concentrations>')
       for ci=1:p.Nc
          for k=1:p.Nx_out
             % blood compartments
             p.x0(p.Nx_out + (ci-1)*p.Nxc + (k-1)*p.Nf +1 : ...
                  p.Nx_out + (ci-1)*p.Nxc +    k *p.Nf)  = c_pp(k); 
             
             % disse compartments
             p.x0(p.Nx_out + (ci-1)*p.Nxc + p.Nx_out*p.Nf + (k-1)*p.Nf+1 : ...
                  p.Nx_out + (ci-1)*p.Nxc + p.Nx_out*p.Nf + k*p.Nf) = c_pp(k); 
          end
       end
    end
   
    
    
    % set the deficiency
    p.deficiency = p.c_sim{k_sim, 3};
    
    % set the end times for simulation
    p.tend = p.c_sim{k_sim, 2};
    p.tspan = [0 p.tend];
    tic
    sol = ode15s(p.odesin, p.tspan, p.x0, p.opt, p);
    tint = toc;
    p.sol{k_sim} = sol; % store solution 
    
    % Set initial concentration for next simulation in row
    p.x0 = deval(sol, tend);
    
    % print information about simulation
    fprintf(' # [%i] \t%s\t%s Elapsed time: %4.2f\n', ...
            k_sim, mat2str(p.c_sim{k_sim, 1}), num2str(p.c_sim{k_sim, 3}), tint); 
end

%% Evaluate simulation
t_total = 0;
t = [];
x = [];
for k_sim = 1:size(p.c_sim, 1)
    
    tend = p.c_sim{k_sim, 2};
    % if the solution for the simulation should be part of the plotted
    % timecourse
    if p.c_sim{k_sim, 4}
        sol = p.sol{k_sim};
        t_sim = (sol.x)';             % use provided stepsize by solver
        x_sim = deval(sol, t_sim);
        t = [t 
             t_sim+t_total];
        x = [x 
             x_sim'];
        t_total = t_total+tend;
    end
end

save(name, 'p');

%%%%%%%%%%% ANALYSIS %%%%%%%%%%%
create_named_variables;
% plots

