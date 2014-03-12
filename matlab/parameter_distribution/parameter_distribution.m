%% Handles the parameter distribution to bride from sinusoidal unit
%   to organ-scale liver model;

%   Matthias Koenig (2014-03-11)
%   Copyright Matthias Koenig 2014 All Rights Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the mean distribution (p has to be defined)
p.name = 'Galactose'; 
p.version = 3;
p.Nc = 1;
p.Nf = 5;
p.id = strcat(p.name, '_v', num2str(p.version), '_Nc', num2str(p.Nc), '_Nf', num2str(p.Nf));

p = pars_layout(p, false);

% Create the random distributions
N = 1000;
names = {'L_{sinusoid} [�m]'
        'y_{sinusoid} [�m]'
        'y_{disse} [�m]'
        'y_{cell} [�m]'
        'v_{blood} [�m/s]'};
data = zeros(N, length(names));

% Creates the random distribution of parameters
for k=1:N
    ptmp = pars_layout(p, true);
    data(k, 1) = ptmp.L;
    data(k, 2) = ptmp.y_sin;
    data(k, 3) = ptmp.y_dis;
    data(k, 4) = ptmp.y_cell;
    data(k, 5) = ptmp.flow_sin;
end
data = data * 1E6;

% Combining results with certain values based on the parameter
% distributions
% Normalize
data = data;


%% plots
fig1 = figure('Name', 'Parameter Distribution', 'Color', [1 1 1], 'Position', [0 0 1800 700]);
for k=1:numel(names)
    subplot(1, numel(names), k);
    hist(data(:, k), 20); 
    histfit(data(:,k), 20, 'kernel')
    xlabel(names{k}, 'FontWeight', 'bold');
    ylabel('count', 'FontWeight', 'bold'); 
    axis square
end
set(fig1, 'PaperPositionMode', 'auto');

print(fig1, '-dtiff', '-r150', 'parameter_distribution_01.tif'); 

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
print(fig2, '-dtiff', '-r150', 'parameter_distribution_02.tif');





         

