function [x_names, x_init, x_ind, x_const] = pars_cellsimple()
%% Inital metabolite concentrations for cell model
%   
% Returns:
%   x_names:  vector of concentration names
%   x_init: vector of initial substrate concentrations
%   author: Matthias Koenig 
%   date:   110523

data = {
    'glc_ext',          5.5,     0 
    'lac_ext',          2.0,     0 
    'o2_ext',           1.2,     0  % (14mmHG) 
    'glc',              5.0,     0
    'lac',              2.0,     0
    'o2',               1.2,     0
    'atp',              2.8,     0
    'adp',              0.8,     0
    'pyr',              0.2,     0
}

x_names = data(:,1);
x_init  = containers.Map(x_names, cell2mat(data(:,2)));
x_ind    = containers.Map(x_names, [1:length(x_names)]);
x_const = containers.Map('KeyType', 'int32', 'ValueType', 'logical');
for k=1:length(x_names)
    % only store the constant entries
    if data{k,3}
       x_const(k) = data{k,3};
   end
end

