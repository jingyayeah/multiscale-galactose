function [x_names, x_init, x_ind, x_const] = pars_cell()
%% Inital metabolite concentrations for cell model
%   
% Returns:
%   x_names:  vector of concentration names
%   x_init: vector of initial substrate concentrations
%   author: Matthias Koenig & Nikolaus Berndt
%   date:   110911


%Startgeometrie

% Zelle
r0=8.0;% %in 10^-6 m
Vol0=4.0/3.0*pi*r0*r0*r0/(1.0e15); %in liter
Vol_zelle0=Vol0;

%Mitochondrium
n=1000;
r_m=.35;        % %in 10^-6 m
Vol_mito0=n*4.0/3.0*pi*r_m*r_m*r_m/(1.0e15); %in liter

%Aussenraum
Vol_ges=3*Vol0;
Vol_out0=Vol_ges-Vol0;%


data = {
    'glc_ext',             5.0,      0    
    'lac_ext',             2.4,        0
    'o2_ext',              40*1.3/760 ,       0    % [mM]  (Henry's Law mmHg -> mM)  

    'z_aus',               0,        0    % 70   %1
    'Vol_cell',            Vol_zelle0,    0    % 17
    'Vol_out',             Vol_out0,      0    % 18
    'Vol_mito',            Vol_mito0,     0    % 57

    'atp',              3,          0    % 86   %1
    'adp',              0.3,        0    % 87   %2
    'nad',              0.259,      0    % 89   %3
    'nadh',             0.001,      0    % 90   %4
    'phos',                3,          0    % 91   %5

    'glc',              1,          0    % 72   %6
    'glc6p',            0.12,       0    % 73   %7
    'fru6p',            0.03,       0    % 74   %1
    'fru16bp',          0.05,       0    % 75   %1
    'fru26bp',          0.0015,     0    % 76   %1
    'dhap',             0.03,       0    % 77   %1
    'g3p',              0.0015,     0    % 78   %1
    'bpg13',            0.0015,     0    % 79   %1
    'pg3',              0.3,        0    % 80   %1
    'pg2',              0.06,       0    % 81   %1
    'pep',              0.03,       0    % 82   %1
    'pyr',              0.15,       0    % 84   %1
    'lac',              1,          0    % 85   %1
    
    'asp',              0.12,    0    % 42   %1
    'glu',              6.7,     0    % 43   %1
    'mal',              0.17,    0    % 45   %1
    'akg',              0.25,    0    % 46   %1
    'oa',               0.0007,  0    % 47   %1
    
    'o2',               20*1.3/760,             0    % mm
    'co2',              5.184,          1    % 49   %1
    
    'atp_mito',            2.5,      0    % 60   %1
    'adp_mito',            2.5,      0    % 61   %1
    'gtp_mito',            0.3,     0    % 38   %1
    'gdp_mito',            0.2,     0    % 39   %1
    'p_mito',              8,        0    % 63   %1
    'nad_mito',            0.015,    0    % 58   %1
    'nadh_mito',           0.035,    0    % 59   %1

    'co2_mito',            0.05,    0    % 40   %1
    
    'lac_mito',         0,          0    % 26   %1
    'pyr_mito',         0.131,      0    % 27   %1
    'acoa_mito',        0.0051,     0    % 28   %1
    'cit_mito',         2.5,        0    % 29   %1
    'isocit_mito',      0.12,       0    % 30   %1
    'akg_mito',         1,          0    % 31   %1
    'succoa_mito',      0.005,      0    % 32   %1
    'suc_mito',              2,     0    % 33   %1
    'fum_mito',            0.4,     0    % 34   %1
    'mal_mito',            1.5,     0    % 35   %1
    'oa_mito',             0.035,   0    % 36   %1
    'coa_mito',            0.008,   0    % 37   %1
    
    'asp_mito',            0.3,     0    % 41   %1
    'glu_mito',            13.5,    0    % 44   %1
    
    'q',                   0.25E-3,  0    % 66   %1
    'qh2',                 0.75E-3,  0    % 67   %1
    'cytcox',              0.9E-3,   0    % 68   %1
    'cytcred',             0.1E-3,   0    % 69   %1
    
    'Vmm',                 155,      0    % 56
    'Vm',                  75,         0    % 13
    
    'h_mito',              0.0001,    0    % 51
    'cl_mito',             10,        0    % 52
    'ka_mito',             140,       0    % 53
    'na_mito',             10,        0    % 54
    'ca_mito',             2.0,       0    % 55
    
    'h_in',                0.0001,    0    % 50
    'cl_in',                8,           0    % 1
    'ka_in',                140,         0    % 2
    'na_in',                10,          0    % 3
    'ca_in',                0.003,       0    % 4
    
    'cl_sub',                8,           0    % 5
    'ka_sub',                140,         0    % 6
    'na_sub',                10,          0    % 7
    'ca_sub',                0.003,       0    % 8
    
    'cl_ext',              150,         0    % 9
    'ka_ext',              4.0,         0    % 10
    'na_ext',              145,         0    % 11
    'ca_ext',              2,           0    % 12
    
    'm',                   0.4,         0    % 14
    'n_na',                0.08,        0    % 15
    'h',                   0.4,         0    % 16
    'o2_mito',             5*1.3/760,   0    % 16
};
for k=1:length(data)
    data{k,4} = k;
end
data;

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

