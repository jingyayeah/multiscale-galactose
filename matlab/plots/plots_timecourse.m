%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Create figures only if not existing
% handles=findall(0,'type','figure');
% exist_fig1 = false;
% for k = 1:numel(handles)
%     name = get(figure(handles(k)), 'Name');
%     if strcmp(name, 'Concentrations')
%         exist_fig1 = true;
%         fig_c = handles(k);
%     end
% end 
% if ~exist_fig1
%     fig_c = figure('Name', 'Concentrations', 'Color', [1 1 1], ...
%               'Position',[0 0 1000 900]);
%     disp('fig1 created')
% end


% figure(fig_c)
cf = (1+1e-15*sin(t));
cf = 1;
scrsz = get(0,'ScreenSize');
position = [200 200 scrsz(3)-200 scrsz(4)-200];
lwidth = 2;

%%
fig1 = figure('Name', 'ATP Bilance & Main Info', 'Position', [100 100 900 1400]);
subplot(5,3,1), plot(t,v_pyr); legend('v_{pyr}',0);
%title('ATP Bilance', 'FontWeight', 'bold')
subplot(5,3,2), plot(t,v_gly_atp); legend('v_{gly_atp}',0);
subplot(5,3,3), plot(t,v_oxi_atp_cyt); legend('v_{oxi_atp_cyt}',0);

subplot(5,3,4), plot(t,v_PYREX); legend('v_{pyr_ex}',0);
subplot(5,3,5), plot(t,v_PDH); legend('v_{pdhc}',0);
subplot(5,3,6), plot(t,v_SCS_ATP); legend('v_{SCS}-ATP',0);
subplot(5,3,8), plot(t,v_cac_atp); legend('v_{cac}-atp',0);
subplot(5,3,9), plot(t,v_oxi_atp); legend('v_{oxi}-atp',0);

% WTF happens in the main pathways
subplot(5,3,10), plot(t,v_HK); legend('v_{HK}',0);
title('v Glycolysis (glc -> pyr)')
subplot(5,3,11), plot(t,v_LDH); legend('v_LDH',0);
title('v LDH (pyr -> lac)')
subplot(5,3,12), plot(t,v_PDH); legend('v_PDH',0);
title('v OxPhos pyr -> co2 + atp')

% Depending on external conditions
% glc
subplot(5,3,13),  p1 = plot(t,glc_ext, 'Color', [0.5 0.5 0.5]); hold on;
plot(t,glc); hold off;
%ylim([0 max(max(glc_ext))*1.1])
xlabel('time [s]')
ylabel('glc [mM]')
% lac
subplot(5,3,14),  p1 = plot(t,lac_ext, 'Color', [0.5 0.5 0.5] ); hold on;
p1 = plot(t,lac); hold off;
%ylim([0 max(0.1, max(max(lac_ext))*1.1)])
xlabel('time [s]')
ylabel('lac [mM]')
% o2
o2_fac = 760/1.3;   % mM -> mmHg
subplot(5,3,15),  p1=plot(t,o2_ext*o2_fac, 'Color', [0.5 0.5 0.5]); hold on;
p1=plot(t,o2*o2_fac, 'k'); hold on;
p1=plot(t,o2_mito*o2_fac, 'r'); hold off;
%ylim([0, max(max(o2_ext*o2_fac))*1.1])
xlabel('time [s]')
ylabel('o2 [mmHg]')

hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', lwidth);
haxes = findobj(gcf, 'type', 'Axes');
set(haxes, 'YGrid', 'on');
%set(haxes, 'PlotBoxAspectRatio', [1 1 1]);


%%
fig2 = figure('Name', 'Glycolysis', 'Position', position);
subplot(5,8,1), plot(t,atp.*cf); legend('ATP',0);
title('Energetic Cofactors');
subplot(5,8,2), plot(t,adp.*cf); legend('ADP',0);
subplot(5,8,3), plot(t,atp_mito.*cf,'--'); legend('ATP_{mito}',0);
subplot(5,8,4), plot(t,adp_mito.*cf,'--'); legend('ADP_{mito}',0);
subplot(5,8,5), plot(t,nad.*cf); legend('NAD',0);
subplot(5,8,6), plot(t,nadh.*cf); legend('NADH',0);
subplot(5,8,7), plot(t,nad_mito.*cf,'--'); legend('NAD_{mito}',0);
subplot(5,8,8), plot(t,nadh_mito.*cf,'--'); legend('NADH_{mito}',0);

% plot all external glc
% subplot(5,7,8),  plot(t,glc_ext); hold on;
subplot(5,7,8),  plot(t,glc.*cf); legend('Glc',0); 
title('Glykolysis: Fluxes and Concentrations'); hold off;

subplot(5,7,9),  plot(t,glc6p.*cf ); legend('Glc6P',0);
subplot(5,7,10),  plot(t,fru6p.*cf ); legend('Fru6P',0);
subplot(5,7,11), plot(t,fru16bp.*cf ); legend('Fru16BP',0);
subplot(5,7,12), plot(t,fru26bp.*cf); legend('Fru26BP',0);
subplot(5,7,13), plot(t,dhap.*cf); legend('DHAP',0);
subplot(5,7,14), plot(t,g3p.*cf); legend('GraP',0);

subplot(5,7,15), plot(t,bpg13.*cf); legend('Bpg13',0);
subplot(5,7,16), plot(t,pg3.*cf); legend('Pg3',0);
subplot(5,7,17), plot(t,pg2.*cf); legend('Pg2 ',1);
subplot(5,7,18), plot(t,pep.*cf); legend('PEP',1);
subplot(5,7,19), plot(t,pyr.*cf); legend('Pyr',1);

%subplot(5,7,20),  plot(t,lac_ext); hold on;
subplot(5,7,20), plot(t,lac.*cf);  legend('Lac',1); %hold off;

subplot(5,7,22),  plot(t,v_GLCT_in.*cf); legend('v_{GLCT_in}',0); title('Fluxes Glycolysis');
subplot(5,7,23),  plot(t,v_HK.*cf); legend('v_{HK}',0); 
subplot(5,7,24),  plot(t,v_GPI.*cf); legend('v_{GPI}',0);
subplot(5,7,25),  plot(t,v_PFK1.*cf); legend('v_{PFK1}',0);
subplot(5,7,26),  plot(t,v_PFK2.*cf); legend('v_{PFK2}',0);
subplot(5,7,27), plot(t,v_ALD.*cf); legend('v_{ALD}',0);
subplot(5,7,28), plot(t,v_TPI.*cf); legend('v_{TPI}',0);

subplot(5,7,29), plot(t,v_GAPDH.*cf); legend('v_{GAPDH}',0);
subplot(5,7,30), plot(t,v_PGK.*cf); legend('v_{PGK}',0);
subplot(5,7,31), plot(t,v_PGM.*cf); legend('v_{PGM}',0);
subplot(5,7,32), plot(t,v_ENO.*cf); legend('v_{ENO}',0);
subplot(5,7,33), plot(t,v_PK.*cf); legend('v_{PK}',0);
subplot(5,7,34), plot(t,v_LDH.*cf); legend('v_{LDH}',0);
subplot(5,7,35), plot(t,v_LDH./v_PK*100.*cf); legend('% in lactat',0);

hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);

%%
fig3 = figure('Name', 'TCA', 'Position', position);
subplot(5,6,1), plot(t,nadh_mito,'--'); legend('nadh_{mito}',0);
subplot(5,6,2), plot(t,nad_mito,'--'); legend('nad_{mito}',0);
subplot(5,6,3), plot(t,atp_mito,'--'); legend('atp_{mito}',0);
subplot(5,6,4), plot(t,adp_mito,'--'); legend('adp_{mito}',0);

subplot(5,6,7), plot(t,pyr_mito,t,pyr,'k'); legend('Pyr_{mito}','Pyr_{in}',0); title('CAC: Str�me + Konzentrationen');
subplot(5,6,8), plot(t,cit_mito); legend('Cit_{mito}',0);
subplot(5,6,9), plot(t,isocit_mito); legend('IsoCit_{mito}',0);
subplot(5,6,10), plot(t,akg_mito); legend('akg_{mito}',0);
subplot(5,6,11), plot(t,succoa_mito); legend('SucCoA_{mito}',0);
subplot(5,6,12), plot(t,suc_mito); legend('Suc_{mito}',0);

subplot(5,6,13), plot(t,fum_mito); legend('Fum_{mito}',0);
subplot(5,6,14), plot(t,mal_mito); legend('Mal_{mito}',0);
subplot(5,6,15), plot(t,oa_mito); legend('Oa_{mito}',0);
subplot(5,6,16), plot(t,acoa_mito); legend('ACoA_{mito}',0);
subplot(5,6,17), plot(t,coa_mito); legend('CoA_{mito}',0);

subplot(5,6,19), plot(t,v_PDH); legend('v_{PDH}',0);
subplot(5,6,20), plot(t,v_CS); legend('v_{CS}',0);
subplot(5,6,21), plot(t,v_ACN); legend('v_{ACN}',0);
subplot(5,6,22), plot(t,v_IDH); legend('v_{IDH}',0);
subplot(5,6,23), plot(t,v_KGDH); legend('v_{KGDH}',0);

subplot(5,6,25), plot(t,v_SCS_ATP); legend('v_{SCS}',0);
subplot(5,6,26), plot(t,v_SDH); legend('v_{SDH}',0);
subplot(5,6,27), plot(t,v_FUMR); legend('v_{FUMR}',0);
subplot(5,6,28), plot(t,v_MDHM); legend('v_{MDHM}',0);

hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);

%%
fig4 = figure('Position', position);
subplot(6,7,1), plot(t,atp); legend('atp',0);
subplot(6,7,2), plot(t,adp); legend('adp',0);
subplot(6,7,3), plot(t,atp_mito); legend('atp_{mito}',0);
subplot(6,7,4), plot(t,adp_mito); legend('adp_{mito}',0);
subplot(6,7,5), plot(t,nad_mito); legend('nad_{mito}',0);
subplot(6,7,6), plot(t,nadh_mito); legend('nadh_{mito}',0);
subplot(6,7,7), plot(t,-Vmm); legend('Vmm',0);

subplot(6,5,6), plot(t,q); legend('q',0);
subplot(6,5,7), plot(t,qh2); legend('qh2',0);
subplot(6,5,8), plot(t,cytcox); legend('cytcox',0);
subplot(6,5,9), plot(t,cytcred); legend('cytcred',0);
subplot(6,5,10), plot(t,o2); legend('o2',0);

subplot(6,5,11), plot(t,h_in); legend('h_{in}',0);
subplot(6,5,12), plot(t,cl_in); legend('cl_{in}',0);
subplot(6,5,13), plot(t,ka_in); legend('ka_{in}',0);
subplot(6,5,14), plot(t,na_in); legend('na_{in}',0);
subplot(6,5,15), plot(t,phos); legend('p_{in}',0);

subplot(6,5,16), plot(t,h_mito); legend('h_{mito}',0);
subplot(6,5,17), plot(t,cl_mito); legend('cl_{mito}',0);
subplot(6,5,18), plot(t,ka_mito); legend('ka_{mito}',0);
subplot(6,5,19), plot(t,na_mito); legend('na_{mito}',0);
subplot(6,5,20), plot(t,p_mito); legend('p_{in}',0);

subplot(6,7,29), plot(t,v_syn); legend('v_{syn}',0);
subplot(6,7,30), plot(t,v_ex); legend('v_ex',0);
subplot(6,7,31), plot(t,v_ATPUSE); legend('v_{ATPUSE}',0);
subplot(6,7,32), plot(t,v_Phos); legend('v_Phos',0);
subplot(6,7,33), plot(t,v1); legend('v1',0);
subplot(6,7,34), plot(t,v3); legend('v3',0);
subplot(6,7,35), plot(t,v4); legend('v4',0);

subplot(6,8,41), plot(t,v_oxi_nad); legend('v_{oxi}-nad',0);
subplot(6,8,42), plot(t,v_oxi_nadh); legend('v_{oxi}-nadh',0);
subplot(6,8,43), plot(t,v_cac_nad); legend('v_{cac}-nad',0);
subplot(6,8,44), plot(t,v_cac_nadh); legend('v_{cac}-nadh',0);
subplot(6,8,45), plot(t,v_oxi_q); legend('v_{oxi}-q',0);
subplot(6,8,46), plot(t,v_oxi_qh2); legend('v_{oxi}-qh2',0);
subplot(6,8,47), plot(t,v_cac_q); legend('v_{cac}-q',0);
subplot(6,8,48), plot(t,v_cac_qh2); legend('v_{cac}-qh2',0);

subplot(6,8,47), plot(t,v_cac_atp); legend('v_{cac}-atp',0);
subplot(6,8,48), plot(t,v_oxi_atp); legend('v_{oxi}-atp',0);

hline = findobj(gcf, 'type', 'line');
set(hline, 'LineWidth', 2);

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


