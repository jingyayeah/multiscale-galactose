%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Steady state plots

% figure(fig_c)
cf = (1+1e-15*sin(t));
cf = 1;
scrsz = get(0,'ScreenSize');
position = [200 200 scrsz(3)-200 scrsz(4)-200];
lwidth = 2;
bcolor = [1 1 1];

% Plot the steady state results against the respective cells
cells = 1:p.Nc;


if exist('fname_results', 'var')
    name = fname_results;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('Name', 'External Concentrations', 'Position', [0 0 1000 900]);

compartments = (1:p.Nb)*p.d_blood*1E6;
cells_dist = cells*p.d_cell*1E6 - 0.5*p.d_cell*1E6;

% critical ATP survival
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

% glc
subplot(3,2,1), p1 = plot(compartments, glc_ext(end,:), 'k-', 'Color', [0.5 0.5 0.5]); hold on
subplot(3,2,1), plot(cells_dist,glc(end, :),'ks-'); hold off
ylabel('glc [mM]')
title('Glucose')
legend({'glc_{ext}', 'glc'}, 'Location', 'NorthEast');

% lac
subplot(3,2,3), p1 = plot(compartments,lac_ext(end,:), 'k-',  'Color', [0.5 0.5 0.5] ); hold on
subplot(3,2,3), plot(cells_dist,lac(end, :),'ks-'); hold off
ylabel('lac [mM]')
title('Lactate')
legend({'lac_{ext}', 'lac'}, 'Location', 'SouthEast');

% o2
o2_fac = 760/1.3;   % mM -> mmHg
subplot(3,2,5), p1=plot(compartments, o2_ext(end,:)*o2_fac, 'k-',  'Color', [0.5 0.5 0.5]); hold on;
subplot(3,2,5), plot(cells_dist,o2(end, :)*o2_fac,'s-', 'Color', [0.7 0.7 0.7]); hold on
subplot(3,2,5), plot(cells_dist,o2_mito(end, :)*o2_fac,'ks-'); hold on
ylabel('O_{2} [mmHg]')
title('Oxygen', 'FontWeight', 'bold')
legend({'o2_{ext}', 'o2_{cyto}', 'o2_{mito}'}, 'Location', 'NorthEast');
xlabel('Distance Blood Vessel [µm]');

% ATP critical
subplot(3,2,2), plot(cells_dist, atp(end,:), 's-', 'Color', [0.3,0.3,0.3]); hold off;
ylabel('Dead (atp < atp_{c} = 0.1)');
title('Critical energetic distance', 'FontWeight', 'bold')
ylim=get(gca,'ylim');
line([atpc;atpc],ylim.', 'color',[0.3,0.3,0.3], 'LineStyle', '--');
legend({'ATP', '(atp < atp_{c} = 0.1)'}, 'Location', 'NorthEast');


% Vmm
subplot(3,2,4), plot(cells_dist, -Vmm(end,:), 'ks-'); hold off;
ylabel('Vmm [mV]');
title('Mitochondrial Membrane Potential', 'FontWeight', 'bold')
legend({'Vmm',}, 'Location', 'SouthEast');

%{
% Glc6P fate
subplot(3,2,5), plot(cells_dist, v_HK(end,:), 'rs-'); hold on;
subplot(3,2,5), plot(cells_dist, v_GLCUSE(end,:), 'gs-'); hold off;
ylabel('Glc6P usage');
title('Glc6P Fluxes [mM/s/cell]', 'FontWeight', 'bold')
xlabel('Distance Blood Vessel [µm]');
legend({'HK', 'GLCUSE'}, 'Location', 'NorthEast');
%}

% ATP from glycolysis, OxPhos and ATP usage
subplot(3,2,6), plot(cells_dist, v_gly_atp(end,:), 'rs-'); hold on;
subplot(3,2,6), plot(cells_dist, v_oxi_atp_cyt(end,:), 'bs-'); hold on;
subplot(3,2,6), plot(cells_dist, v_ATPUSE(end,:), 'ks-'); hold off;
ylabel('ATP from glycolysis & oxphos');
title('ATP Fluxes [mM/s/cell]', 'FontWeight', 'bold')
xlabel('Distance Blood Vessel [µm]');
legend({'glycolysis_{atp}', 'oxphos_{atp}', 'ATP use'}, 'Location', 'NorthEast');

%{
% Where comes the pyruvate from 
subplot(3,3,9), plot(cells_dist, v_PK(end,:), 'rs-'); hold on;
subplot(3,3,9), plot(cells_dist, v_LDH(end,:), 'gs-'); hold on;
subplot(3,3,9), plot(cells_dist, v_PDH(end,:), 'ks-'); hold off;
ylabel('pyruvate fluxes');
title('Pyruvate Fluxes [mM/s/cell]', 'FontWeight', 'bold')
xlabel('Distance Blood Vessel [µm]');
legend({'Glycolysis [glc -> pyr]', 'Lactate Export [pyr -> lac]', 'OxPhos [pyr -> co2 + atp]'}, 'Location', 'NorthOutside');
%}

haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    
    ylim=get(gca,'ylim');
    % ATP critical
    line([atpc;atpc],ylim.', 'color',[0.3,0.3,0.3], 'LineStyle', '--');
    % ATP proliferating
    line([atppro;atppro],ylim.', 'color',[0.6,0.6,0.6], 'LineStyle', '--');
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);

set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', strcat(name,'_', 'fig1.tif')); 

return

%%
fig2 = figure('Name', 'ATP Bilance & Main Info', 'Position', [700 0 800 1200]);
subplot(6,3,1), plot(cells,v_pyr(end,:), 'ko-'); legend('v_{pyr}',0);
%title('ATP Bilance', 'FontWeight', 'bold')
subplot(6,3,2), plot(cells,v_gly_atp(end,:), 'ko-'); legend('v_{gly-atp}',0);
subplot(6,3,3), plot(cells,v_oxi_atp_cyt(end,:), 'ko-'); legend('v_{oxi-atp-cyt}',0);

subplot(6,3,4), plot(cells,v_PYREX(end,:), 'ko-'); legend('v_{PYREX}',0);
subplot(6,3,5), plot(cells,v_PDH(end,:), 'ko-'); legend('v_{PDH}',0);
subplot(6,3,6), plot(cells,v_SCS_ATP(end,:), 'ko-'); legend('v_{SCS-ATP}',0);
subplot(6,3,8), plot(cells,v_cac_atp(end,:), 'ko-'); legend('v_{cac-atp}',0);
subplot(6,3,9), plot(cells,v_oxi_atp(end,:), 'ko-'); legend('v_{oxi-atp}',0);

% WTF happens in the main pathways
subplot(6,3,10), plot(cells,v_HK(end,:), 'ko-'); legend('v_{HK}',0);
title('Glycolysis [glc -> pyr]')
subplot(6,3,11), plot(cells,v_LDH(end,:), 'ko-'); legend('v_{LDH}',0);
title('Lactate Export [pyr -> lac]')
subplot(6,3,12), plot(cells,v_PDH(end,:), 'ko-'); legend('v_{PDH}',0);
title('OxPhos [pyr -> co2 + atp]')

% Depending on external conditions
% glc
subplot(6,3,13), % p1 = plot(cells, repmat(glc_ext(end,:), p.Nf, length(cells))', 'Color', [0.5 0.5 0.5]); hold on;
plot(cells,glc(end, :), 'ko-'); hold off;
%ylim([0 max(max(glc_ext(end,:)))*1.1])
xlabel('cell i')
ylabel('glc [mM]')
% lac
subplot(6,3,14), % p1 = plot(cells,lac_ext(end,:), 'Color', [0.5 0.5 0.5] ); hold on;
p1 = plot(cells,lac(end,:), 'ko-'); hold off;
%ylim([0 max(max(lac_ext(end,:)))*1.1])
xlabel('cell i')
ylabel('lac [mM]')
% o2
o2_fac = 760/1.3;   % mM -> mmHg
subplot(6,3,15), % p1=plot(cells,o2_ext(end,:)*o2_fac, 'Color', [0.5 0.5 0.5]); hold on;
p1=plot(cells,o2(end,:)*o2_fac, 'ko-'); hold off;
%ylim([0, max(max(o2_ext(end,:)*o2_fac))*1.1])
xlabel('cell i')
ylabel('o2 [mmHg]')

subplot(6,3,16)
plot(cells, atp(end, :), 'ro-'); hold off;
xlabel('cell i')
ylabel('atp [mM]')

subplot(6,3,17)
plot(cells, atp(end, :)<0.1, 'ro-'); hold off;
xlabel('cell i')
ylabel('dead [<atp_c]')


haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    ylim=get(gca,'ylim');
    xlabel(gca, 'Cell <i>')
    line([atpc_cell;atpc_cell],ylim.', 'color',[0.3,0.3,0.3], 'LineStyle', '--');
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig3 = figure('Name', 'Glycolysis', 'Position', position, 'Color', bcolor);
subplot(5,8,1), plot(cells,atp(end, :).*cf,'ro-'); legend('ATP',0);
title('Energetic Cofactors');
subplot(5,8,2),plot(cells,adp(end, :).*cf,'bo-'); legend('ADP',0);
subplot(5,8,3),plot(cells,atp_mito(end, :).*cf,'ro-'); legend('ATP_{mito}',0);
subplot(5,8,4),plot(cells,adp_mito(end, :).*cf,'bo-'); legend('ADP_{mito}',0);
subplot(5,8,5),plot(cells,nad(end, :).*cf,'bo-'); legend('NAD',0);
subplot(5,8,6),plot(cells,nadh(end, :).*cf,'ro-'); legend('NADH',0);
subplot(5,8,7),plot(cells,nad_mito(end, :).*cf,'bo-'); legend('nad_{mito}',0);
subplot(5,8,8),plot(cells,nadh_mito(end, :).*cf,'ro-'); legend('nadh_{mito}',0);

% plot all external glc
subplot(5,7,8), plot(cells,glc(end, :).*cf,'bo-'  ); legend('Glc',0); 
title('Glycolysis: Fluxes and Concentrations'); hold off;

subplot(5,7,9), plot(cells,glc6p(end, :).*cf,'mo-' ); legend('Glc6P',0);
subplot(5,7,10), plot(cells,fru6p(end, :).*cf,'ro-' ); legend('Fru6P',0);
subplot(5,7,11),plot(cells,fru16bp(end, :).*cf,'ko-' ); legend('Fru16P',0);
subplot(5,7,12),plot(cells,fru26bp(end, :).*cf,'ko-'  ); legend('Fru26P',0);
subplot(5,7,13),plot(cells,dhap(end, :).*cf,'co-'  ); legend('DHAP',0);
subplot(5,7,14),plot(cells,g3p(end, :).*cf,'yo-'); legend('GRAP',0);

subplot(5,7,15),plot(cells,bpg13(end, :).*cf,'go-'); legend('Bpg13',0);
subplot(5,7,16),plot(cells,pg3(end, :).*cf,'mo-' ); legend('Pg3',0);
subplot(5,7,17),plot(cells,pg2(end, :).*cf,'ro-' ); legend('Pg2 ',1);
subplot(5,7,18),plot(cells,pep(end, :).*cf,'ro-' ); legend('Pep',1);
subplot(5,7,19),plot(cells,pyr(end, :).*cf,'mo-' ); legend('Pyr',1);

subplot(5,7,20),plot(cells,lac(end, :).*cf,'bo-' );  legend('Lac',1); hold off;

subplot(5,7,22), plot(cells,v_GLCT_in(end, :).*cf,'ko-'); legend('v_{GLCT}',0); title('Glycolytic Fluxes');
subplot(5,7,23), plot(cells,v_HK(end, :).*cf,'go-'); legend('v_{HK}',0); 
subplot(5,7,24), plot(cells,v_GPI(end, :).*cf,'mo-'); legend('v_{GPI}',0);
subplot(5,7,25), plot(cells,v_PFK1(end, :).*cf,'ro-'); legend('v_{PFK1}',0);
subplot(5,7,26), plot(cells,v_PFK2(end, :).*cf,'bo-'); legend('v_{PFK2}',0);
subplot(5,7,27),plot(cells,v_ALD(end, :).*cf,'ko-'); legend('v_{ALD}',0);
subplot(5,7,28),plot(cells,v_TPI(end, :).*cf,'co-'); legend('v_{TPI}',0);

subplot(5,7,29),plot(cells,v_GAPDH(end, :).*cf,'yo-'); legend('v_{GAPDH}',0);
subplot(5,7,30),plot(cells,v_PGK(end, :).*cf,'go-'); legend('v_{PGK}',0);
subplot(5,7,31),plot(cells,v_PGM(end, :).*cf,'mo-'); legend('v_{PGM}',0);
subplot(5,7,32),plot(cells,v_ENO(end, :).*cf,'ro-'); legend('v_{ENO}',0);
subplot(5,7,33),plot(cells,v_PK(end, :).*cf,'ro-'); legend('v_{PK}',0);
subplot(5,7,34),plot(cells,v_LDH(end, :).*cf,'mo-'); legend('v_{LDH}',0);
subplot(5,7,35),plot(cells,v_LDH(end, :)./v_PK(end, :)*100.*cf,'mo-'); legend('% in lactat',0);


haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    ylim=get(gca,'ylim');
    xlabel(gca, 'Cell <i>')
    line([atpc_cell;atpc_cell],ylim.', 'color',[0.3,0.3,0.3], 'LineStyle', '--');
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);


%%
fig4 = figure('Name', 'TCA', 'Position', position, 'Color', bcolor);
subplot(5,6,1),plot(cells,nadh_mito(end, :),'ro-'); legend('NADH_{mito}',0);
subplot(5,6,2),plot(cells,nad_mito(end, :),'bo-'); legend('NAD_{mito}',0);
subplot(5,6,3),plot(cells,atp_mito(end, :),'ro-'); legend('ATP_{mito}',0);
subplot(5,6,4),plot(cells,adp_mito(end, :),'bo-'); legend('ADP_{mito}',0);

subplot(5,6,7),plot(cells,pyr_mito(end, :),'ro-', cells, pyr(end, :),'ko-'); legend('Pyr_{mito}','Pyr_{in}',0); title('CAC: Fluxes & Concentrations');
subplot(5,6,8),plot(cells,cit_mito(end, :),'go-'); legend('Cit_{mito}',0);
subplot(5,6,9),plot(cells,isocit_mito(end, :),'mo-'); legend('IsoCit_{mito}',0);
subplot(5,6,10),plot(cells,akg_mito(end, :),'ro-'); legend('akg_{mito}',0);
subplot(5,6,11),plot(cells,succoa_mito(end, :),'ko-'); legend('SucCoA_{mito}',0);
subplot(5,6,12),plot(cells,suc_mito(end, :),'yo-'); legend('Suc_{mito}',0);

subplot(5,6,13),plot(cells,fum_mito(end, :),'co-'); legend('Fum_{mito}',0);
subplot(5,6,14),plot(cells,mal_mito(end, :),'go-'); legend('Mal_{mito}',0);
subplot(5,6,15),plot(cells,oa_mito(end, :),'mo-'); legend('Oa_{mito}',0);
subplot(5,6,16),plot(cells,acoa_mito(end, :),'ro-'); legend('ACoA_{mito}',0);
subplot(5,6,17),plot(cells,coa_mito(end, :),'ro-'); legend('CoA_{mito}',0);

subplot(5,6,19),plot(cells,v_PDH(end, :),'go-'); legend('v_{PDH}',0);
subplot(5,6,20),plot(cells,v_CS(end, :),'go-'); legend('v_{CS}',0);
subplot(5,6,21),plot(cells,v_ACN(end, :),'mo-'); legend('v_{ACN}',0);
subplot(5,6,22),plot(cells,v_IDH(end, :),'ro-'); legend('v_{IDH}',0);
subplot(5,6,23),plot(cells,v_KGDH(end, :),'ko-'); legend('v_{KGDH}',0);

subplot(5,6,25),plot(cells,v_SCS_ATP(end, :),'yo-'); legend('v_{SCS ATP}',0);
subplot(5,6,26),plot(cells,v_SDH(end, :),'co-'); legend('v_{SDH}',0);
subplot(5,6,27),plot(cells,v_FUMR(end, :),'go-'); legend('v_{FUMR}',0);
subplot(5,6,28),plot(cells,v_MDHM(end, :),'mo-'); legend('v_{MDHM}',0);


haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    ylim=get(gca,'ylim');
    xlabel(gca, 'Cell <i>')
    line([atpc_cell;atpc_cell],ylim.', 'color',[0.3,0.3,0.3], 'LineStyle', '--');
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);

%%
fig5 = figure('Position', position, 'Color', bcolor);
subplot(6,7,1),plot(cells,atp(end, :),'ro-'); legend('ATP',0);
subplot(6,7,2),plot(cells,adp(end, :),'bo-'); legend('ADP',0);
subplot(6,7,3),plot(cells,atp_mito(end, :),'ro-'); legend('ATP_{mito}',0);
subplot(6,7,4),plot(cells,adp_mito(end, :),'bo-'); legend('ADP_{mito}',0);
subplot(6,7,5),plot(cells,nad_mito(end, :),'bo-'); legend('NAD_{mito}',0);
subplot(6,7,6),plot(cells,nadh_mito(end, :),'ro-'); legend('NADH_{mito}',0);
subplot(6,7,7),plot(cells,-Vmm(end, :),'mo-'); legend('Vmm',0);

subplot(6,5,6),plot(cells,q(end, :),'bo-'); legend('q',0);
subplot(6,5,7),plot(cells,qh2(end, :),'ro-'); legend('qh2',0);
subplot(6,5,8),plot(cells,cytcox(end, :),'bo-'); legend('cytcox',0);
subplot(6,5,9),plot(cells,cytcred(end, :),'ro-'); legend('cytcred',0);
subplot(6,5,10),plot(cells,o2(end, :),'bo-'); legend('o2',0);

subplot(6,5,11),plot(cells,h_in(end, :),'mo-'); legend('h_{in}',0);
subplot(6,5,12),plot(cells,cl_in(end, :),'ko-'); legend('cl_{in}',0);
subplot(6,5,13),plot(cells,ka_in(end, :),'co-'); legend('ka_{in}',0);
subplot(6,5,14),plot(cells,na_in(end, :),'ro-'); legend('na_{in}',0);
subplot(6,5,15),plot(cells,phos(end, :),'yo-'); legend('p_{in}',0);

subplot(6,5,16),plot(cells,h_mito(end, :),'mo-'); legend('h_{mito}',0);
subplot(6,5,17),plot(cells,cl_mito(end, :),'ko-'); legend('cl_{mito}',0);
subplot(6,5,18),plot(cells,ka_mito(end, :),'co-'); legend('ka_{mito}',0);
subplot(6,5,19),plot(cells,na_mito(end, :),'ro-'); legend('na_{mito}',0);
subplot(6,5,20),plot(cells,p_mito(end, :),'yo-'); legend('p_{in}',0);

subplot(6,7,29),plot(cells,v_syn(end, :),'mo-'); legend('v_{syn}',0);
subplot(6,7,30),plot(cells,v_ex(end, :),'go-'); legend('v_ex',0);
subplot(6,7,31),plot(cells,v_ATPUSE(end, :),'bo-'); legend('v_{ATPUSE}',0);
subplot(6,7,32),plot(cells,v_Phos(end, :),'go-'); legend('v_Phos',0);
subplot(6,7,33),plot(cells,v1(end, :),'ro-'); legend('v1',0);
subplot(6,7,34),plot(cells,v3(end, :),'yo-'); legend('v3',0);
subplot(6,7,35),plot(cells,v4(end, :),'bo-'); legend('v4',0);

subplot(6,8,41),plot(cells,v_oxi_nad(end, :),'bo-'); legend('v_{oxi}-nad',0);
subplot(6,8,42),plot(cells,v_oxi_nadh(end, :),'ro-'); legend('v_{oxi}-nadh',0);
subplot(6,8,43),plot(cells,v_cac_nad(end, :),'bo-'); legend('v_{cac}-nad',0);
subplot(6,8,44),plot(cells,v_cac_nadh(end, :),'ro-'); legend('v_{cac}-nadh',0);
subplot(6,8,45),plot(cells,v_oxi_q(end, :),'yo-'); legend('v_{oxi}-q',0);
subplot(6,8,46),plot(cells,v_oxi_qh2(end, :),'go-'); legend('v_{oxi}-qh2',0);
subplot(6,8,47),plot(cells,v_cac_q(end, :),'yo-'); legend('v_{cac}-q',0);
subplot(6,8,48),plot(cells,v_cac_qh2(end, :),'go-'); legend('v_{cac}-qh2',0);

subplot(6,8,47),plot(cells,v_cac_atp(end, :),'mo-'); legend('v_{cac}-atp',0);
subplot(6,8,48),plot(cells,v_oxi_atp(end, :),'ro-'); legend('v_{oxi}-atp',0);

haxes = findobj(gcf, 'type', 'Axes');
%set(haxes, 'YGrid', 'on');
%set(haxes, 'XGrid', 'on');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax)
    ylim=get(gca,'ylim');
    xlabel(gca, 'Cell <i>')
    line([atpc_cell;atpc_cell],ylim.', 'color',[0.3,0.3,0.3], 'LineStyle', '--');
    % set(ax, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold')
    set(get(gca, 'XLabel'), 'FontWeight', 'bold')
    set(get(gca, 'YLabel'), 'FontWeight', 'bold')
end
hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%saveas(fig1, strcat(fname_results,'_', 'fig1'), 'png'); 
%saveas(fig2, strcat(fname_results,'_', 'fig2'), 'png'); 
%saveas(fig3, strcat(fname_results,'_', 'fig3'), 'png'); 
%saveas(fig4, strcat(fname_results,'_', 'fig4'), 'png'); 
%saveas(fig5, strcat(fname_results,'_', 'fig5'), 'png'); 




set(fig2, 'PaperPositionMode', 'auto');
print(fig2, '-dtiff', '-r150', strcat(name,'_', 'fig2.tif'));
set(fig3, 'PaperPositionMode', 'auto');
print(fig3, '-dtiff', '-r150', strcat(name,'_', 'fig3.tif'));
set(fig4, 'PaperPositionMode', 'auto');
print(fig4, '-dtiff', '-r150', strcat(name,'_', 'fig4.tif'));
set(fig5, 'PaperPositionMode', 'auto');
print(fig5, '-dtiff', '-r150', strcat(name,'_', 'fig5.tif'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
