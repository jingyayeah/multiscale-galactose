%% Complex simulation time courses
fprintf('\n# Simulation time course #\n')

% [gal_pp]  tend def  store
tend = 600;
sim_type = 'peak';
%sim_type = 'stepwise';

switch sim_type
    case 'peak'
        p.c_sim = {
            [0.00012] tend*17 0  false % steady state simulation   
            [0.00012] tend 0  true
            [2.0]     tend 0  true
            [0.00012] tend 0  true
        };
    case 'stepwise'
        p.c_sim = {
           [0.00012] tend*20 0  false % steady state simulation
           [0.00012] tend 0  true
           [1.0]     tend 0  true
           [2.0]     tend 0  true
           [3.0]     tend 0  true
           [4.0]     tend 0  true
           [5.0]     tend 0  true
           [6.0]     tend 0  true
           %[7.0]     tend 0  true
           %[8.0]     tend 0  true
           %[9.0]     tend 0  true
           %[10.0]    tend 0  true
           [0.00012] tend 0  true
        };
end
p.c_sim

fprintf('\n---------------------------\n')
fprintf('Integrate Solution')
fprintf(' # [sim] \t[gal]\n')
fprintf('---------------------------\n')

p.tstart = 0;
p.opt = odeset('AbsTol', 1E-6, 'relTol', 1E-6);
for k_sim=1:size(p.c_sim, 1)
    
    % set the periportal galactose concentration
    % TODO: bad fix, get index via the name
    p.x0(4) = p.c_sim{k_sim, 1}; 
    
    % set the deficiency
    p.deficiency = p.c_sim{k_sim, 3};
    
    % set the end times for simulation
    p.tend = p.c_sim{k_sim, 2};
    p.tspan = [p.tstart p.tend];
    
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

% TODO: save the results

%% Analysis
create_named_variables;
plots

