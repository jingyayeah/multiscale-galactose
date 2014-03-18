clear all; close all;
fig1 = figure('Name', 'Dilution Curves Goresky1983', 'Color', [1 1 1], 'Position', [0 0 600 1200]);

styles = {'ro-', 'ks-', 'ms-', 'bs-', 'gs-'};
dnames = {'RBC', 'Sucrose', 'Albumin', 'Water', 'Na'};

subplot(2,1,1)
[t1, y1] = Goresky1983_data(dnames{1});
[t2, y2] = Goresky1983_data(dnames{2});
[t3, y3] = Goresky1983_data(dnames{3});
[t4, y4] = Goresky1983_data(dnames{4});
[t5, y5] = Goresky1983_data(dnames{5});
semilogy(t1, y1, styles{1}, t2, y2, styles{2}, t3, y3, styles{3}, ...
         t4, y4, styles{4}, t5, y5, styles{5});
ylim([0.1, 100])
xlim([0, 40])

subplot(2,1,2)
hold on;
for kn=1:length(dnames)
    [t, y] = Goresky1983_data(dnames{kn});
    plot(t, y, styles{kn}); hold on
end
ylim([0 15])
xlim([0, 40])
legend(dnames);
hold off;

% general changes for all axis
haxes = findobj(gcf, 'type', 'Axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    set(get(gca, 'XLabel'), 'String', 'time [s]');
    set(get(gca, 'YLabel'), 'String', '10^3 x outflow fraction');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r72', 'Goresky1983_dilution_curves.tif'); 