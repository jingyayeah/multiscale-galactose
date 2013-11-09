function [] = sim_variable_strategies(c_ext0, f_gly, f_oxi)
% Calculate variable strategies along the sinosoid
p.c_ext0 = c_ext0;
p.f_gly = f_gly;
p.f_oxi = f_oxi;

% add path to the cell_6
path(path, '../')
path(path, '../tools/')

% Call the fortran solver with the decided settings
folder_scripts = '/home/mkoenig/Desktop/model_cancer/fortran/Bloodflow_Cell_v6/bin/';
% folder for output
folder_results = './results/121116_variable_strategies_v01/'
% Simulation name
sim_name = sprintf('Cancer_v6_[%0.4f_%0.4f_%0.4f]_var', p.c_ext0(1), p.c_ext0(2), p.c_ext0(3));

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

% Generate the settings for the solver
p.Nc = 25;

p = pars_layout(p);
p = init_cell(p);
p.ft_ext = [1 1 1];
p.delta_t = [0.0 1E5];
p.ext_constant = 0;
p.ode_cells = 1;
p.ode_diffusion = 1;
p.ode_blood = 0;

p.odefun = @dydt_bloodflow;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Storage variables for analysis
analysis.glc_ext = zeros(1, p.Nb);
analysis.lac_ext = zeros(1,  p.Nb);
analysis.o2_ext  = zeros(1,  p.Nb);

analysis.o2  = zeros(1, p.Nc);
analysis.glc = zeros(1, p.Nc);
analysis.atp = zeros(1, p.Nc);
analysis.Vmm = zeros(1, p.Nc);

analysis.v4 = zeros(1, p.Nc);
analysis.v_gly_atp = zeros(1, p.Nc);
analysis.v_oxi_atp_cyt = zeros(1, p.Nc);
analysis.v_ATPUSE = zeros(1, p.Nc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       % create the fortran settings file
       fname_odesettings = strcat(folder_results, sim_name, '.dat')
       create_fortran_settings(p, fname_odesettings);

       fname_results = strcat(folder_results, sim_name, '.fort')
       if (1)  % do the simulations
             % call the solver with the settings
            cmd = sprintf('%s%s %s', folder_scripts, limex, fname_odesettings)
            system(cmd)

           % store the solution in Matlab format 

           cmd = sprintf('%s%s -i %s -o %s', folder_results, format_output, 'fort.10', fname_results)
           system(cmd)
       end % do simulation

       % get the function handle for the timecourses of metabolite
        % concentrations in the adjecent blood compartment
        for kx = 1:p.Nx_out
            switch p.ft_ext(kx)
                case 1
                    % disp('Constant Generator')
                    p.f_ext{kx} = tc_generator('constant', p.c_ext0(kx));
                case 2
                    % disp('Sinus Generator')
                    p.f_ext{kx} = tc_generator('sinus', p.c_ext0(kx));
            end
        end

       % create the workspace variable
       x = load(fname_results);
       t = x(:,1);
       if (numel(t) < 101)
           error(strcat('Limex Simulation did not finish -> ', name));
       end
       x(:,1) = [];
       create_named_variables

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Store data for analysis
        analysis.o2(1, :) = o2_mito(end,:);
        analysis.glc(1, :) = glc(end,:);
        analysis.atp(1, :) = atp(end,:);
        analysis.Vmm(1, :) = Vmm(end,:);
        analysis.v4(1, :) = v4(end,:);

        analysis.v_gly_atp(1, :) = v_gly_atp(end, :);
        analysis.v_oxi_atp_cyt(1,:) = v_oxi_atp_cyt(end,:);
        analysis.v_ATPUSE(1,:) = v_ATPUSE(end,:);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Create the plots
        if (1)
            p
            plots_steady_state;
            %close all
        end
save(strcat(folder_results, sim_name, '_Variable_Strategies_analysis.mat'), 'analysis', 'p');
end