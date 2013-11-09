function [p] = pars_layout(random)
%% PARS_LAYOUT - Defines the sinusoid geometry and layout.
%
%   Matthias Koenig (2013-08-20)
%   Copyright © Matthias König 2013 All Rights Reserved.

meanL = 500E-6;     stdL = 50E-6;      % [m] sinusoid length
meanYsin = 4.4E-6;  stdYsin = 0.45E-6; % [m] radius sinusoid
meanYdis = 0.8E-6;  stdYdis = 0.3E-6;  % [m] diameter Disse space
meanYcell = 0.25*25E-6;  stdYcell = 0.25*5E-6;  % [m] hepatocyte sheet thickness
meanFsin = 60E-6;  stdFsin = 50E-6;  % [m/s] blood flow

if (random == true)
    p.L = max(0.01*meanL, normrnd(meanL, stdL, 1));
    p.y_sin  = max(0.01*meanYsin, normrnd(meanYsin, stdYsin, 1));
    p.y_dis = max(0.01*meanYdis, normrnd(meanYdis, stdYdis, 1));
    p.y_cell = max(0.01*meanYcell, normrnd(meanYcell, stdYcell, 1));
    p.flow_sin = max(0.01*meanFsin, normrnd(meanFsin, stdFsin, 1));
else
   p.L = meanL;
   p.y_sin = meanYsin;
   p.y_dis = meanYdis;
   p.y_cell = meanYcell;
   p.flow_sin = meanFsin;
end

% Number of compartments
p.Nc         = 1; %20           % number of cells
p.Nf         = 5;              % number of blood/disse compartments per cell
p.Nb         = p.Nf*p.Nc;       % number of blood/disse compartments

% Length
p.x_cell     = p.L/p.Nc;        % [m] cell diameter
p.x_sin      = p.x_cell/p.Nf;   % [m] length blood/disse compartment in x  
%p.y_cell     = 0.25*25E-6;      % [m]       
%p.y_sin      = 4.4E-6;          % [m] radius sinusoid
%p.y_dis      = 0.8E-6;          % [m] diameter Disse space

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
         
% Flow velocities [+] pp -> pv & [-] pv -> pp
%p.flow_sin    = 60E-6;    % [m/s] blood flow 
%p.flow_dis      = 0.0;    % [m/s] disse flow 

if (true)
    % Test the volume fractions
    p.Vol_total = p.Vol_cell*p.Nc + p.Vol_dis*p.Nb + p.Vol_sin*p.Nb;
    p.Vol_f = [p.Vol_cell*p.Nc, p.Vol_dis*p.Nb, p.Vol_sin*p.Nb]/p.Vol_total*100;
    %Vol_f: [79.3749 5.8580 14.7671]
    % [79, 6, 15]%
end

end