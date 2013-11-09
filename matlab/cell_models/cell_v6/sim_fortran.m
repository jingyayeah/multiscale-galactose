clear all

disp('----- FORTRAN CANCER SIMULATION ------------')
path(path, './fortran/')

% Call the fortran solver and the make location
folder_scripts = '/home/mkoenig/Desktop/model_cancer/fortran/Bloodflow_Cell_v6/bin/';

% folder for output
folder_results = './results/test/';

% Used scripts
make = 'run_make';
limex = 'limex';
format_output = 'format_output.py';

% compile the current fortran source
cmd = sprintf('%s%s' , folder_scripts, make);
system(cmd);

% copy the scripts for replication of simulations in results folder
cmd = sprintf('cp %s%s %s%s' , folder_scripts, limex, folder_results, limex);
system(cmd);
cmd = sprintf('cp %s%s %s%s' , folder_scripts, format_output, folder_results, format_output);
system(cmd);

% Generate the settings file for the Fortran solver
p.Nc = 25;
p = pars_layout(p);
p = init_cell(p);

p.ft_ext = [1 1 1];
p.delta_t = [0.0 1E5];
p.ext_constant = 0;
p.ode_cells = 1;
p.ode_diffusion = 1;
p.ode_blood = 0;

tmp = 1:p.Nc;
p.f_gly =  0.2* (2.0 +  1.4 * tmp.^4./(tmp.^4 + 6^4));   % super good
p.f_oxi =  1.0* (0.2 - 0.15 * tmp.^4./(tmp.^4 + 6^4));   % super good

% p.c_ext0 = [0.8 1.4  30*1.3/760];
p.c_ext0 = [1.8 1.4  120*1.3/760];

disp('--------------------------------------------')
name = 'fortran_test';
fname_odesettings = strcat(folder_results, name, '.dat')
create_fortran_settings(p, fname_odesettings);
type(fname_odesettings)

disp('--------------------------------------------')
% call the solver with the settings
cmd = sprintf('%s%s %s', folder_results, limex, fname_odesettings)
system(cmd)
disp('--------------------------------------------')

% store the solution in Matlab format 
fname_results = strcat(folder_results, name, '.fort')
cmd = sprintf('%s%s -i %s -o %s', folder_results, format_output, 'fort.10', fname_results)
system(cmd);
disp('--------------------------------------------')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Provide the Matlab fluxes (not available via Fortran)
p.odefun = @dydt_bloodflow;

% Generate the function handles for matlab
for k = 1:p.Nx_out
    switch p.ft_ext(k)
        case 1
            p.f_ext{k} = tc_generator('constant', p.c_ext0(k));
        case 2
            p.f_ext{k} = tc_generator('sinus', p.c_ext0(k));
    end
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load Fortran data and create workspace variables
x = load(fname_results);
t = x(:,1);
x(:,1) = [];

%{
offset = 1
if (offset ~= 0)
    t = t(offset:end);
    x = x(offset:end, :);
end
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

create_named_variables;
% plots;