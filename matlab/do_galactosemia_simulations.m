%% Simulate normal state and galactosemias
% set the galactosemia (0 normal , 1:8 GALK, 9:14 GALT, 15:23 GALE)
%% function [] = do_galactosemia_simulations(p)
do_galactosemias = false;
if (do_galactosemias)    
    def_vector = [1:23 0];
else
    def_vector = [1 0]; % minimal test
end

% simulation timepoints
exact_times = true;
p.tstart = 0;
p.tend   = 2E3;  
p.tsteps = 1000;
p.tspan = [p.tstart p.tend];
p.opt = odeset('AbsTol', 1E-6, 'relTol', 1E-6);

% set the periportal galactose concentration
% TODO: bad fix, get index via the name
p.x0(5) = 2; 

% do the simulations
fprintf('\n* Simulations *\n')
for def_item = def_vector    
    p.deficiency = def_item;
    if (p.deficiency == 0)
        fprintf('\nnormal: %i \n', p.deficiency)    
    else 
        fprintf('\ngalactosemia: %i/23 \n', p.deficiency)
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
    fname = strcat(p.resultsFolder, p.id, '_D', num2str(p.deficiency))
    save(fname, 'p', 't', 'x');
    createCSV(strcat(fname, '.csv'), t, x, p);
end

% variables and plots
create_named_variables;

% clear the variables which were added by the simulation
p = rmfield(p, {'tstart', 'tend', 'tsteps', 'tspan', 'opt'});

% plots_dilution_curves;
%plots
