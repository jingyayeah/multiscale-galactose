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
%   date:       121026
%   version:    6.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; format compact; ;% clc %close all;
path(path, './tools'); 

% Layout of cells with adjacent blood compartments
p.Nc         = 5;              % number of cells  
p = pars_layout(p);             % add all the additional parameters for the layout

% blood flow model with cells
p.odefun = @dydt_bloodflow;

% Initial concentrations based on layout (p.x0)
p = init_cell(p);

% Test Fortran DXDT
%{
if (0)
    p.ext_constant  = false;       % constant blood concentrations in all compartments
    p.ode_cells     = true;
    p.ode_diffusion = false;
    p.ode_blood     = false;
    
    p.f_gly = ones(p.Nc, 1) * 1;   % constant strategy for all cells
    p.f_oxi = ones(p.Nc, 1) * 1;   % constant strategy for all cells
    p.f_ext{1} = tc_generator('constant', 10);
    p.f_ext{2} = tc_generator('constant', 10);
    p.f_ext{3} = tc_generator('constant', 10);
    x0 = (1:p.Nx_out + p.Nc * p.Nxc)';
   res = [x0  dydt_bloodflow(0.0, x0, p)]
   return
end
%}

% Additional settings for the solver -> nonnegative depending on the cell
% model (extern all NonNegative)
%p.Ineg = [59 60];                 % NonNegative concentrations in cell
p.Ineg = [];                 % NonNegative concentrations in cell
p = pars_nonnegative(p);          % calculates the NonNegative information for layout

%%%%%%%%%%% START SIMULATION DEFINITION %%%%%%%%%%%%%%%%%%%%%
            % [glc lac o2]    tend    fun   [cells diffusion bloodflow]
            % extconstant  store [f_gly f_ox]

% Single cell simulation
if (p.Nc == 1)
    % p.opt = odeset('NonNegative', p.NonNegative, 'AbsTol', 1E-6, 'RelTol', 1E-3); 
    p.opt = odeset('AbsTol', 1E-6, 'RelTol', 1E-3); 
    tend = 1E6;
    pathway_facs = [6 .3];
    
    p.c_sim = {
            % everything good 
            [5.5 2   40 *1.3/760]    tend    'constant'  [1 1 0]  true  false   pathway_facs
            [5.5 2   40 *1.3/760]    tend    'constant'  [1 1 0]  false false   pathway_facs
            
            [5.5 2   40 *1.3/760]    tend    'constant'  [1 1 0]  false  true  pathway_facs
            
            [5.5 0   40 *1.3/760]       tend    'constant'  [1 1 0]  false  true  pathway_facs
            [0   2.2   40 *1.3/760]     tend    'constant'  [1 1 0]  false  true  pathway_facs
            [5.5 0     0]               tend    'constant'  [1 1 0]   false true   pathway_facs
            
            [0   2     0]               tend    'constant'  [1 1 0]  false  true  pathway_facs    
            [0   0     40 *1.3/760]    tend    'constant'  [1 1 0]   false true   pathway_facs
             
            % problem as soon as cell goes from very limited o2 to no o2
            [5.5 2  1E-5]             tend     'constant'   [1 1 0]  true  true      pathway_facs
            [5.5 2  1E-5]              tend   'constant'   [1 1 0]  false  true      pathway_facs
            
            [5.5 2     40 *1.3/760]    tend    'constant'  [1 1 0]  false  true   pathway_facs
    };
    
    p.c_sim = {
            [5.5 2   40 *1.3/760]    tend    'constant'  [1 1 0]  true  false   pathway_facs
            [5.5 2   40 *1.3/760]    tend    'constant'  [1 1 0]  false true   pathway_facs
            
            
            [5.5 2   40 *1.3/760]    tend    'constant'  [1 1 0]  false  true  pathway_facs
            
            [5.5 0   40 *1.3/760]       tend    'constant'  [1 1 0]  false  true pathway_facs
            [0   2.2   40 *1.3/760]     tend    'constant'  [1 1 0]  false  true  pathway_facs
            [5.5 2.2    1E-8]               tend    'constant'  [1 1 0]   false true   pathway_facs
            [5.5 2.2    1E-8]               tend    'constant'  [1 1 0]   false true   pathway_facs
            
            [5.5 0     1E-8]               tend     'constant'  [1 1 0]   false true   pathway_facs
            [5.5 2     1E-8]               tend     'constant'  [1 1 0]   false true   pathway_facs
            [0.1 2     1E-8]               tend    'constant'  [1 1 0]   false true   pathway_facs
            [0   2     1E-8]               tend     'constant'  [1 1 0]  false  true  pathway_facs  
 
    };
 
% Cell array simulation
else
   
    %p.opt = odeset('NonNegative', p.NonNegative, 'OutputFcn', @outfun); 
    p.opt = odeset('NonNegative', p.NonNegative, 'OutputFcn', @outfun, 'AbsTol', 1E-8, 'RelTol', 1E-5); 
    pathway_facs = [0.5 0.5];
    p.c_sim = {
             [1.8  1.4   30*1.3/760]     1E3    'constant'  [1 1 0]  false  true   pathway_facs
             %[5.5  1.4   10*1.3/760]    1E5    'constant'  [1 1 0]  false  true   pathway_facs
            %[10  10 10]    tend    'constant'  [1 1 0]  false true   pathway_facs
    };
end

%%%%%%%%%%% END SIMULATION DEFINITION %%%%%%%%%%%%%%%%%%%%%%%

disp('********************************')
disp('Integrate Solution')
fprintf(' # [k_sim] \t[glc lac o2]\n')
fprintf('---------------------------\n')

for k_sim=1:size(p.c_sim, 1)
    % set external concentration profiles -> only in blood compartment
    % generates the c_ext vector (glc_ext, lac_ext, o2_ext)
    if numel(p.c_sim{k_sim, 1}) == 0
        c_ext = p.x0(1:p.Nx_out);
    else
        c_ext = p.c_sim{k_sim, 1};
    end
   
    % which components for integration
    tmp = p.c_sim{k_sim, 4};
    p.ode_cells      = tmp(1);
    p.ode_diffusion  = tmp(2);
    p.ode_blood      = tmp(3);
    p.ext_constant = p.c_sim{k_sim, 5};
    
    if (p.ext_constant)
       disp('<set constant external concentrations>')
       for ci=1:p.Nc
          for k=1:p.Nx_out
             p.x0(p.Nx_out + (ci-1)*p.Nxc + (k-1)*p.Nf+1:p.Nx_out+ (ci-1)*p.Nxc + k*p.Nf) = c_ext(k); 
          end
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
    
    % Scaling of oxidative ATP generation and glycolysis
    factors = p.c_sim{k_sim, 7};
    p.f_gly = ones(1, p.Nc) * factors(1);   % constant strategy for all cells
    p.f_oxi = ones(1, p.Nc) * factors(2);   % constant strategy for all cells
    
    %p
    % simulate and store solution structure for later devaluation
    %p.opt = odeset('OutputFcn', @outfun, 'NonNegative', p.NonNegative);
    tend = p.c_sim{k_sim, 2};
    tic
    sol = ode15s(p.odefun, [0 tend], p.x0, p.opt, p);
    tint = toc;
    p.sol{k_sim} = sol;
    p
    
    % Set initial concentration for next simulation in row
    p.x0 = deval(sol, tend);
    
    % print information about simulation
    fprintf(' # [%i] \t%s\t%s\t%s\t%s\t%s\t%s\t%s\t Elapsed time: %4.2f\n', ...
            k_sim, mat2str(p.c_sim{k_sim, 1}),num2str(p.c_sim{k_sim, 2}), p.c_sim{k_sim, 3}, ...
            mat2str(p.c_sim{k_sim, 4}), num2str(p.c_sim{k_sim, 5}), ...
            num2str(p.c_sim{k_sim, 6}), mat2str(p.c_sim{k_sim, 7}), tint); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evaluate Solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
name = './results/test/matlab_test'; 
save(name, 'p');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

create_named_variables;
% plots
% fig_fortran