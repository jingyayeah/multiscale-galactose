function [x_names, x_init, Nx_out, x_neg, x_ind, x_unit] = pars_test_metabolism()
%% PARS_TEST_METABOLISM - Inital conditions of the cell model.
%   x_names:  vector of variable names
%   x_init: vector of initial conditions
%   x_units:  vector of 

%   Matthias Koenig (2013-08-22)
%   Copyright © Matthias König 2013 All Rights Reserved.

% TODO: calculate Nx_out based on the named variables.
Nx_out = 11;
data = {
    'rbc_sin',             0.0,    0,  '?' % 1   
    'rbcM_sin',            0.0,    0,  '?' % 2
    'suc_sin',             0.0,    0,  '?' % 3
    'sucM_sin',            0.0,    0,  '?' % 4
    'alb_sin',             0.0,    0,  '?' % 5
    'albM_sin',            0.0,    0,  '?' % 6
    'glc_sin',             0.0,    0,  'mmol/l' % 7
    'glcM_sin',            0.0,    0,  'mmol/l' % 8
    'gal_sin',             0.0,    0,  'mmol/l' % 9
    'galM_sin',            0.0,    0,  'mmol/l' % 10
    'h2oM_sin',            0.0,    0,  '?' % 11
    
    'rbc_dis',             0.0,    0,  '?' % 1   
    'rbcM_dis',            0.0,    0,  '?' % 2
    'suc_dis',             0.0,    0,  '?' % 3
    'sucM_dis',            0.0,    0,  '?' % 4
    'alb_dis',             0.0,    0,  '?' % 5
    'albM_dis',            0.0,    0,  '?' % 6
    'glc_dis',             0.0,    0,  'mmol/l' % 7
    'glcM_dis',            0.0,    0,  'mmol/l' % 8
    'gal_dis',             0.0,    0,  'mmol/l' % 9
    'galM_dis',            0.0,    0,  'mmol/l' % 10
    'h2oM_dis',            0.0,    0,  '?' % 11
    
    'glc',             5.5,    0,  'mmol/l' % 1
    'glcM',            0.0,    0,  'mmol/l' % 2
    'gal',             0.0,    0,  'mmol/l' % 3
    'galM',            0.0,    0,  'mmol/l' % 4
    'h2oM',            0.0,    0,  '?'      % 5
    'atp',              2.8,    0,  'mmol/L' % 6
    'adp',              0.8,    0,  'mmol/L' % 7
    'pi',               5.0,    0,  'mmol/L' % 8
    
    'P_GLCT',           1.0,    0,  '-'     % 9
    'P_GALT',           1.0,    0,  '-'     % 10
    'P_HK',             1.0,    0,  '-'     % 11
    'P_HKGAL',          1.0,    0,  '-'     % 12
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

end
