function [p] = pars_layout(p, random)
%% Defines the sinusoid geometry and layout.
%   p : minimal model information
%   random : sinusoid parameters are initialized randomly
%
%   Copyright Matthias Koenig 2013 All Rights Reserved.
if (~isfield(p, {'id', 'version', 'Nc', 'Nf'}))
   error('Fields not defined'); 
end

%p.Nc         = Nc;              % number of cells
%p.Nf         = Nf;              % number of blood/disse compartments per cell

p.L = 500E-6;               % [m] sinusoid length
p.y_sin = 4.4E-6;           % [m] radius sinusoid
p.y_dis = 0.8E-6;           % [m] diameter Disse space
p.y_cell = 6.25E-6;      % [m] hepatocyte sheet thickness
p.flow_sin = 60E-6;         % [m/s] blood flow

if (random == true)
    stdL = 50E-6;      
    stdYsin = 0.45E-6; 
    stdYdis = 0.3E-6;  
    stdYcell = 6.25E-6;  
    stdFsin = 50E-6;  
    % take random paramters around the mean values
    p.L = max(0.01*p.L, normrnd(p.L, stdL, 1));
    p.y_sin  = max(0.01*p.y_sin, normrnd(p.y_sin, stdYsin, 1));
    p.y_dis = max(0.01*p.y_dis, normrnd(p.y_dis, stdYdis, 1));
    p.y_cell = max(0.01*p.y_cell, normrnd(p.y_cell, stdYcell, 1));
    p.flow_sin = max(0.01*p.flow_sin, normrnd(p.flow_sin, stdFsin, 1));
end
    
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
p.Vol_pp = 10*p.Vol_sin;
p.Vol_pv =    p.Vol_sin;
         
if (true)
    % Calculate the volume fractions
    p.Vol_total = p.Vol_cell*p.Nc + p.Vol_dis*p.Nb + p.Vol_sin*p.Nb;
    p.Vol_f = [p.Vol_cell*p.Nc, p.Vol_dis*p.Nb, p.Vol_sin*p.Nb]/p.Vol_total*100;
    % Vol_f: [79.3749 5.8580 14.7671]
    % [79, 6, 15]%
end

end