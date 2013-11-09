function [dxdt, V_names, V] = dydt_test_metabolism(t, x, p, ci)
% DYDT_TEST_METABOLISM - Test system for implementing the metabolism
%       t : time
%       x : concentrations related to cell (length p.Nxc)
%       p : model parameters
%       ci : cell index (cell dependent metabolism 1, ...,  p.Nc)
%
%   Matthias Koenig (2013-08-23)
%   Copyright © Matthias König 2013 All Rights Reserved.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scale = 1.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Disse concentrations
ofs_dis = p.Nx_out*p.Nf;    % offset disse concentrations
glc_dis  = x(ofs_dis + 6*p.Nf+1:  ofs_dis + 7*p.Nf);
glcM_dis = x(ofs_dis + 7*p.Nf+1:  ofs_dis + 8*p.Nf);
gal_dis  = x(ofs_dis + 8*p.Nf+1:  ofs_dis + 9*p.Nf);
galM_dis = x(ofs_dis + 9*p.Nf+1:  ofs_dis +10*p.Nf);
h2oM_dis = x(ofs_dis +10*p.Nf+1:  ofs_dis +11*p.Nf);

% Internal concentrations 
ofs_in = 2*p.Nx_out*p.Nf; % offset internal concentrations
glc     = x(ofs_in + 1);
glcM    = x(ofs_in + 2);    
gal     = x(ofs_in + 3);
galM    = x(ofs_in + 4);
h2oM    = x(ofs_in + 5);
% atp     = x(ofs_in + 6);
% adp     = x(ofs_in + 7);
% pi      = x(ofs_in + 8);

% Dynamic protein amounts (zonation)
P_GLCT  = x(ofs_in + 9);
P_GALT  = x(ofs_in + 10);
P_HK    = x(ofs_in + 11);
P_HKGAL = x(ofs_in + 12);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Transporters (disse -> cell)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
onevec = ones(size(glc_dis));

%% Glucose import (glc_dis <-> glc) %%
Vmax_GLCT = 10.0 *scale*P_GLCT; % [?]
km_glc = 1.0; % [mM]

v_GLCT_dis = Vmax_GLCT/p.Nf*(glc_dis - glc*onevec) ...
                                ./ (onevec + glc_dis/km_glc + glc/km_glc);
v_GLCTM_dis = Vmax_GLCT/p.Nf*(glcM_dis - glcM*onevec) ...
                                ./ (onevec + glcM_dis/km_glc + glcM/km_glc);
v_GLCT_in  = sum(v_GLCT_dis);
v_GLCTM_in = sum(v_GLCTM_dis);

%% Galactose import (gal_dis <-> gal) %%
Vmax_GALT = 10.0 *scale*P_GALT; % [?]
km_gal = 2.0; % [mM]
v_GALT_dis  = Vmax_GALT/p.Nf*(gal_dis - gal*onevec) ...
                                ./ (onevec + gal_dis/km_gal + gal/km_gal);
v_GALTM_dis = Vmax_GALT/p.Nf*(galM_dis - galM*onevec) ...
                                ./ (onevec + galM_dis/km_gal + galM/km_gal);
v_GALT_in  = sum(v_GALT_dis);
v_GALTM_in = sum(v_GALTM_dis);

%% H2O labeled import (h2oM_dis <-> h2oM) %%
Vmax_H2OM = 10.0 *scale;    % [?]
v_H2OTM_dis = Vmax_H2OM/p.Nf*(h2oM_dis - h2oM*onevec);
v_H2OTM_in  = sum(v_H2OTM_dis);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Reactions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hexokinase (glc + atp -> glc6p + adp)
Vmax_HK = 0 * 11 * scale * P_HK;  % [?]
HK_km_glc = 0.1; %[mM]
v_HK  = Vmax_HK * glc/(glc + HK_km_glc);
v_HKM = Vmax_HK * glcM/(glcM+HK_km_glc);

%% Hexokinase Galactose (gal + atp -> gal6p + adp)
Vmax_HKGAL = 0* 11 * scale * P_HKGAL;  % [?]
HKGAL_km_gal = 0.1; %[mM]
v_HKGAL  = Vmax_HKGAL * gal /(gal +HKGAL_km_gal);
v_HKGALM = Vmax_HKGAL * galM/(galM+HKGAL_km_gal);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dx_glc   = + v_GLCT_in - v_HK;
dx_glcM  = + v_GLCTM_in - v_HKM;

dx_gal   = + v_GALT_in - v_HKGAL;
dx_galM  = + v_GALTM_in - v_HKGALM;

dx_h2oM  = + v_H2OTM_in;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxdt = zeros(size(x)); 
f_Vol = p.Vol_cell/p.Vol_dis;  % Volume factor for transport
dxdt(ofs_dis + 6*p.Nf+1:  ofs_dis + 7*p.Nf) = - v_GLCT_dis  * f_Vol;
dxdt(ofs_dis + 7*p.Nf+1:  ofs_dis + 8*p.Nf) = - v_GLCTM_dis * f_Vol;
dxdt(ofs_dis + 8*p.Nf+1:  ofs_dis + 9*p.Nf) = - v_GALT_dis  * f_Vol;
dxdt(ofs_dis + 9*p.Nf+1:  ofs_dis +10*p.Nf) = - v_GALTM_dis * f_Vol;
dxdt(ofs_dis +10*p.Nf+1:  ofs_dis +11*p.Nf) = - v_H2OTM_dis * f_Vol;

dxdt(ofs_in + 1) = dx_glc;
dxdt(ofs_in + 2) = dx_glcM;
dxdt(ofs_in + 3) = dx_gal;
dxdt(ofs_in + 4) = dx_galM;
dxdt(ofs_in + 5) = dx_h2oM;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create additional output variables from the ODE
if nargout > 1
    V_names = {
        'v_GLCT_in'
        'v_GLCTM_in'
        'v_GALT_in'
        'v_GALTM_in'
        'v_HK'
        'v_HKM'
        'v_HKGAL'
        'v_HKGALM'
    };

    V = NaN(length(V_names),1);
    for k=1:numel(V_names)
      V(k) = eval(V_names{k});
    end 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end