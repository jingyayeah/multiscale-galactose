% Data for figures
p.Nt = length(t);
dxdt = zeros(size(x));
for k=1:p.Nt
   dxdt(k,:) = p.odefun(t(k),x(k,:)', p); 
end

% [1] Get complete information for the integration
% solution concentrations -> get all the names from x_names and
% respective dx_x_names
glc_ext = zeros(p.Nt, p.Nb,1);
lac_ext = zeros(p.Nt, p.Nb,1);
o2_ext  = zeros(p.Nt, p.Nb,1);
dx_glc_ext = zeros(size(glc_ext));
dx_lac_ext = zeros(size(lac_ext));
dx_o2_ext = zeros(size(o2_ext));

for ci=1:p.Nc
   glc_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc         +1:p.Nx_out +  (ci-1)*p.Nxc + p.Nf); 
   lac_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc +   p.Nf+1:p.Nx_out +  (ci-1)*p.Nxc + 2*p.Nf); 
   o2_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, p.Nx_out + (ci-1)*p.Nxc + 2*p.Nf+1: p.Nx_out + (ci-1)*p.Nxc + 3*p.Nf); 
   dx_glc_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = dxdt(:, p.Nx_out + (ci-1)*p.Nxc         +1:p.Nx_out +  (ci-1)*p.Nxc + p.Nf); 
   dx_lac_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = dxdt(:, p.Nx_out + (ci-1)*p.Nxc +   p.Nf+1:p.Nx_out +  (ci-1)*p.Nxc + 2*p.Nf); 
   dx_o2_ext(:, (ci-1)*p.Nf+1: ci*p.Nf) = dxdt(:, p.Nx_out + (ci-1)*p.Nxc + 2*p.Nf+1: p.Nx_out + (ci-1)*p.Nxc + 3*p.Nf); 
end


for k=1:p.Nx_in
   eval([p.x_names{p.Nx_out+k} ' = x(:,p.Nx_out + p.Nx_out*p.Nf + k: p.Nxc : end);'])
   eval(['dx_' p.x_names{k+p.Nx_out} ' = dxdt(:, p.Nx_out + p.Nx_out*p.Nf + k: p.Nxc : end);']) 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [2] Get additional fluxes from the integration routines
% These fluxes are defined in the subintegration routine for the modules

v_funcs = {@cell_gly
           @cell_cac
           @cell_oxi
           @cell_atpuse};


for kf = 1:length(v_funcs)
    fun = v_funcs{kf};
    [~, v_names, ~] = fun(0, p.x0(p.Nx_out+1:p.Nx_out+p.Nxc), p, 1);
    v_tmp = zeros(p.Nt, p.Nc, numel(v_names));
    for ci = 1:p.Nc
        for k=1:p.Nt
            xc = x(k, p.Nx_out+ (ci-1)*p.Nxc + 1: p.Nx_out+ ci*p.Nxc);
            [~, ~, tmp] = fun(t(k), xc', p, ci);
            v_tmp(k,ci,:) = tmp;
        end
    end
    for k=1:numel(v_names)
        eval([v_names{k} ' = squeeze(v_tmp(:,:,k));']) 
    end
end