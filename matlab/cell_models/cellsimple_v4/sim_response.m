% Calculate the system response to the external glucose, lactate and o2
% concentrations.
%   author: Matthias Koenig
%   date: 121016

clear all; close all; format compact; clc

% define the external concentration vectors
p.glc = linspace(0, 1, 2);
p.lac = linspace(0, 1, 2);
p.o2  = linspace(0, 0.2, 2);

% Store solution
model_name  = 'Cancer_cellsimple_v4';
sim_variant = '01';
sim_name = strcat(model_name, '_response_v', sim_variant);

% Layout of cells with adjacent blood compartments
p.Nc         = 1;              % number of cells

% Layout of cells with adjacent blood compartments
p.Nc         = 30;              % number of cells  
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
p.opt = odeset('NonNegative', p.NonNegative);

    disp('********************************') 
    disp('Integrate system in steady state') 
    p_ss = p;
    p.ode_cells     = true;      % only use the cell model
    p.ode_blood     = false;    
    p.ode_diffusion = false;    
    p.ext_constant  = true;      % blood concentrations are constant
    
    tend_ss = 1E6;
    tic
    sol_ss = ode15s(p.odefun, [0 tend_ss], p.x0, p.opt, p);
    toc
    % write the changes in the first compartment
    p.x0 = deval(sol_ss, tend_ss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Storage matrix for steady state concentrations, time of integration, and
% success of integration
N = numel(p.glc)*numel(p.lac)*numel(p.o2);
res_x            = zeros(N, numel(p.x0));
res_dxdt         = zeros(N, numel(p.x0));
res_odetoc       = zeros(N);
res_odetend      = zeros(N);
res_odesuccess   = zeros(N);

% Generate the external concentration matrix
c_ext = zeros(N,3);
ind_ext = zeros(N,3);
counter = 0;
for kg=1:numel(p.glc)
    for kl=1:numel(p.lac)
        for ko=1:numel(p.o2)
            counter = counter+1;
            c_ext(counter,:) = [p.glc(kg), p.lac(kl), p.o2(ko)];
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%matlabpool close
matlabpool open local 6

disp('*************************************************************')
fprintf('Progress\t(glc [mM] \t lactate [mM] \t o2 [mM])\n')
disp('*************************************************************') 
tend = 1e6;
parfor k=1:N
    % get external conditions
    glc_ext = c_ext(k,1);
    lac_ext = c_ext(k,2);
    o2_ext  = c_ext(k,3);
    
    % information about step
    fprintf('%6.3f\t\t(%6.3f\t%6.3f\t%6.3f)\n', ...
                k/N*100, glc_ext, lac_ext, o2_ext);

    % set external concentrations
    ploc = p;
    ploc.x0(         1:  p.Nb) = glc_ext;
    ploc.x0(    p.Nb+1:2*p.Nb) = lac_ext;
    ploc.x0(  2*p.Nb+1:3*p.Nb) = o2_ext;
    ploc.f_ext{1} = tc_generator('constant', glc_ext);
    ploc.f_ext{2} = tc_generator('constant', lac_ext);
    ploc.f_ext{3} = tc_generator('constant', o2_ext);

    % integrate
    tic 
        [t,x] = ode15s(ploc.odefun,[0, tend], ploc.x0, ploc.opt, ploc);
    t_toc   = toc;
    t_abort = t(end); 
    res_odetoc(k)  = t_toc;
    res_odetend(k) = t_abort;
    if t_abort < tend
        res_odesuccess(k) = 0;
    else
        res_odesuccess(k) = 1;
    end
    % Store the concentrations
    x_res = x(end, :);
    res_x(k, :) = x_res; 
    % Store the changes in concentrations
    res_dxdt(k, :) = ploc.odefun(tend, x_res', ploc);
end

matlabpool close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save the solution
save(strcat('./data/', sim_name), 'p', 'res_x', 'res_dxdt', 'res_odetoc', ...
        'res_odetend', 'res_odesuccess');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot results
fig_response(sim_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

