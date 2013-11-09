function [p] = pars_layout(p)
% Adds the parameters which define the cell layout
%   author: Matthias Koenig
%   date: 121016

p.Nf         = 5;              % number of blood compartments per cell
p.Nb         = p.Nf*p.Nc;       % number of blood compartments

p.d_cell     = 15E-6;                        % [m] cell diameter (10µm)
p.Vol_cell   = p.d_cell^3;                   % [m³] cell volume 

p.d_blood    = p.d_cell/p.Nf;                % [m] length blood compartment  
p.Vol_blood  = 0.3 * p.Vol_cell/p.Nf;        % [m^3] 1/2 times the adjacent cell

p.L          = p.Nc*p.d_cell;                % [m] complete length model
p.v_blood    = 1E-6;                         % [m/s]  blood flux ( 1E-6 ) 

% Diffusion coefficients [µm^2/s]
p.Ddata = [
           400     % [1] glucose /600               
           230     % [2] lactate /500
          1500     % [3] o2      /2000
];

% model definition
p.ext_constant  = false;       % constant blood concentrations in all compartments

p.ode_cells     = true;       % with cell model
p.ode_diffusion = true;       % with diffusion model 
p.ode_blood     = false;       % with blood transport model


end