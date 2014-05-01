function xdot = Galactose_v13_Nc1_Nf1_no_events(time,x)
%  synopsis:
%     xdot = Galactose_v13_Nc1_Nf1_no_events (time, x)
%     x0 = Galactose_v13_Nc1_Nf1_no_events
%
%  Galactose_v13_Nc1_Nf1_no_events can be used with odeN functions as follows:
%
%  x0 = Galactose_v13_Nc1_Nf1_no_events;
%  [t,x] = ode23s(@Galactose_v13_Nc1_Nf1_no_events, [0 100], Galactose_v13_Nc1_Nf1_no_events);
%  plot (t,x);
%
%  where 100 is the end time
%
%  When Galactose_v13_Nc1_Nf1_no_events is used without any arguments it returns a vector of
%  the initial concentrations of the 26 floating species.
%  Otherwise Galactose_v13_Nc1_Nf1_no_events should be called with two arguments:
%  time and x.  time is the current time. x is the vector of the
%  concentrations of the 26 floating species.
%  When these parameters are supplied Galactose_v13_Nc1_Nf1_no_events returns a vector of 
%  the rates of change of the concentrations of the 26 floating species.
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
%  x(1)        S001__gal
%  x(2)        D001__gal
%  x(3)        PV__gal
%  x(4)        S001__galM
%  x(5)        D001__galM
%  x(6)        PV__galM
%  x(7)        S001__h2oM
%  x(8)        D001__h2oM
%  x(9)        PV__h2oM
%  x(10)        H01__gal
%  x(11)        H01__galM
%  x(12)        H01__h2oM
%  x(13)        H01__glc1p
%  x(14)        H01__glc6p
%  x(15)        H01__gal1p
%  x(16)        H01__udpglc
%  x(17)        H01__udpgal
%  x(18)        H01__galtol
%  x(19)        H01__atp
%  x(20)        H01__adp
%  x(21)        H01__utp
%  x(22)        H01__udp
%  x(23)        H01__phos
%  x(24)        H01__ppi
%  x(25)        H01__nadp
%  x(26)        H01__nadph

xdot = zeros(26, 1);

% List of Compartments 
vol__PP = 3.04106e-014;		%[PP] periportal
vol__S001 = 3.04106e-014;		%[S001] Sinusoid Space 1
vol__D001 = 1.88496e-014;		%[D001] Disse Space 1
vol__PV = 3.04106e-014;		%[PV] perivenious
vol__H01 = 2.23607e-013;		%[H01] Hepatocyte 1

% Global Parameters 
g_p1 = 0.0005;		% L
g_p2 = 4.4e-006;		% y_sin
g_p3 = 1.2e-006;		% y_dis
g_p4 = 7.58e-006;		% y_cell
g_p5 = 0.00018;		% flow_sin
g_p6 = 0.09;		% f_fen
g_p7 = 1;		% Nc
g_p8 = 1;		% Nf
g_p9 = 1;		% Nb
g_p10 = 0.0005;		% x_cell
g_p11 = 0.0005;		% x_sin
g_p12 = 6.08212e-011;		% A_sin
g_p13 = 3.76991e-011;		% A_dis
g_p14 = 1.3823e-008;		% A_sindis
g_p15 = 3.04106e-014;		% Vol_sin
g_p16 = 1.88496e-014;		% Vol_dis
g_p17 = 2.23607e-013;		% Vol_cell
g_p18 = 3.04106e-014;		% Vol_pp
g_p19 = 3.04106e-014;		% Vol_pv
g_p20 = 9.1e-010;		% Dgal
g_p21 = 1.10695e-016;		% Dx_sin_gal
g_p22 = 6.86124e-017;		% Dx_dis_gal
g_p23 = 9.4342e-013;		% Dy_sindis_gal
g_p24 = 9.1e-010;		% DgalM
g_p25 = 1.10695e-016;		% Dx_sin_galM
g_p26 = 6.86124e-017;		% Dx_dis_galM
g_p27 = 9.4342e-013;		% Dy_sindis_galM
g_p28 = 2.2e-009;		% Dh2oM
g_p29 = 2.67613e-016;		% Dx_sin_h2oM
g_p30 = 1.65876e-016;		% Dx_dis_h2oM
g_p31 = 2.2808e-012;		% Dy_sindis_h2oM
g_p32 = 1e-014;		% scale_f
g_p33 = 1e-014;		% scale
g_p34 = 1;		% REF_P
g_p35 = 0;		% deficiency
g_p36 = 0.2;		% H01__nadp_tot
g_p37 = 3.9;		% H01__adp_tot
g_p38 = 0.81;		% H01__udp_tot
g_p39 = 17.539;		% H01__phos_tot
g_p40 = 0.1;		% GALK_PA
g_p41 = 50;		% GALK_keq
g_p42 = 1.5;		% GALK_k_gal1p
g_p43 = 0.8;		% GALK_k_adp
g_p44 = 5.3;		% GALK_ki_gal1p
g_p45 = 8.7;		% GALK_kcat
g_p46 = 0.97;		% GALK_k_gal
g_p47 = 0.034;		% GALK_k_atp
g_p48 = 1;		% H01__GALK_P
g_p49 = 8.7e-015;		% H01__GALK_Vmax
g_p50 = 81.9234;		% H01__GALK_dm
g_p51 = 0.05;		% IMP_f
g_p52 = 0.35;		% IMP_k_gal1p
g_p53 = 1;		% H01__IMP_P
g_p54 = 4.35e-016;		% H01__IMP_Vmax
g_p55 = 100;		% ATPS_f
g_p56 = 0.58;		% ATPS_keq
g_p57 = 0.1;		% ATPS_k_adp
g_p58 = 0.5;		% ATPS_k_atp
g_p59 = 0.1;		% ATPS_k_phos
g_p60 = 1;		% H01__ATPS_P
g_p61 = 8.7e-013;		% H01__ATPS_Vmax
g_p62 = 1e+006;		% ALDR_f
g_p63 = 4;		% ALDR_keq
g_p64 = 40;		% ALDR_k_gal
g_p65 = 40;		% ALDR_k_galtol
g_p66 = 0.1;		% ALDR_k_nadp
g_p67 = 0.1;		% ALDR_k_nadph
g_p68 = 1;		% H01__ALDR_P
g_p69 = 8.7e-009;		% H01__ALDR_Vmax
g_p70 = 1e-010;		% NADPR_f
g_p71 = 1;		% NADPR_keq
g_p72 = 0.015;		% NADPR_k_nadp
g_p73 = 0.01;		% NADPR_ki_nadph
g_p74 = 1;		% H01__NADPR_P
g_p75 = 8.7e-019;		% H01__NADPR_Vmax
g_p76 = 0.01;		% GALT_f
g_p77 = 1;		% GALT_keq
g_p78 = 0.37;		% GALT_k_glc1p
g_p79 = 0.5;		% GALT_k_udpgal
g_p80 = 0.13;		% GALT_ki_utp
g_p81 = 0.35;		% GALT_ki_udp
g_p82 = 804;		% GALT_vm
g_p83 = 1.25;		% GALT_k_gal1p
g_p84 = 0.43;		% GALT_k_udpglc
g_p85 = 1;		% H01__GALT_P
g_p86 = 6.9948e-014;		% H01__GALT_Vmax
g_p87 = 0.3;		% GALE_f
g_p88 = 0.0278;		% GALE_PA
g_p89 = 36;		% GALE_kcat
g_p90 = 0.33;		% GALE_keq
g_p91 = 0.069;		% GALE_k_udpglc
g_p92 = 0.3;		% GALE_k_udpgal
g_p93 = 1;		% H01__GALE_P
g_p94 = 2.61209e-015;		% H01__GALE_Vmax
g_p95 = 2000;		% UGP_f
g_p96 = 0.01;		% UGALP_f
g_p97 = 0.45;		% UGP_keq
g_p98 = 0.563;		% UGP_k_utp
g_p99 = 0.172;		% UGP_k_glc1p
g_p100 = 0.049;		% UGP_k_udpglc
g_p101 = 0.166;		% UGP_k_ppi
g_p102 = 5;		% UGP_k_gal1p
g_p103 = 0.42;		% UGP_k_udpgal
g_p104 = 0.643;		% UGP_ki_utp
g_p105 = 0.643;		% UGP_ki_udpglc
g_p106 = 1;		% H01__UGP_P
g_p107 = 1.74e-011;		% H01__UGP_Vmax
g_p108 = 10.1849;		% H01__UGP_dm
g_p109 = 0.05;		% PPASE_f
g_p110 = 0.07;		% PPASE_k_ppi
g_p111 = 4;		% PPASE_n
g_p112 = 1;		% H01__PPASE_P
g_p113 = 8.7e-013;		% H01__PPASE_Vmax
g_p114 = 2;		% NDKU_f
g_p115 = 1;		% NDKU_keq
g_p116 = 1.33;		% NDKU_k_atp
g_p117 = 0.042;		% NDKU_k_adp
g_p118 = 27;		% NDKU_k_utp
g_p119 = 0.19;		% NDKU_k_udp
g_p120 = 1;		% H01__NDKU_P
g_p121 = 3.48e-011;		% H01__NDKU_Vmax
g_p122 = 50;		% PGM1_f
g_p123 = 10;		% PGM1_keq
g_p124 = 0.67;		% PGM1_k_glc6p
g_p125 = 0.045;		% PGM1_k_glc1p
g_p126 = 1;		% H01__PGM1_P
g_p127 = 4.35e-013;		% H01__PGM1_Vmax
g_p128 = 0.1;		% GLY_f
g_p129 = 0.12;		% GLY_k_glc6p
g_p130 = 0.2;		% GLY_k_p
g_p131 = 1;		% H01__GLY_P
g_p132 = 4.35e-014;		% H01__GLY_Vmax
g_p133 = 0.02;		% GTF_f
g_p134 = 0.1;		% GTF_k_udpgal
g_p135 = 0.1;		% GTF_k_udpglc
g_p136 = 1;		% H01__GTF_P
g_p137 = 1.74e-016;		% H01__GTF_Vmax
g_p138 = 1e+006;		% GLUT2_f
g_p139 = 85.5;		% GLUT2_k_gal
g_p140 = 1;		% H01__GLUT2_P
g_p141 = 1e-008;		% H01__GLUT2_Vmax
g_p142 = 1;		% H01__GLUT2_dm
g_p143 = 10;		% H2OT_f
g_p144 = 1;		% H2OT_k
g_p145 = 1e-013;		% H01__H2OT_Vmax
g_p146 = 0;		% H01__H2OTM
g_p147 = 0;		% H01__GLUT2_GAL
g_p148 = 0;		% H01__GLUT2_GALM

% Boundary Conditions 
g_p149 = 3.64927e-018;		% PP__gal = gal [Amount]
g_p150 = 0;		% PP__galM = galM [Amount]
g_p151 = 0;		% PP__h2oM = h2oM [Amount]

% Local Parameters

if (nargin == 0)

    % set initial conditions
   xdot(1) = 3.64927e-018;		% S001__gal = gal [Amount]
   xdot(2) = 2.26195e-018;		% D001__gal = gal [Amount]
   xdot(3) = 3.64927e-018;		% PV__gal = gal [Amount]
   xdot(4) = 0;		% S001__galM = galM [Amount]
   xdot(5) = 0;		% D001__galM = galM [Amount]
   xdot(6) = 0;		% PV__galM = galM [Amount]
   xdot(7) = 0;		% S001__h2oM = h2oM [Amount]
   xdot(8) = 0;		% D001__h2oM = h2oM [Amount]
   xdot(9) = 0;		% PV__h2oM = h2oM [Amount]
   xdot(10) = 2.68328e-017;		% H01__gal = D-galactose [Amount]
   xdot(11) = 0;		% H01__galM = D-galactose M [Amount]
   xdot(12) = 0;		% H01__h2oM = H2O M [Amount]
   xdot(13) = 2.68328e-015;		% H01__glc1p = D-glucose-1-phosphate [Amount]
   xdot(14) = 2.68328e-014;		% H01__glc6p = D-glucose-6-phosphate [Amount]
   xdot(15) = 2.23607e-016;		% H01__gal1p = D-galactose-1-phosphate [Amount]
   xdot(16) = 7.60263e-014;		% H01__udpglc = UDP-D-glucose [Amount]
   xdot(17) = 2.45967e-014;		% H01__udpgal = UDP-D-galactose [Amount]
   xdot(18) = 2.23607e-016;		% H01__galtol = D-galactitol [Amount]
   xdot(19) = 6.03738e-013;		% H01__atp = ATP [Amount]
   xdot(20) = 2.68328e-013;		% H01__adp = ADP [Amount]
   xdot(21) = 6.03738e-014;		% H01__utp = UTP [Amount]
   xdot(22) = 2.01246e-014;		% H01__udp = UDP [Amount]
   xdot(23) = 1.11803e-012;		% H01__phos = Phosphate [Amount]
   xdot(24) = 1.78885e-015;		% H01__ppi = Pyrophosphate [Amount]
   xdot(25) = 2.23607e-014;		% H01__nadp = NADP [Amount]
   xdot(26) = 2.23607e-014;		% H01__nadph = NADPH [Amount]

else

    % listOfRules
   g_p49 = g_p33*g_p40*g_p45*g_p48/g_p34;
   g_p50 = (1+((x(10)/vol__H01)/vol__H01+(x(11)/vol__H01)/vol__H01)/g_p46)*(1+(x(19)/vol__H01)/vol__H01/g_p47)+(1+(x(15)/vol__H01)/vol__H01/g_p42)*(1+(x(20)/vol__H01)/vol__H01/g_p43)-1;
   g_p54 = g_p51*g_p49*g_p53/g_p34;
   g_p61 = g_p55*g_p49*g_p60/g_p34;
   g_p69 = g_p62*g_p49*g_p68/g_p34;
   g_p75 = g_p70*g_p69*g_p74/g_p34;
   g_p86 = g_p85/g_p34*g_p76*g_p49*g_p82;
   g_p94 = g_p87*g_p49*g_p88*g_p89*g_p93/g_p34;
   g_p107 = g_p95*g_p49*g_p106/g_p34;
   g_p108 = (1+(x(21)/vol__H01)/vol__H01/g_p98+(x(16)/vol__H01)/vol__H01/g_p105)*(1+(x(13)/vol__H01)/vol__H01/g_p99+(x(15)/vol__H01)/vol__H01/g_p102)+(1+(x(16)/vol__H01)/vol__H01/g_p100+(x(17)/vol__H01)/vol__H01/g_p103+(x(21)/vol__H01)/vol__H01/g_p104)*(1+(x(24)/vol__H01)/vol__H01/g_p101)-1;
   g_p113 = g_p109*g_p107*g_p112/g_p34;
   g_p121 = g_p114*g_p107*g_p120/g_p34;
   g_p127 = g_p122*g_p49*g_p126/g_p34;
   g_p132 = g_p128*g_p127*g_p131/g_p34;
   g_p137 = g_p133*g_p49*g_p136/g_p34;
   g_p141 = g_p138*g_p33*g_p140/g_p34;
   g_p142 = 1+((x(2)/vol__D001)/vol__D001+(x(5)/vol__D001)/vol__D001)/g_p139+((x(10)/vol__H01)/vol__H01+(x(11)/vol__H01)/vol__H01)/g_p139;
   g_p145 = g_p143*g_p33;

    % calculate rates of change
   R0 = g_p5*((g_p149/vol__PP)/vol__PP)*g_p12;
   R1 = g_p5*((x(1)/vol__S001)/vol__S001)*g_p12;
   R2 = ;
   R3 = g_p5*((g_p150/vol__PP)/vol__PP)*g_p12;
   R4 = g_p5*((x(4)/vol__S001)/vol__S001)*g_p12;
   R5 = ;
   R6 = g_p5*((g_p151/vol__PP)/vol__PP)*g_p12;
   R7 = g_p5*((x(7)/vol__S001)/vol__S001)*g_p12;
   R8 = ;
   R9 = g_p21*((g_p149/vol__PP)/vol__PP-(x(1)/vol__S001)/vol__S001);
   R10 = g_p21*((x(1)/vol__S001)/vol__S001-(x(3)/vol__PV)/vol__PV);
   R11 = g_p23*((x(1)/vol__S001)/vol__S001-(x(2)/vol__D001)/vol__D001);
   R12 = g_p25*((g_p150/vol__PP)/vol__PP-(x(4)/vol__S001)/vol__S001);
   R13 = g_p25*((x(4)/vol__S001)/vol__S001-(x(6)/vol__PV)/vol__PV);
   R14 = g_p27*((x(4)/vol__S001)/vol__S001-(x(5)/vol__D001)/vol__D001);
   R15 = g_p29*((g_p151/vol__PP)/vol__PP-(x(7)/vol__S001)/vol__S001);
   R16 = g_p29*((x(7)/vol__S001)/vol__S001-(x(9)/vol__PV)/vol__PV);
   R17 = g_p31*((x(7)/vol__S001)/vol__S001-(x(8)/vol__D001)/vol__D001);
   R18 = ;
   R19 = ;
   R20 = ;
   R21 = ;
   R22 = ;
   R23 = ;
   R24 = ;
   R25 = ;
   R26 = ;
   R27 = ;
   R28 = ;
   R29 = ;
   R30 = ;
   R31 = ;
   R32 = ;
   R33 = ;
   R34 = g_p141/(g_p139*g_p8)*((x(2)/vol__D001)/vol__D001-(x(10)/vol__H01)/vol__H01)/g_p142;
   R35 = g_p141/(g_p139*g_p8)*((x(5)/vol__D001)/vol__D001-(x(11)/vol__H01)/vol__H01)/g_p142;
   R36 = g_p145/g_p144/g_p8*((x(8)/vol__D001)/vol__D001-(x(12)/vol__H01)/vol__H01);

   xdot = [
      + R0 - R1 + R9 - R10 - R11
      + R11 - R34
      + R1 - R2 + R10
      + R3 - R4 + R12 - R13 - R14
      + R14 - R35
      + R4 - R5 + R13
      + R6 - R7 + R15 - R16 - R17
      + R17 - R36
      + R7 - R8 + R16
      - R18 + R20 - R22 + R34
      - R19 + R35
      + R36
      + R24 - R26 - R30
      + R30 - R31
      + R18 + R19 - R20 - R24 - R27
      - R24 - R25 + R26 - R33
      + R24 + R25 + R27 - R32
      + R22
      - R18 - R19 + R21 - R29
      + R18 + R19 - R21 + R29
      - R26 - R27 + R29
      - R29 + R32 + R33
      + R20 - R21 + 2*R28 + R31
      + R26 + R27 - R28
      + R22 - R23
      - R22 + R23
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
 



