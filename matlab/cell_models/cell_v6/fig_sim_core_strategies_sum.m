function [] = fig_sim_core_strategies_sum(glc_ext, o2_ext, lac_ext)
if (nargin == 0)
   glc_ext = [0.8 1.8 5.5 16.5]
   o2_ext  = [30 120] * 1.3/760
   lac_ext  = [1.4]
end

% Plot the summaries of the different strategies
q.glc_ext = glc_ext;
q.o2_ext  = o2_ext;
q.lac_ext = lac_ext;

%% Calculate the variables of interest

% Load the data and create the essential variables
folder_results = './results/121121_core_strategies_v01/';
        sim_name = sprintf('Cancer_v6_[%0.4f_%0.4f_%0.4f]', q.glc_ext(1), q.lac_ext(1), q.o2_ext(1));
        file_name = strcat(folder_results, sim_name, '_Core_Strategies_analysis.mat')
        data = load(file_name);
        sim = data.sim;
        p = data.p;
        clear data
        % Calculate the critical values
        Nstr = numel(sim.sim_f_gly);

% Viable rim & o2 consumption
q.atpc = zeros(numel(q.glc_ext), numel(q.o2_ext), Nstr);
q.atpc_o2_consum = zeros(numel(q.glc_ext), numel(q.o2_ext), Nstr);

% Oxygen profiles for the strategies
q.po2_profile = zeros(p.Nb, 2, Nstr);

% Create the figures for the core strategies
for kgly=1:numel(q.glc_ext)
    for ko2=1:numel(q.o2_ext)

        c_ext0 = [q.glc_ext(kgly), q.lac_ext(1), q.o2_ext(ko2)]
            
        sim_name = sprintf('Cancer_v6_[%0.4f_%0.4f_%0.4f]', c_ext0(1), c_ext0(2), c_ext0(3));
        file_name = strcat(folder_results, sim_name, '_Core_Strategies_analysis.mat')
        data = load(file_name);
        p = data.p;
        sim = data.sim;
        analysis = data.analysis;
        clear data
        
        % Calculate the critical values
        Nstr = numel(sim.sim_f_gly);

        % Critical ATP distance
        ATPC0 = 0.1;
        [atpc, atpc_inds]  = getCriticalValues(analysis.atp, ATPC0);
        
        % O2 Consumption in viable rim (critical area)
        atpc_o2_consum = zeros(Nstr, 1);
        for kstr = 1:Nstr
            index = atpc_inds(kstr);
            atpc_o2_consum(kstr) = sum(analysis.v4(kstr, 1:index)) /index;
        end
        
        q.atpc(kgly, ko2, :) = atpc;
        q.atpc_o2_consum(kgly, ko2, :) = atpc_o2_consum;
        
        % save the external o2 profiles
        for kstr=1:Nstr
            % 120 mmHg O2 & 1.8 mM glc
            if (kgly == 2 && ko2==2)
               q.po2_profile(:,1,kstr) = 760/1.3*analysis.o2_ext(kstr, :); 
            end
            % 30 mmHg O2 & 0.8 mM glc
            if (kgly == 1 && ko2==1)
               size(analysis.o2_ext(kstr, :))
               q.po2_profile(:,2,kstr) = 760/1.3*analysis.o2_ext(kstr, :); 
            end
        end
    end
end




%% Display summary of the constant strategies
fig1 = figure('Name', 'Constant Strategies', 'Position', [0 0 1900 500]);
Ncolor = Nstr;
ColorSet = ones(Ncolor, 3);
for k=1:Ncolor
    ColorSet(k,:) = ColorSet(k,:) * ( k/(Ncolor+1) );
end
cells =1:p.Nc;
compartments = (1:p.Nb)*p.d_blood*1E6;
for kstr=1:Nstr

    % Viable rim simulation (5% O2)
    subplot(2,6,1)
    tmp = q.atpc(:, 1, kstr);
    plot(q.glc_ext, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on

    % Viable rim simulation (20% O2)
    subplot(2,6,2)
    tmp = q.atpc(:, 2, kstr);
    plot(q.glc_ext, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on
    
    % Viable rim O2 consumption (5% O2)
    subplot(2,6,3)
    maxv = max(max(q.atpc_o2_consum(:, :, kstr))); 
    tmp = 100 * q.atpc_o2_consum(:, 1, kstr)/maxv;
    plot(q.glc_ext, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on
    
    % Viable rim O2 consumption (20% O2)
    subplot(2,6,4)
    tmp = 100 * q.atpc_o2_consum(:, 2, kstr)/maxv;
    plot(q.glc_ext, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on
    
    % O2 curves
    subplot(2,6,5)
    tmp = q.po2_profile(:,1,kstr);
    plot(compartments, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on
    
    % O2 curves
    subplot(2,6,6)
    tmp = q.po2_profile(:,2,kstr);
    plot(compartments, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on
    
    % Glycolytic component of strategy
    subplot(2,6,7)
    tmp = ones(p.Nc, 1)*sim.sim_f_gly(kstr)/max(sim.sim_f_gly);
    plot(cells, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on
    xlabel('Cell <i>')
    ylabel('Relative glycolytic capacity')
    axis square
    
    % Oxidative component of strategy
    subplot(2,6,8)
    tmp = ones(p.Nc, 1)*sim.sim_f_oxi(kstr)/max(sim.sim_f_oxi);
    plot(cells, tmp, 's-', 'Color', [0 0 0], 'MarkerFaceColor', ColorSet(kstr, :)), hold on
    xlabel('Cell <i>')
    ylabel('Relative oxidative capacity')
    axis square
    
end

%% Display the experimental data in additon
% Viable Rim Mueller-Klieser1986
subplot(2,6,1)
o2 = 5;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-', 'LineWidth', 2, 'MarkerFaceColor', [1 0 0]), hold on
title({'Viable rim (5% O_2)'})
xlabel('Glucose [mM]')
ylabel('Viable rim thickness [µm]')
ylim([40, 300])
axis square

subplot(2,6,2)
o2 = 20;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-', 'LineWidth', 2, 'MarkerFaceColor', [1 0 0]), hold on
title({'Viable rim (20% O_2)'})
xlabel('Glucose [mM]')
ylabel('Viable rim thickness [µm]')
ylim([40, 300])
axis square

% O2 consumption
o2 = 5;
[glc_5, o2c_5, o2c_sd_5] = Mueller_Klieser1986_o2_consumption(o2);
o2 = 20;
[glc_20, o2c_20, o2c_sd_20] = Mueller_Klieser1986_o2_consumption(o2);
max_data = max( max(o2c_5), max(o2c_20) )/100;

subplot(2,6,3)
errorbar (glc_5, o2c_5/max_data, o2c_sd_5/max_data, 'ro-', 'LineWidth', 2, 'MarkerFaceColor', [1 0 0]), hold on
xlabel('Glucose [mM]')
ylabel('O2 consumption (%)')
%ylim([20, 110])
axis square

subplot(2,6,4)
errorbar (glc_20, o2c_20/max_data, o2c_sd_20/max_data, 'ro-', 'LineWidth', 2, 'MarkerFaceColor', [1 0 0]), hold on
xlabel('Glucose [mM]')
ylabel('O2 consumption (%)')
%ylim([20, 110])
axis square

% O2 profiles
subplot(2,6,5)
[dist, po2] = Mueller_Klieser1986_po2_600();
plot (dist, po2, 'o-', 'Color', [1 0 0], 'MarkerFaceColor', [1 0 0], 'LineWidth', 2); hold on;
title({'pO_2 profile (1.8mM glc, 20% O_2)'})
%ylim([0, 1.2*max(po2)])
xlim([0, 300])
xlabel('Distance blood vessel [µm]')
ylabel({'pO_2 [mmHg]'})
axis square

subplot(2,6,6)
[dist, po2] = Mueller_Klieser1986_po2_300();
plot (dist, po2, 'ro-', 'Color', [1 0 0], 'MarkerFaceColor', [1 0 0], 'LineWidth', 2); hold on;
xlim([0, 300])
title({'pO_2 profile (0.8mM glc, 5% O_2)'})
legend({'Sim', 'Data'}, 'Location', 'NorthEast')
xlabel('Distance blood vessel [µm]')
ylabel('pO_2 [mmHg]')
axis square

%% Display the overview
fig2 = figure('Position', [800 0 900 1600])
colorb = [0.2 0.2 0.2]
markers = 6


cells = (cells-0.5) * p.d_cell*1E6;
Ncolumn = 5;
for kstr=1:Nstr
    % Display the strategy
    subplot(Nstr, Ncolumn, Ncolumn*(kstr-1)+1)
    % Glycolytic component of strategy
    maxgly = max(sim.sim_f_gly);
    tmp = ones(p.Nc, 1)*sim.sim_f_gly(kstr)/maxgly;
    plot(cells, tmp, 'rs-', 'Color', colorb, 'MarkerFaceColor', [1 0 0], 'MarkerSize', 4), hold on
    % Oxidative component of strategy
    maxoxi = max(sim.sim_f_oxi);
    tmp = ones(p.Nc, 1)*sim.sim_f_oxi(kstr)/maxoxi;
    plot(cells, tmp, 'bs-', 'Color', colorb, 'MarkerFaceColor', [0 0 1], 'MarkerSize', 4), hold off
    
    xlim([0 300])
    ylim([0,1.1])
    if (kstr == Nstr)
        xlabel({'Distance', 'blood vessel [µm]'})
    end
    if (kstr == 1)
         legend({'Glycolysis', 'OXPHOS'}, 'Location', 'WestOutside')
    end
    ylabel('Pathway Capacity')
    
    % Oxygen profiles 
    % O2 curves (120mmHg)
    subplot(Nstr, Ncolumn, Ncolumn*(kstr-1)+2)
    
    tmp = q.po2_profile(:,1,kstr);
    plot(compartments, tmp, 'ks-', 'LineWidth', 2, 'MarkerSize', 2), hold on
    [dist, po2] = Mueller_Klieser1986_po2_600();
    plot (dist, po2, 'ko-', 'MarkerEdgeColor', colorb, 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, 'MarkerSize', markers); hold off;
    
    ylim([0, 125])
    xlim([0, 300])
    if (kstr == Nstr)
        xlabel({'Distance', 'blood vessel [µm]'})
    end
    ylabel('pO_2 [mmHg]')
    
     subplot(Nstr, Ncolumn, Ncolumn*(kstr-1)+3)
    % O2 curves (30mmHg)
    tmp = q.po2_profile(:,2,kstr);
    plot(compartments, tmp, 'rs-', 'LineWidth', 2, 'MarkerSize', 2), hold on
    [dist, po2] = Mueller_Klieser1986_po2_300();
    plot (dist, po2, 'ro-', 'MarkerEdgeColor', colorb, 'MarkerFaceColor', [1 0 0], 'LineWidth', 2, 'MarkerSize', markers); hold off;
    
    ylim([0, 35])
    xlim([0, 120])
    if (kstr == Nstr)
        xlabel({'Distance', 'blood vessel [µm]'})
    end
    ylabel('pO_2 [mmHg]')
    
    % Viable rim simulation (5% O2)
    subplot(Nstr,Ncolumn, Ncolumn*(kstr-1)+4)
    tmp = q.atpc(:, 1, kstr);
    plot(q.glc_ext, tmp, 'rs--', 'LineWidth', 2, 'MarkerSize', markers), hold on   
    o2 = 5;
    [glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
    errorbar (glc, rim_d, rim_d_sd, 'ro-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [1 0 0], 'MarkerSize', markers), hold on
 
    % Viable rim simulation (20% O2)
    tmp = q.atpc(:, 2, kstr);
    plot(q.glc_ext, tmp, 'ks--', 'LineWidth', 2, 'MarkerSize', markers), hold on   
    o2 = 20;
    [glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
    errorbar (glc, rim_d, rim_d_sd, 'ko-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [0 0 0], 'MarkerSize', markers), hold off

    ylim([40, 300])
    xlim([0.75 17])
    set(gca,'XScale','log');
    set(gca,'XTick',[0.8, 1.8, 5.5, 16.5])
    %set(gca,'XTickLabel',{'0.8','1.8', '5.5', '16.5'})
    
    if (kstr == Nstr)
        xlabel('Glucose [mM]')
    end
    ylabel({'Viable rim [µm]'})
    
    
    % Viable rim O2 consumption
    subplot(Nstr, Ncolumn, Ncolumn*(kstr-1)+5)
    
    maxv = max(max(q.atpc_o2_consum(:, :, kstr))); 
    
    tmp = 100 * q.atpc_o2_consum(:, 1, kstr)/maxv;
    plot(q.glc_ext, tmp, 'rs--', 'LineWidth', 2, 'MarkerSize', markers), hold on
    errorbar (glc_5, o2c_5/max_data, o2c_sd_5/max_data, 'ro-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [1 0 0], 'MarkerSize', markers), hold on
    
    tmp = 100 * q.atpc_o2_consum(:, 2, kstr)/maxv;
    plot(q.glc_ext, tmp, 'ks--', 'LineWidth', 2, 'MarkerSize', markers), hold on
    errorbar (glc_20, o2c_20/max_data, o2c_sd_20/max_data, 'ko-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [0 0 0], 'MarkerSize', markers), hold off
    
    ylim([25, 110])
    xlim([0.75 17])
    set(gca,'XScale','log');
    set(gca,'XTick',[0.8, 1.8, 5.5, 16.5])
    if (kstr == Nstr)
        xlabel('Glucose [mM]')
    end
    
    ylabel('O2 consumption (%)')
end

%% Load the variable strategy and replace the first row
    % Display the strategy
    folder_results = './results/121121_glc_o2_var_v01/'
    load(strcat(folder_results, 'Glucose_O2_analysis'));
    
    % Calculate the o2 consumption in the viable rim
    atpc  = zeros(numel(sim.glc_ext), numel(sim.o2_ext));
    atpc_o2_consum = zeros(numel(sim.glc_ext), numel(sim.o2_ext));
    size(atpc_o2_consum)
    for kglc=1:numel(sim.glc_ext)
    for ko2=1:numel(sim.o2_ext)
        % ATP critical distance
        index = find((analysis.atp(kglc,ko2,:)<0.1), 1, 'first');
        index = index - 1;
        if (numel(index) == 0)
            index = p.Nc;
        end
        atpc(kglc, ko2) = (index-0.5) *p.d_cell*1E6;
        atpc_o2_consum(kglc, ko2) = sum(analysis.v4(kglc, ko2, 1:index))/index;
    end
    end

    subplot(Nstr, Ncolumn, 1)
    % Glycolytic component of strategy
    tmp = p.f_gly/maxgly;
    plot(cells, tmp, 'rs-', 'Color', colorb, 'MarkerFaceColor', [1 0 0], 'MarkerSize', 4), hold on
    % Oxidative component of strategy
    tmp = p.f_oxi/maxoxi;
    plot(cells, tmp, 'bs-', 'Color', colorb, 'MarkerFaceColor', [0 0 1], 'MarkerSize', 4), hold off
    
    xlim([0, 300])
    ylim([0,1.1])
    ylabel('Pathway Capacity')
    
    
    % Oxygen profiles 
    % O2 curves (120mmHg)
    subplot(Nstr, Ncolumn, 2)
    ko2 = 2;    % 120 mmHg
    kglc = 2;   % 1.8 mM
    tmp = squeeze(analysis.o2_ext(kglc, ko2, :))*760/1.3;
    plot(compartments, tmp, 'ks-', 'LineWidth', 2, 'MarkerSize', 2), hold on
    [dist, po2] = Mueller_Klieser1986_po2_600();
    plot (dist, po2, 'ko-', 'MarkerEdgeColor', colorb, 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, 'MarkerSize', markers); hold on;
    
    ylim([0, 125])
    xlim([0, 300])
    ylabel('pO_2 [mmHg]')
    
     subplot(Nstr, Ncolumn, 3)
    % O2 curves (30mmHg)
    ko2 = 1;    % 30 mmHg
    kglc = 1;   % 0.8 mM
    tmp = squeeze(analysis.o2_ext(kglc, ko2, :))*760/1.3;
    plot(compartments, tmp, 'rs-', 'LineWidth', 2, 'MarkerSize', 2), hold on
    [dist, po2] = Mueller_Klieser1986_po2_300();
    plot (dist, po2, 'ro-', 'MarkerEdgeColor', colorb, 'MarkerFaceColor', [1 0 0], 'LineWidth', 2, 'MarkerSize', markers); hold on;
    
    ylim([0, 35])
    xlim([0, 120])
    ylabel('pO_2 [mmHg]')
    
    % Viable rim simulation (5% O2)
    subplot(Nstr,Ncolumn, 4)
    tmp = atpc(:,1)
    plot(sim.glc_ext, tmp, 'rs--', 'LineWidth', 2, 'MarkerSize', markers), hold on   
    o2 = 5;
    [glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
    errorbar (glc, rim_d, rim_d_sd, 'ro-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [1 0 0], 'MarkerSize', markers), hold on
 
    % Viable rim simulation (20% O2)
    tmp = atpc(:,2)
    plot(sim.glc_ext, tmp, 'ks--', 'LineWidth', 2, 'MarkerSize', markers), hold on   
    o2 = 20;
    [glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
    errorbar (glc, rim_d, rim_d_sd, 'ko-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [0 0 0], 'MarkerSize', markers), hold on

    xlim([0.75 17])
    ylim([40, 300])
    ylabel({'Viable rim [µm]'})
    set(gca,'XScale','log');
    set(gca,'XTick',[0.8, 1.8, 5.5, 16.5])
    
    % Viable rim O2 consumption
    subplot(Nstr, Ncolumn, 5)
    
    maxv = max(max(atpc_o2_consum));
    tmp = 100 * atpc_o2_consum(:,1)/maxv;
    plot(sim.glc_ext, tmp, 'rs--', 'LineWidth', 2, 'MarkerSize', markers), hold on
    errorbar (glc_5, o2c_5/max_data, o2c_sd_5/max_data, 'ro-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [1 0 0], 'MarkerSize', markers), hold on
    
    tmp = 100 * atpc_o2_consum(:, 2)/maxv;
    plot(sim.glc_ext, tmp, 'ks--', 'LineWidth', 2, 'MarkerSize', markers), hold on
    errorbar (glc_20, o2c_20/max_data, o2c_sd_20/max_data, 'ko-', 'MarkerEdgeColor', colorb, 'LineWidth', 2, 'MarkerFaceColor', [0 0 0], 'MarkerSize', markers), hold on
    
     xlim([0.75 17])
    ylim([25, 110])    
    ylabel('O2 consumption (%)')
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end