function [] = fig_cell(p)

% Use the solution structures to generate the actual timecourses
t_total = 0;
t = [];
x = [];
for k_sim = 1:size(p.c_sim, 1)
    % if the solution for the simulation should be part of the plotted
    % timecourse
    tend = p.c_sim{k_sim, 2};
    if p.c_sim{k_sim, 6}
        sol = p.sol{k_sim};
        % dtmp = 10;                  % step size for generating the solution
        % t_sim = [0:dtmp:tend]';
        t_sim = (sol.x)';                % use provided stepsize by solver
        x_sim = deval(sol, t_sim);
        
        t = [t 
             t_sim+t_total];
        x = [x 
             x_sim'];
        t_total = t_total+tend;
    end
end

% Data for figures
p.Nt = length(t);
dxdt = zeros(size(x));

for k=1:p.Nt
   dxdt(k,:) = p.odefun(t(k),x(k,:)', p); 
end

% Get complete information for the integration
% [1] solution concentrations -> get all the names from x_names
glc_ext = zeros(p.Nt, p.Nb,1);
lac_ext = zeros(p.Nt, p.Nb,1);
o2_ext  = zeros(p.Nt, p.Nb,1);
dx_glc_ext = zeros(size(glc_ext));
dx_lac_ext = zeros(size(lac_ext));
dx_o2_ext = zeros(size(o2_ext));

for ci=1:p.Nc
   glc_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc         +1:p.Nx_out +  (ci-1)*p.Nxc + p.Nf); 
   lac_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc +   p.Nf+1:p.Nx_out +  (ci-1)*p.Nxc + 2*p.Nf); 
   o2_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc + 2*p.Nf+1: p.Nx_out + (ci-1)*p.Nxc + 3*p.Nf); 
   dx_glc_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = dxdt(:, p.Nx_out + (ci-1)*p.Nxc         +1:p.Nx_out +  (ci-1)*p.Nxc + p.Nf); 
   dx_lac_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = dxdt(:, p.Nx_out + (ci-1)*p.Nxc +   p.Nf+1:p.Nx_out +  (ci-1)*p.Nxc + 2*p.Nf); 
   dx_o2_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = dxdt(:, p.Nx_out + (ci-1)*p.Nxc + 2*p.Nf+1: p.Nx_out + (ci-1)*p.Nxc + 3*p.Nf); 
end

for k=1:p.Nx_in
   eval([p.x_names{p.Nx_out+k} ' = x(:,p.Nx_out + p.Nx_out*p.Nf + k: p.Nxc : end);'])
   eval(['dx_' p.x_names{k+p.Nx_out} ' = dxdt(:, p.Nx_out + p.Nx_out*p.Nf + k: p.Nxc : end);']) 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [3] Get additional fluxes from the integration routines
% These fluxes are defined in the subintegration routine for the modules
% TODO: readout of interesting fluxes
% Get the model fluxes

v_funcs = {@cell_glycolysis
           @cell_cac
           @cell_osmoelectro
           @cell_oxi};
for kf = 1:length(v_funcs)
    fun = v_funcs{kf};
    [~, v_names, ~] = fun(0, p.x0, p);
    v_tmp = zeros(p.Nt, p.Nc, numel(v_names));
    for k=1:p.Nt
        [~, ~, tmp] = fun(t(k), x(k,:)', p); 
        v_tmp(k,:) = tmp;
    end
    for k=1:numel(v_names)
        eval([v_names{k} ' = v_tmp(:,k);']) 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create figures only if not existing
handles=findall(0,'type','figure');
exist_fig1 = false;
for k = 1:numel(handles)
    name = get(figure(handles(k)), 'Name');
    if strcmp(name, 'Concentrations')
        exist_fig1 = true;
        fig_c = handles(k);
    end
end 
if ~exist_fig1
    fig_c = figure('Name', 'Concentrations', 'Color', [1 1 1], ...
              'Position',[0 0 1000 900]);
    disp('fig1 created')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fig1 concentrations
figure(fig_c)

%fig1 = figure;
subplot(6,6,1), plot(t,atp,'r',t,atp_mito,'r--',t,adp,'b',t,adp_mito,'b--'); legend('ATP','ADP',0);
subplot(6,6,2), plot(t,Vol_cell,'g'); legend('Vol_{zelle}',0);
subplot(6,6,3), plot(t,glc_ext,'g',t,lac_ext,'m',t,o2_ext,'b'); legend('glc_{ext}','lac_{ext}','O2_{ext}',0);
subplot(6,6,4), plot(t,nadh_mito,'r--',t,nadh,'r',t,nad_mito,'b--',t,nad,'b'); legend('nadh','nad',0);
subplot(6,6,5), plot(t,q,'b',t,qh2,'r',t,cytcox,'y',t,cytcred,'g'); legend('q','qh2','cytcox','cytcred',0);
subplot(6,6,6), plot(t,v_ex,'r'); legend('v_{ex}',0);

% 
% subplot(6,13,14),  plot(t,glc,'g' , t_const,2.4*ones(size(t_const)),'g' ); legend('Glc',0); title('Glykolyse: Str�me + Konzentrationen');
% subplot(6,13,15),  plot(t,glc6p,'m' ,t_const,0.12*ones(size(t_const)),'m' ); legend('Glc6P',0);
% subplot(6,13,16),  plot(t,fru6p,'r' ,t_const,0.03*ones(size(t_const)),'r' ); legend('Fru6P',0);
% subplot(6,13,17), plot(t,fru16bp,'k' ,t_const,0.05*ones(size(t_const)),'k' ); legend('Fru16P',0);
% subplot(6,13,18), plot(t,fru26bp,'k' ,t_const,0.05*ones(size(t_const)),'k' ); legend('Fru26P',0);
% subplot(6,13,19), plot(t,dhap,'c' ,t_const,0.3*ones(size(t_const)),'c' ); legend('DhaP',0);
% subplot(6,13,20), plot(t,g3p,'y' ,t_const,0.015*ones(size(t_const)),'y' ); legend('G3P',0);
% subplot(6,13,21), plot(t,bpg13,'g' ,t_const,0.0015*ones(size(t_const)),'g' ); legend('Bpg13',0);
% subplot(6,13,22), plot(t,pg3,'m' ,t_const,0.3*ones(size(t_const)),'m' ); legend('Pg3',0);
% subplot(6,13,23), plot(t,pg2,'r' ,t_const,0.06*ones(size(t_const)),'r' ); legend('Pg2 ',1);
% subplot(6,13,24), plot(t,pep,'r' ,t_const,0.03*ones(size(t_const)),'r' ); legend('Pep',1);
% subplot(6,13,25), plot(t,pyr,'m' ,t_const,0.15*ones(size(t_const)),'m' ); legend('Pyr',1);
% subplot(6,13,26), plot(t,lac,'m' ,t_const,1.5*ones(size(t_const)),'r' ); legend('Lac',1);

subplot(6,13,14),  plot(t,glc,'g'  ); legend('Glc',0); title('Glykolyse: Str�me + Konzentrationen');
subplot(6,13,15),  plot(t,glc6p,'m' ); legend('Glc6P',0);
subplot(6,13,16),  plot(t,fru6p,'r' ); legend('Fru6P',0);
subplot(6,13,17), plot(t,fru16bp,'k' ); legend('Fru16P',0);
subplot(6,13,18), plot(t,fru26bp,'k'  ); legend('Fru26P',0);
subplot(6,13,19), plot(t,dhap,'c'  ); legend('DhaP',0);
subplot(6,13,20), plot(t,g3p,'y'); legend('G3P',0);
subplot(6,13,21), plot(t,bpg13,'g'); legend('Bpg13',0);
subplot(6,13,22), plot(t,pg3,'m' ); legend('Pg3',0);
subplot(6,13,23), plot(t,pg2,'r' ); legend('Pg2 ',1);
subplot(6,13,24), plot(t,pep,'r' ); legend('Pep',1);
subplot(6,13,25), plot(t,pyr,'m' ); legend('Pyr',1);
subplot(6,13,26), plot(t,lac,'m' ); legend('Lac',1);


subplot(6,13,27),  plot(t,v_Glc_ex,'k'); legend('v_{Glc-ex}',0); title('Glykolysestr�me');
subplot(6,13,28),  plot(t,v_hexk ,'g'); legend('v_{hexk}',0); 
subplot(6,13,29),  plot(t,v_Glc6PIso,'m'); legend('v_{Glc6PIso}',0);
subplot(6,13,30),  plot(t,v_PhofrukI,'r'); legend('v_{PhofrukI}',0);
subplot(6,13,31),  plot(t,v_PhofrukII,'b'); legend('v_{PhofrukII}',0);
subplot(6,13,32), plot(t,v_aldo,'k'); legend('v_{aldo}',0);
subplot(6,13,33), plot(t,v_TPI ,'c'); legend('v_{TPI}',0);
subplot(6,13,34), plot(t,v_GaPDh,'y'); legend('v_{GaPDh}',0);
subplot(6,13,35), plot(t,v_PgK,'g'); legend('v_{PgK}',0);
subplot(6,13,36), plot(t,v_PgM ,'m'); legend('v_{PgM}',0);
subplot(6,13,37), plot(t,v_Eno ,'r'); legend('v_{Eno}',0);
subplot(6,13,38), plot(t,v_PyrK,'r'); legend('v_{PyrK}',0);
subplot(6,13,39), plot(t,v_LacDh,'m'); legend('v_{LacDh}',0);

subplot(6,11,34), plot(t,pyr_mito,'r',t,pyr,'k'); legend('Pyr_{mito}','Pyr_{in}',0); title('CAC: Str�me + Konzentrationen');
subplot(6,11,35), plot(t,cit_mito,'g'); legend('Cit_{mito}',0);
subplot(6,11,36), plot(t,isocit_mito,'m'); legend('IsoCit_{mito}',0);
subplot(6,11,37), plot(t,akg_mito,'r'); legend('akg_{mito}',0);
subplot(6,11,38), plot(t,succoa_mito,'k'); legend('SucCoA_{mito}',0);
subplot(6,11,39), plot(t,suc_mito,'y'); legend('Suc_{mito}',0);
subplot(6,11,40), plot(t,fum_mito,'c'); legend('Fum_{mito}',0);
subplot(6,11,41), plot(t,mal_mito,'g'); legend('Mal_{mito}',0);
subplot(6,11,42), plot(t,oa_mito,'m'); legend('Oa_{mito}',0);
subplot(6,11,43), plot(t,acoa_mito,'r'); legend('ACoA_{mito}',0);
subplot(6,11,44), plot(t,coa_mito,'r'); legend('CoA_{mito}',0);

subplot(6,9,37), plot(t,v_pdhc,'g'); legend('v_{pdhc}',0);
subplot(6,9,38), plot(t,v_cs,'g'); legend('v_{cs}',0);
subplot(6,9,39), plot(t,v_ac,'m'); legend('v_{ac}',0);
subplot(6,9,40), plot(t,v_icdh,'r'); legend('v_{icdh}',0);
subplot(6,9,41), plot(t,v_akdhc,'k'); legend('v_{akdhc}',0);
subplot(6,9,42), plot(t,v_succoas_atp,'y'); legend('v_{succoas}',0);
subplot(6,9,43), plot(t,v_succdh,'c'); legend('v_{succdh}',0);
subplot(6,9,44), plot(t,v_fum,'g'); legend('v_{fum}',0);
subplot(6,9,45), plot(t,v_mdh,'m'); legend('v_{mdh}',0);
% 
% % subplot(6,4,9), plot(t,Em_N,'g'); legend('Em_N',0);
% % subplot(6,4,10), plot(t,Em_Q,'b'); legend('Em_Q',0);
% % subplot(6,4,11), plot(t,Em_C,'m'); legend('Em_C',0);
% 
% subplot(6,6,31), plot(t,dG1,'g'); legend('dG1',0);
% subplot(6,6,32), plot(t,dG3,'b'); legend('dG3',0);
% subplot(6,6,33), plot(t,v_c1,'g'); legend('v_{c1}',0);
% subplot(6,6,34), plot(t,v_c2_cac,'y'); legend('v_{c2}',0);
% subplot(6,6,35), plot(t,v_c3,'b'); legend('v_{c3}',0);
% subplot(6,6,36), plot(t,v_c4,'m'); legend('v_{c4}',0);

subplot(6,8,41), plot(t,nadh_mito,'r--'); legend('nadh_{mito}',0);
subplot(6,8,42), plot(t,nad_mito,'b--'); legend('nad_{mito}',0);
subplot(6,8,43), plot(t,nadh,'r'); legend('nadh',0);
subplot(6,8,44), plot(t,nad,'b'); legend('nad',0);

subplot(6,8,45), plot(t,v_pdhc,'r'); legend('v_{pdhc}',0);
subplot(6,8,46), plot(t,v_mdh,'b'); legend('v_{mdh}',0);
subplot(6,8,47), plot(t,v_akdhc,'g'); legend('v_{akdhc}',0);
subplot(6,8,48), plot(t,v_icdh,'y'); legend('v_{icdh}',0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
