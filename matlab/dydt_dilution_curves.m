function [dxdt, V_names, V] = dydt_dilution_curves(t, x, p, ci)
% DYDT_DILUTION_CURVES - Changes for the dilution curves.
%       t : time
%       x : concentrations related to cell (length p.Nxc)
%       p : model parameters
%       ci : cell index (cell dependent metabolism 1, ...,  p.Nc)
%
%   Matthias Koenig (2013-09-25)
%   Copyright © Matthias König 2013 All Rights Reserved.
if (nargout == 1)
    t
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scale = 1E-015/8.1730e-015;     % [-]
scale = 2 * 1E-015;  % [-]
Vdis = p.Vol_dis;    % [L]
Vcel = p.Vol_cell;   % [L]
Nf = p.Nf;           % [-]
REF_P = 1;           % [mM]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Disse concentrations
ofs_dis = p.Nx_out*Nf;    % offset disse concentrations
galM_dis = x(ofs_dis + 3*Nf+1:  ofs_dis +4*Nf);
h2oM_dis = x(ofs_dis +4*Nf+1:  ofs_dis +5*Nf);

% Internal concentrations 
ofs_in = 2*p.Nx_out*Nf;     % offset internal concentrations
galM    = x(ofs_in + 1);
h2oM    = x(ofs_in + 2);

% Constant test substances
atp = 2.8; % [mM]
adp = 0.8; % [mM]
glc = 5.5; % [mM]
glc_dis = 5.5; % [mM]
gal1p = 0.05; % [mM]

onevec = ones(size(glc_dis));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLUT2 : transports glucose & galactose
GLUT2_P = 1;              % [mM]
GLUT2_k_glc = 42.0;       % [mM] [Gould1991, Walsmley1998]
GLUT2_k_gal = 85.5;       % [mM] [Colville1993, Arbuckle1996]
GLUT2_kf_gal = 288/220;   % [-]  [Elliott1982]  (2.61/0.30 [Colville1993]) 
GLUT2_Vmax = 1E3 * scale*GLUT2_P/REF_P; % [mmol/s]

% [GALTM] GLUT2 (galactose M) (galM_dis <-> galM)
GLUT2_GALM_dis = GLUT2_Vmax/(GLUT2_k_glc*Nf) * GLUT2_kf_gal * (galM_dis - galM*onevec)./ ...
    (1 +glc_dis/GLUT2_k_glc + galM_dis/GLUT2_k_gal + glc/GLUT2_k_glc + galM/GLUT2_k_gal); % [mmol/s]
GLUT2_GALM = sum(GLUT2_GALM_dis);

% [H20TM] H2O transport (h2oM_dis <-> h2oM)
H2OT_Vmax = 0.1 * scale;   % [1/s]
H2OTM_dis = H2OT_Vmax/Nf * (h2oM_dis - h2oM*onevec);  % [mmol/s]
H2OTM  = sum(H2OTM_dis);    % [mmol/s]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [GALK] Galactokinase  (gal + atp <-> gal1p + adp)
% [GALKM] Galactokinase (galM + atp -> gal1p + adp)
%------------------------------------------------------------
% many mutations characterized by Timson2003
GALK_P = 1;           % [mM]
GALK_PA    = 0.001;     % [mmol]
GALK_keq = 50;        % [-] DeltaG ~ 10kJ/mol
GALK_k_gal1p = 1.5;   % [mM] ? 
GALK_k_adp   = 0.8;   % [mM] ? 
GALK_ki_gal1p = 5.3;  % [mM] [Cuatrecasas1965]
GALK_kcat = 8.7;      % [1/s] [Timson2003]
GALK_k_gal = 0.97;    % [mM]  [Timson2003]
GALK_k_atp = 0.034;   % [mM]  [Timson2003]

GALK_Vmax = scale * GALK_PA*GALK_kcat *GALK_P/REF_P;     % [mmol/s]
GALK_dm = ((1 +galM/GALK_k_gal)*(1+atp/GALK_k_atp) +(1+gal1p/GALK_k_gal1p)*(1+adp/GALK_k_adp) -1);
GALKM = GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+gal1p/GALK_ki_gal1p)* galM*atp/GALK_dm;

             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stoichiometric matrix [mmol/s]
dx_galM  = GLUT2_GALM -GALKM;
dx_h2oM  = H2OTM;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [mmol/L/s]
dxdt = zeros(size(x)); 
dxdt(ofs_dis + 3*Nf+1:  ofs_dis +4*Nf) = - GLUT2_GALM_dis /Vdis;
dxdt(ofs_dis +4*Nf+1:  ofs_dis +5*Nf) = - H2OTM_dis      /Vdis;

dxdt(ofs_in+1:ofs_in+2) = [ 
    dx_galM / Vcel
    dx_h2oM / Vcel
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create additional output variables from the ODE
if nargout > 1
    % additional variables for output
    
    % [mM] and [mmol/L/s]
    V_names = {
        'GLUT2_GALM'
        'GALKM'
    };

    V = NaN(length(V_names),1);
    for k=1:numel(V_names)
      V(k) = eval(V_names{k});
    end 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end