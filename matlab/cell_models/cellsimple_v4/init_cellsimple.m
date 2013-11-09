function [p] = init_cellsimple(p)
% Generate the inital concentration array based on the given
%   layout of the system.
%
%   author:     Matthias Koenig
%   date:       121016
%   version:    4.1

% initial concentrations
[p.x_names, p.x_init] = pars_cellsimple();
p.Nx = numel(p.x_names);
p.Nx_out = 3;                                         % external concentrations (glc, lac, o2)
p.Nx_in  = p.Nx - p.Nx_out;               % internal concentrations
p.Nxc    = p.Nx_out*p.Nf + p.Nx_in;                   % concentrations of one cell
p.x0 = zeros(p.Nx_out*(p.Nb+1) + p.Nx_in*p.Nc, 1);    % x : column vector


% external concentrations
% set the blood constant compartment
for k=1:p.Nx_out
   p.x0(k) = p.x_init(p.x_names{k}); 
end

% set the blood adjacent compartments
for k=1:p.Nx_out
    for ci=1:p.Nc
        p.x0( p.Nx_out + (ci-1)*p.Nxc + (k-1)*p.Nf + 1 : p.Nx_out + (ci-1)*p.Nxc + k*p.Nf) ...
                    = p.x_init(p.x_names{k});    
    end
end

% internal concentrations
x0cell = zeros(p.Nx_in, 1);
for k=1:p.Nx_in
   x0cell(k) = p.x_init(p.x_names{p.Nx_out + k});
end

for ci=1:p.Nc
    p.x0(p.Nx_out + p.Nx_out*p.Nf +(ci-1)*p.Nxc + 1: p.Nx_out + ci*p.Nxc) = x0cell;
end

%{
figure()
plot(x0cell);
input('continue');
%}
clear x0cell

