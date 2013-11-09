%% Helper variables
compartments = (1:p.Nb)*p.x_sin*1E6;
cells = 1:p.Nc;
cells_dist = cells*p.x_cell*1E6 - 0.5*p.x_cell*1E6;
pv_pos = compartments(end)+0.5*p.x_cell*1E6;
Vdis = p.Vol_dis;
Vcel = p.Vol_cell;


dnames = {'rbcM', 'albM', 'sucM', 'galM', 'h2oM'};
styles = {'rs-', 'gs-', 'ks-', 'bs-', 'ms-'};
fig1 = figure('Name', 'Dilution Curves', 'Color',  [1 1 1], 'Position', [0 0 1000 500]);
subplot(1,2,1)
hold on;
plot(t, pp.rbcM_sin, styles{1})
plot(t, pp.albM_sin, styles{2})
plot(t, pp.sucM_sin, styles{3})
plot(t, pp.galM_sin, styles{4})
plot(t, pp.h2oM_sin, styles{5})

plot(t, pv.rbcM_sin, styles{1})
plot(t, pv.albM_sin, styles{2})
plot(t, pv.sucM_sin, styles{3})
plot(t, pv.galM_sin, styles{4})
plot(t, pv.h2oM_sin, styles{5})
legend(dnames)
axis square;
ylabel('time [s]');

subplot(1,2,2)
hold on;
nfac = 100/40;
plot(t, nfac*pv.rbcM_sin, styles{1})
plot(t, nfac*pv.albM_sin, styles{2})
plot(t, nfac*pv.sucM_sin, styles{3})
plot(t, nfac*pv.galM_sin, styles{4})
plot(t, nfac*pv.h2oM_sin, styles{5})
legend(dnames)
axis square;
xlim([0,40])
ylabel('time [s]');


% general changes for all axis
haxes = findobj(gcf, 'type', 'Axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    set(get(gca, 'XLabel'), 'String', 'time [s]');
    set(get(gca, 'YLabel'), 'String', '');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 1);
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', 'dilution_curves/simulation.tif'); 

%%
figure()
subplot(1,3,1), 
tmp = pcolor(compartments, t, galM_sin)
set(tmp, 'EdgeAlpha', 0.1);
title('Galactose Sinusoid')
ylim([0, 20])

subplot(1,3,2), 
tmp = pcolor(compartments, t, galM_dis)
set(tmp, 'EdgeAlpha', 0.1);
title('Galactose Disse')
ylim([0, 20])

subplot(1,3,3), 
tmp = pcolor(compartments, t, galM_dis-galM_sin)
set(tmp, 'EdgeAlpha', 0.1);
title('Galactose Disse - Sinusoid')
ylim([0, 20])
