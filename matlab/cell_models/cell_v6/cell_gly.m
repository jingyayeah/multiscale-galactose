function [dxdt, V_names, V] = cell_gly(t, x, pars, ci)
% Glycolysis model
%       t : time
%       x : concentrations
%       pars : model parameters
%       ci : cell index (cell dependent metabolism)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
offset = pars.Nf*pars.Nx_out - pars.Nx_out; 

glc_ext = x(        1:   pars.Nf);
lac_ext = x(pars.Nf+1: 2*pars.Nf);

atp     = x(offset + 8);  
adp     = x(offset + 9);     
p       = x(offset + 12);

nad     = x(offset + 10);
nadh    = x(offset + 11);

glc     = x(offset + 13);   
glc6p   = x(offset + 14);   
fru6p   = x(offset + 15); 
fru16bp = x(offset + 16);  
fru26bp = x(offset + 17); 
dhap    = x(offset + 18);
g3p     = x(offset + 19);
bpg13   = x(offset + 20); 
pg3     = x(offset + 21); 
pg2     = x(offset + 22); 
pep     = x(offset + 23);
pyr     = x(offset + 24); 
lac     = x(offset + 25); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scale_gly = 0.9* 1.1 * 15 * 3.575;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Glucose import (vectorized for adjacent blood compartments)
% glc_ext <-> glc
% v_GLCT_ext = scale_gly * 1e1/pars.Nf*(glc_ext - glc*ones(pars.Nf,1));
onevec = ones(size(glc_ext));
v_GLCT_ext = scale_gly * 5/pars.Nf*(glc_ext - glc*ones(pars.Nf,1)) ...
                                ./ (onevec + glc_ext/1.0 + glc/1.0);
v_GLCT_in = sum(v_GLCT_ext);

% Hexokinase 
% glc + atp -> glc6p + adp
v_HK = scale_gly * 11 * (1-glc6p/0.3) * glc/(glc+0.045) * atp/(atp+0.13);        


% Glucose-6-phosphate isomerase (fast Lowry et al.)
% glc6p <-> fru6p
v_GPI = scale_gly * 5.5E4 * (glc6p - fru6p/0.5157) ...
                                    /(1 + glc6p/0.182 + fru6p/0.071);

% Phosphofructokinase I (Regulation der Gly)
% fru6p + atp -> fru16bp + adp

%{
v_PFK1 =  scale_gly * 10.0 * fru6p/(fru6p+0.2) ... 
                   * atp/(atp+0.02) * 1/(1+atp/1.8) * fru26bp/(fru26bp+0.005) ;

% Phosphofructokinase II (Regulation der Gly)
% fru6p + atp -> fru26bp + adp
v_PFK2 = 1.0 * scale_gly * 150E-3 * fru6p/(fru6p+0.027) * atp/(atp+0.055) ...
                                            * (1-atp/3.31)^1.4; 

% Fructose-2,6-Biphosphatse
% fru26bp -> fru6p + p
v_FBP2 = 1.0 * scale_gly * 0.2517 * fru26bp/(fru26bp + 0.07*(1+fru6p/0.020));
%}

v_PFK1 =  scale_gly * 10.0 * fru6p/(fru6p+0.2) ... 
                   * atp/(atp+0.02) * 1/(1+atp/1.8) * (1-atp/3.31)^1.4;
v_PFK2 = 0.0;
v_FBP2 = 0.0;

% Aldolase
% fru16bp <-> g3p + dhap
v_ALD = scale_gly * 5E2 * (fru16bp - g3p*dhap/0.0976) ...
         / ( (1+fru16bp/0.089) + (1+g3p/0.0071)*(1+dhap/0.0364) -1 );

% Triose Phosphate Isomerase
% dhap <-> g3p 
v_TPI = scale_gly * 2.08e+05 * (dhap - g3p/0.0545) ...
                                /(1 + dhap/0.48 + g3p/0.015);

% Glyceraldehyde-3-Phosphate Dehydrogenase / Phosphoglycerinaldehyddehydrogenase
% g3p + p + nad <-> bpg13 + nadh
v_GAPDH = scale_gly * 56.0 * nad/(nad+0.143) * g3p/(g3p+0.042) * p/(p+3.9);

% Phosphoglycerade Kinase
% bpg13 + adp <-> pg3 + atp
v_PGK = scale_gly * 3.78e+06 * (bpg13*adp - pg3*atp/1310) / ...
            ( (1+bpg13/0.063)*(1+adp/0.42) + (1+pg3/0.67)*(1+atp/25) -1 );

% Phosphoglycerate Mutase
% pg3 <-> pg2
v_PGM = scale_gly * 0.2E5 * (pg3 - pg2/0.1814) ...
                                / ( (1+pg3/5) + (1+pg2/1) -1 ); 

% Enolase
% pg2 <-> pep
v_ENO = scale_gly * 8.33e+05 * (pg2 - pep/0.5) ...
                            /( (1+pg2/0.12) + (1+pep/0.37) -1 );

% Pyruvate Kinase
% Pep + ADP -> Pyr + ATP
v_PK = scale_gly * 40 * pep/(pep+0.18) * adp/(adp + 0.42*(1+atp/4.4) ); 

% Lactatedehydrogenase
% Pyr + NADH <-> Lac + NAD
v_LDH = scale_gly * 2.65e+05 * (pyr*nadh - 1/3597*lac*nad) ...
                /( (1+pyr/1.4)*(1+nadh/0.027) + (1+lac/6)*(1+nad/0.5) -1 );
  
% Lactate transport (vectorized for adjacent blood compartments)
% lac -> lac_ext
% v_LACT_ext = scale_gly * 5e1/pars.Nf * (lac*ones(pars.Nf,1) - lac_ext);

v_LACT_ext = 0.2 * scale_gly * 10e1/pars.Nf * (lac*ones(pars.Nf,1) - lac_ext) ...
                                ./(onevec + lac_ext/6.0 + lac/6.0);
v_LACT_in = sum(v_LACT_ext);

% Glucose-6p usage for proliferation
v_GLCUSE =  3.5 * glc/(glc + 0.8); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the scaling for the cell
f_gly = pars.f_gly(ci);

% Scaled reactions of glycolysis
v_GLCT_in    = f_gly * v_GLCT_in;
v_GLCT_ext   = f_gly * v_GLCT_ext;

v_HK         = f_gly *v_HK;
v_GPI        = f_gly * v_GPI;
v_PFK1       = f_gly * v_PFK1;
v_ALD        = f_gly * v_ALD;  
v_PFK2       = f_gly * v_PFK2;
v_FBP2       = f_gly * v_FBP2;
v_TPI        = f_gly * v_TPI;
v_GAPDH      = f_gly * v_GAPDH;
v_PGK        = f_gly * v_PGK;
v_PGM        = f_gly * v_PGM;
v_ENO        = f_gly * v_ENO;
v_PK         = f_gly * v_PK;

% Unscaled reactions (lactate metabolism)
% v_LACT_in    = v_LACT_in;
% v_LACT_ext   = v_LACT_ext;
% v_LDH      = v_LDH; 
% v_G6PUSE      = v_G6PUSE;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_glc     = + v_GLCT_in - v_HK - v_GLCUSE;
v_glc6p   = + v_HK - v_GPI;
v_fru6p   = + v_GPI- v_PFK1;
v_fru16bp = + v_PFK1 - v_ALD;  
v_fru26bp = + v_PFK2 - v_FBP2;
v_dhap    = + v_ALD - v_TPI;
v_g3p     = + v_ALD + v_TPI - v_GAPDH;
v_bpg13   = - v_PGK + v_GAPDH;
v_pg3     = + v_PGK - v_PGM;
v_pg2     = + v_PGM - v_ENO;
v_pep     = + v_ENO - v_PK;
v_pyr     = + v_PK - v_LDH;
v_lac     = + v_LDH - v_LACT_in;

v_atp    =  - v_HK - v_PFK1 + v_PGK + v_PK - v_PFK2; 
v_adp    =  + v_HK + v_PFK1 - v_PGK - v_PK + v_PFK2; 

v_nadh   = + v_GAPDH - v_LDH ;  
v_nad    = - v_GAPDH + v_LDH ; 

v_p     = + v_FBP2 - v_GAPDH;    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxdt = zeros(size(x)); 

dxdt(        1 :   pars.Nf) =     - v_GLCT_ext * pars.Vol_cell/pars.Vol_blood; % difference based on layout
dxdt(pars.Nf+1 : 2*pars.Nf) =       v_LACT_ext * pars.Vol_cell/pars.Vol_blood; % difference based on layout

dxdt(offset + 8) =     v_atp;
dxdt(offset + 9) =    v_adp;
dxdt(offset + 10) =     v_nad;
dxdt(offset + 11) =     v_nadh; 
dxdt(offset + 12) =     v_p;

dxdt(offset + 13) =     v_glc;

dxdt(offset + 14) =     v_glc6p;
dxdt(offset + 15) =     v_fru6p;
dxdt(offset + 16) =     v_fru16bp;
dxdt(offset + 17) =     v_fru26bp;
dxdt(offset + 18) =     v_dhap;
dxdt(offset + 19) =     v_g3p;
dxdt(offset + 20) =     v_bpg13;
dxdt(offset + 21) =     v_pg3;
dxdt(offset + 22) =     v_pg2;
dxdt(offset + 23) =     v_pep;
dxdt(offset + 24) =     v_pyr;
dxdt(offset + 25) =     v_lac;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargout > 1
    V_names{1} = 'v_GLCT_in';        V(1)  = v_GLCT_in;
    V_names{2} = 'v_HK';             V(2)  = v_HK;
    V_names{3} = 'v_GPI';            V(3)  = v_GPI;
    V_names{4} = 'v_PFK1';           V(4)  = v_PFK1;
    V_names{5} = 'v_PFK2';           V(5)  = v_PFK2;  
    V_names{6} = 'v_ALD';            V(6)  = v_ALD;
    V_names{7} = 'v_TPI';            V(7)  = v_TPI;
    V_names{8} = 'v_GAPDH ';         V(8)  = v_GAPDH ;  
    V_names{9} = 'v_PGK';            V(9)  = v_PGK;  
    V_names{10} = 'v_PGM ';          V(10) = v_PGM ;  
    V_names{11} = 'v_ENO';           V(11) = v_ENO;  
    V_names{12} = 'v_PK';            V(12) = v_PK;  
    V_names{13} = 'v_LDH';         V(13) = v_LDH;  
    V_names{14} = 'v_gly_atp';       V(14) = v_atp;   
    V_names{15} = 'v_LACT_in';       V(15) = v_LACT_in;  
    V_names{16} = 'v_GLCUSE';       V(16) = v_GLCUSE; 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

end