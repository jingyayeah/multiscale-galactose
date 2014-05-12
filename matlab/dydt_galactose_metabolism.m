function [dxdt, V_names, V] = dydt_galactose_metabolism(t, x, p, ci)
% Galactose metabolic model.
%       t : time
%       x : concentrations related to cell (length p.Nxc)
%       p : model parameters
%       ci : cell index (cell dependent metabolism 1, ...,  p.Nc)
%
%   Copyright Matthias Koenig 2014 All Rights Reserved.

Nf = p.Nf;

%% Disse concentrations
ofs_dis = p.Nx_out*Nf;    % offset disse concentrations
gal_dis  = x(ofs_dis + 3*Nf+1:  ofs_dis + 4*Nf);
galM_dis = x(ofs_dis + 4*Nf+1:  ofs_dis + 5*Nf);
h2oM_dis = x(ofs_dis + 5*Nf+1:  ofs_dis + 6*Nf);

%% Internal concentrations 
ofs_in = 2*p.Nx_out*Nf;     % offset internal concentrations
gal     = x(ofs_in + 1);
galM    = x(ofs_in + 2);
h2oM    = x(ofs_in + 3);
glc1p   = x(ofs_in + 4);
glc6p   = x(ofs_in + 5);
gal1p   = x(ofs_in + 6);
udpglc  = x(ofs_in + 7);
udpgal  = x(ofs_in + 8);
galtol  = x(ofs_in + 9);

atp     = x(ofs_in + 10);
adp     = x(ofs_in + 11);
utp     = x(ofs_in + 12);
udp     = x(ofs_in + 13);
phos    = x(ofs_in + 14);
ppi      = x(ofs_in + 15);
nadp    = x(ofs_in + 16);
nadph   = x(ofs_in + 17);

onevec = ones(size(gal_dis));

%% Scaling
% Scaling has to be performed based on the layout of the system.
% Depending on the number of cells within the system.
scale_f = 10E-15;      % [-]
scale = scale_f;       % [-]
REF_P = 1;             % [mM] reference protein concentration
deficiency = p.deficiency;  % [-] which Galactosemia

% [GLUT2_GAL] galactose transport (gal_dis <-> gal)
% [GLUT2_GALM] galactoseM transport (galM_dis <-> galM)
% [GLUT2_GLC] galactose transport (glc_dis <-> glc)
%------------------------------------------------------------
% GLUT2_P = 1;              % [mM]
% GLUT2_f = 1E6;            % [-]
% GLUT2_k_glc = 42.0;       % [mM] [Gould1991, Walsmley1998]
% GLUT2_k_gal = 85.5;       % [mM] [Colville1993, Arbuckle1996]
% GLUT2_kf_gal = 288/220;   % [-]  [Elliott1982] 288/222  (2.61/0.30 [Colville1993]) 

% GLUT2_Vmax = GLUT2_f * scale * GLUT2_P/REF_P;  % [mole/s]
% GLUT2_dm = (1 +(glc_dis+glcM_dis)/GLUT2_k_glc + (gal_dis+galM_dis)/GLUT2_k_gal + (glc+glcM)/GLUT2_k_glc + (gal+galM)/GLUT2_k_gal); % [-]
% GLUT2_GLC_dis  = GLUT2_Vmax/(GLUT2_k_glc*Nf) * (glc_dis - glc*onevec)./GLUT2_dm;   % [mole/s]
% GLUT2_GAL_dis  = GLUT2_Vmax/(GLUT2_k_glc*Nf) * GLUT2_kf_gal * (gal_dis - gal*onevec)./GLUT2_dm; % [mole/s]
% GLUT2_GALM_dis = GLUT2_Vmax/(GLUT2_k_glc*Nf) * GLUT2_kf_gal * (galM_dis - galM*onevec)./GLUT2_dm; % [mole/s]
% % [GLUT2_GLC] GLUT2 (glucose) (glc_dis <-> glc)
% GLUT2_GLC  = sum(GLUT2_GLC_dis);    % [mole/s]
% % [GLUT2_GAL] GLUT2 (galactose) (gal_dis <-> gal)
% GLUT2_GAL  = sum(GLUT2_GAL_dis);    % [mole/s]
% % [GALTM] GLUT2 (galactose M) (galM_dis <-> galM)
% GLUT2_GALM = sum(GLUT2_GALM_dis);   % [mole/s]

%% [GLUT2_GAL] galactose transport (gal_dis <-> gal)
%% [GLUT2_GALM] galactoseM transport (galM_dis <-> galM)
%------------------------------------------------------------
GLUT2_P = 1;              % [mM]
GLUT2_f = 1E6;            % [-]
GLUT2_k_gal = 85.5;       % [mM] [Colville1993, Arbuckle1996]
GLUT2_Vmax = GLUT2_f * scale * GLUT2_P/REF_P;  % [mole/s]
GLUT2_dm = (1 + (gal_dis+galM_dis)/GLUT2_k_gal + (gal+galM)/GLUT2_k_gal); % [-]
GLUT2_GAL_dis  = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (gal_dis - gal*onevec)./GLUT2_dm;    % [mole/s]
GLUT2_GALM_dis = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (galM_dis - galM*onevec)./GLUT2_dm;  % [mole/s]

GLUT2_GAL  = sum(GLUT2_GAL_dis);    % [mole/s]
GLUT2_GALM = sum(GLUT2_GALM_dis);   % [mole/s]

%% [H20TM] H2O transport (h2oM_dis <-> h2oM)
%------------------------------------------------------------
H2OT_f = 10.0;                % [mole/s]
H2OT_k = 1.0;                 % [mM]
H2OT_Vmax = H2OT_f * scale;   % [mole/s]
H2OTM_dis = H2OT_Vmax/H2OT_k/Nf * (h2oM_dis - h2oM*onevec);  % [mole/s]

H2OTM  = sum(H2OTM_dis);      % [mole/s]


%% [GALK] Galactokinase  (gal + atp <-> gal1p + adp)
%% [GALKM] Galactokinase (galM + atp -> gal1p + adp)
%------------------------------------------------------------
GALK_P = 1;           % [mM]
GALK_PA = 0.05;        % [mole]
GALK_keq = 50;        % [-] DeltaG ~ 10kJ/mol
GALK_k_gal1p = 1.5;   % [mM] ? 
GALK_k_adp   = 0.8;   % [mM] ? 
GALK_ki_gal1p = 5.3;  % [mM] [Cuatrecasas1965]
GALK_kcat = 8.7;      % [1/s] [Timson2003]
GALK_k_gal = 0.97;    % [mM]  [Timson2003]
GALK_k_atp = 0.034;   % [mM]  [Timson2003]

if (deficiency >= 1 && deficiency <= 8)
% 	GALK	Wild Type	8.7�0.5 (100)	0.97�0.22 (100)	0.034�0.004 (100)	(Timson and Reece, 2003)
% 1	GALK	H44Y	2.0�0.1 (23)	7.70�4.40 (794)	0.130�0.009 (382)	(Timson and Reece, 2003)
% 2	GALK	R68C	3.9�0.8 (45)	0.43�0.15 (44)	0.110�0.035 (324)	(Timson and Reece, 2003)
% 3	GALK	A198V	5.9�0.1 (68)	0.66�0.22 (68)	0.026�0.001 (76)	(Timson and Reece, 2003)
% 4	GALK	G346S	0.4�0.04 (5)	1.10�0.16 (113)	0.005�0.002 (15)	(Timson and Reece, 2003)
% 5	GALK	G347S	1.1�0.2 (13)	13.0�2.0 (1340)	0.089�0.034 (262)	(Timson and Reece, 2003)
% 6	GALK	G349S	1.8�0.1 (21)	1.70�0.48 (175)	0.039�0.004 (115)	(Timson and Reece, 2003)
% 7	GALK	E43A	6.7�0.02 (77)	1.90�0.50 (196)	0.035�0.0003 (103)	(Timson and Reece, 2003)
% 8	GALK	E43G	0.9�0.02 (10)	0.14�0.01 (14)	0.0039�0.0006 (11)	(Timson and Reece, 2003)
    switch (deficiency)
       case 1;  GALK_kcat=2.0;    GALK_k_gal=7.7;   GALK_k_atp=0.130;
       case 2;  GALK_kcat=3.9;    GALK_k_gal=0.43;  GALK_k_atp=0.110;
       case 3;  GALK_kcat=5.9;    GALK_k_gal=0.66;  GALK_k_atp=0.026;
       case 4;  GALK_kcat=0.4;    GALK_k_gal=1.1;   GALK_k_atp=0.005;
       case 5;  GALK_kcat=1.1;    GALK_k_gal=13.0;  GALK_k_atp=0.089;
       case 6;  GALK_kcat=1.8;    GALK_k_gal=1.70;  GALK_k_atp=0.039;
       case 7;  GALK_kcat=6.7;    GALK_k_gal=1.90;  GALK_k_atp=0.035;
       case 8;  GALK_kcat=0.9;    GALK_k_gal=0.14;  GALK_k_atp=0.0039;
    end
    %fprintf('GALK deficiency: %s\n', num2str(p.deficiency));
end
GALK_Vmax = scale * GALK_PA*GALK_kcat *GALK_P/REF_P;  % [mole/s]
GALK_dm = ((1 +(gal+galM)/GALK_k_gal)*(1+atp/GALK_k_atp) +(1+gal1p/GALK_k_gal1p)*(1+adp/GALK_k_adp) -1);  % [-]
GALK  = GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+gal1p/GALK_ki_gal1p) * (gal*atp -gal1p*adp/GALK_keq)/ GALK_dm;  % [mole/s] 
GALKM = GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+gal1p/GALK_ki_gal1p) * galM*atp/GALK_dm;  % [mole/s]

%% [IMP] Inositol monophosphatase (gal1p -> gal + phos)
%------------------------------------------------------------
IMP_P = 1;              % [mM]
IMP_f = 0.05;           % [-]
IMP_k_gal1p = 0.35;     % [mM]  [Slepak2007, Parthasarathy1997]
IMP_Vmax = IMP_f * GALK_Vmax * IMP_P/REF_P;  % [mole/s]
IMP = IMP_Vmax/IMP_k_gal1p * gal1p/(1 + gal1p/IMP_k_gal1p);  % [mole/s]

%% [ATPS] ATP synthase (adp + phos <-> atp)
%------------------------------------------------------------
ATPS_P = 1;             % [mM]
ATPS_f = 100.0;          % [-]
ATPS_keq = 0.58;        % [1/mM] 2.8/(0.8*6)
ATPS_k_adp = 0.1;       % [mM] [?]
ATPS_k_atp = 0.5;       % [mM] [?]
ATPS_k_phos = 0.1;      % [mM] [?]
ATPS_Vmax = ATPS_f*GALK_Vmax * ATPS_P/REF_P;      % [mole/s]
ATPS = ATPS_Vmax/(ATPS_k_adp*ATPS_k_phos) *(adp*phos-atp/ATPS_keq)/((1+adp/ATPS_k_adp)*(1+phos/ATPS_k_phos) + atp/ATPS_k_atp); % [mole/s]
    
%% [ALDR] Aldose reductase (gal + nadph <-> galtol + nadp)
%------------------------------------------------------------
%ALDR_kcat = 0.40;     % [1/s] [Wemuth1982, SABIORK: 22893]
ALDR_P = 1;            % [mM]
ALDR_f = 1E6;         % [-]
ALDR_keq = 4.0;        % [-] [?]
ALDR_k_gal = 40.0;     % [mM]  [Wemuth1982, SABIORK: 22893]
ALDR_k_galtol = 40.0;  % [mM]  [?]
ALDR_k_nadp = 0.1;     % [mM]  [?]
ALDR_k_nadph = 0.1;    % [mM]  [?]
ALDR_Vmax = ALDR_f*GALK_Vmax * ALDR_P/REF_P;  % [mole/s]
ALDR = ALDR_Vmax/(ALDR_k_gal*ALDR_k_nadp) *(gal*nadph - galtol*nadp/ALDR_keq) /...
    ( (1+gal/ALDR_k_gal)*(1+nadph/ALDR_k_nadph) +(1+galtol/ALDR_k_galtol)*(1+nadp/ALDR_k_nadp) -1);  % [mole/s]


%% [NADPR] NADP Reductase (nadp -> nadph)
%------------------------------------------------------------
% NADPR_deltag = -19.6; % [kJ/mol] (Schuster1995) (glc6p * nadp - pgl6*nadph*h/keq)                
%NADPR_k_glc6p = 0.045;          % [mM] [Ozer2001, Corpas1995, Bautista1992]
NADPR_P = 1;                     % [mM]
NADPR_f = 1E-5;                 % [-];
NADPR_keq = 1;                   % [-] % nadph/nadp
NADPR_k_nadp  = 0.015;           % [mM] [Ozer2001, Corpas1995, Bautista1992]
NADPR_ki_nadph = 0.010;          % [mM] [Ozer2001, Corpas1995, Bautista1992]
NADPR_Vmax = NADPR_f * ALDR_Vmax * NADPR_P/REF_P;  % [mole/s]
NADPR = NADPR_Vmax/NADPR_k_nadp *(nadp - nadph/NADPR_keq)/(1 +nadp/NADPR_k_nadp +nadph/NADPR_ki_nadph);  % [mole/s]                   

%% [GALT] Galactose-1-phosphate uridyl transferase (gal1p + udpglc <-> glc1p + udpgal)
%------------------------------------------------------------
GALT_P = 1;               % [mM]
GALT_f = 0.01;          % [-] 300/804*1/7
GALT_keq = 1.0;           % [-] [?] 
GALT_k_glc1p  = 0.37;     % [mM] [Geeganage1998]
GALT_k_udpgal = 0.5;      % [mM] [?]
GALT_ki_utp = 0.13;       % [mM] [Segal1971]
GALT_ki_udp = 0.35;       % [mM] [Segal1971]
GALT_vm = 804;            % [-] [Tang2011]
GALT_k_gal1p  = 1.25;     % [mM] [Tang2011] (too high ?, 0.061 [Geeganage1998])
GALT_k_udpglc = 0.43;     % [mM] [Tang2011]
if (deficiency >= 9 && deficiency <= 14)
%       E       Variant	Vmax        Km(gal1p)[mM](%wt)	Km(udpglc)[mM](%wt)	Reference
%   	GALT	Wild Type	804�65 (100)	1.25�0.36 (100)	0.43�0.09 (100)	(Tang, et al., 2012)
% 9     GALT	R201C	396�59 (49)	1.89�0.62 (151)	0.58�0.13 (135)	(Tang, et al., 2012)
% 10	GALT	E220K	253�53 (31)	2.34�0.42 (187)	0.69�0.16 (160)	(Tang, et al., 2012)
% 11	GALT	R223S	297�25 (37)	1.12�0.31 (90)	0.76�0.09 (177)	(Tang, et al., 2012)
% 12	GALT	I278N	45�3 (6)	1.98�0.35 (158)	1.23�0.28 (286)	(Tang, et al., 2012)
% 13	GALT	L289F	306�23 (38)	2.14�0.21 (171)	0.48�0.13 (112)	(Tang, et al., 2012)
% 14	GALT	E291V	385�18 (48)	2.68�0.16 (214)	0.95�0.43 (221)	(Tang, et al., 2012)
    switch (deficiency)
       case 9;  GALT_vm=396;  GALT_k_gal1p=1.89; GALT_k_udpglc=0.58;
       case 10; GALT_vm=253;  GALT_k_gal1p=2.34; GALT_k_udpglc=0.69;
       case 11; GALT_vm=297;  GALT_k_gal1p=1.12; GALT_k_udpglc=0.76;
       case 12; GALT_vm=45;   GALT_k_gal1p=1.98; GALT_k_udpglc=1.23;
       case 13; GALT_vm=306;  GALT_k_gal1p=2.14; GALT_k_udpglc=0.48;
       case 14; GALT_vm=385;  GALT_k_gal1p=2.68; GALT_k_udpglc=0.95;           
    end
    %fprintf('GALT deficiency: %s\n', num2str(p.deficiency));
end
GALT_Vmax = GALT_f*GALK_Vmax*GALT_vm;  % [mole/s]
GALT = GALT_P/REF_P * GALT_Vmax/(GALT_k_gal1p*GALT_k_udpglc) *(gal1p*udpglc - glc1p*udpgal/GALT_keq) / ...
    ((1+gal1p/GALT_k_gal1p)*(1+udpglc/GALT_k_udpglc + udp/GALT_ki_udp + utp/GALT_ki_utp) + (1+glc1p/GALT_k_glc1p)*(1+udpgal/GALT_k_udpgal) - 1);  % [mole/s]


%% [GALE] UDP-glucose 4-epimerase (udpglc <-> udpgal)
%------------------------------------------------------------
GALE_P = 1;               % [mM]
GALE_f = 0.3;             % [-]
GALE_PA = 0.0278;         % [s] (1/36)
GALE_kcat = 36;           % [1/s] [Timson2005]
GALE_keq = 0.33;          % [-]  [?] (udpgal/udpglc ~ 1/3) 
GALE_k_udpglc  = 0.069;   % [mM] [Timson2005]
GALE_k_udpgal  = 0.3;     % [mM] [?]
if (p.deficiency >= 15 && p.deficiency <= 23)
% 	GALE	Wild Type	36�1.4 (100)	0.069�0.012 (100)		(Timson, 2005)
% 15	GALE	N34S	32�1.3 (89)     0.082�0.015 (119)		(Timson, 2005)
% 16	GALE	G90E	0.046�0.0028 (0)0.093�0.024 (135)		(Timson, 2005)
% 17	GALE	V94M	1.1�0.088 (3)	0.160�0.038 (232)		(Timson, 2005)
% 18	GALE	D103G	5.0�0.23 (14)	0.140�0.021 (203)		(Timson, 2005)
% 19	GALE	L183P	11�1.2 (31)     0.097�0.040 (141)		(Timson, 2005)
% 20	GALE	K257R	5.1�0.29 (14)	0.066�0.015 (96)		(Timson, 2005)
% 21	GALE	L313M	5.8�0.36 (16)	0.035�0.011 (51)		(Timson, 2005)
% 22	GALE	G319E	30�1.3 (83)     0.078�0.013 (113)		(Timson, 2005)
% 23	GALE	R335H	15�0.48 (42)	0.099�0.012 (143)		(Timson, 2005)
    switch (p.deficiency)
       case 15;  GALE_kcat=32;    GALE_k_udpglc=0.082;
       case 16;  GALE_kcat=0.046; GALE_k_udpglc=0.093;
       case 17;  GALE_kcat=1.1;   GALE_k_udpglc=0.160;
       case 18;  GALE_kcat=5.0;   GALE_k_udpglc=0.140;
       case 19;  GALE_kcat=11;    GALE_k_udpglc=0.097;
       case 20;  GALE_kcat=5.1;   GALE_k_udpglc=0.066;
       case 21;  GALE_kcat=5.8;   GALE_k_udpglc=0.035;
       case 22;  GALE_kcat=30;    GALE_k_udpglc=0.078;
       case 23;  GALE_kcat=15;    GALE_k_udpglc=0.099; 
    end
    %fprintf('GALE deficiency: %s\n', num2str(p.deficiency));
end

GALE_Vmax = GALE_f*GALK_Vmax*GALE_PA*GALE_kcat*GALE_P/REF_P;  % [mole/s]
GALE = GALE_Vmax/GALE_k_udpglc *(udpglc -udpgal/GALE_keq) /(1 +udpglc/GALE_k_udpglc +udpgal/GALE_k_udpgal);  % [mole/s]

%% [UGP] UDP-glucose pyrophosphorylase (glc1p + utp <-> udpglc + ppi)
%------------------------------------------------------------
UGP_P = 1;             % [mM]
UGP_f = 2000;             % [-]
UGALP_f = 0.01;        % [-]
UGP_keq = 0.45;        % [-]  [Guynn1974, Duggleby1996] (1/4.55 Guynn1974) DeltaG = 3.0kJ/mol (keq = 0.31 % 0.28 - 0.34 )
UGP_k_utp = 0.563;     % [mM] [Duggleby1996, Chang1996]
UGP_k_glc1p = 0.172;   % [mM] [Duggleby1996, Chang1996]
UGP_k_udpglc = 0.049;  % [mM] [Duggleby1996, Chang1996]
UGP_k_ppi = 0.166;     % [mM] [Duggleby1996, Chang1996]
UGP_k_gal1p  = 5.0;    % [mM]
UGP_k_udpgal = 0.42;   % [mM] [Knop1970]
UGP_ki_utp = 0.643;    % [mM] [Duggleby1996] (competitive udpglc)
UGP_ki_udpglc = 0.643; % [mM] [Duggleby1996] (competitive utp)

UGP_Vmax = UGP_f * GALK_Vmax*UGP_P/REF_P;   % [mole/s] 
UGP_dm = ((1 +utp/UGP_k_utp +udpglc/UGP_ki_udpglc)*(1 +glc1p/UGP_k_glc1p +gal1p/UGP_k_gal1p) + (1 +udpglc/UGP_k_udpglc +udpgal/UGP_k_udpgal +utp/UGP_ki_utp)*(1 +ppi/UGP_k_ppi) -1);  % [-] 
UGP = UGP_Vmax/(UGP_k_utp*UGP_k_glc1p) *(glc1p*utp - udpglc*ppi/UGP_keq)/UGP_dm;  % [mole/s] 
   
%% [UGALP] UDP-galactose pyrophosphorylase (gal1p + utp <-> udpgal + ppi)
%------------------------------------------------------------
UGALP = UGALP_f*UGP_Vmax/(UGP_k_utp*UGP_k_gal1p) *(gal1p*utp - udpgal*ppi/UGP_keq)/UGP_dm;  % [mole/s] 

%% [PPASE] Pyrophosphatase (ppi + h2o -> 2 phos)
%------------------------------------------------------------
%PPASE_deltag = -19.2; % [kJ/mol] [-19.2 Guyn1974]
%PPASE_keq = 3.125;    % [mM] [phos^2/ppi ~ 5.0^2/0.008]
PPASE_P = 1;           % [mM]
PPASE_f = 0.05;        % [-]
PPASE_k_ppi = 0.07;    % [mM] [Irie1970][Yoshida1982 0.008] (also much higher values)
PPASE_n = 4;           % [-]
PPASE_Vmax = PPASE_f*UGP_Vmax *PPASE_P/REF_P;  % [mole/s]

PPASE = PPASE_Vmax * ppi^PPASE_n/(ppi^PPASE_n + PPASE_k_ppi^PPASE_n);  % [mole/s]
%PPASE = PPASE_Vmax/PPASE_k_ppi*(ppi - phos*phos/PPASE_keq)/(1+PPASE_k_ppi);  % [mole/s]

%% [NDKU] Nucleoside diphosphokinase (ATP:UDP phosphotransferase) (atp + udp <-> adp + utp)
%------------------------------------------------------------
NDKU_P = 1;         % [mM]
NDKU_f = 2;        % [-]
NDKU_keq = 1;       % [-]
NDKU_k_atp = 1.33;  % [mM] [Kimura1988, Fukuchi1994]
NDKU_k_adp = 0.042; % [mM] [Kimura1988, Lam1986]
NDKU_k_utp = 27;    % [mM] [Fukuchi1994]
NDKU_k_udp = 0.19;  % [mM] [Kimuara1988]
NDKU_Vmax = NDKU_f* UGP_Vmax *NDKU_P/REF_P;  % [mole/s]
NDKU = NDKU_Vmax/NDKU_k_atp/NDKU_k_udp *(atp*udp - adp*utp/NDKU_keq)/...
    ((1+atp/NDKU_k_atp)*(1+udp/NDKU_k_udp) + (1+adp/NDKU_k_adp)*(1+utp/NDKU_k_utp) -1);  % [mole/s]

%% [PGM1] Phosphoglucomutase-1 (glc1p <-> glc6p)
%------------------------------------------------------------
% TODO inhibition glc1p
PGM1_P = 1;                  % [mM]
PGM1_f = 50.0;               % [-]
PGM1_keq = 10.0;             % [-] ( [glc6p]/[glc1p] ~10-12 [Guynn1974]) DeltaG=-7.1 [kJ/mol] [Koenig2012]
PGM1_k_glc6p  = 0.67;        % [mM] [Kashiwaya1994]
PGM1_k_glc1p = 0.045;        % [mM] [Kashiwaya1994, Quick1994]
PGM1_Vmax = PGM1_f * GALK_Vmax*PGM1_P/REF_P;   % [mole/s]
PGM1 = PGM1_Vmax/PGM1_k_glc1p *(glc1p - glc6p/PGM1_keq)/(1+glc1p/PGM1_k_glc1p+glc6p/PGM1_k_glc6p);  % [mole/s]

%% [GLY] Glycolysis (glc6p <-> phos)
%------------------------------------------------------------
GLY_P = 1;                  % [mM]
GLY_f = 0.1;                % [-]
GLY_k_glc6p = 0.12;         % [mM] [concentrations]
GLY_k_p = 0.2;              % [mM] [limitation phosphate]
GLY_Vmax = GLY_f * PGM1_Vmax*GLY_P/REF_P;   % [mole/s]
GLY = GLY_Vmax*(glc6p - GLY_k_glc6p)/GLY_k_glc6p * phos/(phos + GLY_k_p);  % [mole/s]

%% [GTFGAL] Glycosyltransferase galactose (udpgal -> udp)
%% [GTFGLC] Glycosyltransferase glucose (udpglc -> udp)
%------------------------------------------------------------
%GTFGAL = max(0, GTF_Vmax * (GTF_r_udpgal-udpgal)/(udpgal + GTF_k_udpgal));  % [mole/s]
%GTFGLC = max(0, GTF_Vmax * (GTF_r_udpglc-udpglc)/(udpglc + GTF_k_udpglc));  % [mole/s]
%GTF_r_udpgal = 0.11;  % [mM]
%GTF_r_udpglc = 0.34;  % [mM]
GTF_P = 1;            % [mM]
GTF_f = 2E-2;         % [-]
GTF_k_udpgal = 0.1;   % [mM]  (10-50�M Transporters)
GTF_k_udpglc = 0.1;   % [mM]
GTF_Vmax = GTF_f * GALK_Vmax * GTF_P/REF_P;  % [mole/s]
GTFGAL = GTF_Vmax * udpgal/(udpgal + GTF_k_udpgal);  % [mole/s]
GTFGLC = 0* GTF_Vmax * udpglc/(udpglc + GTF_k_udpglc);  % [mole/s]


%% Stoichiometric matrix [mole/s]
dx_gal   = GLUT2_GAL -GALK +IMP -ALDR;
dx_galM  = GLUT2_GALM -GALKM;
dx_h2oM  = H2OTM;
dx_glc1p = GALT -PGM1 -UGP;
dx_glc6p = PGM1 -GLY;
dx_gal1p  = -GALT +GALK -IMP -UGALP +GALKM;
dx_udpglc = -GALT -GALE +UGP   -GTFGLC; 
dx_udpgal =  GALT +GALE +UGALP -GTFGAL;
dx_galtol = ALDR;

dx_atp  = -GALK +ATPS -NDKU;
dx_adp  = +GALK -ATPS +NDKU;
dx_utp  = -UGP -UGALP +NDKU;
dx_udp  = -NDKU +GTFGAL + GTFGLC;
dx_phos = 2*PPASE -ATPS +IMP +GLY;
dx_ppi  = UGP +UGALP -PPASE;
dx_nadp =  ALDR -NADPR;
dx_nadph= -ALDR +NADPR;

Vdis = p.Vol_dis;    % [m3]
Vcel = p.Vol_cell;   % [m3]

%% changes [mole/s/m3] via respective volumes
dxdt = zeros(size(x)); 
dxdt(ofs_dis + 3*Nf+1:  ofs_dis + 4*Nf)  = - GLUT2_GAL_dis  /Vdis;
dxdt(ofs_dis + 4*Nf+1:  ofs_dis + 5*Nf)  = - GLUT2_GALM_dis /Vdis;
dxdt(ofs_dis + 5*Nf+1:  ofs_dis + 6*Nf)  = - H2OTM_dis      /Vdis;
dxdt(ofs_in+1:ofs_in+17) = [ 
    dx_gal
    dx_galM
    dx_h2oM
    dx_glc1p
    dx_glc6p
    dx_gal1p
    dx_udpglc
    dx_udpgal
    dx_galtol
    
    dx_atp
    dx_adp
    dx_utp
    dx_udp
    dx_phos
    dx_ppi
    dx_nadp
    dx_nadph
]/Vcel;


%% Create additional output variables from the ODE
if nargout > 1
    % additional variables for output
    nadp_tot = nadp + nadph;
    atp_tot = atp + adp;
    utp_tot = utp + udp + udpglc + udpgal;
    pi_tot = 3*atp + 2*adp + 3*utp + 2*udp + phos + 2*ppi + glc1p ...
             + glc6p + gal1p + 2*udpglc + 2*udpgal;
    
    % [mM=mole/m3] and [mole/s]
    V_names = {
        'nadp_tot'
        'atp_tot'
        'utp_tot'
        'pi_tot'
        
        'GLUT2_GAL'
        'GLUT2_GALM'
        'H2OTM'
        'GALK'
        'IMP'
        'ALDR'
        'GALT'
        'GALE'
        'UGP'
        'UGALP'
        'GTFGLC'
        'GTFGAL'
        'NDKU'
        'ATPS'
        'NADPR'
        'PPASE'
        'PGM1'
        'GLY'
    };
    V = NaN(length(V_names),1);
    for k=1:numel(V_names)
      V(k) = eval(V_names{k});
    end 
end 
end