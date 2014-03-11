function [x_names, x_init, Nx_out, x_neg, x_ind, x_unit, Ddata, x_gal] = pars_galactose_metabolism()
%% PARS_GALACTOSE_METABOLISM - Inital conditions for galactose model.
%   x_names:  vector of variable names
%   x_init: vector of initial conditions
%   x_units:  vector of 

%   Copyright Matthias Koenig 2014 All Rights Reserved.

% TODO: calculate Nx_out based on the named variables.
Nx_out = 6;
% Name, init, nonnegative, unit, 2h gal challenge 
data = {
    'rbcM_sin',            0.0,    0,  '?',  NaN  % 1
    'suc_sin',             0.0,    0,  'mM', NaN % 2
    'alb_sin',             0.0,    0,  'mM', NaN % 3
    'gal_sin',             0.00012, 0,  'mM', NaN % 4
    'galM_sin',            0.0,    0,  'mM', NaN % 5
    'h2oM_sin',            0.0,    0,  'mM', NaN % 6
    
    'rbcM_dis',            0.0,    0,  '?',  NaN  % 1
    'suc_dis',             0.0,    0,  'mM', NaN % 2
    'alb_dis',             0.0,    0,  'mM', NaN % 3
    'gal_dis',             0.00012, 0,  'mM', NaN % 4
    'galM_dis',            0.0,    0,  'mM', NaN % 5
    'h2oM_dis',            0.0,    0,  'mM', NaN % 6
    
    'gal',             0.00012, 0,  'mM', NaN % 1
    'galM',            0.0,     0,  'mM', NaN % 2
    'h2oM',            0.0,     0,  'mM', NaN % 3
    'glc1p',           0.012,   0,  'mM', 0.011 % 4
    'glc6p',           0.12,    0,  'mM', 0.29 % 5
    'gal1p',           0.001,   0,  'mM', 0.20 % 6
    'udpglc',          0.34,    0,  'mM', 0.27 % 7
    'udpgal',          0.11,    0,  'mM', 0.36 % 8
    'galtol',          0.001,   0,  'mM', NaN % 9
    
    'atp',              2.7,    0,  'mM', 2.9 % 10
    'adp',              1.2,    0,  'mM', 1.0 % 11
    'utp',              0.27,   0,  'mM', NaN % 12
    'udp',              0.09,   0,  'mM', NaN % 13
    'phos',             5.0,    0,  'mM', NaN % 14
    'ppi',              0.008,  0,  'mM', NaN % 15
    'nadp',             0.1,    0,  'mM', NaN % 16
    'nadph',            0.1,    0,  'mM', NaN % 17
};
% add the indices
for k=1:length(data)
    data{k,6} = k;
end
fprintf('\n# METABOLIC CELL MODEL #\n')
data

% Diffusion coefficients [µm^2/s] -> [m^2/s]
Ddata = [             
           0       % [1] RBCM
         400       % [2] suc
         100       % [3] albuminM
         400       % [4] gal
         400       % [5] galM
        2000       % [6] h20M
]*1E-12;


x_names = data(:,1);
x_init  = containers.Map(x_names, cell2mat(data(:,2)));
x_gal  = containers.Map(x_names, cell2mat(data(:,5)));
x_ind    = containers.Map(x_names, [1:length(x_names)]);
x_unit = data(:,4);

x_neg = containers.Map('KeyType', 'int32', 'ValueType', 'logical');
for k=1:length(x_names)
    % only store the constant entries
    if data{k,3}
       x_neg(k) = data{k,3};
   end
end


end
