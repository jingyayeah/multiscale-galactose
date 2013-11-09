clear all

if (1)
    % perform the simulations
    sim_matlab;
    sim_fortran;
end 

name_fortran = './results/test/fortran_test.fort'
name_matlab  = './results/test/matlab_test.mat'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fortran data
x_f = load(name_fortran);
t = x_f(:,1);     % get the time column
x_f(:,1) = []; 

x = x_f;
load(name_matlab)
create_named_variables;
glc_ext_f = glc_ext;
lac_ext_f = lac_ext;
o2_ext_f = o2_ext;


% Matlab Data
sol = p.sol{1};
x_mat = (deval(sol, t))';
x = x_mat;
create_named_variables;
glc_ext_mat = glc_ext;
lac_ext_mat = lac_ext;
o2_ext_mat = o2_ext;

% Difference data
%size(x_mat), size(x_f)
x = x_mat-x_f;    % Difference between Fortran & Matlab
create_named_variables;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the external concentration comparison
figure('Name', 'Matlab-Fortran-Comparison', 'Color', [1 1 1]);
ccolor = [0.3, 0.3, 0.3];
clines = -1:1:10;
ealpha = 0;
colormap('hot')
compartments = [(1:p.Nb) * p.d_blood * 1E6]';
for k=1:12
    subplot(4,3,k)
    switch k
        case 1
            data = glc_ext_f;
            title_name = 'Glucose extern [mM] FORTRAN LIMEX';
        case 2
            data = lac_ext_f;
            title_name = 'Lactate extern [mM] FORTRAN LIMEX';
        case 3
            data = o2_ext_f;
            title_name = 'O2 extern [mM] FORTRAN LIMEX';
            
        case 4
            data = glc_ext_mat;
            title_name = 'Glucose extern [mM] MATLAB ODE15s';
        case 5
            data = lac_ext_mat;
            title_name = 'Lactate extern [mM] MATLAB ODE15s';
        case 6
            data = o2_ext_mat;
            title_name = 'O2 extern [mM] MATLAB ODE15s';
            
        case 7
            data = glc_ext_mat - glc_ext_f;
            title_name = 'Glucose extern [mM] (MATLAB - FORTRAN)';
        case 8
            data = lac_ext_mat - lac_ext_f;
            title_name = 'Lactate extern [mM] (MATLAB - FORTRAN)';
        case 9
            data = o2_ext_mat - o2_ext_f;
            title_name = 'O2 extern [mM] (MATLAB - FORTRAN)s';
            
        case 10
            data = abs(glc_ext_mat - glc_ext_f)./glc_ext_mat;
            title_name = 'Glucose extern [mM] rel(MATLAB - FORTRAN)';
        case 11
            data = abs(lac_ext_mat - lac_ext_f)./lac_ext_mat;
            title_name = 'Lactate extern [mM] rel(MATLAB - FORTRAN)';
        case 12
            data = abs(o2_ext_mat - o2_ext_f)./o2_ext_mat;
            title_name = 'O2 extern [mM] rel(MATLAB - FORTRAN)s';
    end
    
    ptmp = pcolor(compartments, t, data);
    title(title_name);

    set(ptmp, 'EdgeAlpha', ealpha);
    xlabel(strcat('L [µm]'))
    ylabel('t [s]')
    colorbar()
    axis square
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plots_timecourse;
