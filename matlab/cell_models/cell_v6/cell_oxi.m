function [dxdt, V_names, V] = cell_oxi(t, x, pars, ci)
% Oxidative phosporylation
%       t : time
%       x : concentrations
%       pars : model parameters
%       ci : cell index

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
offset = pars.Nf*pars.Nx_out - pars.Nx_out; 

o2_ext  = x(2*pars.Nf+1: 3*pars.Nf);  

Vol_cell   = x(offset + 5); 
Vol_mito   = x(offset + 7);
Vol_mem   = Vol_mito * 0.3;

Vmm        = - x(offset + 59);  % ! Vmm as variable positive !

atp       = x(offset + 8);
adp       = x(offset + 9);
p         = x(offset + 12);

cl_in      = x(offset + 67);
ka_in      = x(offset + 68);
na_in      = x(offset + 69);
ca_in      = x(offset + 70);
h_in       = x(offset + 66);

cl_mito    = x(offset + 62);
ka_mito    = x(offset + 63);
na_mito    = x(offset + 64);
ca_mito    = x(offset + 65);
h_mito     = x(offset + 61);

nad_mito  = x(offset + 38);
nadh_mito = x(offset + 39);
atp_mito  = x(offset + 33);
adp_mito  = x(offset + 34);
p_mito    = x(offset + 37);

o2        = x(offset + 31);
o2_mito   = x(offset + 82);

q         = x(offset + 55);
qh2       = x(offset + 56);
cytcox    = x(offset + 57);
cytcred   = x(offset + 58);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vmm = min(-2.0, Vmm); % handle the critical drop under no oxygen
                      % if the Vmm is droped so low changes have to be
                      % fixed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
F=96490.0;  % C/mol
R=8.3;      % J/K*mol
T=293.0;    % K

% number mitochondria
n=1000;

% starting geometry
%r0=6.36;                        % in 10^-6 m
% A0=1.6*4*pi*r0*r0/(1.0e8);      % in cm*cm 
r_m=.35;
A_m=n*1.0*4*3.14159*r_m*r_m/(1.0e8); % in cm*cm

% membrane capacity in farad / cm*cm
c_m=0.9e-6;

% permeability coefficients in m/s
P_H  = 4e-4;
P_C  = 0.5e-9;
P_K  = 0.2e-9;
P_Na = 0.1e-9;
P_Ca = 0.1e-10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%in A=cm*cm, P=m/s, F=C/Mol, X_in/out/sub=mMol/liter=Mol/m^3
%=> cm*cm*m/s*C/Mol*Mol/m3=10^-4 m^3/s*C*Mol/Mol/m^3=10-4 C/s =10^4 A
% currents (in 10^-4 A)
U = Vmm/1000.0*F/R/T;

% Calcium
I_CaP   = 1e-7*(ca_mito - 3e6*ca_in.^3);
I_Ca_ed = 2.0*A_m*P_Ca*U*F*(ca_in-ca_mito*exp(2.0*U))/(1-exp(2.0*U));

% Chlorid
I_C_ed  = A_m*P_C*U*F*(cl_in-cl_mito*exp(-U))/(1-exp(-U));

% Potasium (Kalium)
I_K_P   = n*3e-8*(ka_in*h_mito-ka_mito*h_in);                                   
I_K_ed  = -A_m*P_K*U*F*(ka_in-ka_mito*exp(U))/(1-exp(U)) ;

% Sodium (Natrium)
I_Na_P = n*2e-7*(na_in*h_mito-na_mito*h_in);
I_Na_ed = -A_m*P_Na*U*F*(na_in-na_mito*exp(U))/(1-exp(U)) + I_Na_P; 

%Proton
I_H_ed  = -A_m*P_H*U*F*(h_in-h_mito*exp(U))/(1-exp(U));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ATP/ADP exchanger
%ADP_in + ATP_mito -> ADP_mito +  ATP_in exchanger in 10^-4 A

v_ex = 60e-10 *n* (1-atp.*adp_mito./(adp.*atp_mito) .* exp(Vmm/1000.0*F/R/T)) ...
       ./ (1 + atp./adp.*exp(0.3*Vmm/1000.0*F/R/T) .* (1 + adp_mito./atp_mito));

% Phosphate transporter in 10^-4 A
v_Phos =  1e5 *n*F*Vol_mito*(p*h_in - p_mito*h_mito);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %Thermodynamic
% dGp = -Vmm + R*T/F*1000*log(h_in./h_mito);
% 
% Em_N = -291 + 0.5*R*T/F*1000*log(nad_mito./nadh_mito);
% Em_Q = 87 + 0.5*R*T/F*1000*log(q./qh2);
% Em_C = 221 + R*T/F*1000*log(cytcox./cytcred);
% 
% % Complex1 : NADH + Q -> NAD + QH2
% dG1 = Em_Q - Em_N - 2*dGp; 
% v1 = A_m*33*max(-50,min(50,dG1))*1e-5.*q./(q+1e-6).*(q>1e-8).*(nadh_mito>1e-6);
% 
% % Complex2 : Q -> QH2
% v_succdh = 0.16*8e3*(suc_mito.*q)./(suc_mito + 1.6).*(q>1e-8);
% v_c2     = v_succdh*1e1*F.*Vol_mito;
% 
% % Complex3 : QH2 + cyt_ox -> Q + cyt_red
% dG3 = Em_C - Em_Q  - dGp;
% v3 = A_m*51*max(-50,min(50,dG3))*1e-5*cytcox./(cytcox + 1e-5).*(cytcox>2e-6).*qh2./(qh2+1e-6).*(qh2>1e-8);
% 
% 
% % Complex4 : cyt_red + O2 -> H2O
% v4 =A_m*2.4/200.*cytcred./(cytcred + 1e-5).*o2./(o2 + 0.01).*(o2>1e-3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Complex1 NADH + Q -> NAD + QH2
Keq_c1 = exp((2*320 + 2*87 + 4*Vmm)*F/R/T/1000) * (h_mito/h_in)^4;
v1     = 4.5 * (nadh_mito*q - 1/Keq_c1 *nad_mito*qh2);

%Complex2 : Q -> QH2
% see CAC !!!

%Complex3 QH2 + cyt_ox -> Q + cyt_red
%Keq_c3 = exp((- 2*87 + 2*221 + 2*Vmm)*F/R/T/1000) * (h_mito/h_in)^4;
Keq_c3 = exp((- 2*87 + 2*221 + 2*Vmm)*F/R/T/1000) * (h_mito/1E-7)^2* (1E-7/h_in)^4;
v3     = 4.5e3 * (qh2*cytcox^2 - 1/Keq_c3*q*cytcred^2);

%Complex4 cyt_red + O2 -> H2O
%v4    =  300e-4 * (h_mito/h_in)^6 * cytcred/(cytcred+0.007) ...
%                         * o2_mito/(o2_mito+0.1*1.3/760);
v4    =  300e-4 * (h_mito/h_in)^6 * cytcred/(cytcred+0.007) ...
                         * o2_mito/(o2_mito+1.0*1.3/760);
                     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ATP-Synthetase in 10^-4 A
% dG_syn  = 3*F*dGp/1000 - 30500 - R*T*log(atp_mito./(adp_mito.*p_mito));
% v_syn   =  - 15e-8*atp_mito./(atp_mito + 1e-3).*abs(dG_syn)./(abs(dG_syn) + 10).*(dG_syn<0) ...
%            + 22e-8*adp_mito./(adp_mito + .1).*p_mito./(p_mito + 1).*abs(dG_syn)./(abs(dG_syn) + 10).*(dG_syn>0); 

Keq_f0f1 = exp(-30500/(R*T) - 3*(Vmm*F/R/T/1000)) * (h_in/h_mito)^3;     %exp((120 + 0.1*Vmm)*F/R/T/1000 )*h_in/1e-4
v_syn = 1e-7 * (adp_mito*p_mito - 1/Keq_f0f1 *atp_mito);                  %./((1 + adp_mito/0.1));%.*(1 + p_mito/1));% + (1+atp_mito/0.1) -1);
         
% Oxygen usage
% v_o2_use = 0.5 * v4 * 1e-1/F/Vol_cell;  
v_o2_use = 0.5 * v4 * 1e-1/F/Vol_mito;  

% Oxygen import
%v_o2T_ext = (24*760/1.3)/pars.Nf  * (o2_ext - o2*ones(pars.Nf,1));
v_o2T_ext = 0.2*(0.5*760/1.3)/pars.Nf  * (o2_ext - o2*ones(pars.Nf,1));
v_o2T_in =  sum(v_o2T_ext);
v_o2TM =   0.1*(0.3*760/1.3) * (o2 - o2_mito);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I_Ca_ed = I_Ca_ed;
I_CaP   = I_CaP;

I_K_P = I_K_P;
I_K_ed = I_K_ed;

I_Na_P = I_Na_P;
I_Na_ed = I_Na_ed;

I_C_ed = I_C_ed;
I_H_ed = I_H_ed;

v1   = v1;
v3   = v3;
v4   = v4;

v_syn = v_syn;
v_ex  = v_ex;
v_Phos = v_Phos ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I_H_P   = -(4*v1+4*v3+2*v4); 
I_H     = I_H_ed + I_H_P  - I_Na_P - I_K_P + v_Phos + 3*v_syn;
I_C     = I_C_ed;
I_Ca    = I_Ca_ed + I_CaP;
I_K     = I_K_ed + I_K_P; 
I_Na    = I_Na_ed + I_Na_P;

% changes in ion concentration
% Ionenkonzentrationen in mM 
% I_X=10^-4 A = 10^-4 C/s; I_X / F= 10^-4 C/s / C/Mol = 10^-4 Mol/s;
% I_X/F / Vol = 10^-4 Mol/s / liter = 10^-4 M/s = 10^-1 mM/s daher:
% 1e-1* I_X/F/Vol = mM/s 

v_h_in = 0;%-1e-1*I_H/F/Vol_cell;
v_h_mito = 1e-1*I_H/F/Vol_mito;

v_ka_in = 0;%-1e-1*I_K/F/Vol_cell;
v_ka_mito = 1e-1*I_K/F/Vol_mito;

v_cl_in = 0;%-1e-1*I_C/F/Vol_cell;
v_cl_mito = 1e-1*I_C/F/Vol_mito;

v_na_in =0;% -1e-1*I_Na/F/Vol_cell;
v_na_mito = 1e-1*I_Na/F/Vol_mito;

v_ca_in = 0;% 1e-1*I_Ca/F/Vol_cell;
v_ca_mito =  -1e-1*I_Ca/F/Vol_mito;

%Membranspannung 1/c_m*A=1/F*cm*cm/cm*cm=1/F=1/C/V=V/C; I_X=10^-4 A =10^-4 C/s
%=>1/(cm*A)*I_X = 10^-4 V/s; v_V soll in 10^-3 V/s gemessen werden:
%=>10^-4 V/s =10^-1 * 10^-3 V/s, daher:

v_Vmm =  1e-1/(c_m*A_m)*(-I_C + I_K + I_H + I_Na - v_Phos + v_ex);
% the minimum value is reached, do not let Vmm fall lower
% handle the critical drop under no oxygen
if (abs(-2.0-Vmm)<=1E-3)
    if (v_Vmm > 0.0)
        v_Vmm = 0.0;
    end
end
                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Metabolites
v_atp =   1e-1*v_ex/(Vol_cell*F);  
v_adp = - 1e-1*v_ex/(Vol_cell*F); 
v_p   = -1e-1*(v_Phos)/F/Vol_cell;

v_atp_mito = - 1e-1*v_ex/(Vol_mito*F) + 1e-1*v_syn/(Vol_mito*F);
v_adp_mito =   1e-1*v_ex/(Vol_mito*F) - 1e-1*v_syn/(Vol_mito*F);

v_nad_mito  =   v1*1e-1/F/Vol_mito;
v_nadh_mito = - v1*1e-1/F/Vol_mito;

v_p_mito =  1e-1*(v_Phos - v_syn)/F/Vol_mito;
v_o2_ext = -v_o2T_ext * pars.Vol_cell/pars.Vol_blood;     % difference based on layout

v_o2_in = v_o2T_in - v_o2TM;
v_o2_mito = v_o2TM*Vol_cell/Vol_mito - v_o2_use;

v_q   = 1e-1/F/Vol_mem*(-v1  + v3);   %- v_c2
v_qh2 = 1e-1/F/Vol_mem*(+v1  - v3);   %+ v_c2

v_cytcox = 1e-1/F/Vol_mem*(-v3 + v4);
v_cytcred = 1e-1/F/Vol_mem*(+v3 - v4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scale_oxi = 0.75*100;               
scale_oxi = scale_oxi * o2/(o2+0.01*1.3/760); % Shut down oxi without oxygen
fac = scale_oxi * pars.f_oxi(ci);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxdt = zeros(size(x));

dxdt(2*pars.Nf+1 : 3*pars.Nf)  =  fac * v_o2_ext;
dxdt(offset + 31)              =  fac *  v_o2_in;
dxdt(offset + 82)              =  fac * v_o2_mito;

dxdt(offset + 59) =     - fac * v_Vmm;

dxdt(offset + 8)  =     fac * v_atp;
dxdt(offset + 9)  =     fac * v_adp;
dxdt(offset + 12) =     fac * v_p;

dxdt(offset + 33) =     fac * v_atp_mito;
dxdt(offset + 34) =     fac * v_adp_mito;
dxdt(offset + 37) =     fac * v_p_mito;
dxdt(offset + 38) =     fac * v_nad_mito;
dxdt(offset + 39) =     fac * v_nadh_mito;

dxdt(offset + 55) =     fac * v_q;
dxdt(offset + 56) =     fac * v_qh2;
dxdt(offset + 57) =     fac * v_cytcox;
dxdt(offset + 58) =     fac * v_cytcred;

dxdt(offset + 66) =     fac * v_h_in;
dxdt(offset + 67) =     fac * v_cl_in;
dxdt(offset + 68) =     fac * v_ka_in;
dxdt(offset + 69) =     fac * v_na_in;
dxdt(offset + 70) =     fac * v_ca_in;
    
dxdt(offset + 61) =     fac * v_h_mito;    
dxdt(offset + 62) =     fac * v_cl_mito;
dxdt(offset + 63) =     fac * v_ka_mito;
dxdt(offset + 64) =     fac * v_na_mito;
dxdt(offset + 65) =     fac * v_ca_mito;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargout > 1
    V_names{1} = 'v_syn';           V(1) = v_syn;
    V_names{2} = 'v_o2_use';        V(2) = v_o2_use;  
    V_names{3} = 'v_ex';            V(3) = v_ex;
    V_names{4} = 'v1';              V(4) = v1;
    V_names{5} = 'v3';              V(5) = v3;
    V_names{6} = 'v4';              V(6) = v4;
    V_names{7} = 'v_Phos';          V(7) = v_Phos;
    
    V_names{8} = 'v_oxi_nad';       V(8) = v_nad_mito;
    V_names{9} = 'v_oxi_nadh';      V(9) = v_nadh_mito;
    V_names{10} ='v_oxi_q';        V(10) = 1e-1./F/Vol_mem*(-v1);
    V_names{11}= 'v_oxi_qh2';       V(11) = 1e-1./F/Vol_mem*(v1);

    V_names{12}= 'v_oxi_atp';       V(12) = 1e-1*v_syn/(Vol_mito*F);
    V_names{13}= 'v_oxi_atp_cyt';   V(13) = v_atp;
    V_names{14}= 'v_o2T_in';        V(14) = v_o2T_in;
    V_names{15}= 'v_o2TM';          V(15) = v_o2TM;
    V_names{16}= 'v_o2_use_cell';   V(16) = v_o2_use * Vol_mito;
    V = fac*V;
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
