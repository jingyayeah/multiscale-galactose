function [dxdt, V_names, V] = cell_atpuse(t, x, pars, ci)
% oxidative phosporylation
%       t : time
%       x : concentrations
%       pars : model parameters
%       ci : cell index (cell dependent metabolism)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
offset = pars.Nf*pars.Nx_out - pars.Nx_out; 

atp       = x(offset + 8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scale_atp = 0.20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ATPUSE
% v_ATPUSE = scale_atp * 50 * atp/(atp+0.3);
v_ATPUSE = scale_atp * ( 10 * atp/(atp+0.3) + 40 * atp );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

v_atp =   - v_ATPUSE;  
v_adp =  + v_ATPUSE; 
v_p   =  + v_ATPUSE;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxdt = zeros(size(x));

dxdt(offset + 8)  =     v_atp;
dxdt(offset + 9)  =     v_adp;
dxdt(offset + 12) =     v_p;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargout > 1
    V_names{1} = 'v_ATPUSE';       V(1) = v_ATPUSE;
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
