
% [2] Get additional fluxes from the integration routines
% These fluxes are defined in the subintegration routine for the modules

v_funcs = {@cell_glycolysis
           @cell_cac
           @cell_osmoelectro
           @cell_oxi};
for kf = 1:length(v_funcs)
    fun = v_funcs{kf};
    % only use the concentrations for the first cell
    [~, v_names, ~] = fun(0, p.x0(p.Nx_out+1:p.Nx_out+p.Nxc), p);
    v_tmp = zeros(p.Nt, p.Nc, numel(v_names));
    for ci = 1:p.Nc
        for k=1:p.Nt
            xc = x(k, p.Nx_out+ (ci-1)*p.Nxc + 1: p.Nx_out + ci*p.Nxc);
            [~, ~, tmp] = fun(t(k), xc', p);
            v_tmp(k, ci, :) = tmp;
        end
    end
    for k=1:numel(v_names)
        eval([v_names{k} ' = v_tmp(:,:,k);']) 
    end
end

ealpha = 0;
compartments = (1:p.Nb) * p.d_blood * 1E6;
cells        = (1:p.Nc); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fig1: Concentrations time courses 
% depending if single cell or array of cells the figures are changed
% so that an optimal view is generated
fig1 = figure('Name', 'Concentrations', 'OuterPosition', [1920 700 1200 500]);
colormap('hot')

ro = 'r-o';     ko = 'k-o';     bo = 'b-o';     go = 'g-o';
rno = 'r-';    kno = 'k-';    bno = 'b-';       gno = 'b-';
ccolor = [0.3, 0.3, 0.3];
clines = -1:1:10;

if (p.Nc > 1)
    % external
    for k=1:p.Nx_out
        subplot(3,p.Nx_out,k)
        switch k
            case 1
                p1 = pcolor(compartments, t, glc_ext);
                title('Glucose extern [mM]');
            case 2
                p1 = pcolor(compartments, t, lac_ext);
                title('Lactate extern [mM]');
            case 3
                p1 = pcolor(compartments, t, o2_ext);
                title('O2 extern [mM]');
        end
        set(p1, 'EdgeAlpha', ealpha)
        xlabel(strcat('L [µm]'))
        ylabel('t [s]')
        colorbar()
        axis square
    end
    % internal
    for k=4:9
        subplot(3,p.Nx_out,k)
        switch k
            case 4
                p1 = pcolor(cells, t, glc);
                title('Glucose [mM]');
            case 5
                p1 = pcolor(cells, t, lac);
                title('Lactate [mM]');
            case 6        
                p1 = pcolor(cells, t, o2);
                title('O2 [mM]');
            case 7
                p1 = pcolor(cells, t, pyr);
                title('Pyruvate [mM]');
            case 8
                p1 = pcolor(cells, t, atp);
                title('ATP [mM]');
            case 9
                p1 = pcolor(cells, t, adp);
                title('ADP [mM]');
        end
        set(p1, 'EdgeAlpha', ealpha)
        xlabel(strcat('cell'))
        ylabel('t [s]')
        colorbar()
        axis square
    end
    
elseif (p.Nc == 1)
    for k=1:5
        subplot(2,3,k)
        switch k
            case 1
                p1 = plot(t, glc, ro, t, glc_ext, ko);
                title('Glc[r], Glc_{ext}[k]', 'FontWeight', 'bold');
                %ylim([-0.1 6])
                set(gca, 'Color', [0.94 0.94 0.94])
            case 2
                p1 = plot(t, lac, ro, t, lac_ext, ko);
                title('Lac[r], Lac_{ext}[k]', 'FontWeight', 'bold');
                %ylim([-0.1 8])
                set(gca, 'Color', [0.94 0.94 0.94])
            case 3        
                p1 = plot(t, o2, ro, t, o2_ext, ko);
                title('O2[r], O2_{ext}[k]', 'FontWeight', 'bold');
                %ylim([-0.1 2])
                set(gca, 'Color', [0.94 0.94 0.94])
            case 4
                p1 = plot(t, pyr, ro);
                title('Pyruvate', 'FontWeight', 'bold');
                %ylim([-0.1 3])
            case 5
                p1 = plot(t, atp, bo, t, adp, go);
                title('ATP [b], ADP [g]', 'FontWeight', 'bold');
                ylim([-0.1 4])
                % legend({'ATP', 'ADP', 'ATP+ADP'})
                legend({'ATP', 'ADP'})

        end
        xlabel(strcat('t [s]'))
        ylabel('c [mM]')
        %axis square
        grid on
        xlim([0 t(end)])
       set(p1, 'MarkerSize', 2.5)
       set(p1, 'LineWidth', 1.5)
    end
end

%% Fluxes
fig2 = figure('Name', 'Fluxes', 'OuterPosition', [1920 0 1200 500]);
if (p.Nc == 1)
    for k=1:6
        subplot(2,3,k)
        switch k
            case 1
                p1 = plot(t, v_syn, bo);
                title('v ATP synthesis', 'FontWeight', 'bold');
            case 2
                p1 = plot(t, v_ATP_use, ro);
                title('v ATP use', 'FontWeight', 'bold'); 
            case 3   
                p1 = plot(t, v_oxi_atp, ko);
                title('v oxi ATP', 'FontWeight', 'bold');
            case 4
                p1 = plot(t, v_Eno, ro);
                title('v Glycolysis', 'FontWeight', 'bold');
            case 5
                p1 = plot(t, v_LacDh, ro);
                title('v LDH', 'FontWeight', 'bold');
            
        end
        xlabel(strcat('time[s]'))
        ylabel('v [mM/s]')
        % axis square
        grid on
        xlim([0 t(end)])
        set(p1, 'MarkerSize', 2.5)
        set(p1, 'LineWidth', 1.5)
    end
end


create_video = false;
if ~create_video

%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FIG3: plot the internal fluxes in the cells if cells were in the simulation
figure(3);
for k=1:9
    subplot(3,3,k) 
    eval(['data = ' v_names_cs{k} ';']) 
    p1 = pcolor(cells, t, data);
    
    set(p1, 'EdgeAlpha', ealpha)
    title(strrep(v_names_cs{k}, '_', ' '))
    xlabel(strcat('cell'))
    ylabel('t [s]')
    colorbar()
    axis square
end
%}
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate video of the data
if create_video
    
    close all
    figure('Name', 'Video', 'Color', [1 1 1], 'Position', [2363  119 1477 1000])
    for tk = 1:numel(t)
        t(tk)
        % create frame
        clf    
        % Get the correct slice of the data
        tk_e = tk+100;
        if tk_e > numel(t)
            break;
        end
        t_c = t(tk:tk_e);
        
        glc_ext_c = glc_ext(tk:tk_e,:);
        lac_ext_c = lac_ext(tk:tk_e,:);
        o2_ext_c  = o2_ext(tk:tk_e,:);
        glc_c = glc(tk:tk_e,:);
        lac_c = lac(tk:tk_e,:);
        o2_c  = o2(tk:tk_e,:);
        atp_c = atp(tk:tk_e,:);
        adp_c = adp(tk:tk_e,:);
        pyr_c = pyr(tk:tk_e,:);
    
    % External Concentrations
    for k=1:3
        subplot(4,3, k)
        switch k
           case 1 
            p1 = plot(t_c, glc_ext_c(:,1), 'k-o');
            title('Glucose extern', 'FontWeight', 'bold')
            ylim([ min(min(glc_ext)) max(max(glc_ext))] )
            xlim([t_c(1), t_c(end)]);
           case 2
            p1 = plot(t_c, lac_ext_c(:,1), 'k-o');
            title('Lactate extern', 'FontWeight', 'bold')
            ylim([ min(min(lac_ext)) max(max(lac_ext))] )
             xlim([t_c(1), t_c(end)]);
           case 3
            p1 = plot(t_c, o2_ext_c(:,1), 'k-o');
            title('O2 extern', 'FontWeight', 'bold')
            ylim([ min(min(o2_ext)) max(max(o2_ext))] )
             xlim([t_c(1), t_c(end)]);
        end
        axis square
        
        xlabel('t [s]')
        ylabel('c [mM]')
        set(gca, 'Color', [0.94 0.94 0.94])
        set(p1, 'MarkerSize', 2.5)
        set(p1, 'LineWidth', 1.5)
    end
    % Concentration information
    for k=4:12
        subplot(4,3,k)
        switch k
            case 4
                p1 = pcolor(compartments, t_c, glc_ext_c);
                title('Glucose extern [mM]');
                caxis([0 max(max(glc_ext))])
                xlabel(strcat('L [µm]'))
            case 5
                p1 = pcolor(compartments, t_c, lac_ext_c);
                title('Lactate extern [mM]');
                caxis([0 max(max(lac_ext))])
                xlabel(strcat('L [µm]'))
            case 6
                p1 = pcolor(compartments, t_c, o2_ext_c);
                title('O2 extern [mM]');
                caxis([0 max(max(o2_ext))])
                xlabel(strcat('L [µm]'))
            case 7
                p1 = pcolor(cells, t_c, glc_c);
                title('Glucose [mM]');
                caxis([0 max(max(glc))])
                xlabel(strcat('cell'))
            case 8
                p1 = pcolor(cells, t_c, lac_c);
                title('Lactate [mM]');
                caxis([0 max(max(lac))])
                xlabel(strcat('cell'))
            case 9        
                p1 = pcolor(cells, t_c, o2_c);
                title('O2 [mM]');
                caxis([0 max(max(o2))])
                xlabel(strcat('cell'))
            case 10
                p1 = pcolor(cells, t_c, pyr_c);
                title('Pyruvate [mM]');
                caxis([0 max(max(pyr))])
                xlabel(strcat('cell'))
            case 11
                p1 = pcolor(cells, t_c, atp_c);
                title('ATP [mM]');
                caxis([0 max(max(atp+adp))])
                xlabel(strcat('cell'))
            case 12
                p1 = pcolor(cells, t_c, adp_c);
                title('ADP [mM]');
                caxis([0 max(max(atp+adp))])
                xlabel(strcat('cell'))
        end
        set(p1, 'EdgeAlpha', ealpha)
        ylabel('t [s]')
        colorbar()
        axis square
    end
    drawnow
    set(gcf,'PaperPositionMode','auto')
    
    if tk<10
        number = strcat('000', int2str(tk));
    elseif tk<100
        number = strcat('00', int2str(tk));
    elseif tk<1000
        number = strcat('0', int2str(tk));
    elseif tk<10000
        number = int2str(tk);
    end
    saveas(gcf, strcat('./video/vid1_', number, '.png'));
    
    end
end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fig3: DXDT
%{
fig3 = figure('Name', 'dxdt', 'Color', [1 1 1]);
% plot the external
for k=1:p.Nx_out
    subplot(3,p.Nx_out,k)
    switch k
        case 1
            p1 = pcolor(compartments, t, dx_glc_ext);
            title('dxdt Glucose extern [mM]');
        case 2
            p1 = pcolor(compartments, t, dx_lac_ext);
            title('dxdt Lactate extern [mM]');
        case 3
            p1 = pcolor(compartments, t, dx_o2_ext);
            title('dxdt O2 extern [mM]');
    end
    set(p1, 'EdgeAlpha', ealpha)
    xlabel(strcat('L [µm]'))
    ylabel('t [s]')
    colorbar()
    axis square
end
% plot internal
for k=4:9
    subplot(3,p.Nx_out,k)
    switch k
        case 4
            p1 = pcolor(cells, t, dx_glc);
            title('dxdt Glucose [mM]');
        case 5
            p1 = pcolor(cells, t, dx_lac);
            title('dxdt Lactate [mM]');
        case 6        
            p1 = pcolor(cells, t, dx_o2);
            title('dxdt O2 [mM]');
        case 7
            p1 = pcolor(cells, t, dx_pyr);
            title('dxdt Pyruvate [mM]');
        case 8
            p1 = pcolor(cells, t, dx_atp);
            title('dxdt ATP [mM]');
        case 9
            p1 = pcolor(cells, t, dx_adp);
            title('dxdt ADP [mM]');
    end
    set(p1, 'EdgeAlpha', ealpha)
    xlabel(strcat('cell'))
    ylabel('t [s]')
    colorbar()
    axis square
end
%}