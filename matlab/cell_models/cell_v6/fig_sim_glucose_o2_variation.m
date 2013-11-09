%% Load the simulation data
folder_results = './results/121121_glc_o2_var_v01/'
%folder_results = './results/121116_glc_o2_v04/'
load(strcat(folder_results, 'Glucose_O2_analysis'));

%% Calculate the critical values
atpc  = zeros(numel(sim.glc_ext), numel(sim.o2_ext));
glcc = zeros(numel(sim.glc_ext), numel(sim.o2_ext)) ;
lacc = zeros(numel(sim.glc_ext), numel(sim.o2_ext)) ;
o2c = zeros(numel(sim.glc_ext), numel(sim.o2_ext)) ;

% Calculate the o2 consumption in the viable rim
o2_consum = zeros(numel(sim.glc_ext), numel(sim.o2_ext));
warburg   = zeros(numel(sim.glc_ext), numel(sim.o2_ext));

for kglc=1:numel(sim.glc_ext)
    for ko2=1:numel(sim.o2_ext)
        
        % ATP critical distance
        in_atpc = find((analysis.atp(kglc,ko2,:)<0.2), 1, 'first');
        in_atpc = in_atpc - 1;
        if (numel(in_atpc) == 0)
            in_atpc = p.Nc;
        end
        atpc(kglc, ko2) = (in_atpc-0.5) *p.d_cell*1E6;
        atpc_o2_consum(kglc, ko2) = sum(analysis.v4(kglc, ko2, 1:in_atpc))/in_atpc;
        
        
        % Glucose critical distance
        in_glcc = find((analysis.glc(kglc,ko2,:)<0.01), 1, 'first');
        in_glcc = in_glcc - 1;
        if (numel(in_glcc) == 0)
            in_glcc = p.Nc;
        end
        glcc(kglc, ko2) = (in_glcc-0.5)*p.d_cell * 1E6;
        glcc_o2_consum(kglc, ko2) = sum(analysis.v4(kglc, ko2, 1:in_glcc))/in_glcc;
        
        
        % O2 critical distance
        in_o2c = find((analysis.o2(kglc,ko2,:)<0.1/760*1.3), 1, 'first');
        in_o2c = in_o2c - 1;
        if (numel(in_o2c) == 0)
            in_o2c = p.Nc;
        end
        o2c(kglc, ko2) = (in_o2c-0.5)*p.d_cell * 1E6;
        o2c_o2_consum(kglc, ko2) = sum(analysis.v4(kglc, ko2, 1:in_o2c))/in_o2c;
        
        % Warburg Effect
        warburg(kglc, ko2) = 100 * sum(analysis.v_HK(kglc, ko2, 1:in_o2c))/ ...
                                    sum(analysis.v_HK(kglc, ko2, 1:in_atpc));

    end
end

%%  Raw data figure (Viable rim & O2 consumption)
names = cell(1, numel(sim.o2_ext));
for k=1:numel(sim.o2_ext)
    names{k} = strcat( num2str(sim.o2_ext(k)*760/1.3), ' mmHg o2');
end

%{
fig1 = figure('Name', 'O2 - Glucose variation', 'Position', [300 300 700 800]);
for ko2=1:numel(sim.o2_ext)

      
   % O2 consum (ATPC)
   subplot(3,2,2)
   %plot(sim.glc_ext, atpc_o2_consum(:,1), 'bs-'), hold on
   plot(sim.glc_ext, atpc_o2_consum(:,1), 'rs-'), hold on
   plot(sim.glc_ext, atpc_o2_consum(:,2), 'ks-'), hold on
   title('O2 consum viable rim (v4)')
   legend(names, 'Location', 'NorthEast')
      
   % O2 consum (O2C)
   subplot(3,2,4)
   %plot(sim.glc_ext, o2c_o2_consum(:,1), 'bs-'), hold on
   plot(sim.glc_ext, o2c_o2_consum(:,1), 'rs-'), hold on
   plot(sim.glc_ext, o2c_o2_consum(:,2), 'ks-'), hold on
   title('O2 consum viable rim (v4)')
   legend(names, 'Location', 'SouthEast')
   
   % O2 consum (GLCC)
   subplot(3,2,6)
   %plot(sim.glc_ext, glcc_o2_consum(:,1), 'bs-'), hold on
   plot(sim.glc_ext, glcc_o2_consum(:,1), 'rs-'), hold on
   plot(sim.glc_ext, glcc_o2_consum(:,2), 'ks-'), hold on
   title('O2 consum viable rim (v4)')
   legend(names, 'Location', 'NorthEast')
end

hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);
haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax);
    set(gca, 'FontWeight', 'bold');
    xlabel('Glucose [mM]')
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
end

set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', strcat(folder_results,'Glucose_O2_analysis.tif')); 
%}

%{
%%  Figure 3A - Comparison of the O2 profiles
fig2 = figure('Name', 'O2 - Profiles', 'Position', [0 0 1000 500]);
dist_sim = (1:p.Nb)*p.d_cell/p.Nf*1E6;
sim_color = [0 0 1];
data_color = [0.3 0.3 0.3];

% po2 Mueller-Klieser1986 (600µm)
ko2 = 2;    % 120 mmHg
kglc = 2;   % 1.8 mM
po2_sim = squeeze(analysis.o2_ext(kglc, ko2, :))*760/1.3;

subplot(1,2,1)
[dist, po2] = Mueller_Klieser1986_po2_600();
plot (dist_sim, po2_sim, 's-', 'Color', sim_color); hold on;
plot (dist, po2, 'ko-', 'MarkerFaceColor', data_color); hold off;
title({'EMT6/Ro Spheroids pO2 Profile', '(1.8mM glucose)'})
legend({'Sim', 'Data'}, 'Location', 'NorthEast')
%ylim([0, 1.2*max(po2)])
xlim([0, 420])

% po2 Mueller-Klieser1986 (300µm)
ko2 = 1;    % 30 mmHg
kglc = 1;   % 0.8 mM
po2_sim = squeeze(analysis.o2_ext(kglc, ko2, :))*760/1.3;
subplot(1,2,2)
[dist, po2] = Mueller_Klieser1986_po2_300();
plot (dist_sim, po2_sim, 's-', 'Color', sim_color); hold on;
plot (dist, po2, 'ko-', 'MarkerFaceColor', data_color); hold off;
title({'EMT6/Ro Spheroids pO2 Profile', '(0.8mM glucose)'})
legend({'Sim', 'Data'}, 'Location', 'NorthEast')
%ylim([0, 1.2*max(po2)])
xlim([0, 420])
%}

%{
% po2 Helmlinger1997 (450µm)
ko2 = 1;    % 15 mmHg
kglc = 3;   % 5.5 mM
po2_sim = squeeze(analysis.o2_ext(kglc, ko2, :))*760/1.3;
subplot(1,3,3)
[dist, po2, po2_sem] = Helmlinger1997_po2();
plot (dist_sim, po2_sim, 's-', 'Color', sim_color); hold on;
errorbar(dist, po2, po2_sem, 'ko-', 'MarkerFaceColor', data_color); hold off;
title('17 day old tumors pO2 profile')
legend({'Sim (5.5mM glucose)', 'Data (glucose in vivo)'}, 'Location', 'NorthEast')
%ylim([0, 1.2*max(po2+po2_sem)])
xlim([0, 420])
%}
%{
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 1);
haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax);
    set(gca, 'FontWeight', 'bold');
    xlabel('Distance Blood Vessel [µm]')
    ylabel('pO2 [mmHg]')
    axis square
    grid on
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
end

set(fig2, 'PaperPositionMode', 'auto');
print(fig2, '-dtiff', '-r150', strcat(folder_results,'O2_profiles.tif')); 
%}

%%  Figure 3B - Viable rim 
fig3 = figure('Name', 'Viable Rim & O2 Consumption', 'Position', [0 000 1000 600]);

% Viable Rim Mueller-Klieser1986
%% Critical ATP distance
subplot(2,3,1)
o2 = 5;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-', 'LineWidth', 2), hold on
o2 = 20;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ko-', 'LineWidth', 2), hold on

%plot(sim.glc_ext, atpc(:,1), 'bs-'), hold on
plot(sim.glc_ext, atpc(:,1), 'rs-'), hold on
plot(sim.glc_ext, atpc(:,2), 'ks-'), hold off

legend({'5% o2', '20% o2'}, 'Location', 'SouthEast')
title({'EMT6/Ro spheroids viable rim', '(ATP critical < 0.1mM)'})
xlabel('Glucose in medium [mM]')
ylabel('Viable rim thickness [µm] +- SD')
axis square

%% Critical o2 distance
subplot(2,3,2)
o2 = 5;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-', 'LineWidth', 2), hold on
o2 = 20;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ko-', 'LineWidth', 2), hold on

%plot(sim.glc_ext, o2c(:,1), 'bs-'), hold on
plot(sim.glc_ext, o2c(:,1), 'rs-'), hold on
plot(sim.glc_ext, o2c(:,2), 'ks-'), hold off

legend({'5% o2', '20% o2'}, 'Location', 'SouthEast')
title({'EMT6/Ro spheroids viable rim', '(O2 critical < 0.1mmHg)'})
xlabel('Glucose in medium [mM]')
ylabel('Viable rim thickness [µm] +- SD')
axis square

%% Critical glc distance
subplot(2,3,3)
o2 = 5;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-', 'LineWidth', 2), hold on
o2 = 20;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ko-', 'LineWidth', 2), hold on

%plot(sim.glc_ext, glcc(:,1), 'bs-'), hold on
plot(sim.glc_ext, glcc(:,1), 'rs-'), hold on
plot(sim.glc_ext, glcc(:,2), 'ks-'), hold off

legend({'5% o2', '20% o2'}, 'Location', 'SouthEast')
title({'EMT6/Ro spheroids viable rim', '(Glucose critical < 0.01mM)'})
xlabel('Glucose in medium [mM]')
ylabel('Viable rim thickness [µm] +- SD')
axis square

   %% O2 consum (ATPC)
   subplot(2,3,4)
   o2 = 5;
   [glc_5, o2c_5, o2c_sd_5] = Mueller_Klieser1986_o2_consumption(o2);
   o2 = 20;
   [glc_20, o2c_20, o2c_sd_20] = Mueller_Klieser1986_o2_consumption(o2);
   max_data = max( max(o2c_5), max(o2c_20) )/100;
   errorbar (glc_5, o2c_5/max_data, o2c_sd_5/max_data, 'ro-', 'LineWidth', 2), hold on
   errorbar (glc_20, o2c_20/max_data, o2c_sd_20/max_data, 'ko-', 'LineWidth', 2), hold on
   
   max_sim = max(max(atpc_o2_consum))/100;
   %plot(sim.glc_ext, atpc_o2_consum(:,1)/max_sim, 'bs-'), hold on
   plot(sim.glc_ext, atpc_o2_consum(:,1)/max_sim, 'rs-'), hold on
   plot(sim.glc_ext, atpc_o2_consum(:,2)/max_sim, 'ks-'), hold off

   legend({'5% o2', '20% o2'}, 'Location', 'NorthEast')
   title({'EMT6/Ro spheroids o2 consumption', '(ATP critical)'})
   xlabel('Glucose in medium [mM]')
   %ylabel('O2 consumption Qx1E4 [cm³ o2/cm³/s]')
   ylabel('O2 consumption (%)')
   axis square
      
   %% O2 consum (O2C)
   subplot(2,3,5)
   errorbar (glc_5, o2c_5/max_data, o2c_sd_5/max_data, 'ro-', 'LineWidth', 2), hold on
   errorbar (glc_20, o2c_20/max_data, o2c_sd_20/max_data, 'ko-', 'LineWidth', 2), hold on
   
   max_sim = max(max(o2c_o2_consum))/100;
   %plot(sim.glc_ext, o2c_o2_consum(:,1)/max_sim, 'bs-'), hold on
   plot(sim.glc_ext, o2c_o2_consum(:,1)/max_sim, 'rs-'), hold on
   plot(sim.glc_ext, o2c_o2_consum(:,2)/max_sim, 'ks-'), hold off

   legend({'5% o2', '20% o2'}, 'Location', 'NorthEast')
   title({'EMT6/Ro spheroids o2 consumption', '(O2 critical)'})
   xlabel('Glucose in medium [mM]')
   %ylabel('O2 consumption Qx1E4 [cm³ o2/cm³/s]')
   ylabel('O2 consumption (%)')
   axis square
      
   
   %% O2 consum (GLCC)
   subplot(2,3,6)
   errorbar (glc_5, o2c_5/max_data, o2c_sd_5/max_data, 'ro-', 'LineWidth', 2), hold on
   errorbar (glc_20, o2c_20/max_data, o2c_sd_20/max_data, 'ko-', 'LineWidth', 2), hold on
   
   max_sim = max(max(glcc_o2_consum))/100;
   %plot(sim.glc_ext, glcc_o2_consum(:,1)/max_sim, 'bs-'), hold on
   plot(sim.glc_ext, glcc_o2_consum(:,1)/max_sim, 'rs-'), hold on
   plot(sim.glc_ext, glcc_o2_consum(:,2)/max_sim, 'ks-'), hold off

   
   legend({'5% o2', '20% o2'}, 'Location', 'NorthEast')
   title({'EMT6/Ro spheroids o2 consumption', '(Glucose critical)'})
   xlabel('Glucose in medium [mM]')
   %ylabel('O2 consumption Qx1E4 [cm³ o2/cm³/s]')
   ylabel('O2 consumption (%)')
   axis square

haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(ax, 'FontWeight', 'bold');
    tit = get(ax, 'Title');
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
end

set(fig3, 'PaperPositionMode', 'auto');
print(fig3, '-dtiff', '-r150', strcat(folder_results,'Viable_Rim_O2_Consumption.tif')); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Figure - Comparison of the O2 profiles
colorb = [0.2 0.2 0.2]
fig4 = figure('Name', 'O2-profiles & Viable Rim', 'Position', [700 700 1100 600]);
dist_sim = (1:p.Nb)*p.d_cell/p.Nf*1E6;
dist_cell=((1:p.Nc)-0.5)*p.d_cell*1E6;

sim_color = [0 0 0];
data_color = [0 0 0];

% po2 Mueller-Klieser1986 (600µm)
ko2 = 2;    % 120 mmHg
kglc = 2;   % 1.8 mM
po2_sim = squeeze(analysis.o2_ext(kglc, ko2, :))*760/1.3;

subplot(2,3,1)
[dist, po2] = Mueller_Klieser1986_po2_600();
plot (dist_sim, po2_sim, 'k--', 'LineWidth', 2); hold on;
plot (dist, po2, 'ko-', 'MarkerEdgeColor', colorb, 'MarkerFaceColor', [0 0 0], 'LineWidth', 2); hold on;

% legend({'Sim', 'Data'}, 'Location', 'NorthEast')
xlabel('Distance blood vessel [µm]')
ylim([0, 125])
xlim([0, 300])
ylabel('pO_2 [mmHg]')

%{
    % Glycolytic component of strategy
    tmp = p.f_gly/4.0 * 120;
    h2 = plot(dist_cell, tmp); hold on;
    set(h2, 'LineStyle',  '-', 'Marker', 's','Color', 'r', 'MarkerFaceColor', [1 0 0], ...
            'LineWidth', 1)
    % Oxidative component of strategy
    tmp = p.f_oxi/0.562 * 120;
    h2 = plot(dist_cell, tmp); 
    set(h2, 'LineStyle',  '-', 'Marker', 's','Color', 'b', 'MarkerFaceColor', [0 0 1], ...
            'LineWidth', 1)
    l1 = legend({'GLY', 'OXP'}, 'Location', 'NorthEast');
    legend boxoff
    set(l1,'FontSize',10);
%}
    

% po2 Mueller-Klieser1986 (300µm)
ko2 = 1;    % 30 mmHg
kglc = 1;   % 0.8 mM
po2_sim = squeeze(analysis.o2_ext(kglc, ko2, :))*760/1.3;
subplot(2,3,2)
[dist, po2] = Mueller_Klieser1986_po2_300();
plot (dist_sim, po2_sim, 'r--', 'LineWidth', 2); hold on;
plot (dist, po2, 'ro-', 'MarkerEdgeColor', colorb, 'MarkerFaceColor', [1 0 0], 'LineWidth', 2); hold on;

%legend({'Sim', 'Data'}, 'Location', 'NorthEast')
xlabel('Distance blood vessel [µm]')
ylim([0, 30])
xlim([0, 120])
ylabel('pO_2 [mmHg]')

%{
    % Glycolytic component of strategy
    tmp = p.f_gly/4.0 * 30;
    h2 = plot(dist_cell, tmp); hold on;
    set(h2, 'LineStyle',  '-', 'Marker', 's','Color', 'r', 'MarkerFaceColor', [1 0 0], ...
            'LineWidth', 1)
    % Oxidative component of strategy
    tmp = p.f_oxi/0.562 * 30;
    h2 = plot(dist_cell, tmp); 
    set(h2, 'LineStyle',  '-', 'Marker', 's','Color', 'b', 'MarkerFaceColor', [0 0 1], ...
            'LineWidth', 1)
    l1 = legend({'GLY', 'OXP'}, 'Location', 'NorthEast');
    legend boxoff
    set(l1,'FontSize',10);
%}


%% Strategy and actual o2 profiles
h = subplot(2,3,3);
    
gly_str = p.f_gly/4.0;
tmp = squeeze(mean(mean(analysis.o2,1), 2))*760/1.3;
p1 = plot(tmp, gly_str, 's--', 'Color', 'r', 'LineWidth', 2); hold on

oxi_str = p.f_oxi/0.562;
tmp = squeeze(mean(mean(analysis.o2,1), 2))*760/1.3;
p1 = plot(tmp, oxi_str, 's--', 'Color', 'b', 'LineWidth', 2); hold off

l1 = legend({'GLY', 'OXP'}, 'Location', 'NorthEast');
legend boxoff
set(l1,'FontSize',10);
xlabel('pO_{2} [mmHg]')
ylabel('Pathway Capacity')
axis square
xlim([0 70])
ylim([0 0.8])
   

% Viable Rim Mueller-Klieser1986
%% Critical ATP distance - Viable Rim
subplot(2,3,4)
%plot(sim.glc_ext, atpc(:,1), 'bs-'), hold on
plot(sim.glc_ext, atpc(:,1), 'rs--', 'LineWidth', 2), hold on

o2 = 5;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-', 'Color', [1 0 0], 'LineWidth', 2, 'MarkerFaceColor', [1 0 0]), hold on

plot(sim.glc_ext, atpc(:,2), 'ks--', 'LineWidth', 2), hold on

o2 = 20;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ko-', 'Color', [0 0 0], 'LineWidth', 2, 'MarkerFaceColor', [0 0 0]), hold off

%legend({'Sim 5% O_2', 'Data 5% O_2', 'Sim 20% O_2', 'Data 20% O_2'}, 'Location', 'NorthOutside')
xlim([0.75 17])
ylim([40, 300])
xlabel('Glucose [mM]')
ylabel({'Viable rim [µm]'})
set(gca,'XScale','log');
set(gca,'XTick',[0.8, 1.8, 5.5, 16.5])


%% O2 consum (ATPC)
subplot(2,3,5)

max_sim = max(max(atpc_o2_consum))/100;
%plot(sim.glc_ext, atpc_o2_consum(:,1)/max_sim, 'bs-'), hold on
plot(sim.glc_ext, atpc_o2_consum(:,1)/max_sim, 'rs--', 'LineWidth', 2), hold on

o2 = 5;
[glc_5, o2c_5, o2c_sd_5] = Mueller_Klieser1986_o2_consumption(o2);
o2 = 20;
[glc_20, o2c_20, o2c_sd_20] = Mueller_Klieser1986_o2_consumption(o2);
max_data = max( max(o2c_5), max(o2c_20) )/100;
errorbar (glc_5, o2c_5/max_data, o2c_sd_5/max_data, 'ro-', 'Color', [1 0 0], 'LineWidth', 2, 'MarkerFaceColor', [1 0 0]), hold on

plot(sim.glc_ext, atpc_o2_consum(:,2)/max_sim, 'ks--', 'LineWidth', 2), hold on

errorbar (glc_20, o2c_20/max_data, o2c_sd_20/max_data, 'ko-', 'Color', [0 0 0], 'LineWidth', 2, 'MarkerFaceColor', [0 0 0]), hold off

%legend({'Sim 5% O_2', 'Data 5% O_2', 'Sim 20% O_2', 'Data 20% O_2'}, 'Location', 'NorthEast')
xlim([0.75 17])
%ylim([25, 110])    
ylabel('O2 consumption (%)')
xlabel('Glucose [mM]')
set(gca,'XScale','log');
set(gca,'XTick',[0.8, 1.8, 5.5, 16.5])

%% Warburg effect
subplot(2,3,6)
%plot(sim.glc_ext, atpc_o2_consum(:,1)/max_sim, 'bs-'), hold on
plot(sim.glc_ext, warburg(:,1), 'rs--', 'LineWidth', 2), hold on
plot(sim.glc_ext, warburg(:,2), 'ks--', 'LineWidth', 2), hold on

%legend({'Sim 5% O_2', 'Sim 20% O_2'}, 'Location', 'NorthEast')
xlim([0.75 17])
ylim([0, 110])    
ylabel({'Aerob Glycolysis (%)'})
xlabel('Glucose [mM]')
set(gca,'XScale','log');
set(gca,'XTick',[0.8, 1.8, 5.5, 16.5])



%hline = findobj(gcf, 'type', 'line');
%set(hline, 'LineWidth', 1);
haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax);
    set(gca, 'FontWeight', 'bold');

    axis square
    %grid on
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
end

set(fig4, 'PaperPositionMode', 'auto');
print(fig4, '-dtiff', '-r150', strcat(folder_results,'O2_Profiles_Viable_Rim.tif')); 



%% Plot the dependency of state from the actual strategy
%{
fig5 = figure('Name', 'test', 'Position', [0 0 800 600]);

% Glycolytic component of strategy
subplot(2,2,1)
gly_str = p.f_gly/4.0;
color_red = [1 0.2 0.2];
for kglc=1:numel(sim.glc_ext)
    for ko2=1:numel(sim.o2_ext)
        po2_sim = squeeze(analysis.o2(kglc, ko2, :))*760/1.3;       
        p1 = plot(po2_sim, gly_str); hold on
        set(p1, 'LineStyle', '--', 'Color', color_red, 'LineWidth', 2)
    end
end

tmp = squeeze(mean(mean(analysis.o2,1), 2))*760/1.3;
 p1 = plot(tmp, gly_str); hold on
 set(p1, 'LineStyle', '--', 'Color',  [1 0 0], 'LineWidth', 2)

title('Glycolytic Capacity')
xlabel('pO_{2} [mmHg]')
ylabel('Pathway Capacity')
axis square
xlim([0 120])
%ylim([0 1])

% Oxidative component of strategy
subplot(2,2,2)
oxi_str = p.f_oxi/0.562;
color_blue = [0.2 0.2 1];
for kglc=1:numel(sim.glc_ext)
    for ko2=1:numel(sim.o2_ext)
        po2_sim = squeeze(analysis.o2(kglc, ko2, :))*760/1.3;        
        p1 = plot(po2_sim, oxi_str); hold on
        set(p1, 'LineStyle', '--', 'Color', color_blue, 'LineWidth', 2)
    end
end
% mean

tmp = squeeze(mean(mean(analysis.o2,1), 2))*760/1.3;
p1 = plot(tmp, oxi_str); hold on
set(p1, 'LineStyle', 'o-', 'Color',  [0 0 1], 'LineWidth', 2)
title('OXP Capacity')
xlabel('pO_{2} [mmHg]')
ylabel('Pathway Capacity')
axis square
xlim([0 120])
%ylim([0 1])
%}

