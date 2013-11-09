% Plot the external gradients & energy state of cells
clear all

p.Nc = 25;
p = pars_layout(p);
p = init_cell(p);
p.odefun = @dydt_bloodflow;

p.ft_ext = [1 1 1];
p.ext_constant = 0;
p.ode_cells = 1;
p.ode_diffusion = 1;
p.ode_blood = 0;

%tmp = 1:p.Nc;
%p.f_gly =  0.2* (2.0 +  1.4 * tmp.^4./(tmp.^4 + 6^4));   % super good
%p.f_oxi =  2.0 * (0.2 - 0.15 * tmp.^4./(tmp.^4 + 6^4));   % super good
    
    tmp = (1:p.Nc)-1;
    %p.f_gly =  0.6*(2.0 +  1.4 * tmp.^4./(tmp.^4 + 8^4));
    %p.f_oxi =  (0.18 - 0.17 * tmp.^4./(tmp.^4 + 8^4));
   p.f_gly =  (2.0 +  1.4 * tmp.^4./(tmp.^4 + 7^4));
   p.f_oxi =  (0.2 - 0.19 * tmp.^4./(tmp.^4 + 7^4));
    
% Plot the steady state results against the respective cells
%sim = 'sim_30';
%sim = 'sim_120';

sim = 'sim_test';

%% Load the data
folder_results = './results/121121_glc_o2_var_v01/'
switch sim
    case 'sim_30'
        name = 'Cancer_v6_25_5_[0.8_1.4_30].fort';
        p.c_ext0 = [0.8 1.4 30];
    case 'sim_120'
        name = 'Cancer_v6_25_5_[1.8_1.4_120].fort';
        p.c_ext0 = [1.8 1.4 120];
    case 'sim_test'
        name = 'Cancer_v6_25_5_[5.5_1.4_30].fort';
        p.c_ext0 = [5.5 1.4 30];
end
x = load(strcat(folder_results, name));
t = x(:,1);
x(:,1) = [];

% Generate the function handles for matlab
for k = 1:p.Nx_out
    switch p.ft_ext(k)
        case 1
            p.f_ext{k} = tc_generator('constant', p.c_ext0(k));
        case 2
            p.f_ext{k} = tc_generator('sinus', p.c_ext0(k));
    end
end
create_named_variables;
    
%% Helper variables
compartments = (1:p.Nb)*p.d_blood*1E6;
cells = 1:p.Nc;
cells_dist = cells*p.d_cell*1E6 - 0.5*p.d_cell*1E6;
o2_fac = 760/1.3;   % mM -> mmHg


%% Critical values for viable rim & for line
index = find(atp(end, :)<=0.1, 1, 'first');
index = index-1;
if (numel(index) == 0)
    index = 1
end
atpc = cells_dist(index);
atpc_cell = cells(index);


% critical ATP proliferating
index = find(atp(end, :)<=2.0, 1, 'first');
index = index-1;
if (numel(index) == 0 || index == 0)
    index = 1
end
atppro = cells_dist(index);
atppro_cell = cells(index); 

% Critical O2 value
index = find(o2(end, :)*o2_fac<3, 1, 'first');
if (numel(index) == 0)
    index = 1
end
o2c_line = cells_dist(index);




%% Create the figures
fig1 = figure('Name', 'Figure_3', 'Position', [0 0 700 1000]);
lwidth = 2;
bcolor = [1 1 1];
color_atp = [0.5,0.5,0.5];


% glc
subplot(3,2,1)
%glc_ext_mean = zeros(1, p.Nc);
%for k=1:p.Nc
%   glc_ext_mean(k) = mean(glc_ext(end, (k-1)*p.Nf + 1: k*p.Nf));
%end
%plot(cells_dist, glc_ext_mean, 's-', 'Color', [0.5 0.5 0.5]); hold on
subplot(3,2,1)
plot(compartments, glc_ext(end,:), 'k-'); hold on
plot(cells_dist,glc(end, :),'s-', 'Color', 'r'); hold off
ylabel('Glucose [mM]')
l1 = legend({'glc_{ext}', 'glc'}, 'Location', 'NorthEast');
legend boxoff
set(l1,'FontSize',10);

% o2
subplot(3,2,3)
%o2_ext_mean = zeros(1, p.Nc+1);
%o2_ext_mean(1) = o2_ext(end, 1);
%for k=1:p.Nc
%   o2_ext_mean(k+1) = mean(o2_ext(end, (k-1)*p.Nf + 1: k*p.Nf));
%end

plot(compartments, o2_ext(end,:)*o2_fac, 'k-'); hold on;
% plot(cells_dist,o2(end, :)*o2_fac,'s-', 'Color', [0.7 0.7 0.7]); hold on
%plot([p.d_blood cells_dist], o2_ext_mean*o2_fac, 's-', 'Color', [0.5 0.5 0.5]); hold on;
plot(cells_dist, o2_mito(end, :)*o2_fac,'s-', 'Color', [0 0 1]); hold on
% plot additional experimental data
switch sim
    case 'sim_30'
        [dist, po2] = Mueller_Klieser1986_po2_300();
        plot (dist, po2, 'ro-', 'Color', [1 0 0], 'MarkerFaceColor', [1 0 0], 'LineWidth', 2); hold off;
    case 'sim_120'
        [dist, po2] = Mueller_Klieser1986_po2_600();  
        plot (dist, po2, 'ro-', 'Color', [1 0 0], 'MarkerFaceColor', [1 0 0], 'LineWidth', 2); hold off;
end
ylabel('O_{2} [mmHg]')
l1 = legend({'O_{2 ext}', 'O_{2 mito}', 'O_{2 data}'}, 'Location', 'NorthEast');
legend boxoff
set(l1,'FontSize',10);

% lac
subplot(3,2,5)
plot(compartments,lac_ext(end,:), 'k-'); hold on
%lac_ext_mean = zeros(1, p.Nc);
%for k=1:p.Nc
%   lac_ext_mean(k) = mean(lac_ext(end, (k-1)*p.Nf + 1: k*p.Nf));
%end
%plot(cells_dist,lac_ext_mean, 's-',  'Color', [0.5 0.5 0.5] ); hold on
plot(cells_dist,lac(end, :),'s-', 'Color', [0 0.5 0]); hold off
ylabel('Lactate [mM]')
l1 = legend({'lac_{ext}', 'lac'}, 'Location', 'SouthEast');
legend boxoff
set(l1,'FontSize',10);
xlabel('Distance Blood Vessel [µm]');


% ATP critical
subplot(3,2,2), 

% plot(cells_dist, atp(end,:), 's-', 'Color', [0.3,0.3,0.3]); hold off;
% plot(cells_dist, -Vmm(end,:), 'ks-'); hold off;

[ax, h1, h2] = plotyy(cells_dist, atp(end,:), cells_dist, -Vmm(end,:));
set(get(ax(1),'YLabel'), 'String', {'ATP [mM]', '(atp < atp_{c} = 0.1)'}); 
set(get(ax(2),'YLabel'), 'String', {'Vmm [mV]'});

set(h1,'LineStyle','-', 'Marker', 's', 'Color', color_atp);
set(ax(1), 'YColor', color_atp);
set(h2,'LineStyle','-', 'Marker', 's', 'Color', [0 0 0]);
set(ax(2), 'YColor', [0 0 0]);
set(ax(2), 'YLim', [-130 0]);


% ATP from glycolysis, OxPhos and ATP usage
subplot(3,2,4)
plot(cells_dist, v_ATPUSE(end,:), 'ks-'); hold on;
plot(cells_dist, v_gly_atp(end,:), 'rs-'); hold on;
plot(cells_dist, v_oxi_atp_cyt(end,:), 'bs-'); hold on;
ylabel('ATP Fluxes [mmol/s/cell]');
l1 = legend({'ATPU', 'GLY', 'OXP'}, 'Location', 'NorthEast');
legend boxoff
set(l1,'FontSize',10);
ylim([0 30])

% pyruvate fate (how much to lactate and to oxphos)
subplot(3,2,6)
v_PYROX = v_PYREX(end,:).*Vol_mito(end,:)./Vol_cell(end,:);

plot(cells_dist, v_LDH(end,:), 's-', 'Color', [0 0.5 0]); hold on;
plot(cells_dist, v_PK(end,:), 'rs-'); hold on;
plot(cells_dist, v_PYROX, 'bs-'); hold on;
plot(cells_dist, 2*v_GLCUSE(end,:), 's-', 'Color', [0.6 0.6 0.6]); hold off;

%plot(cells_dist, v_LDH(end,:)+ v_PYROX, 's-', 'Color', [0 0 0]); hold on;

ylabel('Pyruvate Fluxes [mmol/s/cell]');
xlabel('Distance Blood Vessel [µm]');
l1 = legend({'LACT','GLY','OXP', 'GLCU'}, 'Location', 'NorthEast');
legend boxoff
set(l1,'FontSize',10);
ylim([0 30])
%legend({'Glycolysis [glc -> pyr]', 'Lactate Export [pyr -> lac]', 'OxPhos [pyr -> co2 + atp]'}, 'Location', 'NorthOutside');
%}


xlabel('Distance Blood Vessel [µm]');


haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    ylim=get(gca,'ylim');
    % ATP critical
    line([atpc;atpc],ylim.', 'color', color_atp, 'LineStyle', '--');
    line([o2c_line;o2c_line],ylim.', 'color', [0 0.6 1], 'LineStyle', '--');

    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    xlim([0 230])
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', strcat(name, '_', 'fig3.tif')); 


return

%% Bilancing the pyruvate
fig2 = figure();

v_PYROX = v_PYREX(end,:).*Vol_mito(end,:)./Vol_cell(end,:);

subplot(1,2,1)
plot(cells_dist, v_PK(end,:), 'rs-'); hold on;
plot(cells_dist, v_LDH(end,:), 's-', 'Color', [0 0.5 0]); hold on;
plot(cells_dist, v_PYROX, 'bs-'); hold on;
plot(cells_dist, v_LDH(end,:)+ v_PYROX, 's-', 'Color', [0 0 0]); hold on;
ylabel('Pyruvate Fluxes [mM/s/cell]');
xlabel('Distance Blood Vessel [µm]');
legend({'glycolysis','lactate export', 'oxphos'}, 'Location', 'NorthEast');

subplot(1,2,2)
plot(cells_dist, v_PK(end, :) - (v_LDH(end,:)+ v_PYROX), 's-')


