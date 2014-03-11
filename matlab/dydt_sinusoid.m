function [dydt] = dydt_sinusoid(t, y, p)
%% Calculate the derivates for the sinusoid model.
%   t       : time
%   y       : vector of concentrations
%   dydt    : returns changes in concentration [mole/m3]
%   p       : vector of parameters
%
%   Copyright Matthias Koenig 2014 All Rights Reserved.

dydt = zeros(size(y));
ofs_cel = p.Nx_out;     % Offset to variables of first cell

%% Concentrations in periportal and perivenious compartment
y_pp = p.pp_fun(t, p);
y_pv = y(end-p.Nx_out+1:end);
dydt_pv = zeros(size(y_pv));

%% Cells
if p.with_cells
    %disp('[1] CELLS')    
    for ci = 1:p.Nc
        % get the concentration vector for cell ci
        x = y(ofs_cel + (ci-1)*p.Nxc + 1 : ofs_cel + ci*p.Nxc);
        
        % calculate the changes in cell ci
        dxdt_ci      = p.odecell(t,x,p,ci);
   
        % write the dxdt in the global changes
        dydt(ofs_cel + (ci-1)*p.Nxc + 1 : ofs_cel + ci*p.Nxc) = dxdt_ci;
    end
end

%% Sinusoid and disse concentration matrix
y_sin      = zeros(p.Nb, p.Nx_out);
dydt_sin   = zeros(p.Nb, p.Nx_out);
y_dis      = zeros(p.Nb, p.Nx_out);
dydt_dis   = zeros(p.Nb, p.Nx_out);
for k=1:p.Nx_out
    for ci=1:p.Nc
       y_sin( (ci-1)*p.Nf+1 : ci*p.Nf , k) = ...
            y( ofs_cel + (ci-1)*p.Nxc + (k-1)*p.Nf+1: ...
               ofs_cel + (ci-1)*p.Nxc +     k*p.Nf); 

        y_dis( (ci-1)*p.Nf+1 : ci*p.Nf , k) = ...
            y( ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc + (k-1)*p.Nf+1 : ... 
               ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc +     k*p.Nf);
    end
end

%% Blood flow disse
if p.with_flow
    %disp('[2] BLOOD')
    vb = p.flow_sin * p.A_sin;    % [mole/s  * m3/mole]
    
    for k=1:p.Nx_out
        % changes in first compartment depend on time course in pp
        dydt_sin(1,k) = dydt_sin(1,k) ...
            + vb/p.Vol_sin * (y_pp(k) - y_sin(1,k));  % [mole/s/m3]
        
        % interior compartments & last compartment (influx [+] & efflux [-])
        if (p.Nb >1)
        dydt_sin(2:p.Nb,k) = dydt_sin(2:p.Nb,k) ...    
            + vb/p.Vol_sin * (y_sin(1:p.Nb-1, k) - y_sin(2:p.Nb, k)); % [mole/s/m3]
        end
        % changes for the pv compartment
        dydt_pv(k) = dydt_pv(k) + ...
            + vb/p.Vol_pv * (y_sin(p.Nb,k) - y_pv(k)); % [mole/s/m3]
    end
end

%% Diffusion sinusoid & disse
if p.with_diffusion
    %disp('[3] DIFFUSION')
    for k=1:p.Nx_out
        % Changes depend on the architecture
        D = p.Ddata(k);     %[m^2/s]
        Dx_sin = D/p.x_sin * p.A_sin;               % [m3/s]
        Dy_sin = D/p.y_dis * p.A_sindis;
        Dx_dis = D/p.x_sin * p.A_dis;
        Dy_dis = D/p.y_dis * p.A_sindis;
        
        % Sinusoid
        if (p.Nb > 1)
        % changes in the first sinusoid compartment (i = 1)          
        dydt_sin(1,k) = dydt_sin(1,k) + ...     % [mole/m3/s] 
            + Dx_sin/p.Vol_sin * (y_pp(k) - 2*y_sin(1,k) + y_sin(2,k)) ...
            + Dy_sin/p.Vol_sin * (y_dis(1,k) - y_sin(1,k));
        % changes in the interior sinusoid compartments (i = 2:Nb-1)
        dydt_sin(2:p.Nb-1,k) = dydt_sin(2:p.Nb-1,k) ...
            + Dx_sin/p.Vol_sin * (y_sin(1:p.Nb-2,k)  - 2*y_sin(2:p.Nb-1,k) + y_sin(3:p.Nb  ,k)) ...
            + Dy_sin/p.Vol_sin * (y_dis(2:p.Nb-1, k) - y_sin(2:p.Nb-1,k)); 
        % changes for the last sinusoid compartment (i = p.Nb)
        dydt_sin(p.Nb,k) = dydt_sin(p.Nb,k) ...
            + Dx_sin/p.Vol_sin * (y_sin(p.Nb-1,k)   - y_sin(p.Nb,k) + y_pv(k)) ...
            + Dy_sin/p.Vol_sin * (y_dis(p.Nb, k)    - y_sin(p.Nb,k));  
        else
            % changes in the one sinusoid compartment (i = 1)
            dydt_sin(1,k) = dydt_sin(1,k) ...
            + Dx_sin/p.Vol_sin * (y_pp(k) - 2*y_sin(1,k) + y_pv(k)) ...
            + Dy_sin/p.Vol_sin * (y_dis(1, k) - y_sin(1,k)); 
        end
        % changes in the pv compartment
        dydt_pv(k) = dydt_pv(k) ...
            + Dx_sin/p.Vol_sin * (y_sin(p.Nb,k) - y_pv(k));      
        
        % Disse
        if (p.Nb > 1)
        % changes in the first Disse compartment (i = 1)
        dydt_dis(1,k) = dydt_dis(1,k) + ...     % [mole/m3/s]
            + Dx_dis/p.Vol_dis * (y_dis(2,k) - y_dis(1,k)) ...
            + Dy_dis/p.Vol_dis * (y_sin(1,k) - y_dis(1,k));                
        % changes in the interior Disse compartments (i = 2:Nb-1)
        dydt_dis(2:p.Nb-1,k) = dydt_dis(2:p.Nb-1,k) ...
          + Dx_dis/p.Vol_dis * (y_dis(1:p.Nb-2,k)  -2*y_dis(2:p.Nb-1,k) +y_dis(3:p.Nb  ,k)) ...
          + Dy_dis/p.Vol_dis * (y_sin(2:p.Nb-1, k) - y_dis(2:p.Nb-1,k)); 
        % changes for the last Disse compartment (i = p.Nb)
        dydt_dis(p.Nb,k) = dydt_dis(p.Nb,k) ...
          + Dx_dis/p.Vol_dis * (y_dis(p.Nb-1,k) - y_dis(p.Nb,k)) ...
          + Dy_dis/p.Vol_dis * (y_sin(p.Nb, k)  - y_dis(p.Nb,k));  
        else
            % changes in the one Disse compartment (i = 1)
              dydt_dis(p.Nb,k) = dydt_dis(p.Nb,k) ...
            + Dy_dis/p.Vol_dis * (y_sin(1, k)  - y_dis(1,k));  
        end
    end
end

%% Add flow and diffusion changes
for k=1:p.Nx_out
    for ci=1:p.Nc
        % Sinusoid changes
        dydt(ofs_cel + (ci-1)*p.Nxc + (k-1)*p.Nf+1: ofs_cel + (ci-1)*p.Nxc + k*p.Nf) = ... 
        dydt(ofs_cel + (ci-1)*p.Nxc + (k-1)*p.Nf+1: ofs_cel + (ci-1)*p.Nxc + k*p.Nf) + ...
                dydt_sin( (ci-1)*p.Nf+1 : ci*p.Nf , k);
        % Disse changes
        dydt(ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc + (k-1)*p.Nf+1: ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc + k*p.Nf) = ... 
        dydt(ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc + (k-1)*p.Nf+1: ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc + k*p.Nf) + ...
                dydt_dis( (ci-1)*p.Nf+1 : ci*p.Nf , k);
   end
end

%% pp and pv changes 
% Concentrations in [pp] are given via function, [pv] changes are dynamic;
dydt(1:ofs_cel) = 0.0;
dydt(end-ofs_cel+1 : end) = dydt_pv;

% constant external concentrations in all sinusoids and disse
if p.ext_constant
    disp('[4] SINUSOID & DISSE CONSTANT !')
    for ci=1:p.Nc
        dydt(ofs_cel + (ci-1)*p.Nxc+1: ofs_cel +(ci-1)*p.Nxc + 2*p.Nx_out*p.Nf) = 0.0;   
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 