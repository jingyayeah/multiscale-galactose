%% Handles the parameter distribution to bride from sinusoidal unit
%   to organ-scale liver model;

%   Matthias Koenig (2013-10-14)
%   Copyright © Matthias König 2013 All Rights Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the mean distribution
p = pars_layout(false);

% Get random distributions
N = 1000;
names = {'L_{sinusoid} [µm]'
        'y_{sinusoid} [µm]'
        'y_{disse} [µm]'
        'y_{cell} [µm]'
        'v_{blood} [µm/s]'};
data = zeros(N, length(names));


for k=1:N
    ptmp = pars_layout(true);
    data(k, 1) = ptmp.L;
    data(k, 2) = ptmp.y_sin;
    data(k, 3) = ptmp.y_dis;
    data(k, 4) = ptmp.y_cell;
    data(k, 5) = ptmp.flow_sin;
end
data = data * 1E6;

% plot
fig1 = figure('Name', 'Parameter Distribution', 'Color', [1 1 1], 'Position', [0 0 1800 700]);
for k=1:numel(names)
    subplot(1, numel(names), k);
    hist(data(:, k), 20);
    xlabel(names{k}, 'FontWeight', 'bold');
    ylabel('count', 'FontWeight', 'bold'); 
    axis square
end
set(fig1, 'PaperPositionMode', 'auto');
print(fig1, '-dtiff', '-r150', 'organ_scale/parameters_01.tif'); 

fig2 = figure('Name', 'Parameter Distribution 2', 'Color', [1 1 1], 'Position', [0 0 1800 1800]);
count = 1;
for k=1:numel(names)
    for j=1:numel(names)
        subplot(numel(names), numel(names), count);
        p1 = plot(data(:, j), data(:, k), 'o', 'Color', [0.2 0.2 0.2], 'MarkerSize',3);
        xlabel(names{j}, 'FontWeight', 'bold');
        ylabel(names{k}, 'FontWeight', 'bold');
        axis square
        count = count +1;
    end
end
set(fig2, 'PaperPositionMode', 'auto');
print(fig2, '-dtiff', '-r150', 'organ_scale/parameters_02.tif'); 





         

