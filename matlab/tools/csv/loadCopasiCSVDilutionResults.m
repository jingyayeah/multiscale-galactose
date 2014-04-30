% function [] = loadCopasiCSVResults()
%% Loading simulation results from copasi for visualization
% Plot the results for the different models.

%% Get simulation files
clear all; clc;
mname = 'Galactose_Dilution_v3_Nc5_Nf5';

folder = '~/multiscale-galactose-results/';
files = dir(folder);
sim_files = {};
for kf = 1:size(files, 1)
    file = files(kf);
    kstart = strfind(file.name, mname);
    kend   = strfind(file.name, '.txt');
    if (numel(kstart >0) && numel(kend) > 0)
       % collect files
       sim_files{end+1,1} = file;
    end
end

% This are the Nf files
Nfiles = length(sim_files)
flows = zeros(Nfiles, 1);
for kf = 1:Nfiles
    % Do some stuff 
    file = sim_files{kf,1};
    file.name
    pars = sscanf(file.name, strcat(mname,'_flow%f_gal%f.txt'));
    flows(kf) = pars(1);
end
% scale the flows [µm/s]
flows = flows*1E6;
flows'


%% Now collect the data
data = cell(Nfiles, 1);
delim = ', ';
for kf = 1:Nfiles
    kf/Nfiles * 100
    % Do some stuff 
    file = sim_files{kf,1};
    filename = strcat(folder, file.name);
    if (kf == 1)
        [header, dtmp] = csvreadh( filename, delim );
    else
        [~, dtmp] = csvreadh( filename, delim );
    end
    data{kf,1} = dtmp;
end
t = dtmp(:,1);
Nt = numel(t);
clear dtmp

%% Create the empty vectors for storage
ind_pp_gal = find(ismember(header,'PP__gal'));
ind_pv_gal = find(ismember(header,'PV__gal'));
ind_pp_galM = find(ismember(header,'PP__galM'));
ind_pv_galM = find(ismember(header,'PV__galM'));
ind_pp_rbcM = find(ismember(header,'PP__rbcM'));
ind_pv_rbcM = find(ismember(header,'PV__rbcM'));
ind_pp_alb = find(ismember(header,'PP__alb'));
ind_pv_alb = find(ismember(header,'PV__alb'));
ind_pp_h2oM = find(ismember(header,'PP__h2oM'));
ind_pv_h2oM = find(ismember(header,'PV__h2oM'));
ind_pp_suc = find(ismember(header,'PP__suc'));
ind_pv_suc = find(ismember(header,'PV__suc'));

uFlows = sort(unique(flows));

% do a repmat
PP__gal = zeros(Nt, numel(uFlows));
PV__gal = zeros(Nt, numel(uFlows));
PP__galM = zeros(Nt, numel(uFlows));
PV__galM = zeros(Nt, numel(uFlows));
PP__rbcM = zeros(Nt, numel(uFlows));
PV__rbcM = zeros(Nt, numel(uFlows));
PP__alb = zeros(Nt, numel(uFlows));
PV__alb = zeros(Nt, numel(uFlows));
PP__h2oM = zeros(Nt, numel(uFlows));
PV__h2oM = zeros(Nt, numel(uFlows));
PP__suc = zeros(Nt, numel(uFlows));
PV__suc = zeros(Nt, numel(uFlows));

for kfile=1:Nfiles
   tmp = data{kfile,1};
   
   ind_flow = find(uFlows==flows(kfile),1);
  
   PP__gal(:, ind_flow) = tmp(:, ind_pp_gal);
   PV__gal(:, ind_flow) = tmp(:, ind_pv_gal);
   PP__galM(:, ind_flow) = tmp(:, ind_pp_galM);
   PV__galM(:, ind_flow) = tmp(:, ind_pv_galM);
   PP__rbcM(:, ind_flow) = tmp(:, ind_pp_rbcM);
   PV__rbcM(:, ind_flow) = tmp(:, ind_pv_rbcM);
   PP__alb(:, ind_flow) = tmp(:, ind_pp_alb);
   PV__alb(:, ind_flow) = tmp(:, ind_pv_alb);
   PP__h2oM(:, ind_flow) = tmp(:, ind_pp_h2oM);
   PV__h2oM(:, ind_flow) = tmp(:, ind_pv_h2oM);
   PP__suc(:, ind_flow) = tmp(:, ind_pp_suc);
   PV__suc(:, ind_flow) = tmp(:, ind_pv_suc);
end



%% Plot the dilution indicator data
fig1 = figure('Name', 'Dilution Indicator', 'Color', [1 1 1], 'Position', [0 0 1800 400]);
for k=1:numel(uFlows)
    subplot(1,numel(uFlows),k)
    
    plot(t, PP__gal(:,k), '-', 'Color', [0.5 0.5 0.5]); hold on
    plot(t, PV__gal(:,k), 'k-'); hold on
    %plot(t, PP__galM(:,k), 'k-'); hold on
    %plot(t, PV__galM(:,k), 'k-'); hold on
    
    %plot(t, PP__rbcM(:,k), 'r-'); hold on
    plot(t, PV__rbcM(:,k), 'r-'); hold on
    %plot(t, PP__alb(:,k), 'b-'); hold on
    plot(t, PV__alb(:,k), 'b-'); hold on
    %plot(t, PP__h2oM(:,k), 'm-'); hold on
    plot(t, PV__suc(:,k), '-', 'Color', [0 0.8 0.2]); hold on
    plot(t, PV__h2oM(:,k), 'm-'); hold on
    %plot(t, PP__suc(:,k), '-', ); hold on
    
    
    xlabel('time [s]')
    ylabel('indicator')
    xlim([10,110])
    ylim([0,1.05])
    axis square
    
    if (k==numel(uFlows))
       legend({'MARKER','GAL', 'RBC', 'ALBUMIN', 'SUCROSE', 'WATER'}) 
    end
    
end

lwidth = 2;
haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    %xlim([0 230])
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', strcat(mname, '_Flow_Dependence.tif')); 

fig2 = figure('Name', 'Dilution Indicator', 'Color', [1 1 1], 'Position', [0 0 500 500]);
    k = 3;
    plot(t, PP__gal(:,k), '-', 'Color', [0.5 0.5 0.5]); hold on
    plot(t, PV__gal(:,k), 'k-'); hold on
    %plot(t, PP__galM(:,k), 'k-'); hold on
    %plot(t, PV__galM(:,k), 'k-'); hold on
    
    %plot(t, PP__rbcM(:,k), 'r-'); hold on
    plot(t, PV__rbcM(:,k), 'r-'); hold on
    %plot(t, PP__alb(:,k), 'b-'); hold on
    plot(t, PV__alb(:,k), 'b-'); hold on
    %plot(t, PP__h2oM(:,k), 'm-'); hold on
    plot(t, PV__suc(:,k), '-', 'Color', [0 0.8 0.2]); hold on
    plot(t, PV__h2oM(:,k), 'm-'); hold on
    %plot(t, PP__suc(:,k), '-', ); hold on
    
    
    xlabel('time [s]')
    ylabel('indicator')
    xlim([10,110])
    ylim([0,1.05])
    axis square
    legend({'MARKER','GAL', 'RBC', 'ALBUMIN', 'SUCROSE', 'WATER'}) 
    

lwidth = 2;
haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    %xlim([0 230])
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);
set(fig2, 'PaperPositionMode', 'auto');
print(fig2, '-dtiff', '-r100', strcat(mname, '_Flow_Dependence2.tif')); 


%% Plot the water distribution through the system

   

