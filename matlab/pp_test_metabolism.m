function [y_pp] = pp_test_metabolism(t, p)
%% PP_TEST_METABOLISM - Calculate periportal time courses.
% Here the simulation profiles in the external metabolites are 
% generated and used to run the model.

%   Matthias Koenig (2013-08-23)
%   Copyright © Matthias König 2013 All Rights Reserved.

y_pp = zeros(p.Nx_out, numel(t));
for k=1:p.Nx_out
   y_pp(k,:) = k;
   
   % TODO: provide dynamic changes in the periportal concentrations
   % y_pp(k) = p.f_pp{k}(t);
end


end