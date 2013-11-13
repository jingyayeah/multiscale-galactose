%% Helper variables
compartments = (1:p.Nb)*p.x_sin*1E6;
cells = 1:p.Nc;
cells_dist = cells*p.x_cell*1E6 - 0.5*p.x_cell*1E6;
pv_pos = compartments(end)+0.5*p.x_cell*1E6;
Vdis = p.Vol_dis;
Vcel = p.Vol_cell;


%% Overview over external profiles
sunit = 'mole/m^3';
funit = 'mole/s';

if (false)
fig1 = figure('Name', 'External', 'Position', [50 50 1500 600], 'Color', [1 1 1]);
% Galactose
subplot(1,6,1)
plot(0, pp.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, gal_sin(end,:), 'k-'); hold on
plot(compartments, gal_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, gal(end, :),'s-', 'Color', 'b'); hold off
ylabel('galactose [mole/m^3]')
xlabel('pp < - > pv [�m]')
title('galactose')
l1 = legend({'gal_{pp}', 'gal_{sin}', 'gal_{dis}', 'gal_{pv}', 'gal_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

% Time courses
subplot(1,6,2)
plot(t, gal, 'ks-'); hold on
title('galactose')
ylabel('galactose  [mole/m^3]');
xlabel('time [s]')

% Time courses
subplot(1,6,3)
plot(t, GLUT2_GAL/Vcel, 'ks-'); hold on
title('GLUT2 (galactose)')
ylabel('GLUT2 (galactose) [mole/m^3/s]')
xlabel('time [s]')

subplot(1,6,4)
plot(t, pp.gal_sin, 'k-'); hold on
plot(t, pv.gal_sin, 'b-'); hold off
title('Galactose pp and pv')
ylabel('galactose [mole/m^3]')
xlabel('time [s]')

sp = subplot(1,6,5);
view(sp,[34.5 30]);
surf(t, compartments, gal_dis', 'EdgeAlpha', 0.1)
title('galactose Disse')
ylabel('Nf')
xlabel('time [s]')
zlabel('galactose  [mole/m^3]')

sp = subplot(1,6,6);
view(sp,[34.5 30]);
surf(t, compartments, gal_sin', 'EdgeAlpha', 0.1)
title('galactose Sinusoid')
ylabel('Nf')
xlabel('time [s]')
zlabel('galactose  [mole/m^3]')

lwidth = 1;
bcolor = [1 1 1];
haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    ylim=get(gca,'ylim');
    set(gca, 'ylim', 1.05*ylim)
    
    xlim=get(gca,'xlim');
    set(gca, 'xlim', 1.05*xlim)
    % set(get(gca, 'XLabel'), 'String', 'pp < - > pv [�m]');
    
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    %xlim([0 230])
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);
%set(fig1, 'PaperPositionMode', 'auto');
%print(fig1, '-dtiff', '-r150', './results/External_Concentrations.tif'); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bilancing
fig2 = figure('Name', 'Bilances', 'Position', [50 50 1200 900], 'Color', [1 1 1]);
rnum = 3;
cnum = 5;
% ATP Bilance
subplot(rnum,cnum,1); hold on;
plot(t, adp, 'r-');
plot(t, atp, 'b-');
plot(t, atp_tot, 'k-');
legend({'adp', 'atp', 'atp_{tot}'})
hold off; title('ATP Bilance'); ylabel('[mole/m^3]')

% UTP balance
subplot(rnum,cnum,2); hold on;
plot(t, udp, 'r-');
plot(t, utp, 'b-');
plot(t, udpglc, '-', 'Color', [1 0.5 0.25]);
plot(t, udpgal, '-', 'Color', [0 0.5 0]);
plot(t, utp_tot, 'k-');
legend({'udp', 'utp', 'udpglc', 'udpgal', 'utp_{tot}'})
hold off; title('UTP Bilance'); ylabel('[mole/m^3]')

% NADP Bilance
subplot(rnum,cnum,3); hold on;
plot(t, nadp, 'r-');
plot(t, nadph, 'b-');
plot(t, nadp_tot, 'k-'); 
legend({'nadp', 'nadph', 'nadp_{tot}'});
hold off; title ('NADP Bilance'); ylabel('[mole/m^3]')

% Phosphate balance
subplot(rnum,cnum,4), hold on;
plot(t, phos, 'r-');
plot(t, 2*ppi, 'b-');
plot(t, glc1p, '-', 'Color', [1 0.5 0.25]);
plot(t, gal1p, '-', 'Color', [0 0.5 0]);
plot(t, pi_tot, 'k-', 'LineWidth', 3);
legend({'phos', '2*ppi', 'glc1p', 'gal1p', 'pi_{tot}'});
hold off; title('Phosphate Bilance'); ylabel('[mole/m^3]')

% Galactitol
subplot(rnum,cnum,5); hold on;
plot(t, galtol, 'r-')
plot(t, gal, 'b-'), hold off;
legend({'galtol', 'gal'});
hold off; title ('Galactitol'); ylabel('[mole/m^3]');

% plot the difference pp<->pv
subplot(rnum,cnum,6); hold on;
plot(pp.gal_sin, pp.gal_sin, 'ro');
plot(pp.gal_sin, pv.gal_sin, 'bo');
plot(pp.gal_sin, pp.gal_sin-pv.gal_sin, 'ko');
title('pp - pv Galactose Clearance');
hold off; title('GLUT2 (galactose)'); ylabel('pv galactose');

subplot(rnum,cnum,7); hold on;
plot(t, GLUT2_GAL/Vcel, 'k-');
plot(t, GLUT2_GALM/Vcel, 'r-');
legend({'gal', 'galM'});
hold off; title('GLUT2 (galactose)'); ylabel('[mole/m^3/s]');

subplot(rnum,cnum,8); hold on;
plot(t, GALK/Vcel, 'k-');
plot(t, IMP/Vcel, 'r-');
legend({'GALK', 'IMP'});
hold off; title('GALK'); ylabel('[mole/m^3/s]');

subplot(rnum,cnum, 9); hold on;
plot(t, ALDR/Vcel,  'k-');
plot(t, NADPR/Vcel, 'r-');
legend({'ALDR', 'NADPR'});
hold off; title('ALDR'); ylabel('[mole/m^3/s]');

subplot(rnum, cnum, 10); hold on;
plot(t, GALK/Vcel, 'k-');
plot(t, GALT/Vcel, 'r-');
plot(t, GALE/Vcel, 'b-');
legend({'GALK', 'GALT', 'GALE'});
hold off; title('Galactose Core'); ylabel('[mole/m^3/s]');

subplot(rnum, cnum, 11); hold on;
plot(t, UGP/Vcel, 'k-');
plot(t, UGALP/Vcel, 'r-');
plot(t, PPASE/Vcel, 'b-');
legend({'UGP', 'UGALP', 'PPASE'});
hold off; title('UGP'); ylabel('[mole/m^3/s]');

subplot(rnum, cnum, 12); hold on;
plot(t, ATPS/Vcel, 'k-');
plot(t, GALK/Vcel, 'r-');
hold off; title('ATP reactions'); ylabel('[mole/m^3/s]');
legend({'ATPS', 'GALK'});
hold off

subplot(rnum, cnum, 13); hold on
plot(t, PGM1/Vcel, 'k-');
plot(t, GALK/Vcel, 'r-');
plot(t, (GALK-IMP)/Vcel, 'b-'); ylabel('[mole/m^3/s]');
legend({'PGM1', 'GALK', 'GALK-IMP'});
hold off; title('gal -> glycolysis');

subplot(rnum, cnum, 14); hold on;
plot(t, NDKU/Vcel, 'k-'); ylabel('[mole/m^3/s]');
hold off; title('ATP -> UTP');
legend({'NDKU'});

subplot(rnum, cnum, 15); hold on;
plot(t, GTFGAL/Vcel, 'k-');
plot(t, GTFGLC/Vcel, 'b-');
legend({'GTFGAL', 'GTFGLC'});
hold off; title('GTF - Glycosltransferases'); ylabel('[mole/m^3/s]');

hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);
haxes = findobj(gcf, 'type', 'Axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    ylimd=get(gca,'ylim');
    set(gca, 'ylim', [0.95*ylimd(1) 1.05*ylimd(2)]);
    
    xlim=get(gca,'xlim');
    %set(gca, 'xlim', 1.05*xlim)
    set(get(gca, 'XLabel'), 'String', 'time [s]');
    
    set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
clear xlim

subplot(rnum,cnum,6);
xlabel('pp galactose [mM]')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot initial concentrations (set ranges) and all model concentrations
fig3 = figure('Name', 'Concentration Ranges', 'Position', [50 50 900 900], 'Color', [1 1 1]);
cnames = {'gal', 'glc1p', 'glc6p', 'gal1p', 'udpglc', 'udpgal', 'galtol', ...
    'atp', 'adp', 'utp', 'udp', 'phos', 'ppi', 'nadp', 'nadph'};
csize = ceil(sqrt(numel(cnames)));
clear ylim

[~, x_init, ~, ~, ~, ~, ~, x_gal] = pars_galactose_metabolism();
for kn=1:numel(cnames)
    % TODO: get the real initial values, not from the integration start
    name = cnames{kn};
    subplot(csize, csize,kn)
    y = eval([name]);
    hold on;
    tl = t(1); tu = t(end);
    % plot initial fill
    tmp = x_init(name);
    yl = 0.8*tmp;
    yu = 1.2*tmp;
    fp = fill([tl tu tu tl], [yl yl yu yu], [0 0.8 0.2]);
    %line([tl tu], [yl yl], 'Color', [0.4 0.4 0.4], 'LineStyle', '--')
    %line([tl tu], [yu yu], 'Color', [0.4 0.4 0.4], 'LineStyle', '--')
    set(fp, 'FaceAlpha', 0.2, 'EdgeAlpha', 0.2);
    
    % plot gal challenge fill
    % plot initial fill
    tmp = x_gal(name);
    if (~isnan(tmp))
        yl = 0.8*tmp;
        yu = 1.2*tmp;
        fp = fill([tl tu tu tl], [yl yl yu yu], [0.5 0.5 0.5]);
        set(fp, 'FaceAlpha', 0.2, 'EdgeAlpha', 0.2);
    end
    
    plot(t, y, 'k-', 'LineWidth', 2);
    hold off;
   
    axis square;
    if (kn>csize*(csize-1))
        xlabel('time [s]')
    end
    ylabel(strcat(name, ' [mM]'))
    title(name, 'FontWeight', 'bold')
    tmp = ylim();
    ylim([0 1.2*tmp(2)])
    xlim([0 t(end)])
    
end
set(fig3, 'PaperPositionMode', 'auto');
print(fig3, '-dtiff', '-r150', strcat(p.resultsFolder,'Normal_Concentrations.tif')); 
return


    linewidth 2
    axis square;
    xlabel('time [s]')
    ylabel({name, '[mM]'})
    title(name, 'FontWeight', 'bold')
    ylim([0 1.2*max(y)])




return






%% Galactose
subplot(4,6,5)
plot(0, pp.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, gal_sin(end,:), 'k-'); hold on
plot(compartments, gal_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, gal(end, :),'s-', 'Color', 'b'); hold off
ylabel('galactose [mmol/l]')
title('galactose')
l1 = legend({'gal_{pp}', 'gal_{sin}', 'gal_{dis}', 'gal_{pv}', 'gal_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

subplot(4,6,17)
plot(0, pp.galM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, galM_sin(end,:), 'k-'); hold on
plot(compartments, galM_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.galM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, galM(end, :),'s-', 'Color', 'b'); hold off
ylabel('galactose M [mmol/l]')
l1 = legend({'galM_{pp}', 'galM_{sin}', 'galM_{dis}', 'galM_{pv}', 'galM_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

% Time courses
subplot(4,6,11)
plot(0, pp.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, gal_sin, 'k-'); hold on
plot(compartments, gal_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.gal_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, gal,'s-', 'Color', 'b'); hold off
ylabel('galactose [mmol/l]')

subplot(4,6,23)
plot(0, pp.galM_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, galM_sin, 'k-'); hold on
plot(compartments, galM_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.gal_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, galM,'s-', 'Color', 'b'); hold off
ylabel('galactose M [mmol/l]')








%% Create the figures
fig2 = figure('Name', 'External', 'Position', [0 0 1800 1000], 'Color', [1 1 1]);

%% RBC
% Steady State Plots
subplot(4,6,1)
plot(0, pp.rbc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, rbc_sin(end,:), 'k-'); hold on
plot(compartments, rbc_dis(end, :),'s-', 'Color', 'r'); hold on
plot(pv_pos, pv.rbc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('RBC [?]')
title('RBC')
l1 = legend({'RBC_{pp}', 'RBC_{sin}', 'RBC_{dis}', 'RBC_{pv}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

subplot(4,6,13)
plot(0, pp.rbcM_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, rbcM_sin(end,:), 'k-'); hold on
plot(compartments, rbcM_dis(end, :),'s-', 'Color', 'r'); hold on
plot(pv_pos, pv.rbcM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('RBCM [?]')
l1 = legend({'RBCM_{pp}', 'RBCM_{sin}', 'RBCM_{dis}', 'RBCM_{pv}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

% Time courses
subplot(4,6,7)
plot(0, pp.rbc_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, rbc_sin, 'k-'); hold on
plot(compartments, rbc_dis, 's-', 'Color', 'r'); hold on
plot(pv_pos, pv.rbc_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('RBC [?]')

subplot(4,6,19)
plot(0, pp.rbcM_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'blck'); hold on
plot(compartments, rbcM_sin, 'k-'); hold on
plot(compartments, rbcM_dis, 's-', 'Color', 'r'); hold on
plot(pv_pos, pv.rbcM_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('RBCM [?]')


%% Sucrose 
% Steady State Plots
subplot(4,6,2)
plot(0, pp.suc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, suc_sin(end,:), 'k-'); hold on
plot(compartments, suc_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.suc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('sucrose [mmol/l]')
title('sucrose')
l1 = legend({'suc_{pp}', 'suc_{sin}', 'suc_{dis}', 'suc_{pv}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

subplot(4,6,14)
plot(0, pp.sucM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, sucM_sin(end,:), 'k-'); hold on
plot(compartments, sucM_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.sucM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('sucrose M [mmol/l]')
l1 = legend({'sucM_{pp}', 'sucM_{sin}', 'sucM_{dis}', 'suc_{pv}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

% Time courses
subplot(4,6,8)
plot(0, pp.suc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, suc_sin, 'k-'); hold on
plot(compartments, suc_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.suc_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('sucrose [mmol/l]')

subplot(4,6,20)
plot(0, pp.sucM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, sucM_sin, 'k-'); hold on
plot(compartments, sucM_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.sucM_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('sucrose M [mmol/l]')

%% Albumin
subplot(4,6,3)
plot(0, pp.alb_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, alb_sin(end,:), 'k-'); hold on
plot(compartments, alb_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.alb_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('albumin [?]')
title('albumin')
l1 = legend({'alb_{pp}', 'alb_{sin}', 'alb_{dis}', 'alb_{pv}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

subplot(4,6,15)
plot(0, pp.albM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, albM_sin(end,:), 'k-'); hold on
plot(compartments, albM_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.albM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('albumin M [?]')
l1 = legend({'albM_{pp}', 'albM_{sin}', 'albM_{dis}', 'albM_{pv}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

% Time courses
subplot(4,6,9)
plot(0, pp.alb_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, alb_sin, 'k-'); hold on
plot(compartments, alb_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.alb_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('albumin [?]')

subplot(4,6,21)
plot(0, pp.albM_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, albM_sin, 'k-'); hold on
plot(compartments, albM_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.albM_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold off
ylabel('albumin M [?]')


%% Glucose
% Steady State Plots
subplot(4,6,4)
plot(0, pp.glc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, glc_sin(end,:), 'k-'); hold on
plot(compartments, glc_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.glc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, glc(end, :),'s-', 'Color', 'b'); hold off
ylabel('glucose [mmol/l]')
title('glucose')
l1 = legend({'glc_{pp}', 'glc_{sin}', 'glc_{dis}', 'glc_{pv}', 'glc_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

subplot(4,6,16)
plot(0, pp.glcM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, glcM_sin(end,:), 'k-'); hold on
plot(compartments, glcM_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.glcM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, glcM(end, :),'s-', 'Color', 'b'); hold off
ylabel('glucose M [mmol/l]')
l1 = legend({'glcM_{pp}', 'glcM_{sin}', 'glcM_{dis}', 'glcM_{pv}', 'glcM_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

% Time courses
subplot(4,6,10)
plot(0, pp.glc_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, glc_sin, 'k-'); hold on
plot(compartments, glc_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.glc_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, glc,'s-', 'Color', 'b'); hold off
ylabel('glucose [mmol/l]')

subplot(4,6,22)
plot(0, pp.glcM_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, glcM_sin, 'k-'); hold on
plot(compartments, glcM_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.glcM_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, glcM,'s-', 'Color', 'b'); hold off
ylabel('glucose M [mmol/l]')


%% Galactose
subplot(4,6,5)
plot(0, pp.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, gal_sin(end,:), 'k-'); hold on
plot(compartments, gal_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, gal(end, :),'s-', 'Color', 'b'); hold off
ylabel('galactose [mmol/l]')
title('galactose')
l1 = legend({'gal_{pp}', 'gal_{sin}', 'gal_{dis}', 'gal_{pv}', 'gal_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

subplot(4,6,17)
plot(0, pp.galM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, galM_sin(end,:), 'k-'); hold on
plot(compartments, galM_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.galM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, galM(end, :),'s-', 'Color', 'b'); hold off
ylabel('galactose M [mmol/l]')
l1 = legend({'galM_{pp}', 'galM_{sin}', 'galM_{dis}', 'galM_{pv}', 'galM_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

% Time courses
subplot(4,6,11)
plot(0, pp.gal_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, gal_sin, 'k-'); hold on
plot(compartments, gal_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.gal_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, gal,'s-', 'Color', 'b'); hold off
ylabel('galactose [mmol/l]')

subplot(4,6,23)
plot(0, pp.galM_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, galM_sin, 'k-'); hold on
plot(compartments, galM_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.gal_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, galM,'s-', 'Color', 'b'); hold off
ylabel('galactose M [mmol/l]')

%% H2O
subplot(4,6,18)
plot(0, pp.h2oM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, h2oM_sin(end,:), 'k-'); hold on
plot(compartments, h2oM_dis(end, :),'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.h2oM_sin(end), 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, h2oM(end, :),'s-', 'Color', 'b'); hold off
ylabel('H2O M [mmol/l]')
title('H2O M')
l1 = legend({'h2oM_{pp}', 'h2oM_{sin}', 'h2oM_{dis}', 'h2oM_{pv}', 'h2oM_{cell}'}, 'Location', 'NorthEast');
legend boxoff; set(l1,'FontSize',10);

subplot(4,6,24)
plot(0, pp.h2oM_sin(end), 's-', 'Color', 'black', 'MarkerFaceColor', 'black'); hold on
plot(compartments, h2oM_sin, 'k-'); hold on
plot(compartments, h2oM_dis, 'r-', 'Color', 'r'); hold on
plot(pv_pos, pv.h2oM_sin, 's', 'Color', 'black', 'MarkerFaceColor', [0.5 0.5 0.5]); hold on
plot(cells_dist, h2oM,'s-', 'Color', 'b'); hold off
ylabel('H2O M [mmol/l]')

lwidth = 1;
bcolor = [1 1 1];
haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    ylim=get(gca,'ylim');
    set(gca, 'ylim', [0 1.05*ylim(2)])
    
    
    xlim=get(gca,'xlim');
    set(gca, 'xlim', [-0.05*compartments(end) 1.05*compartments(end)])
    set(get(gca, 'XLabel'), 'String', 'pp < - > pv [�m]');
    
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    %xlim([0 230])
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', './results/External_Concentrations.tif'); 


% clean the workspace (remove unused variables)
clear('ax', 'bcolor', 'haxes', 'hline', 'k', 'l1', 'lwidth', 'tit', 'xlim', 'ylim')