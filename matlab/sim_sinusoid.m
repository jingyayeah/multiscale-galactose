%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SIM_SINUSOID - single sinusoid model with adjacent cells.
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
%   Matthias Koenig (2013-09-09)
%   Copyright � Matthias K�nig 2013 All Rights Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format compact;
clear all; clc; %close all;
install;
fprintf('***********************************************\n')
fprintf('SINGLE SINUSOID MODEL - HEPATIC METABOLISM\n')
fprintf('***********************************************\n')

%%%%%%%%%%% MODEL DEFINITION %%%%%%%%%%%
% Sinusoid geometry and layout
p = pars_layout(false);          

% ODE model for the sinusoids and the cells
p.odesin   = @dydt_sinusoid;         % sinusoid differential equations
% p.odecell  = @dydt_test_metabolism;  % single cell metabolism equations
% p.parscell = @pars_test_metabolism;  % single cell parameters
% p.pp_fun = @pp_test_metabolism;      % periportal input function
% p.pv_fun = @pv_zeros;                % perivenious output function is
                                       % calculated from model

% Galactose Metabolism                                       
p.odecell  = @dydt_galactose_metabolism;
p.parscell = @pars_galactose_metabolism;
p.pp_fun   = @pp_galactose_metabolism;    
% p.odecell  = @dydt_dilution_curves;
% p.parscell = @pars_dilution_curves;
% p.pp_fun = @pp_dilution_curves;    

% Initial concentrations based on layout (p.x0) and ode functions
p = init_sinusoid(p);

% model definition, which part should be simulated
p.ext_constant    = false;      % constant blood concentrations in all compartments
p.with_cells      = true;
p.with_flow       = true;
p.with_diffusion  = true;

print_model_overview(p);

%%%%%%%%%%% MODEL DEFINITION %%%%%%%%%%%
p.resultsFolder = '../../multiscale-galactose-results/';
p.mname = strcat('galactose_model_', 'Nc', num2str(p.Nc), '_Nf', num2str(p.Nf));  

%%%%%%%%%%% SIMULATION %%%%%%%%%%%
%% Test simulation
fprintf('\n# NORMAL GALACTOSE METABOLISM #\n')
tic
% TODO:  'OutputFcn', @ode_out_function for printing time

% set the galactosemia (0 normal , 1:8 GALK, 9:14 GALT, 15:23 GALE)
% p.opt = odeset('AbsTol', 1E-6, 'RelTol', 1E-6, 'MaxStep', 0.1); 
p.deficiency = 0
p.opt = odeset('AbsTol', 1E-8, 'RelTol', 1E-6); 
p.tspan = [0, 1E6];
sol = ode15s(p.odesin, p.tspan, p.x0, p.opt, p);
toc;

t = (sol.x)'; 
%%
%t = linspace(tspan(1), tspan(end), 21);
x = deval(sol, t);
% set the used pp and pv concentrations
x(1:p.Nx_out,:) = p.pp_fun(t, p);
% x(end-p.Nx_out+1:end, :) = p.pv_fun(t, p);

x = x';

num2str(p.deficiency)
fname = strcat(p.resultsFolder, p.mname, '_D', num2str(p.deficiency))
save(fname, 'p', 't', 'x');

create_named_variables;
% plots_dilution_curves;

%plots
%return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% simulate all deficiencies
fprintf('\n# GALACTOSEMIAS #\n')
for kd=1:23
    p.deficiency = kd;
    fprintf('\tgalactosemia: %s/23 \n', num2str(kd))
    % p
    tic
    sol = ode15s(p.odesin, p.tspan, p.x0, p.opt, p);
    toc
    t = (sol.x)';
    x = deval(sol, t);
    % set the used pp and pv concentrations
    x(1:p.Nx_out,:) = p.pp_fun(t, p);
    x = x';
    fname = strcat(p.resultsFolder, p.mname, '_D', num2str(p.deficiency))
    save(fname, 'p', 't', 'x');
end

return;



% TODO: make the more complex simulation definition work 

%%%%%%%%%%% SIMULATION DEFINITION %%%%%%%%%%%
% [glc lac o2 ins glu]    tend  [cells diffusion bloodflow] extconstant  store
tend = 1E6;

% Single cell simulation
if (p.Nc == 1)
    % p.opt = odeset('NonNegative', p.NonNegative, 'AbsTol', 1E-6, 'RelTol', 1E-3); 
    p.opt = odeset('AbsTol', 1E-6, 'RelTol', 1E-3); 
    
    p.c_sim = {
       [8.0 2   40 *1.3/760 10 5]    tend   [1 1 0]  true  true
       [8.0 2   40 *1.3/760 10 5]    tend   [1 1 0]  false  true
       [3.5 2   40 *1.3/760 10 5]    tend  [1 1 ]   false  true
    };
    
% Cell array simulation
else
    %p.opt = odeset('NonNegative', p.NonNegative, 'OutputFcn', @outfun); 
    p.opt = odeset('NonNegative', p.NonNegative, 'OutputFcn', @outfun, 'AbsTol', 1E-8, 'RelTol', 1E-5); 
    p.c_sim = {
       [8.0 2   40 *1.3/760 1 0.05]    tend   [1 1 0] 'constant' true  true
       [8.0 2   40 *1.3/760 1 0.05]    tend   [1 1 0] 'constant' false  true
       [3.5 2   40 *1.3/760 1 0.05]    tend  [1 1 0]  'constant' false  true
    };
end

print_simulation_overview(p)
return


%%%%%%%%%%% SIMULATE SYSTEM %%%%%%%%%%%
fprintf('\n---------------------------\n')
fprintf('Integrate Solution')
fprintf(' # [k_sim] \t[glc lac o2 ins glu]\n')
fprintf('---------------------------\n')

for k_sim=1:size(p.c_sim, 1)
    % set external concentration profiles -> only in blood compartment
    % generates the c_ext vector (glc_ext, lac_ext, o2_ext)
    if numel(p.c_sim{k_sim, 1}) == 0
        c_pp = p.x0(1:p.Nx_out);
    else
        c_pp = p.c_sim{k_sim, 1};
    end
   
    % which components are part of the model
    tmp = p.c_sim{k_sim, 3};
    p.with_cells      = tmp(1);
    p.with_diffusion  = tmp(2);
    p.with_flow       = tmp(3);
    p.ext_constant    = p.c_sim{k_sim, 5};
    
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
    
    % get the function handles for the timecourses of metabolite
    % concentrations in pp compartment
    for kx = 1:p.Nx_out
        switch p.c_sim{k_sim, 4}
            case 'constant'
                % disp('Constant Generator')
                p.f_pp{kx} = tc_generator('constant', c_pp(kx));
                break;
            case 'sinus'
                % disp('Sinus Generator')
                p.f_pp{kx} = tc_generator('sinus', c_pp(kx));
                break;
            otherwise
                warning('Function handles for pp timecourses not found');
        end
    end
    
    % simulate and store solution structure for later devaluation
    tend = p.c_sim{k_sim, 2};
    tic
    sol = ode15s(p.odefun, [0 tend], p.x0, p.opt, p);
    tint = toc;
    p.sol{k_sim} = sol;
    
    % Set initial concentration for next simulation in row
    p.x0 = deval(sol, tend);
    
    % print information about simulation
    fprintf(' # [%i] \t%s\t%s\t%s\t%s\t%s\t%s\t%s\t Elapsed time: %4.2f\n', ...
            k_sim, mat2str(p.c_sim{k_sim, 1}),num2str(p.c_sim{k_sim, 2}), p.c_sim{k_sim, 3}, ...
            mat2str(p.c_sim{k_sim, 4}), num2str(p.c_sim{k_sim, 5}), ...
            num2str(p.c_sim{k_sim, 6}), mat2str(p.c_sim{k_sim, 7}), tint); 
end

%%%%%%%%%%% EVALUATE SIMULATION %%%%%%%%%%%
t_total = 0;
t = [];
x = [];
for k_sim = 1:size(p.c_sim, 1)
    
    tend = p.c_sim{k_sim, 2};
    % if the solution for the simulation should be part of the plotted
    % timecourse
    if p.c_sim{k_sim, 6}
        sol = p.sol{k_sim};
        % dtmp = 10;                  % step size for generating the solution
        % t_sim = [0:dtmp:tend]';
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

