% test the jpattern function
%   author: Matthias Koenig
%   date:   110916
%   version:    0.1
clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the layout of the blood compartments and the cells
p.Nc         = 5;              % number of cells             
p.fac        = 10;              % number of blood compartments per cell
p.Nb         = p.fac * p.Nc;    % number of blood compartments

p.Nx_out = 3;      % external concentrations (glc, lac, o2)
p.Nx_in  = 5;       % internal concentrations (glc, lac, o2, A, B, C)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the different patterns due to cells, blood and diffusion in the
% model
ealpha = 0.1;
close all
fig1 = figure('Name', 'JPattern');
colormap('gray');
for k=1:4
    subplot(2,2,k)
    switch k
        case 1
            p.ode_cells = true;
            p.ode_blood = true;
            p.ode_diffusion = true;
        case 2
            p.ode_cells = true;
            p.ode_blood = false;
            p.ode_diffusion = false;
        case 3
            p.ode_cells = false;
            p.ode_blood = true;
            p.ode_diffusion = false;
        case 4
            p.ode_cells = false;
            p.ode_blood = false;
            p.ode_diffusion = true;
    end     
    p.ext_constant = false;     % no changes in external compartment
    J = cellsimple_v2_jpattern(p);
    %J = zeros(p.Nx_out*p.Nb + p.Nc*p.fac);
    p
    p1 = pcolor(J);
    set(p1, 'EdgeAlpha', ealpha);
    switch k
        case 1
            title('CELLS - BLOOD - DIFFUSION')
        case 2
            title('CELLS')
        case 3
            title('BLOOD')
        case 4
            title('DIFFUSION')
    end
    axis square
    axis ij
    ylabel('dxdt')
    xlabel('x')
    colorbar()
    p.ext_constant = true;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

