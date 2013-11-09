function [y_pp] = pp_dilution_curves(t, p)
% PP_DILUTION_CURVES - Calculate periportal time courses.
% Here the simulation profiles in the external metabolites are 
% generated and used to run the model.

%   Matthias Koenig (2013-09-06)
%   Copyright © Matthias König 2013 All Rights Reserved.

y_pp = zeros(p.Nx_out, numel(t));
% constant initial concentrations (use the start initial concentrations
% pp)


for kt = 1:numel(t)
   y_pp(:,kt) = p.x0(1:p.Nx_out)*3; 
end

for kt = 1:numel(t)
y_pp(1,:) = 0.0; %RBCM
y_pp(2,:) = 0.0; %sucM
y_pp(3,:) = 0.0; %albM
y_pp(4,:) = 0.0; %galM
y_pp(5,:) = 0.0; %h20M

I = find( (t>=1).*(t<5) == 1);
    y_pp(1,I) = 10.0; %RBCM
    y_pp(2,I) = 10.0; %sucM
    y_pp(3,I) = 10.0; %albM
    y_pp(4,I) = 10.0; %galM
    y_pp(5,I) = 10.0; %h20M
end

end