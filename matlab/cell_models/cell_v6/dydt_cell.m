function [dydt] = dydt_cell(t,y,p)
% Calculate combined changes of all cells.
%
%   y : concentrations of full model of cell array
%   dydt : changes ( [unit]/s with [unit] being unit of corresponding
%          variable y
%
%   x : concentrations of single cell
%   dxdt : changes due to single cell
%
%   author: Matthias Koenig & Nikolaus Berndt
%   date: 121028

dydt = zeros(size(y));
for ci = 1:p.Nc
    
    % get the concentration vector for every cell
    x = y(p.Nx_out + (ci-1)*p.Nxc + 1 : p.Nx_out + ci*p.Nxc);
    
    % Reactions scaled in the modules (CAC and OXI are scaled together)
    dx_gly      = cell_gly(t,x,p,ci);               % Glycolysis
    dx_cac      = cell_cac(t,x,p,ci);               % TCA cycle
    dx_oxi      = cell_oxi(t,x,p,ci);               % Oxidative Phosphorylation
    dx_atpuse   = cell_atpuse(t,x,p,ci);            % ATPUSE
   
    dxdt = (dx_gly +  dx_cac + dx_oxi + dx_atpuse);
    
    %dxdt = (dx_gly + dx_atpuse);
    %dxdt = (dx_gly );
    %dxdt = (dx_gly + dx_cac + dx_atpuse);
    
    %dxdt = (dx_gly);
    %dxdt =  (dx_gly + dx_cac + dx_atpuse);
    
    % write the dxdt in the global changes
    dydt(p.Nx_out + (ci-1)*p.Nxc + 1 : p.Nx_out + ci*p.Nxc) = dxdt;
end 