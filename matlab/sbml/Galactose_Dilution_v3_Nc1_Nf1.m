function xdot = Galactose_Dilution_v3_Nc1_Nf1(time,x)
%  synopsis:
%     xdot = Galactose_Dilution_v3_Nc1_Nf1 (time, x)
%     x0 = Galactose_Dilution_v3_Nc1_Nf1
%
%  Galactose_Dilution_v3_Nc1_Nf1 can be used with odeN functions as follows:
%
%  x0 = Galactose_Dilution_v3_Nc1_Nf1;
%  [t,x] = ode23s(@Galactose_Dilution_v3_Nc1_Nf1, [0 100], Galactose_Dilution_v3_Nc1_Nf1);
%  plot (t,x);
%
%  where 100 is the end time
%
%  When Galactose_Dilution_v3_Nc1_Nf1 is used without any arguments it returns a vector of
%  the initial concentrations of the 35 floating species.
%  Otherwise Galactose_Dilution_v3_Nc1_Nf1 should be called with two arguments:
%  time and x.  time is the current time. x is the vector of the
%  concentrations of the 35 floating species.
%  When these parameters are supplied Galactose_Dilution_v3_Nc1_Nf1 returns a vector of 
%  the rates of change of the concentrations of the 35 floating species.
%
%  the following table shows the mapping between the vector
%  index of a floating species and the species name.
%  
%  NOTE for compartmental models
%  matlab translator generates code that when simulated in matlab, 
%  produces results which have the units of species amounts. Users 
%  should divide the results for each species with the volume of the
%  compartment it resides in, in order to obtain concentrations.
%  
%  Indx      Name
%  x(1)        S001__rbcM
%  x(2)        D001__rbcM
%  x(3)        PV__rbcM
%  x(4)        S001__suc
%  x(5)        D001__suc
%  x(6)        PV__suc
%  x(7)        S001__alb
%  x(8)        D001__alb
%  x(9)        PV__alb
%  x(10)        S001__gal
%  x(11)        D001__gal
%  x(12)        PV__gal
%  x(13)        S001__galM
%  x(14)        D001__galM
%  x(15)        PV__galM
%  x(16)        S001__h2oM
%  x(17)        D001__h2oM
%  x(18)        PV__h2oM
%  x(19)        H01__gal
%  x(20)        H01__galM
%  x(21)        H01__h2oM
%  x(22)        H01__glc1p
%  x(23)        H01__glc6p
%  x(24)        H01__gal1p
%  x(25)        H01__udpglc
%  x(26)        H01__udpgal
%  x(27)        H01__galtol
%  x(28)        H01__atp
%  x(29)        H01__adp
%  x(30)        H01__utp
%  x(31)        H01__udp
%  x(32)        H01__phos
%  x(33)        H01__ppi
%  x(34)        H01__nadp
%  x(35)        H01__nadph

xdot = zeros(35, 1);

% List of Compartments 
vol__PP = 1.#QNAN;		%PP
vol__S001 = 1.#QNAN;		%S001
vol__D001 = 1.#QNAN;		%D001
vol__PV = 1.#QNAN;		%PV
vol__H01 = 1.#QNAN;		%H01

% Global Parameters 
g_p1 = 0.0005;		% L
g_p2 = 4.4e-006;		% y_sin
g_p3 = 8e-007;		% y_dis
g_p4 = 6.25e-006;		% y_cell
g_p5 = 6e-005;		% flow_sin
g_p6 = 1;		% Nc
g_p7 = 1;		% Nf
g_p8 = 1.#QNAN;		% Nb
g_p9 = 1.#QNAN;		% x_cell
g_p10 = 1.#QNAN;		% x_sin
g_p11 = 1.#QNAN;		% A_sin
g_p12 = 1.#QNAN;		% A_dis
g_p13 = 1.#QNAN;		% A_sindis
g_p14 = 1.#QNAN;		% Vol_sin
g_p15 = 1.#QNAN;		% Vol_dis
g_p16 = 1.#QNAN;		% Vol_cell
g_p17 = 1.#QNAN;		% Vol_pp
g_p18 = 1.#QNAN;		% Vol_pv
g_p19 = 0;		% DrbcM
g_p20 = 1.#QNAN;		% Dx_sin_rbcM
g_p21 = 1.#QNAN;		% Dx_dis_rbcM
g_p22 = 1.#QNAN;		% Dy_sindis_rbcM
g_p23 = 4e-010;		% Dsuc
g_p24 = 1.#QNAN;		% Dx_sin_suc
g_p25 = 1.#QNAN;		% Dx_dis_suc
g_p26 = 1.#QNAN;		% Dy_sindis_suc
g_p27 = 1e-010;		% Dalb
g_p28 = 1.#QNAN;		% Dx_sin_alb
g_p29 = 1.#QNAN;		% Dx_dis_alb
g_p30 = 1.#QNAN;		% Dy_sindis_alb
g_p31 = 4e-010;		% Dgal
g_p32 = 1.#QNAN;		% Dx_sin_gal
g_p33 = 1.#QNAN;		% Dx_dis_gal
g_p34 = 1.#QNAN;		% Dy_sindis_gal
g_p35 = 4e-010;		% DgalM
g_p36 = 1.#QNAN;		% Dx_sin_galM
g_p37 = 1.#QNAN;		% Dx_dis_galM
g_p38 = 1.#QNAN;		% Dy_sindis_galM
g_p39 = 2e-009;		% Dh2oM
g_p40 = 1.#QNAN;		% Dx_sin_h2oM
g_p41 = 1.#QNAN;		% Dx_dis_h2oM
g_p42 = 1.#QNAN;		% Dy_sindis_h2oM
g_p43 = 1e-014;		% scale_f
g_p44 = 1.#QNAN;		% scale
g_p45 = 1;		% REF_P
g_p46 = 0;		% deficiency
g_p47 = 1.#QNAN;		% H01__nadp_tot
g_p48 = 1.#QNAN;		% H01__adp_tot
g_p49 = 1.#QNAN;		% H01__udp_tot
g_p50 = 1.#QNAN;		% H01__phos_tot
g_p51 = 0.1;		% GALK_PA
g_p52 = 50;		% GALK_keq
g_p53 = 1.5;		% GALK_k_gal1p
g_p54 = 0.8;		% GALK_k_adp
g_p55 = 5.3;		% GALK_ki_gal1p
g_p56 = 8.7;		% GALK_kcat
g_p57 = 0.97;		% GALK_k_gal
g_p58 = 0.034;		% GALK_k_atp
g_p59 = 1;		% H01__GALK_P
g_p60 = 1.#QNAN;		% H01__GALK_Vmax
g_p61 = 1.#QNAN;		% H01__GALK_dm
g_p62 = 0.05;		% IMP_f
g_p63 = 0.35;		% IMP_k_gal1p
g_p64 = 1;		% H01__IMP_P
g_p65 = 1.#QNAN;		% H01__IMP_Vmax
g_p66 = 100;		% ATPS_f
g_p67 = 0.58;		% ATPS_keq
g_p68 = 0.1;		% ATPS_k_adp
g_p69 = 0.5;		% ATPS_k_atp
g_p70 = 0.1;		% ATPS_k_phos
g_p71 = 1;		% H01__ATPS_P
g_p72 = 1.#QNAN;		% H01__ATPS_Vmax
g_p73 = 1e+006;		% ALDR_f
g_p74 = 4;		% ALDR_keq
g_p75 = 40;		% ALDR_k_gal
g_p76 = 40;		% ALDR_k_galtol
g_p77 = 0.1;		% ALDR_k_nadp
g_p78 = 0.1;		% ALDR_k_nadph
g_p79 = 1;		% H01__ALDR_P
g_p80 = 1.#QNAN;		% H01__ALDR_Vmax
g_p81 = 1e-010;		% NADPR_f
g_p82 = 1;		% NADPR_keq
g_p83 = 0.015;		% NADPR_k_nadp
g_p84 = 0.01;		% NADPR_ki_nadph
g_p85 = 1;		% H01__NADPR_P
g_p86 = 1.#QNAN;		% H01__NADPR_Vmax
g_p87 = 0.01;		% GALT_f
g_p88 = 1;		% GALT_keq
g_p89 = 0.37;		% GALT_k_glc1p
g_p90 = 0.5;		% GALT_k_udpgal
g_p91 = 0.13;		% GALT_ki_utp
g_p92 = 0.35;		% GALT_ki_udp
g_p93 = 804;		% GALT_vm
g_p94 = 1.25;		% GALT_k_gal1p
g_p95 = 0.43;		% GALT_k_udpglc
g_p96 = 1;		% H01__GALT_P
g_p97 = 1.#QNAN;		% H01__GALT_Vmax
g_p98 = 0.3;		% GALE_f
g_p99 = 0.0278;		% GALE_PA
g_p100 = 36;		% GALE_kcat
g_p101 = 0.33;		% GALE_keq
g_p102 = 0.069;		% GALE_k_udpglc
g_p103 = 0.3;		% GALE_k_udpgal
g_p104 = 1;		% H01__GALE_P
g_p105 = 1.#QNAN;		% H01__GALE_Vmax
g_p106 = 2000;		% UGP_f
g_p107 = 0.01;		% UGALP_f
g_p108 = 0.45;		% UGP_keq
g_p109 = 0.563;		% UGP_k_utp
g_p110 = 0.172;		% UGP_k_glc1p
g_p111 = 0.049;		% UGP_k_udpglc
g_p112 = 0.166;		% UGP_k_ppi
g_p113 = 5;		% UGP_k_gal1p
g_p114 = 0.42;		% UGP_k_udpgal
g_p115 = 0.643;		% UGP_ki_utp
g_p116 = 0.643;		% UGP_ki_udpglc
g_p117 = 1;		% H01__UGP_P
g_p118 = 1.#QNAN;		% H01__UGP_Vmax
g_p119 = 1.#QNAN;		% H01__UGP_dm
g_p120 = 0.05;		% PPASE_f
g_p121 = 0.07;		% PPASE_k_ppi
g_p122 = 4;		% PPASE_n
g_p123 = 1;		% H01__PPASE_P
g_p124 = 1.#QNAN;		% H01__PPASE_Vmax
g_p125 = 2;		% NDKU_f
g_p126 = 1;		% NDKU_keq
g_p127 = 1.33;		% NDKU_k_atp
g_p128 = 0.042;		% NDKU_k_adp
g_p129 = 27;		% NDKU_k_utp
g_p130 = 0.19;		% NDKU_k_udp
g_p131 = 1;		% H01__NDKU_P
g_p132 = 1.#QNAN;		% H01__NDKU_Vmax
g_p133 = 50;		% PGM1_f
g_p134 = 10;		% PGM1_keq
g_p135 = 0.67;		% PGM1_k_glc6p
g_p136 = 0.045;		% PGM1_k_glc1p
g_p137 = 1;		% H01__PGM1_P
g_p138 = 1.#QNAN;		% H01__PGM1_Vmax
g_p139 = 0.1;		% GLY_f
g_p140 = 0.12;		% GLY_k_glc6p
g_p141 = 0.2;		% GLY_k_p
g_p142 = 1;		% H01__GLY_P
g_p143 = 1.#QNAN;		% H01__GLY_Vmax
g_p144 = 0.02;		% GTF_f
g_p145 = 0.1;		% GTF_k_udpgal
g_p146 = 0.1;		% GTF_k_udpglc
g_p147 = 1;		% H01__GTF_P
g_p148 = 1.#QNAN;		% H01__GTF_Vmax
g_p149 = 1e+006;		% GLUT2_f
g_p150 = 85.5;		% GLUT2_k_gal
g_p151 = 1;		% H01__GLUT2_P
g_p152 = 1.#QNAN;		% H01__GLUT2_Vmax
g_p153 = 1.#QNAN;		% H01__GLUT2_dm
g_p154 = 10;		% H2OT_f
g_p155 = 1;		% H2OT_k
g_p156 = 1.#QNAN;		% H01__H2OT_Vmax
g_p157 = 1.#QNAN;		% H01__H2OTM
g_p158 = 1.#QNAN;		% H01__GLUT2_GAL
g_p159 = 1.#QNAN;		% H01__GLUT2_GALM

% Boundary Conditions 
g_p160 = 0;		% PP__rbcM = rbcM[Concentration]
g_p161 = 0;		% PP__suc = suc[Concentration]
g_p162 = 0;		% PP__alb = alb[Concentration]
g_p163 = 0.00012;		% PP__gal = gal[Concentration]
g_p164 = 0;		% PP__galM = galM[Concentration]
g_p165 = 0;		% PP__h2oM = h2oM[Concentration]

% Local Parameters

if (nargin == 0)

    % set initial conditions
   xdot(1) = 0*vol__S001;		% S001__rbcM = rbcM [Concentration]
   xdot(2) = 0*vol__D001;		% D001__rbcM = rbcM [Concentration]
   xdot(3) = 0*vol__PV;		% PV__rbcM = rbcM [Concentration]
   xdot(4) = 0*vol__S001;		% S001__suc = suc [Concentration]
   xdot(5) = 0*vol__D001;		% D001__suc = suc [Concentration]
   xdot(6) = 0*vol__PV;		% PV__suc = suc [Concentration]
   xdot(7) = 0*vol__S001;		% S001__alb = alb [Concentration]
   xdot(8) = 0*vol__D001;		% D001__alb = alb [Concentration]
   xdot(9) = 0*vol__PV;		% PV__alb = alb [Concentration]
   xdot(10) = 0.00012*vol__S001;		% S001__gal = gal [Concentration]
   xdot(11) = 0.00012*vol__D001;		% D001__gal = gal [Concentration]
   xdot(12) = 0.00012*vol__PV;		% PV__gal = gal [Concentration]
   xdot(13) = 0*vol__S001;		% S001__galM = galM [Concentration]
   xdot(14) = 0*vol__D001;		% D001__galM = galM [Concentration]
   xdot(15) = 0*vol__PV;		% PV__galM = galM [Concentration]
   xdot(16) = 0*vol__S001;		% S001__h2oM = h2oM [Concentration]
   xdot(17) = 0*vol__D001;		% D001__h2oM = h2oM [Concentration]
   xdot(18) = 0*vol__PV;		% PV__h2oM = h2oM [Concentration]
   xdot(19) = 0.00012*vol__H01;		% H01__gal = D-galactose [Concentration]
   xdot(20) = 0*vol__H01;		% H01__galM = D-galactose M [Concentration]
   xdot(21) = 0*vol__H01;		% H01__h2oM = H2O M [Concentration]
   xdot(22) = 0.012*vol__H01;		% H01__glc1p = D-glucose-1-phosphate [Concentration]
   xdot(23) = 0.12*vol__H01;		% H01__glc6p = D-glucose-6-phosphate [Concentration]
   xdot(24) = 0.001*vol__H01;		% H01__gal1p = D-galactose-1-phosphate [Concentration]
   xdot(25) = 0.34*vol__H01;		% H01__udpglc = UDP-D-glucose [Concentration]
   xdot(26) = 0.11*vol__H01;		% H01__udpgal = UDP-D-galactose [Concentration]
   xdot(27) = 0.001*vol__H01;		% H01__galtol = D-galactitol [Concentration]
   xdot(28) = 2.7*vol__H01;		% H01__atp = ATP [Concentration]
   xdot(29) = 1.2*vol__H01;		% H01__adp = ADP [Concentration]
   xdot(30) = 0.27*vol__H01;		% H01__utp = UTP [Concentration]
   xdot(31) = 0.09*vol__H01;		% H01__udp = UDP [Concentration]
   xdot(32) = 5*vol__H01;		% H01__phos = Phosphate [Concentration]
   xdot(33) = 0.008*vol__H01;		% H01__ppi = Pyrophosphate [Concentration]
   xdot(34) = 0.1*vol__H01;		% H01__nadp = NADP [Concentration]
   xdot(35) = 0.1*vol__H01;		% H01__nadph = NADPH [Concentration]

else

    % listOfRules
   g_p159 = D001__GLUT2_GALM;
   g_p158 = D001__GLUT2_GAL;
   g_p157 = D001__H2OTM;
   g_p44 = g_p43;
   g_p153 = 1+((x(11)/vol__D001)+(x(14)/vol__D001))/g_p150+((x(19)/vol__H01)+(x(20)/vol__H01))/g_p150;
   g_p152 = g_p149*g_p44*g_p151/g_p45;
   g_p60 = g_p44*g_p51*g_p56*g_p59/g_p45;
   g_p138 = g_p133*g_p60*g_p137/g_p45;
   g_p143 = g_p139*g_p138*g_p142/g_p45;
   g_p118 = g_p106*g_p60*g_p117/g_p45;
   g_p124 = g_p120*g_p118*g_p123/g_p45;
   g_p119 = (1+(x(30)/vol__H01)/g_p109+(x(25)/vol__H01)/g_p116)*(1+(x(22)/vol__H01)/g_p110+(x(24)/vol__H01)/g_p113)+(1+(x(25)/vol__H01)/g_p111+(x(26)/vol__H01)/g_p114+(x(30)/vol__H01)/g_p115)*(1+(x(33)/vol__H01)/g_p112)-1;
   g_p132 = g_p125*g_p118*g_p131/g_p45;
   g_p105 = g_p98*g_p60*g_p99*g_p100*g_p104/g_p45;
   g_p97 = g_p96/g_p45*g_p87*g_p60*g_p93;
   g_p80 = g_p73*g_p60*g_p79/g_p45;
   g_p86 = g_p81*g_p80*g_p85/g_p45;
   g_p72 = g_p66*g_p60*g_p71/g_p45;
   g_p65 = g_p62*g_p60*g_p64/g_p45;
   g_p61 = (1+((x(19)/vol__H01)+(x(20)/vol__H01))/g_p57)*(1+(x(28)/vol__H01)/g_p58)+(1+(x(24)/vol__H01)/g_p53)*(1+(x(29)/vol__H01)/g_p54)-1;
   g_p148 = g_p144*g_p60*g_p147/g_p45;
   g_p50 = 3*(x(28)/vol__H01)+2*(x(29)/vol__H01)+3*(x(30)/vol__H01)+2*(x(31)/vol__H01)+(x(32)/vol__H01)+2*(x(33)/vol__H01)+(x(22)/vol__H01)+(x(23)/vol__H01)+(x(24)/vol__H01)+2*(x(25)/vol__H01)+2*(x(26)/vol__H01);
   g_p49 = (x(30)/vol__H01)+(x(31)/vol__H01)+(x(25)/vol__H01)+(x(26)/vol__H01);
   g_p48 = (x(28)/vol__H01)+(x(29)/vol__H01);
   g_p47 = (x(34)/vol__H01)+(x(35)/vol__H01);
   g_p156 = g_p154*g_p44;
   g_p9 = g_p1/g_p6;
   g_p10 = g_p9/g_p7;
   g_p11 = pi*pow(g_p2,2);
   g_p40 = g_p39/g_p10*g_p11;
   g_p13 = 2*pi*g_p2*g_p10;
   g_p12 = pi*pow(g_p2+g_p3,2)-g_p11;
   g_p36 = g_p35/g_p10*g_p11;
   g_p34 = g_p31/g_p3*g_p13;
   g_p33 = g_p31/g_p10*g_p12;
   g_p32 = g_p31/g_p10*g_p11;
   g_p30 = g_p27/g_p3*g_p13;
   g_p29 = g_p27/g_p10*g_p12;
   g_p28 = g_p27/g_p10*g_p11;
   g_p26 = g_p23/g_p3*g_p13;
   g_p25 = g_p23/g_p10*g_p12;
   g_p24 = g_p23/g_p10*g_p11;
   g_p22 = g_p19/g_p3*g_p13;
   g_p21 = g_p19/g_p10*g_p12;
   g_p20 = g_p19/g_p10*g_p11;
   g_p14 = g_p11*g_p10;
   g_p15 = g_p12*g_p10;
   vol__S001 = g_p14;
   g_p17 = 10*g_p14;
   g_p18 = g_p14;
   vol__PP = g_p17;
   g_p16 = pi*pow(g_p2+g_p3+g_p4,2)*g_p9-pi*pow(g_p2+g_p3,2)*g_p9;
   vol__D001 = g_p15;
   vol__PV = g_p18;
   g_p42 = g_p39/g_p3*g_p13;
   g_p41 = g_p39/g_p10*g_p12;
   g_p37 = g_p35/g_p10*g_p12;
   g_p38 = g_p35/g_p3*g_p13;
   vol__H01 = g_p16;
   g_p8 = g_p7*g_p6;

    % calculate rates of change
   R0 = g_p5*(g_p160/vol__PP)*g_p11;
   R1 = g_p5*(x(1)/vol__S001)*g_p11;
   R2 = g_p5*(x(3)/vol__PV)*g_p11;
   R3 = g_p5*(g_p161/vol__PP)*g_p11;
   R4 = g_p5*(x(4)/vol__S001)*g_p11;
   R5 = g_p5*(x(6)/vol__PV)*g_p11;
   R6 = g_p5*(g_p162/vol__PP)*g_p11;
   R7 = g_p5*(x(7)/vol__S001)*g_p11;
   R8 = g_p5*(x(9)/vol__PV)*g_p11;
   R9 = g_p5*(g_p163/vol__PP)*g_p11;
   R10 = g_p5*(x(10)/vol__S001)*g_p11;
   R11 = g_p5*(x(12)/vol__PV)*g_p11;
   R12 = g_p5*(g_p164/vol__PP)*g_p11;
   R13 = g_p5*(x(13)/vol__S001)*g_p11;
   R14 = g_p5*(x(15)/vol__PV)*g_p11;
   R15 = g_p5*(g_p165/vol__PP)*g_p11;
   R16 = g_p5*(x(16)/vol__S001)*g_p11;
   R17 = g_p5*(x(18)/vol__PV)*g_p11;
   R18 = g_p20*((g_p160/vol__PP)-(x(1)/vol__S001));
   R19 = g_p20*((x(1)/vol__S001)-(x(3)/vol__PV));
   R20 = g_p22*((x(1)/vol__S001)-(x(2)/vol__D001));
   R21 = g_p24*((g_p161/vol__PP)-(x(4)/vol__S001));
   R22 = g_p24*((x(4)/vol__S001)-(x(6)/vol__PV));
   R23 = g_p26*((x(4)/vol__S001)-(x(5)/vol__D001));
   R24 = g_p28*((g_p162/vol__PP)-(x(7)/vol__S001));
   R25 = g_p28*((x(7)/vol__S001)-(x(9)/vol__PV));
   R26 = g_p30*((x(7)/vol__S001)-(x(8)/vol__D001));
   R27 = g_p32*((g_p163/vol__PP)-(x(10)/vol__S001));
   R28 = g_p32*((x(10)/vol__S001)-(x(12)/vol__PV));
   R29 = g_p34*((x(10)/vol__S001)-(x(11)/vol__D001));
   R30 = g_p36*((g_p164/vol__PP)-(x(13)/vol__S001));
   R31 = g_p36*((x(13)/vol__S001)-(x(15)/vol__PV));
   R32 = g_p38*((x(13)/vol__S001)-(x(14)/vol__D001));
   R33 = g_p40*((g_p165/vol__PP)-(x(16)/vol__S001));
   R34 = g_p40*((x(16)/vol__S001)-(x(18)/vol__PV));
   R35 = g_p42*((x(16)/vol__S001)-(x(17)/vol__D001));
   R36 = g_p60/(g_p57*g_p58)*1/(1+(x(24)/vol__H01)/g_p55)*((x(19)/vol__H01)*(x(28)/vol__H01)-(x(24)/vol__H01)*(x(29)/vol__H01)/g_p52)/g_p61;
   R37 = g_p60/(g_p57*g_p58)*1/(1+(x(24)/vol__H01)/g_p55)*(x(20)/vol__H01)*(x(28)/vol__H01)/g_p61;
   R38 = g_p65/g_p63*(x(24)/vol__H01)/(1+(x(24)/vol__H01)/g_p63);
   R39 = g_p72/(g_p68*g_p70)*((x(29)/vol__H01)*(x(32)/vol__H01)-(x(28)/vol__H01)/g_p67)/((1+(x(29)/vol__H01)/g_p68)*(1+(x(32)/vol__H01)/g_p70)+(x(28)/vol__H01)/g_p69);
   R40 = g_p80/(g_p75*g_p77)*((x(19)/vol__H01)*(x(35)/vol__H01)-(x(27)/vol__H01)*(x(34)/vol__H01)/g_p74)/((1+(x(19)/vol__H01)/g_p75)*(1+(x(35)/vol__H01)/g_p78)+(1+(x(27)/vol__H01)/g_p76)*(1+(x(34)/vol__H01)/g_p77)-1);
   R41 = g_p86/g_p83*((x(34)/vol__H01)-(x(35)/vol__H01)/g_p82)/(1+(x(34)/vol__H01)/g_p83+(x(35)/vol__H01)/g_p84);
   R42 = g_p97/(g_p94*g_p95)*((x(24)/vol__H01)*(x(25)/vol__H01)-(x(22)/vol__H01)*(x(26)/vol__H01)/g_p88)/((1+(x(24)/vol__H01)/g_p94)*(1+(x(25)/vol__H01)/g_p95+(x(31)/vol__H01)/g_p92+(x(30)/vol__H01)/g_p91)+(1+(x(22)/vol__H01)/g_p89)*(1+(x(26)/vol__H01)/g_p90)-1);
   R43 = g_p105/g_p102*((x(25)/vol__H01)-(x(26)/vol__H01)/g_p101)/(1+(x(25)/vol__H01)/g_p102+(x(26)/vol__H01)/g_p103);
   R44 = g_p118/(g_p109*g_p110)*((x(22)/vol__H01)*(x(30)/vol__H01)-(x(25)/vol__H01)*(x(33)/vol__H01)/g_p108)/g_p119;
   R45 = g_p107*g_p118/(g_p109*g_p113)*((x(24)/vol__H01)*(x(30)/vol__H01)-(x(26)/vol__H01)*(x(33)/vol__H01)/g_p108)/g_p119;
   R46 = g_p124*pow((x(33)/vol__H01),g_p122)/(pow((x(33)/vol__H01),g_p122)+pow(g_p121,g_p122));
   R47 = g_p132/g_p127/g_p130*((x(28)/vol__H01)*(x(31)/vol__H01)-(x(29)/vol__H01)*(x(30)/vol__H01)/g_p126)/((1+(x(28)/vol__H01)/g_p127)*(1+(x(31)/vol__H01)/g_p130)+(1+(x(29)/vol__H01)/g_p128)*(1+(x(30)/vol__H01)/g_p129)-1);
   R48 = g_p138/g_p136*((x(22)/vol__H01)-(x(23)/vol__H01)/g_p134)/(1+(x(22)/vol__H01)/g_p136+(x(23)/vol__H01)/g_p135);
   R49 = g_p143*((x(23)/vol__H01)-g_p140)/g_p140*(x(32)/vol__H01)/((x(32)/vol__H01)+g_p141);
   R50 = g_p148*(x(26)/vol__H01)/((x(26)/vol__H01)+g_p145);
   R51 = 0*g_p148*(x(25)/vol__H01)/((x(25)/vol__H01)+g_p146);
   R52 = g_p152/(g_p150*g_p7)*((x(11)/vol__D001)-(x(19)/vol__H01))/g_p153;
   R53 = g_p152/(g_p150*g_p7)*((x(14)/vol__D001)-(x(20)/vol__H01))/g_p153;
   R54 = g_p156/g_p155/g_p7*((x(17)/vol__D001)-(x(21)/vol__H01));

   xdot = [
      + R0 - R1 + R18 - R19 - R20
      + R20
      + R1 - R2 + R19
      + R3 - R4 + R21 - R22 - R23
      + R23
      + R4 - R5 + R22
      + R6 - R7 + R24 - R25 - R26
      + R26
      + R7 - R8 + R25
      + R9 - R10 + R27 - R28 - R29
      + R29 - R52
      + R10 - R11 + R28
      + R12 - R13 + R30 - R31 - R32
      + R32 - R53
      + R13 - R14 + R31
      + R15 - R16 + R33 - R34 - R35
      + R35 - R54
      + R16 - R17 + R34
      - R36 + R38 - R40 + R52
      - R37 + R53
      + R54
      + R42 - R44 - R48
      + R48 - R49
      + R36 + R37 - R38 - R42 - R45
      - R42 - R43 + R44 - R51
      + R42 + R43 + R45 - R50
      + R40
      - R36 - R37 + R39 - R47
      + R36 + R37 - R39 + R47
      - R44 - R45 + R47
      - R47 + R50 + R51
      + R38 - R39 + 2*R46 + R49
      + R44 + R45 - R46
      + R40 - R41
      - R40 + R41
   ];
end;


function z = pow (x, y) 
    z = x^y; 


function z = sqr (x) 
    z = x*x; 


function z = piecewise(varargin) 
		numArgs = nargin; 
		result = 0; 
		foundResult = 0; 
		for k=1:2: numArgs-1 
			if varargin{k+1} == 1 
				result = varargin{k}; 
				foundResult = 1; 
				break; 
			end 
		end 
		if foundResult == 0 
			result = varargin{numArgs}; 
		end 
		z = result; 


function z = gt(a,b) 
   if a > b 
   	  z = 1; 
   else 
      z = 0; 
   end 


function z = lt(a,b) 
   if a < b 
   	  z = 1; 
   else 
      z = 0; 
   end 


function z = geq(a,b) 
   if a >= b 
   	  z = 1; 
   else 
      z = 0; 
   end 


function z = leq(a,b) 
   if a <= b 
   	  z = 1; 
   else 
      z = 0; 
   end 


function z = neq(a,b) 
   if a ~= b 
   	  z = 1; 
   else 
      z = 0; 
   end 


function z = and(varargin) 
		result = 1;		 
		for k=1:nargin 
		   if varargin{k} ~= 1 
		      result = 0; 
		      break; 
		   end 
		end 
		z = result; 


function z = or(varargin) 
		result = 0;		 
		for k=1:nargin 
		   if varargin{k} ~= 0 
		      result = 1; 
		      break; 
		   end 
		end 
		z = result; 


function z = xor(varargin) 
		foundZero = 0; 
		foundOne = 0; 
		for k = 1:nargin 
			if varargin{k} == 0 
			   foundZero = 1; 
			else 
			   foundOne = 1; 
			end 
		end 
		if foundZero && foundOne 
			z = 1; 
		else 
		  z = 0; 
		end 
		 


function z = not(a) 
   if a == 1 
   	  z = 0; 
   else 
      z = 1; 
   end 


function z = root(a,b) 
	z = a^(1/b); 
 



