clear all, close all
name = 'steady_state_response'
fprintf('* Figures: %s.mat\n', name);
load(sprintf('./results/%s.mat', name));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Steady state reached in all conditions ?
Nglc = numel(glc)
Nglyc = numel(glyc)

v_tmp = res.v{1,1};
t_tmp = res.t{1,1};
hgp_tmp = v_tmp(:,1);   % GLUT2
gng_tmp = v_tmp(:,4);   % D-Glucose-6-phosphate Isomerase
gly_tmp = v_tmp(:,5);   % Glucose 1-phosphate 1,6-phosphomutase

fig0 = figure();
subplot(1,3,1)
plot(t_tmp, hgp_tmp);
subplot(1,3,2)
plot(t_tmp, gng_tmp);
subplot(1,3,3)
plot(t_tmp, gly_tmp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% plot the response curves
fig1 = figure('Name', 'Koenig2012_SS_Response', 'Color', [1 1 1], ...
             'Position', [100 0 1200 400]);

% plot all the single glycogen curves
for k_glyc = 1:Nglyc

    % Steady state flux vectors depending on glucose
    hgp = zeros(Nglc, 1);
    gng = zeros(Nglc, 1);
    gly = zeros(Nglc, 1);
    for k_glc = 1:Nglc
        v = res.v{k_glc, k_glyc};
        hgp(k_glc, 1) = v(end,1);   % GLUT2
        gng(k_glc, 1) = v(end,4);   % D-Glucose-6-phosphate Isomerase
        gly(k_glc, 1) = v(end,5);   % Glucose 1-phosphate 1,6-phosphomutase
    end
    
    % glycogen dependent color
    pcolor = [0.1 0.1 0.1] + 0.6*[1 1 1]*k_glyc/Nglyc;
    
    % HGP/HGU
    subplot(1,3,1)
    plot(glc, hgp, '-o', 'Color', pcolor)
    title('HGP/HGU')
    xlabel('glucose [mmol/L]')
    ylabel('HGP/HGU [µmol/kg/min]')
    hold on;
    
     % GNG/GLY
    subplot(1,3,2)
    plot(glc, gng, '-o', 'Color', pcolor)
    title('GNG/GLY')
    xlabel('glucose [mmol/L]')
    ylabel('GNG/GLY [µmol/kg/min]')
    hold on;
    
    % /HGU
    subplot(1,3,3)
    
    plot(glc, gly, '-o', 'Color', pcolor)
    title('GLY/GLYN')
    xlabel('glucose [mmol/L]')
    ylabel('GlY/GLYN [µmol/kg/min]')
    hold on;
end

%hline = findobj(gcf, 'type', 'line');
%set(hline, 'LineWidth', 2);
haxes = findobj(gcf, 'type', 'axes');
for k=1: numel(haxes)
    ax = haxes(k);
    set(gcf, 'CurrentAxes', ax);
    set(gca, 'FontWeight', 'bold');
    tit = get(gca, 'Title');
    set(tit, 'FontWeight', 'bold', 'FontSize', 12)
    set(get(ax, 'XLabel'), 'FontWeight', 'bold')
    set(get(ax, 'YLabel'), 'FontWeight', 'bold')
    axis square
end
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', sprintf('./results/%s.tif', name)); 

