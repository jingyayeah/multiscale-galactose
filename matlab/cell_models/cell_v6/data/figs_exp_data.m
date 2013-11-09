% plot the experimental data
close all, clear all

figure('Name', 'Experimental Data', 'Position', [300 300 1000 600])

%% po2 Mueller-Klieser1986 (600µm)
subplot(2,3,1)
[dist, po2] = Mueller_Klieser1986_po2_600;
plot (dist, po2, 'ko-')
title('EMT6/Ro spheroids pO2 profile')
xlabel('Distance blood vessel [µm]')
ylabel('po2 [mmHg]')
legend({'1.8mM glucose'}, 'Location', 'NorthEast')
axis square, grid on
ylim([0, 1.2*max(po2)])
xlim([0, 1.2*max(dist)])

%% po2 Mueller-Klieser1986 (300µm)
subplot(2,3,2)
[dist, po2] = Mueller_Klieser1986_po2_300();
plot (dist, po2, 'ko-')
title('EMT6/Ro spheroids pO2 profile')
xlabel('Distance blood vessel [µm]')
ylabel('po2 [mmHg]')
legend({'0.8mM glucose'}, 'Location', 'NorthEast')
axis square, grid on
ylim([0, 1.2*max(po2)])
xlim([0, 1.2*max(dist)])

%% po2 Helmlinger1997 (450µm)
subplot(2,3,3)
[dist, po2, po2_sem] = Helmlinger1997_po2();
errorbar (dist, po2, po2_sem, 'ko-'), hold off
title('17 day old tumors pO2 profile')
xlabel('Distance blood vessel [µm]')
ylabel('po2 [mmHg] +- SEM')
legend({'glucose (in vivo)'}, 'Location', 'NorthEast')
axis square, grid on
ylim([0, 1.2*max(po2+po2_sem)])
xlim([0, 1.2*max(dist)])



%% Viable Rim Mueller-Klieser1986
subplot(2,3,4)
o2 = 5;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-'), hold on
o2 = 20;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2);
errorbar (glc, rim_d, rim_d_sd, 'ko-'), hold off
legend({'5% o2', '20% o2'}, 'Location', 'SouthEast')
title('EMT6/Ro spheroids viable rim')
xlabel('Glucose in medium [mM]')
ylabel('Viable rim thickness [µm] +- SD')
axis square, grid on

%% O2 consumption Mueller-Klieser1986
subplot(2,3,5)
o2 = 5;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_o2_consumption(o2);
errorbar (glc, rim_d, rim_d_sd, 'ro-'), hold on
o2 = 20;
[glc, rim_d, rim_d_sd] = Mueller_Klieser1986_o2_consumption(o2);
errorbar (glc, rim_d, rim_d_sd, 'ko-'), hold off
legend({'5% o2', '20% o2'}, 'Location', 'NorthEast')
title('EMT6/Ro spheroids o2 consumption')
xlabel('Glucose in medium [mM]')
ylabel('O2 consumption Qx10⁴ [cm³ o2/cm³/s]')
axis square, grid on


hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);
haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(ax, 'FontWeight', 'bold');
    tit = get(ax, 'Title');
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
end