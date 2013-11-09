clear all, close all, format compact
% add path to the cell_6
path(path, '../')
path(path, '../tools/')


% Call the fortran solver with the decided settings
folder_scripts = '/home/mkoenig/Desktop/model_cancer/fortran/Bloodflow_Cell_v6/bin/';
% folder for output
%folder_results = './results/121116_glc_o2_var_v04/'
folder_results = './results/121121_glc_o2_var_v01/'

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
sim.glc_ext = [0.8 1.8 5.5 16.5];
sim.lac_ext = [1.4];
%sim.o2_ext =  [15 30 120] * 1.3/760;
sim.o2_ext =  [30 120] * 1.3/760;


p.Nc = 25;
p = pars_layout(p);
p = init_cell(p);
p.ft_ext = [1 1 1];
p.delta_t = [0.0 1E5];
p.ext_constant = 0;
p.ode_cells = 1;
p.ode_diffusion = 1;
p.ode_blood = 0;

% constant strategy
if (0)
    disp('Constant Strategy')
    p.f_gly = ones(1, p.Nc) * 2.435; % 1.79;
    p.f_oxi = ones(1, p.Nc) * 0.2 % 0.3;
else
    disp('Variable Strategy')
    
    %p.f_gly =  1.0 +  2.4 * tmp.^3./(tmp.^3 + 3^3);
    %p.f_oxi =  0.42 - (0.42-0.05) * tmp.^3./(tmp.^3 + 3^3);
    %p.f_gly =  2.0 +  1.4 * tmp.^3./(tmp.^3 + 3^3);
    %p.f_oxi =  0.2 - (0.15) * tmp.^3./(tmp.^3 + 3^3);
    
    % p.f_gly =  (2.0 +  2.0 * tmp.^4./(tmp.^4 + 6^4));
    % p.f_oxi =  (0.2 - 0.19 * tmp.^4./(tmp.^4 + 6^4));
    tmp = (1:p.Nc)-1;
    %tmp_n = 5;
    %p.f_gly =  0.6*(2.0 +  1.4 * tmp.^tmp_n./(tmp.^tmp_n + 5^tmp_n));   % super good
    %p.f_oxi =  (0.2 - 0.15 * tmp.^4./(tmp.^4 + 6^4));   % super good
    %p.f_oxi =  1.8*(0.2 - 0.19 * tmp.^tmp_n./(tmp.^tmp_n + 5^tmp_n));   % super good
    
   %p.f_gly =  0.3*(2.0 +  1.4 * tmp.^4./(tmp.^4 + 6^4));
  % p.f_oxi =  0.9*(0.2 - 0.15 * tmp.^4./(tmp.^4 + 6^4));
    
   p.f_gly =  (2.0 +  1.4 * tmp.^4./(tmp.^4 + 7^4));
   p.f_oxi =  (0.2 - 0.19 * tmp.^4./(tmp.^4 + 7^4));
   
    
    %sim.sim_f_gly = [0.1  0.5  1.0  2  3.4  4]
    %sim.sim_f_oxi = [0.5620  0.5  0.42 0.2  0.05 0.04]
    
end 
% Variable strategy
%sim.sim_f_gly = [0.1 0.2 0.3 0.4 0.5  1.1450 1.7900 2.4350 3.0800 3.4025]
%sim.sim_f_oxi = [0.5620    0.5465    0.5310    0.5155  0.5  0.4  0.3  0.2 0.1 0.05]

p.odefun = @dydt_bloodflow;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Storage variables for analysis
analysis.glc_ext = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nb);
analysis.lac_ext = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nb);
analysis.o2_ext = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nb);

analysis.o2 = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nc);
analysis.glc = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nc);
analysis.atp = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nc);
analysis.Vmm = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nc);
analysis.v4 = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nc);
analysis.v_HK = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nc);
analysis.v_o2_use_cell = zeros(numel(sim.glc_ext), numel(sim.o2_ext), p.Nc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = numel(sim.glc_ext)*numel(sim.o2_ext)*numel(sim.lac_ext);
for kglc = 1:numel(sim.glc_ext)
   for klac = 1:numel(sim.lac_ext)
        for ko2 = 1:numel(sim.o2_ext)
           % set the external concentrations
           sim_glc = sim.glc_ext(kglc);
           sim_lac = sim.lac_ext(klac);
           sim_o2 = sim.o2_ext(ko2);
            
           p.c_ext0 = [sim_glc, sim_lac, sim_o2];
           
           % create the fortran settings file
           name = strcat('Cancer_v6_' , num2str(p.Nc), '_', num2str(p.Nf), '_[', ...
                        num2str(sim_glc), '_', ...
                        num2str(sim_lac), '_', ...
                        num2str(sim_o2*760/1.3), ']')
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
           end % do the simulations
           
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
               continue;
           end
           x(:,1) = [];
           create_named_variables

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Store data for analysis
            analysis.glc_ext(kglc, ko2, :) = glc_ext(end,:);
            analysis.lac_ext(kglc, ko2, :) = lac_ext(end,:);
            analysis.o2_ext(kglc, ko2, :) = o2_ext(end,:);
            
            analysis.o2(kglc, ko2, :) = o2_mito(end,:);
            analysis.glc(kglc, ko2, :) = glc(end,:);
            analysis.atp(kglc, ko2, :) = atp(end,:);
            analysis.Vmm(kglc, ko2, :) = Vmm(end,:);
            analysis.v4(kglc, ko2, :) = v4(end,:);
            analysis.v_o2_use_cell(kglc, ko2, :) = v_o2_use_cell(end,:);
            analysis.v_HK(kglc, ko2, :) = v_HK(end,:);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            if (0) % Create the plots
                p
                plots_steady_state;
                close all
            end 
           
       end
   end
end

save(strcat(folder_results, 'Glucose_O2_analysis'), 'analysis', 'sim', 'p');