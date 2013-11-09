% plot all the galactosemias for comparison;
clc, clear all, format compact
fprintf('\n---------------------------\n')
fprintf('# PLOTS GALACTOSEMIAS #\n')
fprintf('----------------------------\n')

fig1 = figure('Name', 'Concentration Ranges', 'Position', [50 50 900 900], 'Color', [1 1 1]);
cnames = {'gal', 'glc1p', 'glc6p', 'gal1p', 'udpglc', 'udpgal', 'galtol', ...
    'atp', 'adp', 'utp', 'udp', 'phos', 'ppi', 'nadp', 'nadph'};
csize = ceil(sqrt(numel(cnames)));
for kd=1:24
    k = kd;
    if (k==24)
        k = 0;
    end
    fprintf('GALACTOSEMIA: %s\n', num2str(k))
    name = strcat('./results/test_', num2str(k));
    load(name);
    create_named_variables;
    
    for kn=1:numel(cnames)
        name = cnames{kn};
        subplot(csize, csize,kn)
        y = eval([name]);
        hold on;
        % plot the normal case
        if (p.deficiency == 0)
            tl = t(1); tu = t(end);
            yl = 0.8*y(1);
            yu = 1.2*y(1);
            fill([tl tu tu tl], [yl yl yu yu], [0.9 0.9 0.9], 'EdgeAlpha', 0.3, 'EdgeColor', 'none');
            %line([tl tu], [yl yl], 'Color', [0.4 0.4 0.4], 'LineStyle', '--')
            %line([tl tu], [yu yu], 'Color', [0.4 0.4 0.4], 'LineStyle', '--')
            plot(t, y, 'k-', 'LineWidth', 2);
        end
        % GALK deficiencies
        if (p.deficiency >= 1 && p.deficiency <=8)
            plot(t, y, 'r-', 'LineWidth', 1);
        % GALT deficiencies
        elseif (p.deficiency >= 9 && p.deficiency <=14)
            plot(t, y, 'b-', 'LineWidth', 1);
        % GALE deficiencies
         elseif (p.deficiency >= 15 && p.deficiency <=23)
            plot(t, y, 'Color', [0 0.8 0.2], 'LineWidth', 1);
        end
    end
end
for kn=1:numel(cnames)
    name = cnames{kn};
    subplot(csize, csize, kn)
    axis square;
    if (kn>csize*(csize-1))
        xlabel('time [s]')
    end
    ylabel(strcat(name, ' [mM]'))
    title(name, 'FontWeight', 'bold')
    tmp = ylim();
    ylim([0 1.2*tmp(2)])
end
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', './results/Galactosemia_Concentrations.tif'); 

%%
fig2 = figure('Name', 'Fluxes Ranges', 'Position', [50 50 900 900], 'Color', [1 1 1]);
cnames = {'GLUT2_GAL', 'GALK', 'IMP', 'ALDR', 'GALT', 'GALE', 'UGP', 'UGALP', ...
    'NDKU', 'ATPS', 'NADPR', 'PPASE', 'PGM1', 'GTFGAL'};
csize = ceil(sqrt(numel(cnames)));
for kd=1:24
    k = kd;
    if (k==24)
        k = 0;
    end
    fprintf('GALACTOSEMIA: %s\n', num2str(k))
    name = strcat('./results/test_', num2str(k));
    load(name);
    create_named_variables;
    
    for kn=1:numel(cnames)
        name = cnames{kn};
        subplot(csize, csize,kn)
        y = eval([name]);
        hold on;
        % plot the normal case
        if (p.deficiency == 0)
            plot(t, y, 'k-', 'LineWidth', 2);
        end
        % GALK deficiencies
        if (p.deficiency >= 1 && p.deficiency <=8)
            plot(t, y, 'r-', 'LineWidth', 1);
        % GALT deficiencies
        elseif (p.deficiency >= 9 && p.deficiency <=14)
            plot(t, y, 'b-', 'LineWidth', 1);
        % GALE deficiencies
         elseif (p.deficiency >= 15 && p.deficiency <=23)
            plot(t, y, 'Color', [0 0.8 0.2], 'LineWidth', 1);
        end
    end
end

for kn=1:numel(cnames)
    name = cnames{kn};
    subplot(csize, csize, kn)
    axis square;
    if (kn>csize*(csize-1))
        xlabel('time [s]')
    end
    ylabel(strcat(name, ' [mmol/L/s]'))
    title(name, 'FontWeight', 'bold')
    tmp = ylim();
    ylim([1.2*tmp(1) 1.2*tmp(2)])
end
set(fig2, 'PaperPositionMode', 'auto');
print(fig2, '-dtiff', '-r150', './results/Galactosemia_Fluxes.tif'); 

