clear all; close all;
fig1 = figure('Name', 'Dilution Curves Goresky1973', 'Color', [1 1 1], 'Position', [0 0 1200 600]);

styles = {'ro-', 'ks-', 'bs-'};
dnames = {'RBC', 'Sucrose', 'Galactose'};

for exp=1:3
    exp
    subplot(2,3,exp)
    [t1, y1] = Goresky1973_data(dnames{1}, exp);
    [t2, y2] = Goresky1973_data(dnames{2}, exp);
    [t3, y3] = Goresky1973_data(dnames{3}, exp);
    semilogy(t1, y1, styles{1}, t2, y2, styles{2}, t3, y3, styles{3}); 
    ylim([0.1, 100])
    
    subplot(2,3,3+exp)
    hold on;
    for kn=1:length(dnames)
        [t, y] = Goresky1973_data(dnames{kn}, exp);
        plot(t, y, styles{kn});
    end
    ylim([0 16])
    legend(dnames);
    hold off;
end

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
set(hline, 'LineWidth', 1);
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', 'Goresky1973_dilution_curves.tif'); 