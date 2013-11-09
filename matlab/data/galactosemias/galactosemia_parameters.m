% Plot the alterations in kinetic parameters for the
% different galactosemias

%% [1] GALK 
%-------------------------------------------------------------------------
% GALK_P = 1;           % [mM]
% GALK_PA = 4;        % [mole]
% GALK_keq = 50;        % [-] DeltaG ~ 10kJ/mol
% GALK_k_gal1p = 1.5;   % [mM] ? 
% GALK_k_adp   = 0.8;   % [mM] ? 
% GALK_ki_gal1p = 5.3;  % [mM] [Cuatrecasas1965]
close all


GALK_kcat = [8.7, 2.0, 3.9, 5.9, 0.4, 1.1, 1.8, 6.7, 0.9]; % [1/s] [Timson2003] 
GALK_kcat_err = [0.5, 0.1, 0.8, 0.1, 0.04, 0.2, 0.1, 0.02, 0.02];
GALK_k_gal = [0.97, 7.7, 0.43, 0.66, 1.1, 13.0, 1.70, 1.90, 0.14];    % [mM]  [Timson2003]
GALK_k_gal_err = [0.22, 4.40, 0.15, 0.22, 0.16, 2.0, 0.48, 0.50, 0.01];
GALK_k_atp = [0.034, 0.130, 0.110, 0.026, 0.005, 0.089, 0.039, 0.035, 0.0039];   % [mM]  [Timson2003]
GALK_k_atp_err = [0.004, 0.009, 0.035, 0.001, 0.002, 0.034, 0.004, 0.0003, 0.0006];
%         switch (p.deficiency)
%            case 1;  GALK_kcat=2.0;    GALK_k_gal=7.7;   GALK_k_atp=0.130;
%            case 2;  GALK_kcat=3.9;    GALK_k_gal=0.43;  GALK_k_atp=0.110;
%            case 3;  GALK_kcat=5.9;    GALK_k_gal=0.66;  GALK_k_atp=0.026;
%            case 4;  GALK_kcat=0.4;    GALK_k_gal=1.1;   GALK_k_atp=0.005;
%            case 5;  GALK_kcat=1.1;    GALK_k_gal=13.0;  GALK_k_atp=0.089;
%            case 6;  GALK_kcat=1.8;    GALK_k_gal=1.70;  GALK_k_atp=0.039;
%            case 7;  GALK_kcat=6.7;    GALK_k_gal=1.90;  GALK_k_atp=0.035;
%            case 8;  GALK_kcat=0.9;    GALK_k_gal=0.14;  GALK_k_atp=0.0039;
%         end
    % GALK_Vmax = scale * GALK_PA*GALK_kcat *GALK_P/REF_P;  % [mole/s]
    % GALK_dm = ((1 +(gal+galM)/GALK_k_gal)*(1+atp/GALK_k_atp) +(1+gal1p/GALK_k_gal1p)*(1+adp/GALK_k_adp) -1);  % [-]
    % GALK  = GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+gal1p/GALK_ki_gal1p) * (gal*atp -gal1p*adp/GALK_keq)/ GALK_dm;  % [mole/s] 
    % GALKM = GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+gal1p/GALK_ki_gal1p) * galM*atp/GALK_dm;  % [mole/s]

fig_GALK = figure('Name', 'GALK', 'Color', [1 1 1], 'Position', [0 0 1000 300] );
dcolor = 'red'
for k=1:3
    switch (k)
        case 1;
            y = GALK_kcat;
            err = GALK_kcat_err;
        case 2;
            y = GALK_k_gal;
            err = GALK_k_gal_err;
        case 3;
            y = GALK_k_atp;
            err = GALK_k_atp_err;
    end
            
    subplot(1,3,k),
     %p1 = plot(0, y(1), 's', 'Color', 'black'); hold on;
     p1 = errorbar(0, y(1), err(1), 's', 'Color', 'black'); hold on;
     
     set(p1)
     set(p1, 'MarkerFaceColor', 'black')
     p1 = errorbar(1:length(y)-1, y(2:end), err(2:end), 's', 'Color', dcolor), hold on   
     % set(p1, 'MarkerFaceColor', dcolor)

     line('XData', [0 length(y)-1], 'YData', [y(1) y(1)], 'LineWidth', 2, ...
        'LineStyle', '--', 'Color', [0.3 0.3 0.3]);
     xlim([0 length(y)-1])
     axis square
     xlabel('GALK Deficiency #', 'FontWeight', 'bold', 'FontSize', 14)
     switch (k)
        case 1;
            %title('GALK kcat', 'FontWeight', 'bold')
            ylabel('kcat [1/s]', 'FontWeight', 'bold', 'FontSize', 14)
        case 2;
            %title('GALK k_{gal}', 'FontWeight', 'bold')
            ylabel('k_{gal} [mM]', 'FontWeight', 'bold', 'FontSize', 14)
        case 3;
            %title('GALK k_{atp}', 'FontWeight', 'bold')
            ylabel('k_{atp} [mM]', 'FontWeight', 'bold', 'FontSize', 14)
    end       
end
set(fig_GALK, 'PaperPositionMode', 'auto');
print(fig_GALK, '-dtiff', '-r150', 'GALK_deficiencies.tif'); 

    
    
%% [2] GALT
%-------------------------------------------------------------------------
GALT_vm = 804;            % [-] [Tang2011]
GALT_k_gal1p  = 1.25;     % [mM] [Tang2011] (too high ?, 0.061 [Geeganage1998])
GALT_k_udpglc = 0.43;     % [mM] [Tang2011]
if (p.deficiency >= 9 && p.deficiency <= 14)
%       E       Variant	Vmax        Km(gal1p)[mM](%wt)	Km(udpglc)[mM](%wt)	Reference
%   	GALT	Wild Type	804±65 (100)	1.25±0.36 (100)	0.43±0.09 (100)	(Tang, et al., 2012)
% 9     GALT	R201C	396±59 (49)	1.89±0.62 (151)	0.58±0.13 (135)	(Tang, et al., 2012)
% 10	GALT	E220K	253±53 (31)	2.34±0.42 (187)	0.69±0.16 (160)	(Tang, et al., 2012)
% 11	GALT	R223S	297±25 (37)	1.12±0.31 (90)	0.76±0.09 (177)	(Tang, et al., 2012)
% 12	GALT	I278N	45±3 (6)	1.98±0.35 (158)	1.23±0.28 (286)	(Tang, et al., 2012)
% 13	GALT	L289F	306±23 (38)	2.14±0.21 (171)	0.48±0.13 (112)	(Tang, et al., 2012)
% 14	GALT	E291V	385±18 (48)	2.68±0.16 (214)	0.95±0.43 (221)	(Tang, et al., 2012)
    switch (p.deficiency)
       case 9;  GALT_vm=396;  GALT_k_gal1p=1.89; GALT_k_udpglc=0.58;
       case 10; GALT_vm=253;  GALT_k_gal1p=2.34; GALT_k_udpglc=0.69;
       case 11; GALT_vm=297;  GALT_k_gal1p=1.12; GALT_k_udpglc=0.76;
       case 12; GALT_vm=45;   GALT_k_gal1p=1.98; GALT_k_udpglc=1.23;
       case 13; GALT_vm=306;  GALT_k_gal1p=2.14; GALT_k_udpglc=0.48;
       case 14; GALT_vm=385;  GALT_k_gal1p=2.68; GALT_k_udpglc=0.95;           
    end
    %fprintf('GALT deficiency: %s\n', num2str(p.deficiency));
end

%% [3] GALE
%-------------------------------------------------------------------------
GALE_k_udpglc  = 0.069;   % [mM] [Timson2005]
GALE_k_udpgal  = 0.3;     % [mM] [?]
if (p.deficiency >= 15 && p.deficiency <= 23)
% 	GALE	Wild Type	36±1.4 (100)	0.069±0.012 (100)		(Timson, 2005)
% 15	GALE	N34S	32±1.3 (89)     0.082±0.015 (119)		(Timson, 2005)
% 16	GALE	G90E	0.046±0.0028 (0)0.093±0.024 (135)		(Timson, 2005)
% 17	GALE	V94M	1.1±0.088 (3)	0.160±0.038 (232)		(Timson, 2005)
% 18	GALE	D103G	5.0±0.23 (14)	0.140±0.021 (203)		(Timson, 2005)
% 19	GALE	L183P	11±1.2 (31)     0.097±0.040 (141)		(Timson, 2005)
% 20	GALE	K257R	5.1±0.29 (14)	0.066±0.015 (96)		(Timson, 2005)
% 21	GALE	L313M	5.8±0.36 (16)	0.035±0.011 (51)		(Timson, 2005)
% 22	GALE	G319E	30±1.3 (83)     0.078±0.013 (113)		(Timson, 2005)
% 23	GALE	R335H	15±0.48 (42)	0.099±0.012 (143)		(Timson, 2005)
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

