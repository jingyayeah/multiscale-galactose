% Data for figures
p.Nt = length(t);

%% Calculate dxdt
dxdt = zeros(size(x));
for k=1:p.Nt
   dxdt(k,:) = p.odesin(t(k),x(k,:)', p); 
end

%% Create the named variables for the system
ofs_cel = p.Nx_out;
% Sinusoid & Disse variables
for k=1:2*p.Nx_out
    % create empty variables
    % rbc_sin = zeros(p.Nt, p.Nb,1);
    eval([p.x_names{k} ' = zeros(p.Nt, p.Nb,1);'])
    % dx.rbc_sin = zeros(p.Nt, p.Nb,1);
    eval(['dx.' p.x_names{k} ' = zeros(p.Nt, p.Nb,1);'])
   
    for ci=1:p.Nc
       % Store external variables 
       eval([p.x_names{k} '(:, (ci-1)*p.Nf+1: ci*p.Nf) = x(:, ofs_cel + (ci-1)*p.Nxc + (k-1)*p.Nf+1:ofs_cel + (ci-1)*p.Nxc + k*p.Nf);'])
       eval(['dx.' p.x_names{k} '(:, (ci-1)*p.Nf+1: ci*p.Nf) = dxdt(:, ofs_cel + (ci-1)*p.Nxc + (k-1)*p.Nf+1:ofs_cel + (ci-1)*p.Nxc + k*p.Nf);'])
    end
end

% Cellular variables 
%fprintf('* cellular variables *\n')
for k=1:p.Nx_in
   %sprintf('%s\n', p.x_names{2*p.Nx_out+k})
   eval([p.x_names{2*p.Nx_out+k} ' = x(:, ofs_cel + 2*p.Nx_out*p.Nf + k: p.Nxc : end);'])
   eval(['dx.' p.x_names{2*p.Nx_out+k} ' = dxdt(:, ofs_cel + 2*p.Nx_out*p.Nf + k: p.Nxc : end);']);
end

% fprintf('* pp and pv variables *\n')
% pp and pv variables
for k=1:p.Nx_out
   %sprintf('%s\n', p.x_names{k})
   eval(['pp.' p.x_names{k} ' = x(:, k);']);
   eval(['pv.' p.x_names{k} ' = x(:, end-p.Nx_out+k);']);
   eval(['pvdx.' p.x_names{k} ' = dxdt(:, end-p.Nx_out+k);']);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [2] Additional variables defined in cell model
% fprintf('* additional derived variables *\n')
v_funcs = {p.odecell};
for kf = 1:length(v_funcs)
    fun = v_funcs{kf};
    [~, v_names, ~] = fun(0, p.x0(p.Nx_out+1:p.Nx_out+p.Nxc), p, 1);
    v_tmp = zeros(p.Nt, p.Nc, numel(v_names));
    for ci = 1:p.Nc
        for k=1:p.Nt
            xc = x(k, ofs_cel + (ci-1)*p.Nxc + 1: p.Nx_out+ ci*p.Nxc);
            [~, ~, tmp] = fun(t(k), xc', p, ci);
            v_tmp(k,ci,:) = tmp;
        end
    end
    for k=1:numel(v_names)
        %sprintf('%s\n', v_names{k})
        eval([v_names{k} ' = squeeze(v_tmp(:,:,k));']) 
    end
end

% clean the workspace (remove unused variables)
clear('k', 'kf', 'tmp', 'v_tmp', 'v_names', 'xc', 'ci')