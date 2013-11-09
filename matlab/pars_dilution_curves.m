function [x_names, x_init, Nx_out, x_neg, x_ind, x_unit, Ddata] = pars_dilution_curves()
%% PARS_DILUTION_CURVES - Inital conditions for dilution curves.
%   x_names:  vector of variable names
%   x_init: vector of initial conditions
%   x_units:  vector of 

%   Matthias Koenig (2013-09-25)
%   Copyright © Matthias König 2013 All Rights Reserved.

Nx_out = 5;
data = {
    'rbcM_sin',            0.0,    0,  '?' % 1
    'sucM_sin',            0.0,    0,  '?' % 2
    'albM_sin',            0.0,    0,  '?' % 3
    'galM_sin',            0.0,    0,  'mmol/l' % 4
    'h2oM_sin',            0.0,    0,  '?' % 5
    
    'rbcM_dis',            0.0,    0,  '?' % 1
    'sucM_dis',            0.0,    0,  '?' % 2
    'albM_dis',            0.0,    0,  '?' % 3
    'galM_dis',            0.0,    0,  'mmol/l' % 4
    'h2oM_dis',            0.0,    0,  '?' % 5
    
    'galM',            0.0,     0,  'mmol/l' % 1
    'h2oM',            0.0,     0,  '?'      % 2
};
for k=1:length(data)
    data{k,5} = k;
end
fprintf('\n# METABOLIC CELL MODEL #\n')
data

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

% Diffusion coefficients [µm^2/s] -> [m^2/s]
Ddata = [             
           0       % [1] RBCM
         400       % [2] sucM
         100       % [3] albuminM
         400       % [4] galM 
        2000       % [5] h20M
]*1E-12;

end
