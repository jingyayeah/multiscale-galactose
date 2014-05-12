function [p] = pars_layout(p)
%% Defines the sinusoid geometry and layout.
%   p : minimal model information
%
%   Copyright Matthias Koenig 2014 All Rights Reserved.

if (~isfield(p, {'id', 'version', 'Nc', 'Nf'}))
   error('Minimal fields necessary for layout not defined !'); 
end

% Geometrical parameter

p.L     = 500E-6*p.Nc/20;   % [m] sinusoid length
p.y_sin = 4.4E-6;           % [m] radius sinusoid
p.y_dis = 1.20E-6;          % [m] diameter Disse space
p.y_cell = 7.58E-6;         % [m] hepatocyte sheet thickness
p.flow_sin = 180E-6;        % [m/s] blood flow
p.f_fen    = 0.09;          % [-] fenestraetion

% Number of compartments
p.Nb         = p.Nf*p.Nc;        % number of blood/disse compartments

% Length
p.x_cell     = p.L/p.Nc;        % [m] cell diameter
p.x_sin      = p.x_cell/p.Nf;   % [m] length blood/disse compartment in x  

% Exchange areas between compartments
p.A_sin = pi*p.y_sin^2;                     % [m^2] cylindrical geometry
p.A_dis = pi*(p.y_sin+p.y_dis)^2 - p.A_sin; % [m^2] cylindrical geometry
p.A_sindis = 2*pi*p.y_sin * p.x_sin;

% Volumes of the compartments
p.Vol_sin    = p.A_sin * p.x_sin;      % [m^3] cylindrical geometry
p.Vol_dis    = p.A_dis * p.x_sin;      % [m^3] cylindrical geometry
p.Vol_cell   = pi*(p.y_sin+p.y_dis+p.y_cell)^2*p.x_cell .... % [m^3] cylindrical geometry (cell layer)
             - pi*(p.y_sin+p.y_dis)^2*p.x_cell;
p.Vol_pp =    p.Vol_sin;               % [m^3]
p.Vol_pv =    p.Vol_sin;               % [m^3]

p.f_sin = p.Vol_sin/(p.Vol_sin + p.Vol_dis + p.Vol_cell); % [-]
p.f_dis = p.Vol_dis/(p.Vol_sin + p.Vol_dis + p.Vol_cell); % [-]
p.f_cell = p.Vol_cell/(p.Vol_sin + p.Vol_dis + p.Vol_cell); % [-]
% [15, 6, 79]%

p.Vol_sinunit = p.L*pi*(p.y_sin + p.y_dis + p.y_cell)^2; % [m^3]
p.Q_sinunit = pi*p.y_sin^2*p.flow_sin;                   % [m^3/s]
         
Vol_liv = 1.5E-3;         % [m^3] liver volume
rho_liv = 1.1E3;          % [kg/m^3] 
Q_liv   = 1.750E-3/60;      % [m^3/s]

m_liv = rho_liv * Vol_liv;  % [kg]
q_liv = Q_liv/m_liv;        % [m^3/s/kg]

end