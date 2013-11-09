function [] = fig_singlecell(sim_name);

% Load the stored data for the simulation
load(sim_name);

% Data for figures
p.Nt = length(t);
dxdt = zeros(size(x));
for k=1:p.Nt
   dxdt(k,:) = p.odefun(t(k),x(k,:)', p); 
end

% Get complete information for the integration
% [1] solution concentrations -> get all the names from x_names
glc_ext = x(:, 1:p.Nb);
lac_ext = x(:, p.Nb+1:2*p.Nb);
o2_ext  = x(:, 2*p.Nb+1:3*p.Nb);

for k=1:p.Nx_in
   eval([p.x_names{k+p.Nx_out} ' = x(:,3*p.Nb + k: p.Nx_in : end);'])
end

% [2] dxdt profiles
dx_glc_ext = dxdt(:, 1:p.Nb);
dx_lac_ext = dxdt(:, p.Nb+1:2*p.Nb);
dx_o2_ext  = dxdt(:, 2*p.Nb+1:3*p.Nb);
for k=1:p.Nx_in
   eval(['dx_' p.x_names{k+p.Nx_out} ' = dxdt(:, 3*p.Nb + k: p.Nx_in : end);']) 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [3] Get additional fluxes from the integration routines
% These fluxes are defined in the subintegration routine for the modules
% TODO: readout of interesting fluxes
% Get the model fluxes
[~, v_names_cs, ~] = dydt_cellsimple(0, p.x0, p);
v_cs = zeros(p.Nt, p.Nc, numel(v_names_cs));
for k=1:p.Nt
    [~, ~, tmp] = dydt_cellsimple(t(k), x(k,:)', p); 
    v_cs(k,:,:) = tmp;
end

% define names for the v_cac timecourse
for k=1:numel(v_names_cs)
   eval([v_names_cs{k} ' = v_cs(:,:,k);']) 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create figures only if not existing
handles=findall(0,'type','figure');
exist_fig1 = false;
exist_fig2 = false;
exist_fig3 = false;
scrsz = get(0,'ScreenSize');
if ~exist_fig1
    fig_c = figure('Name', 'Concentrations', 'Color', [1 1 1], ...
              'OuterPosition', [1 scrsz(4)/2 1000 scrsz(4)/2]);
    disp('fig1 created')
end
if ~exist_fig2
    fig_v = figure('Name', 'Fluxes', 'Color', [0.7 0.7 1], ...
              'OuterPosition',[1 1 1000 scrsz(4)/2]);
    disp('fig2 created')
end
if ~exist_fig3
    fig_dx = figure('Name', 'DXDT', 'Color', [1 0.7 0.7], ...
              'Position',[1920+500 600 900 600]);
    disp('fig3 created')
end

ro = 'r-o';     ko = 'k-o';     bo = 'b-o';     go = 'g-o';
rno = 'r-';    kno = 'k-';    bno = 'b-';       gno = 'b-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert the time-axis
time = 'min'
switch (time)
    case 's'
        t = t;
    case 'min'
        t = t/60;
end


%% FIG1: Concentrations
figure(fig_c)
% plot internal
for k=1:5
    subplot(2,3,k)
    switch k
        case 1
            p1 = plot(t, glc, ro, t, glc_ext, ko);
            title('Glc[r], Glc_{ext}[k]', 'FontWeight', 'bold');
            %ylim([-0.1 6])
            set(gca, 'Color', [0.94 0.94 0.94])
        case 2
            p1 = plot(t, lac, ro, t, lac_ext, ko);
            title('Lac[r], Lac_{ext}[k]', 'FontWeight', 'bold');
            %ylim([-0.1 8])
            set(gca, 'Color', [0.94 0.94 0.94])
        case 3        
            p1 = plot(t, o2, ro, t, o2_ext, ko);
            title('O2[r], O2_{ext}[k]', 'FontWeight', 'bold');
            %ylim([-0.1 2])
            set(gca, 'Color', [0.94 0.94 0.94])
        case 4
            p1 = plot(t, pyr, ro);
            title('Pyruvate', 'FontWeight', 'bold');
            %ylim([-0.1 3])
        case 5
            p1 = plot(t, atp, bo, t, adp, go);
            title('ATP [b], ADP [g]', 'FontWeight', 'bold');
            ylim([-0.1 4])
            % legend({'ATP', 'ADP', 'ATP+ADP'})
            legend({'ATP', 'ADP'})
            
    end
    xlabel(strcat('t [', time, ']'))
    ylabel('c [mM]')
    axis square
    grid on
    xlim([0 t(end)])
   set(p1, 'MarkerSize', 2.5)
   set(p1, 'LineWidth', 1.5)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fig2: DXDT
figure(fig_dx)
for k=1:p.Nx_out
   % Profile in first compartment
   subplot(3,3, k)
   switch k
       case 1
           p1 = plot(t, dx_glc_ext, ko);
           title('Glucose extern', 'FontWeight', 'bold');
           %ylim([-0.1 4])
       case 2
           p1 = plot(t, dx_lac_ext, ko);
           title('Lactate extern','FontWeight', 'bold')
           %ylim([-0.1 8])
       case 3
           p1 = plot(t, dx_o2_ext, ko);
           title('O2 extern', 'FontWeight', 'bold')
           %ylim([-0.1 1.5])
   end
   set(gca, 'Color', [0.94 0.94 0.94])
   set(p1, 'MarkerSize', 2.5)
   set(p1, 'LineWidth', 1.5)
   axis square
   grid on
   xlabel(strcat('t [', time, ']'))
   ylabel('dxdt [mM/s]')
   xlim([0 t(end)])
end
% plot internal
for k=4:8
    subplot(3,p.Nx_out,k)
    switch k
        case 4
            p1 = plot(t, dx_glc, ro, t, dx_glc_ext, ko);
            title('Glucose [mM]', 'FontWeight', 'bold');
            %ylim([-0.1 6])
            
        case 5
            p1 = plot(t, dx_lac, ro, t, dx_lac_ext, ko);
            title('Lactate [mM]', 'FontWeight', 'bold');
            %ylim([-0.1 8])
        case 6        
            p1 = plot(t, o2, ro, t, dx_o2_ext, ko);
            title('O2 [mM]', 'FontWeight', 'bold');
            %ylim([-0.1 2])
        case 7
            p1 = plot(t, dx_pyr, ro);
            title('Pyruvate [mM]', 'FontWeight', 'bold');
            %ylim([-0.1 3])
        case 8
            p1 = plot(t, dx_atp, bo, t, dx_adp, ro, t, dx_atp+dx_adp, ko);
            title('ATP [b], ADP [r] [mM]', 'FontWeight', 'bold');
            %ylim([-0.1 8])
            %legend({'ATP', 'ADP', 'ATP+ADP'})
    end
    xlabel(strcat('t [', time, ']'))
    ylabel('dxdt [mM/s]')
    axis square
    grid on
    xlim([0 t(end)])
    set(p1, 'MarkerSize', 2.5)
    set(p1, 'LineWidth', 1.5)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fig3: Fluxes
figure(fig_v)
for k=1:6
    subplot(2,3,k)
    switch k
        case 1
            p1 = plot(t, v_glut1_in, ro);
            title('GLUT1', 'FontWeight', 'bold');
        case 3
            p1 = plot(t, v_do2_in, ro);
            title('D02', 'FontWeight', 'bold'); 
        case 2   
            p1 = plot(t, v_mct4_in, ro, t, v_mct1_in, bo);
            title('MCT', 'FontWeight', 'bold');
            legend({'MCT4', 'MCT1'})            
        case 4
            p1 = plot(t, v_anaerob, ro, t, v_aerob, bo, t, -v_atpase, go);
            title('ATP fluxes', 'FontWeight', 'bold');
            legend({'anearob', 'aerob', 'atpase'});
        
        case 5
            p1 = plot(t, v_anaerob*2, ro, t, v_aerob*27.8, bo, ...
                      t, -v_atpase, go,   t, dx_atp, ko);
            title('ATP changes', 'FontWeight', 'bold');
            legend({'anearob', 'aerob', 'atpase', 'netto'});            
        case 6
            p1 = plot(t, v_ldha, ro, t, v_ldhb, bo);
            title('LDH', 'FontWeight', 'bold');
            legend({'LDHA', 'LDHB'})
            
            
    end
    xlabel(strcat('time[s]'))
    ylabel('v [mM/s]')
    axis square
    grid on
    xlim([0 t(end)])
    set(p1, 'MarkerSize', 2.5)
    set(p1, 'LineWidth', 1.5)
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%