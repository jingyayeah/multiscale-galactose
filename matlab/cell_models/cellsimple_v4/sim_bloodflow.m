%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIM_BLOODFLOW
%
% Blood flow model with adjacent cells.
% A single cell has Nf adjacent blood compartments. The complete layout
% consists of Nc cells and Nb = Nf*Nc blood compartments. 
%
% Metabolites in the blood are transported via the blood flow (v_blood) or
% via diffusion with diffusion coefficients Dglc, D_lac, D_o2.
%
% Metabolites in the blood/external compartment are depicted with '*_ext'.
% Nx_out is the number of external metabolites, Nx_in the number of
% internal metabolites. 
% The concentration vector x consists of 
%   - [1] the Nx_out external concentrations (Nx_out*p.Nb elements) with
%   concentrations of one metabolite after each other
%   - [2] the Nx_in internal concentrations (Nx_in*Nc), sorted by cells.
%
% Model can be simulated with constant external blood concentrations
% (ext_constant), with or without blood flow (ode_blood), with or without
% cells (ode_cells) and with or without diffusion (ode_diffusion).
%
% The timecourse of the external concentrations in the first compartment
% (blood supply for the cells) is set via the f_*_ext functions (use the
% time course generator tc_generator).
%   
%    -- -- -- -- -- -- -- -- -- -- -- 
% ->|xx|  |  |  |  |  |  |  |  |  |  | -> (diffusion & possible blood flow)
%    -- -- -- -- -- -- -- -- -- -- --      (concentrations xx in adjacent
%      |              |              |      compartment are constant)
%      |  (cell)      |  (cell)      |      Nc : number of cells
%      |              |              |      Nb : number of blood comps
%       -------------- --------------       Nf : blood comps per cell
%
%   author:     Matthias Koenig
%   date:       121016
%   version:    4.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; format compact; close all; clc
path(path, './tools/');
path(path, './fortran/');

% Store solution
model_name  = 'Cancer_cellsimple_v4';
sim_variant = '05';
sim_name = strcat('./data/', model_name, '_sim_v', sim_variant);

sim_name = './data/matlab_30_05_test'

% Layout of cells with adjacent blood compartments
p.Nc         = 1;              % number of cells  
p = pars_layout(p);             % add all the additional parameters for the layout

% blood flow model with cells
p.odefun = @dydt_bloodflow;

% Initial concentrations based on layout (p.x0)
p = init_cellsimple(p);

% Time course in first blood compartment adjacent to array
p.f_ext{1} = tc_generator('constant', p.x_init('glc_ext')); 
p.f_ext{2} = tc_generator('constant', p.x_init('lac_ext'));
p.f_ext{3} = tc_generator('constant', p.x_init('o2_ext'));

% Additional settings for the solver
p.NonNegative = 1:numel(p.x0);
p.opt = odeset('NonNegative', p.NonNegative, 'AbsTol', 1E-6, 'RelTol', 1E-3);
p.opt = odeset('NonNegative', p.NonNegative, 'AbsTol', 1E-6, 'RelTol', 1E-3, 'OutputFcn', @outfun);
disp('*** Parameters after initialisation ***')
p

%% FORTRAN TEST CODE FOR COMPARISON
%{
p.odecells    = true;
p.odediffusion = false;
p.odeblood = false;
p.x0 = [1:length(p.x0)]';
p.f_glc_ext = tc_generator('sinus', 1.5*p.x_init('glc_ext'), 0.5*p.x_init('glc_ext')); 
p.f_lac_ext = tc_generator('sinus', 1.5*p.x_init('lac_ext'), 0.5*p.x_init('lac_ext'));
p.f_o2_ext  = tc_generator('sinus', 1.5*p.x_init('o2_ext'), 0.5*p.x_init('o2_ext'));
dxdt = odefun(0, p.x0, p); 
tmp = [p.x0 dxdt]
return
%}

%%%%%%%%%%% START SIMULATION DEFINITION %%%%%%%%%%%%%%%%%%%%%
            % [glc lac o2]    tend    fun   [cells diffusion bloodflow]  extconstant  store
tend = 500;
%{
p.c_sim = {
            % ext_constant test
            [6 2.5 2]  tend   'constant'  [1 1 0]  true   false  % ss
            [6 2.5 2]  tend   'constant'  [1 1 0]  true   true   % normal
            [0 2.5 2]  tend   'constant'  [1 1 0]  true   true   % single 0
            [6 0 2]  tend   'constant'  [1 1 0]  true   true     
            [6 2.5 0]  tend   'constant'  [1 1 0]  true   true
            [6 0 0]  tend   'constant'  [1 1 0]  true   true  % double 0
            [0 2.5 0]  tend   'constant'  [1 1 0]  true   true
            [0 0 2]  tend   'constant'  [1 1 0]  true   true
            [0 0 0]  tend   'constant'  [1 1 0]  true   true
};
%}
tend = 2000;
p.c_sim = {
            % ext_variable test
            [6 2.5 2]  1E6   'constant'  [1 1 0]  true   false  % ss
            [6 2.5 2]  tend   'constant'  [1 1 0]  false   true   % normal
            
            [6 2.5 0]  tend   'constant'  [1 1 0]  false   false
            [6 2.5 0]  tend   'constant'  [1 1 0]  false   true
            
            [6 0 0]  tend   'constant'  [1 1 0]  false   true  % double 0
            [6 0 0]  tend   'constant'  [1 1 0]  false   true  % double 0          
            
            [6 0 2]  tend   'constant'  [1 1 0]  false   false     
            [6 0 2]  tend   'constant'  [1 1 0]  false   true     
            
            [0 2.5 0]  tend   'constant'  [1 1 0]  false   false
            [0 2.5 0]  tend   'constant'  [1 1 0]  false   true
            
            [0 0 2]  tend   'constant'  [1 1 0]  false   false
            [0 0 2]  tend   'constant'  [1 1 0]  false   true
            
            [0 0 0]  tend   'constant'  [1 1 0]  false   false
            [0 0 0]  tend   'constant'  [1 1 0]  false   true
};

%{
p.c_sim = {
            % ext_variable test
            [5.5 2.5 2.2]   1E6   'constant'  [1 1 0]   true   false  % ss
            [5.5 2.5 2.2]  1000   'constant'  [1 1 0]  false   true  % ss
};
%}

%%%%%%%%%%% END SIMULATION DEFINITION %%%%%%%%%%%%%%%%%%%%%%%

disp('********************************')
disp('Integrate Solution')
fprintf(' # [k_sim] \t[glc lac o2]\n')
fprintf('---------------------------\n')
for k_sim=1:size(p.c_sim, 1)
    
    % set external concentration profiles -> only in blood compartment
    % generates the c_ext vector (glc_ext, lac_ext, o2_ext)
    if numel(p.c_sim{k_sim, 1}) == 0
        % disp('-> using standard initial concentrations');
        c_ext = p.x0(1:p.Nx_out);
    else
        % disp('-> using given initial concentrations');
        c_ext = p.c_sim{k_sim, 1};
    end
    
    % set external concentration profiles in all profiles
    if (p.Nc == 1)
        disp('Set adjacent blood compartments to given external concentrations')
        for k=1:p.Nx_out
            p.x0(p.Nx_out + (k-1)*p.Nf + 1:p.Nx_out+ k*p.Nf) = c_ext(k); 
        end
    end
    
    % get the function handle for the timecourses of metabolite
    % concentrations in the adjecent blood compartment
    for kx = 1:p.Nx_out
        switch p.c_sim{k_sim, 3}
            case 'constant'
                % disp('Constant Generator')
                p.f_ext{kx} = tc_generator('constant', c_ext(kx));
            case 'sinus'
                % disp('Sinus Generator')
                p.f_ext{kx} = tc_generator('sinus', c_ext(kx));
        end
    end
    
    % which components for integration
    tmp = p.c_sim{k_sim, 4};
    p.ode_cells      = tmp(1);
    p.ode_diffusion  = tmp(2);
    p.ode_blood      = tmp(3);
    p.ext_constant = p.c_sim{k_sim, 5};
    
    % simulate and store solution structure for later devaluation
    %p.opt = odeset('OutputFcn', @outfun, 'NonNegative', p.NonNegative);
    tend = p.c_sim{k_sim, 2};
    tic
    sol = ode15s(p.odefun, [0 tend], p.x0, p.opt, p);
    tint = toc;
    p.sol{k_sim} = sol;
    
    % Set initial concentration for next simulation in row
    p.x0 = deval(sol, tend);
    
    % print information about simulation
    fprintf(' # [%i] \t%s\t%s\t%s\t%s\t%s\t%s\t Elapsed time: %4.2f\n', ...
            k_sim, mat2str(p.c_sim{k_sim, 1}),num2str(p.c_sim{k_sim, 2}), p.c_sim{k_sim, 3}, ...
            mat2str(p.c_sim{k_sim, 4}), num2str(p.c_sim{k_sim, 5}), ...
            num2str(p.c_sim{k_sim, 6}), tint); 
end
fprintf('---------------------------\n')

%% Save solution structures
disp('* Save solution *');
save(sim_name, 'p', '-v7.3')




fig_bloodflow(sim_name);
% fig_fortran
fprintf('---------------------------\n')