function [dxdt, V_names, V] = cell_osmoelectro(t,x,pars)
% osmo-electrical model

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
offset = pars.Nf*pars.Nx_out - pars.Nx_out; 

atp       = x(offset + 8);

Vol_cell  = x(offset + 5);

cl_in     = x(offset + 67);
ka_in     = x(offset + 68);
na_in     = x(offset + 69);
ca_in     = x(offset + 70);

cl_ext    = x(offset + 75);
ka_ext    = x(offset + 76);
na_ext    = x(offset + 77);
ca_ext    = x(offset + 78);

Vm        = x(offset + 60);

m         = x(offset + 79);
n_na      = x(offset + 80);
h         = x(offset + 81);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
F = 96490.0;  % C/mol
R = 8.3;      % J/K*mol
T = 293.0;    % K

% membrane capacity in farad / cm*cm
c_m = 0.9e-6;

% geometries
r0         = 8.0;                          % %in 10^-6 m
A0         = 1.4*4*pi*r0*r0/(1.0e8);       % in cm*cm
Vol_zelle0 = 4.0/3.0*pi*r0*r0*r0/(1.0e15); %in liter
Vol_ges    = 3*Vol_zelle0;


% permeabilities in m/s
P_C   = 40e-9;
P_K0  = 20.0e-9;
P_Na0 = 0.4e-9;

P_Ca = 0.8e-10;

P_Kg  = 0;  % 1000e-9;
P_Nag = 0;  %1*3500e-9;
P_K  = m^4.0*P_Kg+P_K0;
P_Na = n_na^3*h*P_Nag+P_Na0;

Na0   = 10;    
I_NaKP = 1.12e-1*A0./((1+Na0/na_in).^4).*(atp./(atp+0.4)).*(atp>1e-8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

U = Vm/1000.0*F/R/T;

% Calcium
Ca0  = 1.0e-3;
k_CaP = 2.0e-14;    
I_CaP = -3.8*k_CaP*F/(1+(Ca0/ca_in)^1);
 
% Currents
% in A=cm*cm, P=m/s, F=C/Mol, X_in/out/sub=mMol/liter=Mol/m^3
% => cm*cm*m/s*C/Mol*Mol/m3=10^-4 m^3/s*C*Mol/Mol/m^3=10-4 C/s =10^4 A
I_C  = A0*P_C*U*F*(cl_ext-cl_in*exp(-U))/(1-exp(-U));
I_K  = -A0*P_K*U*F*(ka_ext-ka_in*exp(U))/(1-exp(U));
I_Na = -A0*P_Na*U*F*(na_ext-na_in*exp(U))/(1-exp(U));  
I_Ca = -2.0*A0*P_Ca*U*F*(ca_ext-ca_in*exp(2.0*U))/(1-exp(2.0*U));

I_K  = I_K  + 2.0*I_NaKP;
I_Na = I_Na - 3.0*I_NaKP -2*I_CaP;
I_Ca = I_Ca + I_CaP;

% Volume changes
A_in = 42*Vol_zelle0/Vol_cell;
B_in = 100*Vol_zelle0/Vol_cell;

O_in  = cl_in  + ka_in  + na_in +A_in + B_in;   % + ca_in
O_out = cl_ext + ka_ext + na_ext;  % +ca_ext;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changes
% ion concentration in mM 
%I_X=10^-4 A = 10^-4 C/s; I_X / F= 10^-4 C/s / C/Mol = 10^-4 Mol/s;
%I_X/F / Vol = 10^-4 Mol/s / liter = 10^-4 M/s = 10^-1 mM/s daher:
%1e-1* I_X/F/Vol = mM/s 

v_cl_in  =  1e-1*I_C/F/Vol_cell - cl_in/Vol_cell*1e-10*(O_in-O_out);
v_cl_ext =  0;

v_ka_in  =  1e-1*I_K/F/Vol_cell - ka_in/Vol_cell*1e-10*(O_in-O_out);
v_ka_ext =  0;

v_na_in  = 1e-1*I_Na/F/Vol_cell - na_in/Vol_cell*1e-10*(O_in-O_out);
v_na_ext = 0;

v_ca_in  = 1e-1*I_Ca/F/Vol_cell - ca_in/Vol_cell*1e-10*(O_in-O_out);
v_ca_ext = 0;


%Membranspannung 1/c_m*A=1/F*cm*cm/cm*cm=1/F=1/C/V=V/C; I_X=10^-4 A =10^-4 C/s
%=>1/(cm*A)*I_X = 10^-4 V/s; v_V soll in 10^-3 V/s gemessen werden:
%=>10^-4 V/s =10^-1 * 10^-3 V/s, daher:
v_Vm = 1e-1*1/(c_m*A0)*(-I_C + I_Na + I_K + 2*I_Ca);%

%Gatingvariablen in 1/s
v_m    = 0;
v_n_Na = 0;
v_h    = 0;  

%Volumen
v_Vol_cell = 1e-8* (O_in-O_out);
v_Vol_ext   = -v_Vol_cell;

% Changes in Atp (NaK pump)
v_ATP_pumpe = I_NaKP*1e-4/F*1000./Vol_cell;
v_ATP_use   = 6.38e-2*atp/(atp + 0.1).*(atp>1e-8);

v_atp = - v_ATP_pumpe - v_ATP_use;
v_adp =   v_ATP_pumpe + v_ATP_use;
v_p = v_adp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxdt = zeros(size(x));

dxdt(offset + 5) =         v_Vol_cell;
dxdt(offset + 6) =         v_Vol_ext;

dxdt(offset + 8) =         v_atp;
dxdt(offset + 9) =         v_adp;
dxdt(offset + 12) =         v_p;

dxdt(offset + 60) =         v_Vm; 

dxdt(offset + 67) =         v_cl_in; 
dxdt(offset + 68) =         v_ka_in;
dxdt(offset + 69) =         v_na_in;
dxdt(offset + 70) =         v_ca_in; 
         
dxdt(offset + 75) =         v_cl_ext; 
dxdt(offset + 76) =         v_ka_ext; 
dxdt(offset + 77) =         v_na_ext; 
dxdt(offset + 78) =         v_ca_ext;
    
dxdt(offset + 79) =         v_m;
dxdt(offset + 80) =         v_n_Na; 
dxdt(offset + 81) =         v_h; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%dxdt = dxdt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargout > 1
    V_names{1} = 'v_ATP_pumpe';        V(1) = v_ATP_pumpe;
    V_names{2} = 'v_ATP_use';          V(2) = v_ATP_use; 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

end