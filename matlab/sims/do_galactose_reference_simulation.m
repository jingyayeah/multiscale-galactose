%% Reference simulation to test the implementation of the model.
fprintf('\n# Reference time course #\n')

% Perform simple simulation with standardized time points and integration
% tolerances
p.tspan = [0:1:1000];
p.opt = odeset('AbsTol', 1E-6, 'relTol', 1E-6);
[t, x] = ode15s(p.odesin, p.tspan, p.x0, p.opt, p);

% Store the data as CSV
% create header and data table
fname = 'test_galactose.CSV'
writeCSVResult(fname, t, x, p);

% Evaluate simulation

%% Analysis
create_named_variables;
plots
