function [p] = pars_nonnegative(p)
% Calculate the NonNegative information for the complete layout
if (~isfield(p, 'Ineg'))
    warning('NonNegative information missing for cell');
end

p.Ineg_all = [];
p.NonNegative = 1:numel(p.x0);
for c=1:p.Nc
   for k = 1:numel(p.Ineg)
        p.Ineg_all(numel(p.Ineg_all) + 1) = p.Nx_out + (c-1)*p.Nxc + (p.Nx_out*p.Nf) + p.Ineg(k) -3;
   end
end
p.NonNegative(p.Ineg_all) = [];

