function [p] = init_sinusoid(p)
%% INIT_SINUSOID : Set initial condition vector and non-negativities.
% Calculates based on the layout and the given cell metabolic model
% the initial condition vector and the non-negativiy conditions.
% 
%   Matthias Koenig (2013-08-22)
%   Copyright © Matthias König 2013 All Rights Reserved.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the possible negative concentrations in the cell
% TODO: broken indeces (correct) -> get the nonnegativity information from
%       the cell metabolism model
                    
% if (~isfield(p, 'Ineg'))
%     warning('NonNegative information missing for cell');
% end
% 
% % Create full list of indexes
% Ineg = cell2mat(p.x_neg.keys())
% p.Ineg_all = [];
% p.NonNegative = 1:numel(p.x0);
% 
% % for every cell get the indexes of the negative
% for c=1:p.Nc
%    for k = 1:numel(Ineg)
%        Nn = numel(p.Ineg_all);
%        
%        index = p.Ineg(k);
%        % Sinusoid
%        if (index <= p.Nx_out)
%         p.Ineg_all( + 1) = 
%            
%        % Space of Disse
%        elseif (index <= 2.p.Nx_out)
%        
%        % Cell Metabolite
%        else
%            
%        end
%  
%         p.Ineg_all(numel(p.Ineg_all) + 1) = p.Nx_out + (c-1)*p.Nxc + (p.Nx_out*p.Nf) + p.Ineg(k) -3;
%    end
% end
% % delete the possible negatives from the nonnegatives
% p.NonNegative(p.Ineg_all) = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end