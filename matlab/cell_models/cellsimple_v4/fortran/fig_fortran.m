clear all, close all
folder_fortran = '/home/mkoenig/Desktop/model_cancer/fortran/Bloodflow_Cellsimple_v4/results/' 
folder_matlab = './data/';

sim_fortran = strcat(folder_fortran, 'fortran_30_05_test', '.dat');
sim_matlab  = strcat(folder_matlab, 'matlab_30_05_test', '.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare figure
figure('Name', 'Matlab-Fortran-Comparison', 'Color', [1 1 1]);
ccolor = [0.3, 0.3, 0.3];
clines = -1:1:10;
ealpha = 0;
colormap('hot')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab Data
disp('* Load Matlab data')
load(sim_matlab)

compartments = [(1:p.Nb) * p.d_blood * 1E6]';
t_total = 0;
t = [];
x = [];
for k_sim = 1:size(p.c_sim, 1)
    % if the solution for the simulation should be part of the plotted
    % timecourse
    tend = p.c_sim{k_sim, 2};
    if p.c_sim{k_sim, 6}
        sol = p.sol{k_sim};
        %dtmp = 25;                  % step size for generating the solution
        %t_sim = [0:dtmp:tend]';
        t_sim = linspace(0, tend, 101);
        x_sim = deval(sol, t_sim);
        
        t = [t 
             t_sim+t_total];
        x = [x 
             x_sim'];
        t_total = t_total+tend;
    end
end

% [1] solution concentrations -> get all the names from x_names
p.Nt = length(t);
glc_ext = zeros(p.Nt, p.Nb,1);
lac_ext = zeros(p.Nt, p.Nb,1);
o2_ext  = zeros(p.Nt, p.Nb,1);

for ci=1:p.Nc
   glc_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc         +1:p.Nx_out +  (ci-1)*p.Nxc + p.Nf); 
   lac_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc +   p.Nf+1:p.Nx_out +  (ci-1)*p.Nxc + 2*p.Nf); 
   o2_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc + 2*p.Nf+1: p.Nx_out + (ci-1)*p.Nxc + 3*p.Nf); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fortran Data
disp('* Load Fortran data')
res = load(sim_fortran);
t_f = res(:,1);
res(:,1) = [];
glc_ext_f = zeros(size(res,1), p.Nb);
lac_ext_f = glc_ext_f;
o2_ext_f  = glc_ext_f;
for ci = 1:p.Nc
    glc_ext_f(:,(ci-1)*p.Nf+1: ci*p.Nf) = ...
        res(:,p.Nx_out + (ci-1)*p.Nxc + 1: p.Nx_out + (ci-1)*p.Nxc + p.Nf);
    lac_ext_f(:,(ci-1)*p.Nf+1: ci*p.Nf) = ... 
        res(:, p.Nx_out + (ci-1)*p.Nxc + p.Nf + 1: p.Nx_out + (ci-1)*p.Nxc + 2*p.Nf);
     o2_ext_f(:,(ci-1)*p.Nf+1: ci*p.Nf) = ...
         res(:, p.Nx_out + (ci-1)*p.Nxc +2*p.Nf+1: p.Nx_out + (ci-1)*p.Nxc + 3*p.Nf);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot data
disp('* Plot data')
x = compartments;
for k=1:9
    subplot(3,3,k)
    switch k
        case 1
            y = t_f;
            data = glc_ext_f;
            title_name = 'Glucose extern [mM] FORTRAN LIMEX';
        case 2
            y = t_f;
            data = lac_ext_f;
            title_name = 'Lactate extern [mM] FORTRAN LIMEX';
        case 3
            y = t_f;
            data = o2_ext_f;
            title_name = 'O2 extern [mM] FORTRAN LIMEX';
        case 4
            y = t;
            data = glc_ext;
            title_name = 'Glucose extern [mM] MATLAB ODE15s';
        case 5
            y = t;
            data = lac_ext;
            title_name = 'Lactate extern [mM] MATLAB ODE15s';
        case 6
            y = t;
            data = o2_ext;
            title_name = 'O2 extern [mM] MATLAB ODE15s';
        case 7
            y = t;
            data = glc_ext - glc_ext_f;
            title_name = 'Glucose extern [mM] (MATLAB - FORTRAN)';
        case 8
            y = t;
            data = lac_ext - lac_ext_f;
            title_name = 'Lactate extern [mM] (MATLAB - FORTRAN)';
        case 9
            y = t;
            data = o2_ext - o2_ext_f;
            title_name = 'O2 extern [mM] (MATLAB - FORTRAN)s';
    end
    
    ptmp = pcolor(x, y, data);
    %hold on;
    title(title_name);
    %[C,h] = contour(x, y, data, clines, 'k-', 'LineColor', ccolor); 
    
    %text_handle = clabel(C, h, clines, 'Rotation', 90, 'LabelSpacing', 500);
    %text_handle = clabel(C, h, clines);
    %hold off
    %set(text_handle,'Color',ccolor);
    set(ptmp, 'EdgeAlpha', ealpha);
    xlabel(strcat('L [µm]'))
    ylabel('t [s]')
    colorbar()
    axis square
    %shading interp
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

