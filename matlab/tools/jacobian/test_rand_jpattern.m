% Generate the JPattern for the given model based on the initial vector and
% the given dxdt function
% Uses the initial concentration and randomly perturbs and reads the
% resulting nonzero dxdts.

clear all; close all; format compact
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Layout of cells with adjacent blood compartments
p.Nc         = 5;              % number of cells             
p.Nf         = 5;              % number of blood compartments per cell
p.Nb         = p.Nf*p.Nc;       % number of blood compartments

p.d_cell     = 10E-6;                        % [m] cell diameter (10µm)
p.Vol_cell   = p.d_cell^3;                   % [m³] cell volume 

p.d_blood    = p.d_cell/p.Nf;                % [m] length blood compartment  
p.Vol_blood  = 0.5 * p.Vol_cell/p.Nf;        % [m^3] 1/2 times the adjacent cell

p.L          = p.Nc*p.d_cell;                % [m] complete length model

% Blood velocity
% pars.v_blood = 180E-6;                     % [m/s]  blood flux (sinosoid)
p.v_blood = 1E-6;                          % [m/s]  blood flux

% Diffusion coefficients 
p.D_glc = 600;                % [µm^2/s] Diffusion coeffiecent (glucose)
p.D_lac = 500;                % [µm^2/s] Diffusion coeffiecent (lactate)
p.D_o2 = 2000;                % [µm^2/s] Diffusion coeffiecent (O2)

% model definition
p.debug         = false;     % warnings & debug info
p.ext_constant  = false;     % constant blood concentrations in all compartments

p.ode_cells     = true;      % with cell model
p.ode_blood     = true;      % with blood transport model
p.ode_diffusion = true;      % with diffusion model 

% blood flow model with cells
p.Ineg = [];                 % NonNegative concentrations in cell
odefun = @model_v2_dxdt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial concentrations based on layout (p.x0)
p = cellsimple_v2_init(p);
p.f_glc_ext = tc_generator('constant', p.x_init('glc_ext')); 
p.f_lac_ext = tc_generator('constant', p.x_init('lac_ext'));
p.f_o2_ext  = tc_generator('constant', p.x_init('o2_ext'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the calculated JPattern
J = cellsimple_v2_jpattern(p);

% Generate the random Jpattern
[Jrand_sparse, Jrand] = rand_jpattern_generator(p, odefun);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the different entries and plot
Jdiff = J-Jrand;
figure(1)
colormap('gray');
for k=1:3
    subplot(1,3,k)
    switch k
        case 1
            p1 = pcolor(J);
            title('Jpattern')
        case 2
            p1 = pcolor(Jrand);
            title('Random Jpattern')
        case 3
            p1 = pcolor(Jdiff);
            title('Difference in Jpattern')
    end
    set(p1, 'EdgeAlpha', 0);
    axis ij
    axis square
    colorbar
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









