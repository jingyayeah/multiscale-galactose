function [p] = init_sinusoid(p)
%% Creates initial condition vector and non-negativities.
% Calculates based on the layout and the given cell metabolic model
% the initial condition vector and the non-negativity conditions.
% 
%   Copyright Matthias Koenig 2013 All Rights Reserved.


% initial concentrations for cell
[p.x_names, p.x_init, p.Nx_out, ~, ~, ~, Ddata] = p.parscell();
p.Ddata = Ddata;

% get the number of external and internal concentrations
p.Nx_in  = numel(p.x_names) - 2*p.Nx_out;   % all concentrations - sinusoid and disse 
p.Nxc    = 2*p.Nx_out*p.Nf + p.Nx_in;       % concentrations of one cell

% zero init vector ( [pp] cells [pv] )
ofs_cel = p.Nx_out;
p.x0 = zeros(ofs_cel + p.Nxc*p.Nc + ofs_cel, 1);   

% sinusoid concentrations pp & pv are set via the pp and pv functions
for k=1:p.Nx_out
   p.x0(k) = p.x_init(p.x_names{k}); 
end
for k=1:p.Nx_out
   p.x0(ofs_cel + p.Nxc*p.Nc + k) = p.x_init(p.x_names{k}); 
end

% set sinusoid and disse concentrations next to cells
for k=1:p.Nx_out
    for ci=1:p.Nc
        % sinusoid
        p.x0(ofs_cel + (ci-1)*p.Nxc + (k-1)*p.Nf+1 : ofs_cel + (ci-1)*p.Nxc + k*p.Nf) ...
                    = p.x_init(p.x_names{k});
        % disse
        p.x0(ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc  +(k-1)*p.Nf + 1 : ofs_cel + p.Nx_out*p.Nf + (ci-1)*p.Nxc + k*p.Nf) ...
                    = p.x_init(p.x_names{p.Nx_out + k});
    end
end

% internal concentrations single cell
x0cell = zeros(p.Nx_in, 1);
for k=1:p.Nx_in
   x0cell(k) = p.x_init(p.x_names{2*p.Nx_out + k});
end
% internal concentrations all cells
for ci=1:p.Nc
    p.x0(ofs_cel + 2*p.Nx_out*p.Nf +(ci-1)*p.Nxc + 1: ofs_cel + ci*p.Nxc) = x0cell;
end



% ---------------------------------------------------------------------------
%% Plot the initial condition vecor or debugging
if (false)
    figure('Name', 'Initial Concentrations', 'Color', [1,1,1], ...
            'Position', [0 0 1000 800])
    subplot(2,1,1)
    plot(x0cell, 'ko-');
    xlabel('Index in cell model')

    subplot(2,1,2)
    plot(p.x0,'ko-');
    xlabel('Index full model')
    
    drawnow
end

end