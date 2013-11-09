function [] = fig_response(sim_name)
% Figure for the system response to the external glucose, lactate and o2
% concentrations.
%   author: Matthias Koenig
%   date: 110917
close all;

% load the solution from 'sim_cell_response'
load(strcat('./data/', sim_name));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General information about integration
% plot integration success
fig1 = figure('Name', 'ODE Success', 'Color', [1 1 1]);
    counter = 0;
    for ko = 1:numel(p.o2)
        counter = counter + 1;
        subplot(3, numel(p.o2), counter);
        data = res_odesuccess(:,:, ko);
        pcolor(p.lac, p.glc, data);
        title(strcat('Success O2: ', num2str(p.o2(ko)), ' mM' ));
        xlabel('Lactate [mM]');
        ylabel('Glucose [mM]');
        axis square
        colorbar
    end
% plot integration time
% fig2 = figure('Name', 'ODE TOC Integration Time', 'Color', [1 1 1]);
    counter = 0;
    for ko = 1:numel(p.o2)
        counter = counter + 1;
        subplot(3, numel(p.o2), numel(p.o2) + counter);
        data = res_odetoc(:,:, ko);
        pcolor(p.lac, p.glc, data);
        title(strcat('TOC O2: ', num2str(p.o2(ko)), ' mM' ));
        xlabel('Lactate [mM]');
        ylabel('Glucose [mM]');
        axis square
        colorbar
        caxis([0 4])
    end
% plot integration abort time
%fig3 = figure('Name', 'ODE Abort Time', 'Color', [1 1 1]);
    counter = 0;
    for ko = 1:numel(p.o2)
        counter = counter + 1;
        subplot(3, numel(p.o2), 2*numel(p.o2) + counter);
        data = res_odetend(:,:, ko);
        pcolor(p.lac, p.glc, data);
        title(strcat('ODE Abort time O2: ', num2str(p.o2(ko)), ' mM' ))
        xlabel('Lactate [mM]')
        ylabel('Glucose [mM]')
        axis square
        colorbar
        caxis([0 p.tend])
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot interesting concentrations

% [1] solution concentrations
for k=1:length(p.x_names)
   eval([p.x_names{k} ' = res_x(:,:,:,k);'])
end
% now the names for all concentrations are defined
% disp('atp')
% atp(:,:,1)'


fig2 = figure('Name', 'Concentrations', 'Color', [1 1 1]);
x_plot = {'atp', 'adp', 'glc', 'lac', 'o2', 'pyr'};
counter = 0;
for kn = 1:numel(x_plot)
    eval([ 'data =' x_plot{kn} ';']);
    for ko = 1:numel(p.o2)
        counter = counter + 1;    
        subplot(numel(x_plot), numel(p.o2), counter);
        data_o2 = data(:,:,ko);
        pcolor(p.lac, p.glc, data_o2);
        title(strcat(x_plot(kn)','with O2: ', num2str(p.o2(ko)), ' mM' ))
        xlabel('Lactate [mM]')
        ylabel('Glucose [mM]')
        %axis square
        colorbar
    end
end
