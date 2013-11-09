function [] = fig_sim_core_strategies(c_ext0)
% Create the figures for the core strategies in the tumor

% Set the external glc, lac and o2 concentration and load the data
if (nargin == 0)
    p.c_ext0 = [5.5, 1.4, 30*1.3/760];
else
    p.c_ext0 = c_ext0;
end

folder_results = './results/121117_core_strategies_v03/';
sim_name = sprintf('Cancer_v6_[%0.4f_%0.4f_%0.4f]', p.c_ext0(1), p.c_ext0(2), p.c_ext0(3));
file_name = strcat(folder_results, sim_name, '_Core_Strategies_analysis.mat')
data = load(file_name);
p = data.p;
sim = data.sim;
analysis = data.analysis;
clear data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the critical values
Ngly = numel(sim.sim_f_gly);

% Critical ATP distance
ATPC0 = 0.1;
[atpc, atpc_inds]  = getCriticalValues(analysis.atp, ATPC0);
% Proliferating ATP
ATPP0 = 2.0;
atppro = getCriticalValues(analysis.atp, ATPP0);
% Critical glucose
GLCC0 = 1E-2;
[glcc, glcc_inds] = getCriticalValues(analysis.glc, GLCC0);
% Critical O2
O2C0 = 1E-4;
[o2c, o2c_inds] = getCriticalValues(analysis.o2, GLCC0);
% Critical ATPUSE
ATPUSEC0 = 0.8*40.0;
atpusec = getCriticalValues(analysis.v_ATPUSE, ATPUSEC0);
% Critical GLCUSE
GLCUSEC0 = 0.8*35.0;
glcusec = getCriticalValues(analysis.v_GLCUSE, GLCUSEC0);

function [c0_vals, c0_inds] = getCriticalValues(data, c0)
    N = size(data,1);
    c0_inds = zeros(N,1);
    c0_vals = zeros(N,1);
    for kg=1:N
        in = find((data(kg, :) < c0), 1, 'first');
        in = in-1;
        if (numel(in) == 0)
            in = p.Nc;
        end
        c0_inds(kg) = in;
        c0_vals(kg) = (in-0.5)*p.d_cell * 1E6;
    end
end

% O2 Consumption in viable rim (critical area)
atpc_o2_consum = zeros(Ngly, 1);
glcc_o2_consum = zeros(Ngly, 1);
o2c_o2_consum = zeros(Ngly, 1);
for kgly = 1:Ngly
    index = atpc_inds(kgly);
    atpc_o2_consum(kgly) = sum(analysis.v4(kgly, 1:index)) /index;

    index = glcc_inds(kgly);
    glcc_o2_consum(kgly) = sum(analysis.v4(kgly, 1:index)) /index;

    index = o2c_inds(kgly);
    o2c_o2_consum(kgly) = sum(analysis.v4(kgly, 1:index)) /index;
end
    



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('Name', 'Core Strategies', 'Position', [300 300 900 700]);

   % O2 critical distance
   subplot(2,3,1)
   plot(o2c, sim.sim_f_gly, 'ks-')
   title(sprintf('Critical O2 Distance (<%0.2f)', O2C0)); 

   % Glc critical distance
   subplot(2,3,2)
   plot(glcc, sim.sim_f_gly, 'ks-')
   title(sprintf('Critical Glucose Distance (<%0.2f)', GLCC0)); 

   % ATP critical distance
   subplot(2,3,3)
   plot(atpc, sim.sim_f_gly, 'bs-'), hold on
   plot(atppro, sim.sim_f_gly, 'ks-'), hold off
   title({'Critical ATP Distance', sprintf('ATP < %0.2f & ATP < %0.2f', ATPC0, ATPP0)})
   
   % ATPUSE critical
   subplot(2,3,4)
   plot(atpusec, sim.sim_f_gly, 'ks-')
   title({'Critical ATPUSE Distance', sprintf('(ATPUSE < %0.2f)', ATPUSEC0)}) 
   
   % GLCUSE critical
   subplot(2,3,5)
   plot(glcusec, sim.sim_f_gly, 'ks-')
   title({'Critical GLCUSE Distance', sprintf('(GLCUSE < %0.2f)', GLCUSEC0)}) 
   

hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);
haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax);
    set(gca, 'FontWeight', 'bold');
    ylabel('[OXPHOS] <-> [GLY]')
    xlabel('Distance Blood Vessel [µm]')
    tit = get(gca, 'Title');
    xlim([0 300])
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
    axis square

end
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', strcat(folder_results, sim_name, '_Core_Strategies_fig1.tif')); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure of zonated strategies

cells = 1:p.Nc;
compartments = 1:p.Nb * p.d_cell*1E6;

fig2 = figure('Name', 'Zonated Strategies', 'Position', [100 100 1600 800]);
subplot(3,4,1)
imagesc(cells, sim.sim_f_gly, analysis.v_gly_atp)
title('Glycolysis ATP')
subplot(3,4,2)
imagesc(cells, sim.sim_f_gly, analysis.v_oxi_atp_cyt)
title('Oxidative Phosphorylation ATP')
subplot(3,4,3)
imagesc(cells, sim.sim_f_gly, analysis.v_ATPUSE)
title('ATP use')
subplot(3,4,4)
imagesc(cells, sim.sim_f_gly, analysis.v_GLCUSE)
title('Glucose use')

subplot(3,4,5)
imagesc(cells, sim.sim_f_gly, analysis.atp)
title('ATP')
subplot(3,4,6)
atppro = double(analysis.atp>=ATPP0);
imagesc(cells, sim.sim_f_gly, atppro)
title('ATP Proliferating')
subplot(3,4,7)
imagesc(cells, sim.sim_f_gly, double(analysis.v_ATPUSE>=0.8*40.0))
title('ATPUSE > 80% Max(ATPUSE)')
subplot(3,4,8)
imagesc(cells, sim.sim_f_gly, double(analysis.v_GLCUSE>=0.8*35.0))
title('GLCUSE > 80% Max(GLCUSE)')

subplot(3,4,9)
imagesc(compartments, sim.sim_f_gly, analysis.glc_ext)
title('Glucose extern')
subplot(3,4,10)
imagesc(compartments, sim.sim_f_gly, analysis.o2_ext)
title('O2 extern')
subplot(3,4,11)
imagesc(compartments, sim.sim_f_gly, analysis.lac_ext)
title('Lactate extern')

subplot(3,4,12)
atpc = double(analysis.atp>ATPC0);
imagesc(cells, sim.sim_f_gly, atpc)
title('ATP Critical')

haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax);
    set(gca, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    xlabel('Cell <i>')
    ylabel('Glycolytic Capacity')
    colormap('hot')
    colorbar;
    shading('flat');
    
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
    axis square
        axis xy
end
set(fig2, 'PaperPositionMode', 'auto');
print(fig2, '-dtiff', '-r150', strcat(folder_results, sim_name, '_Core_Strategies_fig2.tif')); 

end
