function [x_names, x_init, Nx_out, x_neg, x_ind, x_unit, Ddata] = pars_galactose_metabolism()
%% PARS_GALACTOSE_METABOLISM - Inital conditions for galactose model.
%   x_names:  vector of variable names
%   x_init: vector of initial conditions
%   x_units:  vector of 

%   Copyright Matthias Koenig 2013 All Rights Reserved.

% TODO: calculate Nx_out based on the named variables.
Nx_out = 7;
data = {
    'rbc_sin',             0.0,    0,  '?' % 1   
    'rbcM_sin',            0.0,    0,  '?' % 2
    'suc_sin',             0.0,    0,  '?' % 3
    'alb_sin',             0.0,    0,  '?' % 4
    'gal_sin',             0.0012, 0,  'mmol/l' % 5
    'galM_sin',            0.0,    0,  'mmol/l' % 6
    'h2oM_sin',            0.0,    0,  '?' % 7
    
    'rbc_dis',             0.0,    0,  '?' % 1   
    'rbcM_dis',            0.0,    0,  '?' % 2
    'suc_dis',             0.0,    0,  '?' % 3
    'alb_dis',             0.0,    0,  '?' % 4
    'gal_dis',             0.0012, 0,  'mmol/l' % 5
    'galM_dis',            0.0,    0,  'mmol/l' % 6
    'h2oM_dis',            0.0,    0,  '?' % 7
    
    'gal',             0.00012, 0,  'mmol/l' % 1
    'galM',            0.0,     0,  'mmol/l' % 2
    'h2oM',            0.0,    0,  '?'      % 3
    'glc1p',           0.012,  0,  'mmol/l' % 4
    'glc6p',           0.12,   0,   'mmol/l' % 5
    'gal1p',           0.001,   0,  'mmol/l' % 6
    'udpglc',          0.34,   0,  'mmol/l' % 7
    'udpgal',          0.11,   0,  'mmol/l' % 8
    'galtol',          0.001,   0,  'mmol/l' % 9
    
    'atp',              2.7,    0,  'mmol/L' % 10
    'adp',              1.2,    0,  'mmol/L' % 11
    'utp',              0.27,   0,  'mmol/L' % 12
    'udp',              0.09,    0,  'mmol/L' % 13
    'phos',             5.0,    0,  'mmol/L' % 14
    'ppi',              0.008,    0,  'mmol/L' % 15
    'nadp',             0.1,    0,  'mmol/L' % 16
    'nadph',            0.1,    0,  'mmol/L' % 17
};
for k=1:length(data)
    data{k,5} = k;
end
fprintf('\n# METABOLIC CELL MODEL #\n')
data

% Diffusion coefficients [µm^2/s] -> [m^2/s]
Ddata = [             
           0       % [1] RBC
           0       % [2] RBCM
         400       % [3] suc
         100       % [4] albuminM
         400       % [5] gal
         400       % [6] galM
        2000       % [7] h20M
]*1E-12;


x_names = data(:,1);
x_init  = containers.Map(x_names, cell2mat(data(:,2)));
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
