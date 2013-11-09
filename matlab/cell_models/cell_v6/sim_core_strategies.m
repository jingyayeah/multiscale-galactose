function [] = sim_core_strategies(c_ext0)
% Calculate the constant strategies for the system for the given external
% glucose, lactate and oxygen concentrations
close all, format compact
path(path, '../')
path(path, '../tools/')

% Set the external glc, lac and o2 concentration
if (nargin == 0)
    p.c_ext0 = [5.5, 1.4, 30*1.3/760];
else
    p.c_ext0 = c_ext0;
end

% Call the fortran solver with the decided settings
folder_scripts = '/home/mkoenig/Desktop/model_cancer/fortran/Bloodflow_Cell_v6/bin/';
% folder for output
folder_results = './results/121121_core_strategies_v01/'
% Simulation name
sim_name = sprintf('Cancer_v6_[%0.4f_%0.4f_%0.4f]', p.c_ext0(1), p.c_ext0(2), p.c_ext0(3));

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition of the constant strategies
% sim.sim_f_oxi = 1 - sim.sim_f_gly;
% sim.sim_f_oxi = 7.45/12.9 - 2/12.9 * sim.sim_f_gly;
% sim.sim_f_gly = [0.1 0.2 0.3 0.4 0.5  1.1450 1.7900 2.4350 3.0800 3.4025]
% sim.sim_f_oxi = [0.5620    0.5465    0.5310    0.5155  0.5  0.4  0.3  0.2 0.1 0.05]

%sim.sim_f_gly = [0.05 0.2 0.4 0.6 0.8 0.95];
%sim.sim_f_oxi = [0.95 0.8 0.6 0.4 0.2 0.05];

%sim.sim_f_gly = [0.1  0.5  1.0  2  3.4]
%sim.sim_f_oxi = [0.5620 0.5  0.42 0.2  0.05]


%sim.sim_f_gly = [0.1     0.5  1.0  2  3.4   4.0]
%sim.sim_f_oxi = [0.5620  0.5  0.42 0.2  0.05 0.01]

sim.sim_f_gly = [0.1     0.5  1.0  2.7  3.4   4.0]
sim.sim_f_oxi = [0.5620  0.5  0.42 0.15  0.05 0.01]


Ngly = numel(sim.sim_f_gly);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the settings for the solver
p.Nc            = 25;
p = pars_layout(p);
p = init_cell(p);
p.odefun = @dydt_bloodflow;
p.ft_ext        = [1 1 1];
p.delta_t       = [0.0 1E5];
p.ext_constant  = 0;
p.ode_cells     = 1;
p.ode_diffusion = 1;
p.ode_blood     = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Storage variables for analysis
analysis.glc_ext = zeros(Ngly, p.Nb);
analysis.lac_ext = zeros(Ngly, p.Nb);
analysis.o2_ext = zeros(Ngly, p.Nb);

analysis.o2 = zeros(Ngly, p.Nc);
analysis.glc = zeros(Ngly, p.Nc);
analysis.atp = zeros(Ngly, p.Nc);
analysis.Vmm = zeros(Ngly, p.Nc);

analysis.v4 = zeros(Ngly, p.Nc);
analysis.v_gly_atp = zeros(Ngly, p.Nc);
analysis.v_oxi_atp_cyt = zeros(Ngly, p.Nc);
analysis.v_ATPUSE   = zeros(Ngly, p.Nc);
analysis.v_GLCUSE = zeros(Ngly, p.Nc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform simulation for all strategies
for kgly = 1:Ngly
       % set the external concentrations
       p.f_gly = ones(1, p.Nc)* sim.sim_f_gly(kgly);
       p.f_oxi = ones(1, p.Nc)* sim.sim_f_oxi(kgly);

       % create the fortran settings file
       name = strcat(sim_name, sprintf('_%0.4f_%0.4f', sim.sim_f_gly(kgly), sim.sim_f_oxi(kgly)) );
       fname_odesettings = strcat(folder_results, name, '.dat')
       create_fortran_settings(p, fname_odesettings);

       fname_results = strcat(folder_results, name, '.fort')
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

       % create the workspace variables
       x = load(fname_results);
       t = x(:,1);
       if (numel(t) < 101)
           error(strcat('Limex Simulation did not finish -> ', name));
           continue;
       end
       x(:,1) = [];
       create_named_variables

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Store data for analysis
        analysis.glc_ext(kgly,:) = glc_ext(end,:);
        analysis.lac_ext(kgly,:) = lac_ext(end,:);
        analysis.o2_ext(kgly,:)  = o2_ext(end,:);

        analysis.o2(kgly, :) = o2_mito(end,:);
        analysis.glc(kgly, :) = glc(end,:);
        analysis.atp(kgly, :) = atp(end,:);
        analysis.Vmm(kgly, :) = Vmm(end,:);
        analysis.v4(kgly, :) = v4(end,:);

        analysis.v_gly_atp(kgly, :) = v_gly_atp(end, :);
        analysis.v_oxi_atp_cyt(kgly, :) = v_oxi_atp_cyt(end,:);
        analysis.v_ATPUSE(kgly, :) = v_ATPUSE(end,:);
        analysis.v_GLCUSE(kgly, :) = v_GLCUSE(end,:);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Create the plots
        if (0)
            p
            plots_steady_state;
            %close all
        end

end
save(strcat(folder_results, sim_name, '_Core_Strategies_analysis.mat'), 'analysis', 'sim', 'p');
end