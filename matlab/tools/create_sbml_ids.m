function [ids] = create_sbml_ids(p)
% Create the same generic name for all the compartments like in the SBML.
% Comparison of results: time course vector of concentrations

% p.x_ids = create_sbml_ids(p);
ids = cell(size(p.x0));

% PP__, PV__, D001__, S001__, H01__ 

% PP and PV SBML ids
ofs_cel = p.Nx_out;
for k=1:p.Nx_out
   ids{k} = sprintf('PP__%s', p.x_names{k});
end
for k=1:p.Nx_out
   ids{ofs_cel + p.Nxc*p.Nc + k} = sprintf('PV__%s', p.x_names{k});
end

% set sinusoid and disse ids next to cells
count = 0;
for ci=1:p.Nc
    for fi=1:p.Nf
        count = count +1;
        for k=1:p.Nx_out
            % sinusoid
            ids{ofs_cel + (ci-1)*p.Nxc + (k-1)*p.Nf+ fi } ...
                = sprintf('S%03d__%s', count, p.x_names{k});
            % disse
            ids{ofs_cel + + p.Nx_out*p.Nf + (ci-1)*p.Nxc + (k-1)*p.Nf+ fi } ...
                = sprintf('D%03d__%s', count, p.x_names{k});
        end
    end
end

% internal concentrations ids for cells
cell_ids = cell(p.Nx_in, 1);
for k=1:p.Nx_in
   cell_ids{k} = p.x_names{2*p.Nx_out + k};
end
% internal concentrations ids all cells
for ci=1:p.Nc
    for k=1:p.Nx_in
        ids{ofs_cel + 2*p.Nx_out*p.Nf +(ci-1)*p.Nxc + k} = sprintf('H%02d__%s',ci, cell_ids{k});
    end
end

end