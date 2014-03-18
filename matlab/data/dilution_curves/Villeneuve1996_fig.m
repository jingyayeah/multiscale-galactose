clear all; close all;
fig1 = figure('Name', 'Dilution Curves Villeneuve1996', 'Color', [1 1 1], 'Position', [0 0 600 1200]);

styles = {'ro-', 'ks-', 'ms-', 'bs-'};
dnames = {'RBC', 'Sucrose', 'Albumin', 'Water'};

subplot(2,1,1)
[t1, y1] = Villeneuve1996_data(dnames{1});
[t2, y2] = Villeneuve1996_data(dnames{2});
[t3, y3] = Villeneuve1996_data(dnames{3});
[t4, y4] = Villeneuve1996_data(dnames{4});
semilogy(t1, y1, styles{1}, t2, y2, styles{2}, t3, y3, styles{3}, t4, y4, styles{4});
ylim([100, 10000])
xlim([0, 130])

subplot(2,1,2)
hold on;
for kn=1:length(dnames)
    [t, y] = Villeneuve1996_data(dnames{kn});
    plot(t, y, styles{kn}); hold on
end
ylim([0 5000])
xlim([0, 130])
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
print(fig1, '-dtiff', '-r72', 'Villeneuve1996_dilution_curves.tif'); 