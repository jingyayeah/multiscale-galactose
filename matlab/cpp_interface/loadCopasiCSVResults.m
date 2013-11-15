% function [] = loadCopasiCSVResults()
%% Loading simulation results from copasi for visualization
% Plot the results for the different models.
clear all; clc;
mname = 'Galactose_v3_Nc1_Nf5';
% mname = 'Galactose_v3_Nc5_Nf5';

%% Get simulation files

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
gals = zeros(Nfiles, 1);
for kf = 1:Nfiles
    % Do some stuff 
    file = sim_files{kf,1};
    file.name
    pars = sscanf(file.name, strcat(mname,'_flow%f_gal%f.txt'));
    flows(kf) = pars(1);
    gals(kf) = pars(2);
end
% scale the flows [µm/s]
flows = flows*1E6;
flows'
gals'

figure()
plot(gals, flows, 'ko');

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
uFlows = sort(unique(flows));
uGals = sort(unique(gals));

% do a repmat
PP__gal = zeros(Nt, numel(uFlows), numel(uGals));
PV__gal = zeros(Nt, numel(uFlows), numel(uGals));
for kfile=1:Nfiles
   tmp = data{kfile,1};
   ind_flow = find(uFlows==flows(kfile),1);
   ind_gal = find(uGals==gals(kfile),1);
   
   PP__gal(:, ind_flow, ind_gal) = tmp(:, ind_pp_gal);
   PV__gal(:, ind_flow, ind_gal) = tmp(:, ind_pv_gal);
end
PPPV_dif = PP__gal - PV__gal;


%% Plotting the clearance and extraction data

clear xlim, ylim
kpeak = 334;   % last index in the galactose peak

% subplot(3,2,1)
% y = squeeze(PP__gal(334,:,:));
% surf(uGals, uFlows, y); hold on
% 
% y = squeeze(PV__gal(334,:,:));
% surf(uGals, uFlows, y); hold on

% plot the slices
fig1 = figure('Name', 'Galactose Clearance', 'Color', [1 1 1], 'Position', [0 0 600 600]);

subplot(2,2,1)
for kflow=1:numel(uFlows)
    y = squeeze(PPPV_dif(kpeak,kflow,:));    
    plot(uGals, y, 'ko-'); hold on
    xlabel('periportal galactose [mM]')
    xlim([0, max(uGals)])
    ylabel('Galactose Elimination (GE)')
    axis square
end
%y = squeeze(mean(PPPV_dif(334,2:end,:),2));    
%plot(uGals, y, 'bo-'); hold on

subplot(2,2,2)
for kgal=1:numel(uGals)
    y = squeeze(PPPV_dif(kpeak,:,kgal));    
    plot(uFlows, y, 'ko-'); hold on
    xlabel('blood flow [µm/s]')
    xlim([0, max(uFlows)])
    ylabel('Galactose Elimination (GE)')
end
%y = squeeze(mean(PPPV_dif(334,:,:),3));    
%plot(uFlows, y, 'bo-'); hold on

% Extraction Ration
subplot(2,2,3)
for kgal=1:numel(uGals)
    y = squeeze(PPPV_dif(kpeak,:,kgal)./PP__gal(kpeak,:,kgal));    
    plot(uFlows, y, 'ko-'); hold on
    xlabel('blood flow [µm/s]')
    xlim([0, max(uFlows)])
    ylabel('Extraction Ratio (ER)')
end
%y = squeeze(mean(PPPV_dif(334,:,:)./PP__gal(334,:,:),3));    
%plot(uFlows, y, 'bo-'); hold on

% Clearance
subplot(2,2,4)
for kgal=1:numel(uGals)
    y = squeeze(PPPV_dif(kpeak,:,kgal)./PP__gal(kpeak,:,kgal) .* uFlows');    
    plot(uFlows, y, 'ko-'); hold on
    xlabel('blood flow [µm/s]')
    xlim([0, max(uFlows)])
    ylabel('Clearance (Cl)')
end
%y = squeeze(mean(PPPV_dif(334,:,:)./PP__gal(334,:,:).*uFlows',3));    
%plot(uFlows, y, 'bo-'); hold on

lwidth = 1;
haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    ylim1=get(gca,'ylim');
    set(gca, 'ylim', 1.05*ylim1)
    
    xlim1=get(gca,'xlim');
    set(gca, 'xlim', 1.05*xlim1)
    % set(get(gca, 'XLabel'), 'String', 'pp < - > pv [�m]');
    
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
print(fig1, '-dtiff', '-r150', strcat(mname, '_Extraction.tif')); 


%end


