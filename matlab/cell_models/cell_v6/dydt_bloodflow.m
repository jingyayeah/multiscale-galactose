function [dydt] = dydt_bloodflow(t, y, p)
% dydt for blood flow/diffusion with cells.
%   t       : time
%   y       : vector of concentrations
%   dydt    : returns changes in concentration

%   author: Matthias Koenig (matthias.koenig@charite.de)
%           Charite Berlin
%           Computational Systems Biochemistry Berlin
%   date:   121015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Concentrations in (blood vessel)
yblood = zeros(p.Nx_out,1);
for k=1:p.Nx_out
   yblood(k) = p.f_ext{k}(t);
end
dydt = zeros(p.Nx_out + p.Nc*p.Nxc, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1] CELLS - calculate changes in concentration due to cells
if p.ode_cells
    %disp('[1] CELLS')
    f_dxdt =  0.005*0.46;
    dydt = f_dxdt * dydt_cell(t,y,p);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create external concentration matrix
y_ext    = zeros(p.Nb, p.Nx_out);
dydt_ext = zeros(size(y_ext));

for k=1:p.Nx_out
    for ci=1:p.Nc
       y_ext( (ci-1)*p.Nf+1 : ci*p.Nf , k) = ...
            y( p.Nx_out + (ci-1)*p.Nxc + (k-1)*p.Nf + 1: p.Nx_out + (ci-1)*p.Nxc + k*p.Nf); 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [2] BLOOD FLOW
if p.ode_blood
    %disp('[2] BLOOD')
    vb = p.v_blood/p.d_blood;    % [m/s/m]     
    for k=1:p.Nx_out
        % changes in first compartment depend on time course in blood
        dydt_ext(1,k) = dydt_ext(1,k) + ...
                        vb*(yblood(k) - y_ext(1,k));
        
        % interior compartments (influx [+] & efflux [-])
        dydt_ext(2:p.Nb-1,k) = dydt_ext(2:p.Nb-1,k) + ...    
              vb*( y_ext(1:p.Nb-2, k) - y_ext(2:p.Nb-1, k)); 
    
        % changes for the last compartment (influx [+])
        dydt_ext(p.Nb,k) = dydt_ext(p.Nb,k) + ...
                           vb*( y_ext(p.Nb-1,k));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [3] DIFFUSION  
if p.ode_diffusion
    %disp('[3] DIFFUSION')
    for k=1:p.Nx_out
        vdif = p.Ddata(k)*1E-12/p.d_blood/p.d_blood;
        
        % changes in the first compartment (i = 2:Nb-1)
        dydt_ext(1,k) = dydt_ext(1,k) + ...
                 + vdif * ( 0.5 * yblood(k) ...
                          + 0.5 * y_ext(2,k) ...
                          -       y_ext(1,k) );

        % changes in the interior compartments (i = 2:Nb-1)
        dydt_ext(2:p.Nb-1,k) = dydt_ext(2:p.Nb-1,k) ...
            + vdif * (  0.5 * y_ext(1:p.Nb-2,k) ...  
                      + 0.5 * y_ext(3:p.Nb  ,k) ...    
                      -       y_ext(2:p.Nb-1,k) );   

        % changes for the last compartments
        dydt_ext(p.Nb,k) = dydt_ext(p.Nb,k) ...
            + 0.5 * vdif * (y_ext(p.Nb-1,k) - y_ext(p.Nb,k));        
    end
end

% Add changes due to blood and diffusion
for k=1:p.Nx_out
    for ci=1:p.Nc
        dydt(p.Nx_out + (ci-1)*p.Nxc + (k-1)*p.Nf + 1: p.Nx_out + (ci-1)*p.Nxc + k*p.Nf) = ... 
        dydt(p.Nx_out + (ci-1)*p.Nxc + (k-1)*p.Nf + 1: p.Nx_out + (ci-1)*p.Nxc + k*p.Nf) + ...
            dydt_ext( (ci-1)*p.Nf+1 : ci*p.Nf , k);
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [4] CONSTANT EXTERNAL CONCENTRATIONS
% Concentrations in the first 3 compartments are directly determined
% via the given functions for the concentrations
dydt(1:p.Nx_out) = 0;

if p.ext_constant
    for ci=1:p.Nc
        dydt(p.Nx_out + (ci-1)*p.Nxc + 1: p.Nx_out +(ci-1)*p.Nxc + p.Nx_out*p.Nf) = 0;   % constant external concentrations in all blood
                          % compartments
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 