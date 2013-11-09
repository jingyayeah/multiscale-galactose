function [x_names, x_init, x_unit, x_const, x_ind] = pars_glycolysis()
%% PARS_GLYCOLYSIS - Inital conditions of the cell model
%   x_names:  vector of variable names
%   x_init: vector of initial conditions
%   x_units:  vector of 

%   Matthias Koenig (2013-08-20)
%   Copyright © Matthias König 2013 All Rights Reserved.

data = {
    'glc_ext',             5.0,         0,  'mmol/L' % 1   
    'lac_ext',             2.4,         0,  'mmol/L' % 2
    'o2_ext',              40*1.3/760 , 0,  'mmol/L' % 3  (Henry's Law mmHg -> mM)  
    'ins_ext',             1,           0,  'nmol/L' % 4
    'glu_ext',             0.050,       0,  'nmol/L' % 5
    
    'glc_dis',             5.0,         0,  'mmol/L' % 1    
    'lac_dis',             2.4,         0,  'mmol/L' % 2
    'o2_dis',              40*1.3/760 , 0,  'mmol/L' % 3 (Henry's Law mmHg -> mM)  
    'ins_dis',             1   ,        0,  'pmol/L' % 4
    'glu_dis',             0.050,       0,  'nmol/L' % 5
    
    'atp', 2.8000, 1, 'mmol/L'      % 1
    'adp', 0.8000, 1, 'mmol/L'      % 2
    'amp', 0.1600, 1, 'mmol/L'      % 3
    'utp', 0.2700, 0, 'mmol/L'      % 4
    'udp', 0.0900, 0, 'mmol/L'      % 5
    'gtp', 0.2900, 0, 'mmol/L'      % 6
    'gdp', 0.1000, 0, 'mmol/L'      % 7
    'nad', 1.2200, 1, 'mmol/L'      % 8
    'nadh', 0.56E-3, 1, 'mmol/L'    % 9
    'p',    5.0000, 1, 'mmol/L'     % 10
    'pp',   0.0080, 0, 'mmol/L'     % 11
    'co2', 5.0000, 1, 'mmol/L'      % 12 
    'glc1p', 0.0120, 0, 'mmol/L'    % 13
    'udpglc', 0.3800, 0, 'mmol/L'   % 14
    'glyglc', 250.0000, 0, 'mmol/L' % 15
    'glc', 5.0000, 0, 'mmol/L'      % 16
    'glc6p', 0.1200, 0, 'mmol/L'    % 17
    'fru6p', 0.0500, 0, 'mmol/L'    % 18
    'fru16bp', 0.0200, 0, 'mmol/L'  % 19
    'fru26bp', 0.0040, 0, 'mmol/L'  % S20
    'grap', 0.1000, 0, 'mmol/L'     % S21
    'dhap', 0.0300, 0, 'mmol/L'     % S22
    'bpg13', 0.3000, 0, 'mmol/L'    % S23
    'pg3', 0.2700, 0, 'mmol/L'      % S24
    'pg2', 0.0300, 0, 'mmol/L'      % S25
    'pep', 0.1500, 0, 'mmol/L'      % S26
    'pyr', 0.1000, 0, 'mmol/L'      % S27
    'oaa', 0.0100, 0, 'mmol/L'      % S28
    'lac', 0.5000, 0, 'mmol/L'      % S30
    
    'co2_mito', 5.0000, 1, 'mmol/L'  % S31
    'p_mito', 5.0000, 1, 'mmol/L'    % S32
    'oaa_mito', 0.0100, 0, 'mmol/L'  % S33
    'pep_mito', 0.1500, 0, 'mmol/L'  % S34
    'acoa_mito', 0.0400, 1, 'mmol/L' % S35
    'pyr_mito', 0.1000, 0, 'mmol/L'  % S36
    'cit_mito', 0.3200, 1, 'mmol/L'  % S37
    'atp_mito', 2.8000, 1, 'mmol/L'  % S38
    'adp_mito', 0.8000, 1, 'mmol/L'  % S39
    'gtp_mito', 0.2900, 0, 'mmol/L'  % S40
    'gdp_mito', 0.1000, 0, 'mmol/L'  % S41
    'coa_mito', 0.0550, 1, 'mmol/L'  % S42
    'nadh_mito', 0.2400, 1, 'mmol/L' % S43
    'nad_mito', 0.9800, 1, 'mmol/L'  % S44
};
for k=1:length(data)
    data{k,5} = k;
end
%data;

x_names = data(:,1);
x_init  = containers.Map(x_names, cell2mat(data(:,2)));
x_ind    = containers.Map(x_names, [1:length(x_names)]);
x_unit = data(:,4);
x_const = containers.Map('KeyType', 'int32', 'ValueType', 'logical');
for k=1:length(x_names)
    % only store the constant entries
    if data{k,3}
       x_const(k) = data{k,3};
   end
end

end
