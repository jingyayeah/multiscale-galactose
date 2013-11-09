function [dxdt, V_names, V] = cell_cac(t, x, pars, ci)
% TCA cycle model
%       t : time
%       x : concentrations
%       pars : model parameters
%       ci : cell index


offset = pars.Nf*pars.Nx_out - pars.Nx_out; 

Vol_cell  = x(offset + 5); 
Vol_mito  = x(offset + 7);
Vol_mem   = Vol_mito*0.3;

nad     = x(offset + 10);
nadh    = x(offset + 11);

pyr     = x(offset + 24);
akg         = x(offset + 29);
asp         = x(offset + 26);
glu         = x(offset + 27);
mal         = x(offset + 28);
oa          = x(offset + 30);

o2        = x(offset + 31);

atp_mito   = x(offset + 33);
adp_mito   = x(offset + 34);
p_mito     = x(offset + 37);
nad_mito   = x(offset + 38);
nadh_mito  = x(offset + 39);

pyr_mito        = x(offset + 42);
acoa_mito       = x(offset + 43);
cit_mito        = x(offset + 44);
isocit_mito     = x(offset + 45);
akg_mito        = x(offset + 46);
succoa_mito     = x(offset + 47);
suc_mito        = x(offset + 48);
fum_mito        = x(offset + 49);
mal_mito        = x(offset + 50);
oa_mito         = x(offset + 51);
coa_mito        = x(offset + 52);

asp_mito        = x(offset + 53);
glu_mito        = x(offset + 54);
    
Vmm             = - x(offset + 59);
q               = x(offset + 55);
qh2             = x(offset + 56);

h_in            = x(offset + 66);
h_mito          = x(offset + 61);
ca_mito         = x(offset + 65);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scale_cac = 0.75*128;
scale_cac = scale_cac * o2/(o2+0.01*1.3/760); % Shut down oxi without oxygen;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TCA Cycle     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lactate and pyruvate import mito
v_PYREX = scale_cac * 1e6 * (pyr*h_in - pyr_mito*h_mito);       %*(1-Pyr_mito/(Pyr_mito + 0.1));

% Pyrovatedehydrogenase complex
% Pyr_mito + CoA + NAD -> AcCoA + Co2 + NADH
v_PDH  = scale_cac * 5 * (1 + 1.7*ca_mito/(ca_mito+1e-3))  * pyr_mito/(0.017 + pyr_mito) ...
           * nad_mito/(0.036 + nad_mito) * coa_mito/(0.0047 + coa_mito);

% Citrate synthase (Regulation of CAC)(ATP,ADP) 
% Oxa + AcCoA + H20 <-> Cit + CoA + H+
v_CS = scale_cac * 40 * oa_mito/(0.0361 + oa_mito) * acoa_mito/(0.016 + acoa_mito);

% Aconitase (fast?)
% Cit <-> IsoCit
v_ACN = scale_cac * 1e7 * (cit_mito - isocit_mito/0.067) ...
                                / (1 + cit_mito/0.45 + isocit_mito/0.1);

% NAD-dependent isocitrate dehydrogenas (Regulation of CAC)
% IsoCit + NAD -> a_keto + NADH + Co2 (ADP, NAD, Cit)
K_m_iso_icdg =  0.24 * (1.5 - ca_mito^2/(ca_mito^2+(5e-4)^2)) * (1.5 - adp_mito/(adp_mito+0.1));
v_IDH = scale_cac * 10 * nad_mito/(nad_mito+0.043) ...
                        * isocit_mito^2/(isocit_mito^2 + K_m_iso_icdg^2);

% Alpha-Ketogluterate dehydrogenase complex
f_Ca = 2*(1.5 - ca_mito^2/(ca_mito^2 + (5e-4)^2));
v_KGDH = scale_cac * 15 * akg_mito/(akg_mito + f_Ca) ...
                        * nad_mito/(nad_mito + 0.021*(1+nadh_mito/0.0045)) ... 
                        * coa_mito/(coa_mito+0.001);

% Succinyl-CoA Synthetase
% SucCoA + ADP/GDP + P <-> Succ + CoA + ATP/ADP 
f_P_suc_atp = (1 + 1.2*p_mito^3/(p_mito^3 + 2.5^3));
v_SCS_ATP = scale_cac * 1e4 * f_P_suc_atp ...
              * (succoa_mito*adp_mito*p_mito - 1/3.8*suc_mito*coa_mito*atp_mito) ...
              / ((1+succoa_mito/0.041)*(1+adp_mito/0.25)*(1+p_mito/0.72) ...
                      + (1+suc_mito/5.1)*(1+coa_mito/0.032)*(1 + atp_mito/0.055) -1 );

% Succinate Dehydrogenase
% Succ + QH -> Fum +QH2 ?
v_SDH = scale_cac * 2e4 * (suc_mito*q - 1/2.6964*fum_mito*qh2) ...
                            / (suc_mito + 0.1*(1+mal_mito/2.2));

% Fumarase
% Fum + H20 <-> Mal
v_FUMR   = scale_cac * 2e7 * (fum_mito - 1/4.4*mal_mito) ...
                                / (1 + fum_mito/0.14 + mal_mito/0.3);          

% Malate dehydrogenase (mito)
% Mal + NAD <-> Oxa +NADH
v_MDHM    = scale_cac * 1e5 * (mal_mito*nad_mito - 1/1.2e-3*oa_mito*nadh_mito) ...
    / ( (1+mal_mito/1.4)*(1+nad_mito/0.1) + (1+oa_mito/0.04)*(1+nadh_mito/0.05) -1 );


%%% MALATE-ASPARTATE SHUTTLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Malate dehydrogenase cytosol
% Mal_in + NAD_in <-> Oxa_in + NADH_in
v_MDHC = scale_cac * 1e4 * (mal*nad - 1/1.2e-3*oa*nadh) ...
                            / ( (1+mal/1.4)*(1+nad/0.1) + (1+oa/0.04)*(1+nadh/0.05) -1 );

% AAT Aspartate-Aminotransferase
% ASP + a_keto <-> Oxa + Gluta
v_AATM = scale_cac * 1e5 * (asp_mito*akg_mito - 1/0.147*oa_mito*glu_mito);
v_AATC   = scale_cac *1e5 * (asp*akg - 1/0.147*oa*glu);

% Aspartate-Glutamate carrier
% Asp_mito + Gluta_cyt + H_cyt -> Asp_cyt + Gluta_mito + H_mito
F = 96490.0;  % C/mol
R = 8.3;      % J/K*mol
T = 293.0;    % K
dGp = - Vmm + R*T/F*1E3*log(h_in/h_mito);
K_AGC = exp(F*dGp/(1E3*R*T));

v_AGT = scale_cac * 1E3 * (asp_mito*glu - 1/K_AGC*asp*glu_mito) ...
                / ((asp_mito+0.05)*(glu+2.8) + (asp+0.05)*(glu_mito+2.8));

% Malate-a_keto-carrier
% Mal_cyt + a_keto_mito -> Mal_mito + a_keto_cyt
v_MAKT = scale_cac * 1e5 * (mal*akg_mito - mal_mito*akg);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      v_PYREX   = pars.f_oxi(ci) * v_PYREX;
      v_PDH     = pars.f_oxi(ci) * v_PDH;
      v_CS      = pars.f_oxi(ci) * v_CS;
      v_ACN     = pars.f_oxi(ci) * v_ACN;
      v_IDH     = pars.f_oxi(ci) * v_IDH;
      v_KGDH    = pars.f_oxi(ci) * v_KGDH;
      v_SCS_ATP = pars.f_oxi(ci) * v_SCS_ATP;
      v_SDH     = pars.f_oxi(ci) * v_SDH;
      v_FUMR    = pars.f_oxi(ci) * v_FUMR;
      v_MDHM    = pars.f_oxi(ci) * v_MDHM;
      v_MDHC    = pars.f_oxi(ci) * v_MDHC;
      v_AATM    = pars.f_oxi(ci) * v_AATM;
      v_AATC    = pars.f_oxi(ci) * v_AATC;
      v_AGT     = pars.f_oxi(ci) * v_AGT;
      v_MAKT    = pars.f_oxi(ci) * v_MAKT;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

v_nad   = - v_MDHC ;
v_nadh  = + v_MDHC ;

v_asp   = - v_AATC + v_AGT*Vol_mito/Vol_cell;
v_akg   = - v_AATC + v_MAKT*Vol_mito/Vol_cell;
v_glu   =   v_AATC - v_AGT*Vol_mito/Vol_cell;
v_oa    =   v_MDHC + v_AATC;
v_mal   =  -v_MDHC - v_MAKT*Vol_mito/Vol_cell;
v_pyr   =  -v_PYREX*Vol_mito/Vol_cell;

v_atp_mito =  + v_SCS_ATP;
v_adp_mito =  - v_SCS_ATP;

v_p_mito = - v_SCS_ATP ;

v_nad_mito   = - v_PDH - v_MDHM - v_KGDH - v_IDH ;
v_nadh_mito  = + v_PDH + v_MDHM + v_KGDH + v_IDH ;

v_pyr_mito   = v_PYREX - v_PDH ; 

v_ACNoa_mito      = v_PDH - v_CS;
v_cit_mito       = v_CS - v_ACN;
v_isocit_mito    = v_ACN - v_IDH;
v_akg_mito       = v_IDH - v_KGDH - v_AATM - v_MAKT;
v_succoa_mito    = v_KGDH - v_SCS_ATP ;
v_suc_mito       = v_SCS_ATP - v_SDH; 
v_fum_mito       = v_SDH - v_FUMR;
v_mal_mito       = v_FUMR - v_MDHM + v_MAKT;
v_oa_mito        = v_MDHM  - v_CS + v_AATM;
v_coa_mito       = -v_KGDH + v_SCS_ATP  + v_CS - v_PDH ;

v_q         = -  v_SDH * Vol_mito/Vol_mem;      %- v_c2_qh2;%
v_qh2       = +  v_SDH * Vol_mito/Vol_mem;      %+ v_c2_qh2;%

v_asp_mito   = - v_AATM - v_AGT;
v_glu_mito   =   v_AATM + v_AGT;

v_h_in   = -(v_PYREX - v_PDH) * Vol_mito/Vol_cell;
v_h_mito =  (v_PYREX - v_PDH);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dxdt = zeros(size(x));

dxdt(offset + 10) = v_nad;
dxdt(offset + 11) = v_nadh;

dxdt(offset + 24) = v_pyr;

dxdt(offset + 42) = v_pyr_mito;
dxdt(offset + 43) = v_ACNoa_mito;
dxdt(offset + 44) = v_cit_mito;        
dxdt(offset + 45) = v_isocit_mito;
dxdt(offset + 46) = v_akg_mito; 
dxdt(offset + 47) = v_succoa_mito;
dxdt(offset + 48) = v_suc_mito;  
dxdt(offset + 49) = v_fum_mito;       
dxdt(offset + 50) = v_mal_mito;  
dxdt(offset + 51) = v_oa_mito;
dxdt(offset + 52) = v_coa_mito;

dxdt(offset + 26) = v_asp;
dxdt(offset + 27) = v_glu;
dxdt(offset + 28) = v_mal;
dxdt(offset + 29) = v_akg; 
dxdt(offset + 30) = v_oa;

dxdt(offset + 38) = v_nad_mito;
dxdt(offset + 39) = v_nadh_mito;
dxdt(offset + 33) = v_atp_mito;
dxdt(offset + 34) = v_adp_mito;
dxdt(offset + 37) = v_p_mito;

dxdt(offset + 55) = v_q;               
dxdt(offset + 56) = v_qh2;   

dxdt(offset + 53) = v_asp_mito;
dxdt(offset + 54) = v_glu_mito;

dxdt(offset + 66) = 0;          % TODO : v_h_in; 
dxdt(offset + 61) = 0;          % TODO : v_h_mito;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargout > 1
    V_names{1} = 'v_AGT';    V(1) = v_AGT;
    V_names{2} = 'v_MAKT ';  V(2) = v_MAKT ;
    V_names{3} = 'v_AATM ';  V(3) = v_AATM ;
    V_names{4} = 'v_AATC ';  V(4) = v_AATC ;
    V_names{5} = 'v_MDHC ';  V(5) = v_MDHC ;
    
    V_names{6} = 'v_PYREX ';  V(6) = v_PYREX ;
    V_names{7} = 'v_PDH ';    V(7) = v_PDH ;
    V_names{8} = 'v_CS';      V(8) = v_CS ;
    V_names{9} = 'v_ACN ';    V(9) = v_ACN  ;
    V_names{10} = 'v_IDH ';    V(10) = v_IDH ;
    V_names{11} = 'v_KGDH ';   V(11) = v_KGDH ;
    V_names{12} = 'v_SCS_ATP'; V(12) = v_SCS_ATP ;
    V_names{13} = 'v_SDH ';     V(13) = v_SDH  ;
    V_names{14} = 'v_FUMR';         V(14) = v_FUMR;
    V_names{15} = 'v_MDHM';         V(15) = v_MDHM ;

    V_names{16} = 'v_cac_nad';     V(16) = v_nad_mito ;
    V_names{17} = 'v_cac_nadh';    V(17) = v_nadh_mito;
    V_names{18} = 'v_cac_q';       V(18) = v_q;
    V_names{19} = 'v_cac_qh2';     V(19) = v_qh2;

    V_names{20} = 'v_cac_atp';     V(20) = v_atp_mito;
    V_names{21} = 'v_pyr';         V(21) = v_pyr;
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
end
