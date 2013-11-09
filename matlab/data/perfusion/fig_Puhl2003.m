% Visualize the Puhl 2003 data
close all, clear all, format compact;

d = data_Puhl2003();

fig1 = figure('Name', 'Puhl2003', 'Position', [0 100 1600, 500], ...
                'Color', [1 1 1]);

%% RBC velocity
subplot(1,3,1)
pbar = bar(d.hist_rbcv, d.hist_rbcv_percent, 1.0);
set(pbar, 'FaceColor', [0.5 0.5 0.5], ...
       'EdgeColor', [0 0 0]);
hold on;

pline = plot(d.dens_rbcv, d.dens_rbcv_percent, 'k');
set(pline, 'LineWidth', 2.0);
title('RBC velocity (RBCV)', 'FontWeight', 'bold')
xlabel('RBC velocity [mm/s]', 'FontWeight', 'bold')
ylabel('Percent [%]', 'FontWeight', 'bold')
xlim([0 3])
ylim([0 55])
axis square

%% Sinusoidal diameter
subplot(1,3,2)
pbar = bar(d.hist_sd, d.hist_sd_percent, 1.0);
set(pbar, 'FaceColor', [0.5 0.5 0.5], ...
       'EdgeColor', [0 0 0]);
hold on;

pline = plot(d.dens_sd, d.dens_sd_percent, 'k');
set(pline, 'LineWidth', 2.0)
title('Sinusoidal diameter (SD)', 'FontWeight', 'bold')
xlabel('Sinusoidal diameter [µm]', 'FontWeight', 'bold')
ylabel('Percent [%]', 'FontWeight', 'bold')
xlim([6 12])
ylim([0 45])
axis square

%% Functional sinusoidal density
subplot(1,3,3)
pbar = bar(d.hist_fsd, d.hist_fsd_percent, 1.0);
set(pbar, 'FaceColor', [0.5 0.5 0.5], ...
       'EdgeColor', [0 0 0]);
hold on;

pline = plot(d.dens_fsd, d.dens_fsd_percent, 'k');
set(pline, 'LineWidth', 2.0)
title('Functional sinusoidal density (FSD)', 'FontWeight', 'bold')
xlabel('Functional sinusoidal density [1/cm]', 'FontWeight', 'bold')
ylabel('Percent [%]', 'FontWeight', 'bold')
xlim([300 500])
ylim([0 40])
set(gca,'XTick',[300, 340, 380, 420, 460])
axis square

% save the plot
print(fig1, 'fig_Puhl2003.png', '-r72')


%% Other Quantities calculated in the paper